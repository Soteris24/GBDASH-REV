#include <gb/gb.h>
#include <gbdk/font.h>
#include <gbdk/console.h>
#include <stdio.h>
#include "player.h"
#include "assets.h"
#include "hUGEDriver.h"
#include "famidash_metatiles.c"  // metatiles[] and famidash_metatile_collision[]


const uint8_t cube_tiles[] = {
        0xFF,0xFF,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,
        0xFF,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,
        0xFF,0xFF,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,
        0xFF,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF
};

uint8_t music_ready = 0;
uint8_t redraw = 1;
uint8_t selected = 0;

extern const hUGESong_t song_stereoma;

void play_music_safe(void) {
    if (music_ready) hUGE_dosound();
}

void setup_menu_font(void) {
    font_init();
    font_set(font_load(font_min));
}

void load_bkg_tileset(const uint8_t* tiles, uint16_t tile_count) {
    if (tile_count == 256u) {
        set_bkg_data(0, 128, tiles);
        set_bkg_data(128, 128, tiles + (128u * 16u));
    }
    else {
        set_bkg_data(0, (uint8_t)tile_count, tiles);
    }
}

// -------------------------------------------------------
// Ring-buffer background
// GB background is 32x32 tiles = 16x16 metatiles (ring)
//  new columns are drawn as the camera moves right.
// -------------------------------------------------------
#define BKG_MT_W  16
#define BKG_MT_H  16
#define VIEW_MT_W 10
#define VIEW_MT_H  9
#define SCROLL_SPEED 3

void draw_mt_column(uint8_t ring_col, uint16_t map_col,
    const uint8_t* map, uint16_t map_w, uint16_t map_h,
    uint8_t map_bank) { 

    uint8_t bx = ring_col << 1;

    // Save the current bank, then switch to the maps bank
    uint8_t _prev = _current_bank;
    SWITCH_ROM(map_bank);

    for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
        uint8_t mt = map[(uint16_t)r * map_w + map_col];
        uint8_t by = (r & (BKG_MT_H - 1)) << 1;
        set_bkg_tiles(bx, by, 2, 1, &metatiles[mt][0]);
        set_bkg_tiles(bx, by + 1, 2, 1, &metatiles[mt][2]);
    }

    // Switch back to the previous bank so the rest of the engine works
    SWITCH_ROM(_prev);
}

void fill_scroll_bg(const uint8_t* map, uint16_t map_w, uint16_t map_h, uint8_t map_bank) {
    uint16_t cols = (map_w < BKG_MT_W) ? map_w : BKG_MT_W;
    for (uint16_t c = 0; c < cols; c++) {
        // Added l->map_bank here
        draw_mt_column((uint8_t)(c % BKG_MT_W), c, map, map_w, map_h, map_bank);
    }
}

// -------------------------------------------------------
// Menu
// -------------------------------------------------------
void draw_menu(void) {
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    gotoxy(0, 0);
    printf("GBDASH\n\n");
    for (uint8_t i = 0; i < MAX_LEVELS; i++) {
        gotoxy(1, 2 + i);
        if (i == selected) printf("> %s", game_levels[i]->name);
        else               printf("  %s", game_levels[i]->name);
    }
    SHOW_BKG;
    redraw = 0;
}

// -------------------------------------------------------
// Level player
// -------------------------------------------------------
void play_level(uint8_t idx) {
    // --- 1. DECLARE ALL VARIABLES HERE ---
    const Level* l = game_levels[idx];
    const uint8_t* map = l->map;
    uint16_t map_w = l->map_width;
    uint16_t map_h = l->map_height;

    uint16_t cam_px = 0;

    // FIX 1: Push camera down! (256 map height - 144 screen height = 112)
    uint16_t cam_py = 112;
    uint16_t loaded_r = BKG_MT_W - 1;

    uint8_t _prev;
    uint8_t died;
    int16_t py;

    Player player;

    // --- 2. SETUP ---
    // Floor is roughly at pixel 176. Spawn player at 160 so they drop onto it.
    player_init(&player, 32, 160);

    DISPLAY_OFF;
    load_bkg_tileset(l->tiles, l->tile_count);

    set_sprite_data(0, 4, cube_tiles);
    set_sprite_tile(0, 0); set_sprite_tile(1, 1);
    set_sprite_tile(2, 2); set_sprite_tile(3, 3);

    move_bkg(0, (uint8_t)cam_py); // Apply vertical camera shift
    fill_scroll_bg(map, map_w, map_h, l->map_bank);

    // FIX 2: Set the palettes! Without OBP0_REG, sprites are painted transparent!
    BGP_REG = 0xE4;
    OBP0_REG = 0xE4;
    SPRITES_8x8;

    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;

    waitpadup();

    // --- 3. GAME LOOP ---
    while (1) {
        wait_vbl_done();
        uint8_t joy = joypad();
        if (joy & J_START) break;

        // Auto-Scroll Camera Right
        if (cam_px < ((map_w - VIEW_MT_W) << 4)) {
            uint16_t prev = cam_px >> 4;
            cam_px += SCROLL_SPEED;
            uint16_t curr = cam_px >> 4;
            if (curr != prev) {
                uint16_t need = curr + VIEW_MT_W;
                if (need > loaded_r && need < map_w) {
                    loaded_r = need;
                    draw_mt_column((uint8_t)(need % BKG_MT_W), need, map, map_w, map_h, l->map_bank);
                }
            }
        }

        // Physics Update
        player.world_x = cam_px + PLAYER_SCREEN_X;

        _prev = _current_bank;
        SWITCH_ROM(l->map_bank);
        died = player_update(&player, joy, map, map_w, map_h);
        SWITCH_ROM(_prev);

        if (died) {
            cam_px = 0;
            loaded_r = BKG_MT_W - 1;
            player_init(&player, 32, 160); // Respawn height
            move_bkg(0, (uint8_t)cam_py);
            fill_scroll_bg(map, map_w, map_h, l->map_bank);
        }

        // FIX 3: Tell player_screen_y about our camera offset so math works!
        py = player_screen_y(&player, cam_py);

        move_sprite(0, PLAYER_SCREEN_X + 8,     py + 16);
        move_sprite(1, PLAYER_SCREEN_X + 8 + 8, py + 16);
        move_sprite(2, PLAYER_SCREEN_X + 8,     py + 16 + 8);
        move_sprite(3, PLAYER_SCREEN_X + 8 + 8, py + 16 + 8);

        move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
    }

    // --- 4. CLEANUP ---
    HIDE_SPRITES;
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
        }
        else if (joy & J_DOWN) {
            if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
            waitpadup();
        }
        else if (joy & J_A) {
            play_level(selected);
        }

        wait_vbl_done();
    }
}
