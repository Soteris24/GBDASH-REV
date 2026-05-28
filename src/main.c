#include <gb/gb.h>
#include <gbdk/font.h>
#include <gbdk/console.h>
#include <gbdk/zx0decompress.h>
#include <stdio.h>

#include "assets.h"
#include "hUGEDriver.h"
#include "famidash_metatiles.c"

static uint8_t buffer[2048];

uint8_t music_ready = 0;
uint8_t selected    = 0;
uint8_t redraw      = 1;

extern const hUGESong_t song_stereoma;

void play_music_safe(void) {
    if (music_ready) hUGE_dosound();
}

void setup_menu_font(void) {
    font_init();
    font_set(font_load(font_min));
}

void load_bkg_tileset(const uint8_t *tiles, uint16_t tile_count) {
    if (tile_count == 256u) {
        set_bkg_data(0,   128, tiles);
        set_bkg_data(128, 128, tiles + (128u * 16u));
    } else {
        set_bkg_data(0, (uint8_t)tile_count, tiles);
    }
}

void draw_metatile_map(uint16_t map_w, uint8_t cols, uint8_t rows,
                       const uint8_t *map) {
    for (uint8_t y = 0; y < rows; y++) {
        for (uint8_t x = 0; x < cols; x++) {
            uint8_t mt = map[(uint16_t)y * map_w + x];
            set_bkg_tiles(x << 1, y << 1,       2, 1, &metatiles[mt][0]);
            set_bkg_tiles(x << 1, (y << 1) + 1, 2, 1, &metatiles[mt][2]);
        }
    }
}

// -------------------------------------------------------
// Ring-buffer dimensions.
// The GB background is 32x32 tiles = 16x16 metatiles.
// We use all 16 rows and 16 columns as a 2D ring buffer.
// Viewport is 10 cols x 9 rows (160x144px).
// -------------------------------------------------------
#define BKG_MT_W   16   // background ring width  in metatiles
#define BKG_MT_H   16   // background ring height in metatiles
#define VIEW_MT_W  10   // visible columns (160px / 16px)
#define VIEW_MT_H   9   // visible rows    (144px / 16px)

// Draw one metatile column into the ring buffer at ring x = bkg_col,
// for all map rows currently in [cam_y .. cam_y + BKG_MT_H).
void draw_mt_column(uint8_t bkg_col, uint16_t map_col,
                    const uint8_t *map, uint16_t map_w, uint16_t map_h) {
    uint8_t bx = bkg_col << 1;
    for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
        uint8_t mt = map[(uint16_t)r * map_w + map_col];
        uint8_t by = (r & (BKG_MT_H - 1)) << 1;   // ring wrap on Y
        set_bkg_tiles(bx, by,     2, 1, &metatiles[mt][0]);
        set_bkg_tiles(bx, by + 1, 2, 1, &metatiles[mt][2]);
    }
}

// Draw one metatile row into the ring buffer at ring y = bkg_row.
void draw_mt_row(uint8_t bkg_row, uint16_t map_row,
                 uint16_t cam_x_col, uint16_t visible_cols,
                 const uint8_t *map, uint16_t map_w) {
    uint8_t by = bkg_row << 1;
    for (uint16_t c = 0; c < visible_cols; c++) {
        uint16_t mc = cam_x_col + c;
        if (mc >= map_w) break;
        uint8_t mt = map[(uint16_t)map_row * map_w + mc];
        uint8_t bx = (uint8_t)((mc & (BKG_MT_W - 1)) << 1);
        set_bkg_tiles(bx, by,     2, 1, &metatiles[mt][0]);
        set_bkg_tiles(bx, by + 1, 2, 1, &metatiles[mt][2]);
    }
}

// Fill the entire 16x16 ring on level entry.
void fill_scroll_bg(const uint8_t *map, uint16_t map_w, uint16_t map_h) {
    uint16_t cols = (map_w < BKG_MT_W) ? map_w : BKG_MT_W;
    for (uint16_t c = 0; c < cols; c++) {
        draw_mt_column((uint8_t)(c % BKG_MT_W), c, map, map_w, map_h);
    }
}

// -------------------------------------------------------
// Menu
// -------------------------------------------------------
void draw_menu(void) {
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    gotoxy(0, 0);
    printf("GBDREV PREBUILD 01 \n\n");
    for (uint8_t i = 0; i < MAX_LEVELS; i++) {
        gotoxy(1, 2 + i);
        if (i == selected) printf("0 %s", game_levels[i]->name);
        else               printf("  %s", game_levels[i]->name);
    }
    SHOW_BKG;
    redraw = 0;
}

// -------------------------------------------------------
// Static level loader (levels 0-3)
// -------------------------------------------------------
void load_level(uint8_t idx) {
    const Level *l = game_levels[idx];
    const uint8_t *tile_data;
    const uint8_t *map_data;

    DISPLAY_OFF;

    if (l->tiles_are_compressed) {
        zx0_decompress(l->tiles, buffer);
        tile_data = buffer;
    } else {
        tile_data = l->tiles;
    }
    load_bkg_tileset(tile_data, l->tile_count);

    if (l->map_is_compressed) {
        zx0_decompress(l->map, buffer);
        map_data = buffer;
    } else {
        map_data = l->map;
    }

    uint8_t cols = (l->map_width  > VIEW_MT_W) ? VIEW_MT_W : (uint8_t)l->map_width;
    uint8_t rows = (l->map_height > VIEW_MT_H) ? VIEW_MT_H : (uint8_t)l->map_height;

    fill_bkg_rect(0, 0, 20, 18, 0);
    draw_metatile_map(l->map_width, cols, rows, map_data);

    SHOW_BKG;
    DISPLAY_ON;

    waitpadup();
    while (!(joypad() & J_START)) wait_vbl_done();
    waitpadup();
    setup_menu_font();
    redraw = 1;
}

// -------------------------------------------------------
// Scrolling level loader  (level 4 — SM SCROLL)
//
// Left/Right: scroll horizontally (smooth, 2px/frame)
// Up/Down:    scroll vertically   (smooth, 2px/frame)
// Start:      return to menu
//
// The map is 894 cols x 16 rows (rows 11-26 of the full level).
// The GB background ring (16x16 metatiles) holds the whole height
// at once, so vertical scrolling needs NO column redraws — it's
// just a free SCY register change. Only horizontal movement draws
// new columns (one per 16px boundary crossed).
// -------------------------------------------------------
#define SCROLL_SPEED 2

void play_level_scroll(uint8_t idx) {
    const Level *l     = game_levels[idx];
    const uint8_t *map = l->map;
    uint16_t map_w     = l->map_width;
    uint16_t map_h     = l->map_height;   // 16

    uint16_t cam_px    = 0;               // horizontal camera, pixels
    uint16_t cam_py    = 0;               // vertical camera, pixels

    // Horizontal: max scroll so last visible column is map edge
    uint16_t max_px    = (map_w - VIEW_MT_W) << 4;
    // Vertical: map is 16 rows = 256px tall. Screen is 144px = 9 rows.
    // Max cam_py so we don't scroll past the bottom of the map.
    uint16_t max_py    = (map_h - VIEW_MT_H) << 4;  // (16-9)*16 = 112

    // Track rightmost map column loaded into ring so we don't double-draw
    uint16_t loaded_right = BKG_MT_W - 1;

    DISPLAY_OFF;
    load_bkg_tileset(l->tiles, l->tile_count);
    move_bkg(0, 0);
    fill_scroll_bg(map, map_w, map_h);
    SHOW_BKG;
    DISPLAY_ON;

    waitpadup();

    while (1) {
        wait_vbl_done();

        uint8_t joy = joypad();
        if (joy & J_START) break;

        // --- Horizontal scroll ---
        if (joy & J_RIGHT) {
            if (cam_px < max_px) {
                uint16_t prev_col = cam_px >> 4;
                cam_px += SCROLL_SPEED;
                if (cam_px > max_px) cam_px = max_px;
                uint16_t curr_col = cam_px >> 4;

                if (curr_col != prev_col) {
                    uint16_t need_col = curr_col + VIEW_MT_W;
                    if (need_col > loaded_right && need_col < map_w) {
                        loaded_right = need_col;
                        draw_mt_column((uint8_t)(need_col % BKG_MT_W),
                                       need_col, map, map_w, map_h);
                    }
                }
            }
        } else if (joy & J_LEFT) {
            if (cam_px > 0) {
                if (cam_px < SCROLL_SPEED) cam_px = 0;
                else cam_px -= SCROLL_SPEED;
                // Left scroll: columns were already loaded on the way right.
                // Only need to redraw if scrolling back past the ring boundary.
                uint16_t curr_col = cam_px >> 4;
                if (curr_col < loaded_right && loaded_right > BKG_MT_W) {
                    draw_mt_column((uint8_t)(curr_col % BKG_MT_W),
                                   curr_col, map, map_w, map_h);
                }
            }
        }

        // --- Vertical scroll ---
        // The full 16-row map is already in the ring — SCY is free!
        if (joy & J_DOWN) {
            if (cam_py < max_py) {
                cam_py += SCROLL_SPEED;
                if (cam_py > max_py) cam_py = max_py;
            }
        } else if (joy & J_UP) {
            if (cam_py > 0) {
                if (cam_py < SCROLL_SPEED) cam_py = 0;
                else cam_py -= SCROLL_SPEED;
            }
        }

        // SCX wraps at 256 naturally (ring is 16 metatiles = 256px wide)
        // SCY wraps at 256 naturally (ring is 16 metatiles = 256px tall)
        move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
    }

    move_bkg(0, 0);
    waitpadup();
    setup_menu_font();
    redraw = 1;
}

// -------------------------------------------------------
// Main
// -------------------------------------------------------
void main(void) {
    music_ready = 0;
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    hUGE_init(&song_stereoma);
    music_ready = 1;

    TMA_REG = 224;
    TAC_REG = 0x04;
    add_TIM(play_music_safe);

    set_interrupts(VBL_IFLAG | TIM_IFLAG);
    enable_interrupts();

    setup_menu_font();

    while (1) {
        if (redraw) draw_menu();
        uint8_t joy = joypad();

        if (joy & J_UP) {
            if (selected > 0) { selected--; redraw = 1; }
            waitpadup();
        } else if (joy & J_DOWN) {
            if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
            waitpadup();
        } else if (joy & J_A) {
            if (selected == 4) play_level_scroll(selected);
            else               load_level(selected);
        }

        wait_vbl_done();
    }
}