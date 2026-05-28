#include <gb/gb.h>
#include <gbdk/font.h>
#include <gbdk/console.h>
#include <gbdk/zx0decompress.h>
#include <stdio.h>

#include "assets.h"
#include "hUGEDriver.h"
#include "famidash_metatiles.c"

uint8_t music_ready = 0;
static uint8_t buffer[4096]; // enough for one full 256-tile 2bpp tileset
uint8_t selected = 0;
uint8_t redraw = 1;

extern const hUGESong_t song_stereoma;

void play_music_safe(void) {
    if (music_ready) {
        hUGE_dosound();
    }
}

void setup_menu_font(void) {
    font_init();
    font_set(font_load(font_min));
}

// 2x2 block logic
void draw_metatile_map(uint16_t map_width, uint8_t width, uint8_t height, const uint8_t *map_array) {
    for (uint8_t y = 0; y < height; y++) {
        for (uint8_t x = 0; x < width; x++) {
            uint8_t metatile_id = map_array[(uint16_t)y * map_width + x];

            set_bkg_tiles(x << 1, y << 1, 2, 1, &metatiles[metatile_id][0]);
            set_bkg_tiles(x << 1, (y << 1) + 1, 2, 1, &metatiles[metatile_id][2]);
        }
    }
}

void load_bkg_tileset(const uint8_t *tiles, uint16_t tile_count) {
    if (tile_count == 256u) {
        set_bkg_data(0, 128, tiles);
        set_bkg_data(128, 128, tiles + (128u * 16u));
    } else {
        set_bkg_data(0, (uint8_t)tile_count, tiles);
    }
}

void draw_menu(void) {   
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    gotoxy(0, 0);
    printf("GBDREV PREBUILD 01 \n\n");
    for(uint8_t i = 0; i < MAX_LEVELS; i++) {
        gotoxy(1, 2 + i); 
        if (i == selected) {
            printf("0 %s", game_levels[i]->name);
        } else {
            printf("  %s", game_levels[i]->name);
        }
    }
    SHOW_BKG;
    redraw = 0;
}

void load_level(uint8_t idx) {
    const Level *l = game_levels[idx];
    const uint8_t *tile_data;
    const uint8_t *map_data;
    uint8_t draw_width;
    uint8_t draw_height;

    DISPLAY_OFF;
    
    // load level gfx
    if (l->tiles_are_compressed) {
        zx0_decompress(l->tiles, buffer);
        tile_data = buffer;
    } else {
        tile_data = l->tiles;
    }
    load_bkg_tileset(tile_data, l->tile_count);
    
    // load map metatiles
    if (l->map_is_compressed) {
        zx0_decompress(l->map, buffer);
        map_data = buffer;
    } else {
        map_data = l->map;
    }

    draw_width = (l->map_width > 10) ? 10 : l->map_width;
    draw_height = (l->map_height > 9) ? 9 : l->map_height;
    
    // clean screen and draw metatiles
    fill_bkg_rect(0, 0, 20, 18, 0); 
    draw_metatile_map(l->map_width, draw_width, draw_height, map_data);
    
    SHOW_BKG;
    DISPLAY_ON;
    
    // wait start to back to menu
    waitpadup();
    while(!(joypad() & J_START)) {
        wait_vbl_done();
    }
    
    waitpadup();
    setup_menu_font();
    redraw = 1; 
}

void main(void) {
    music_ready = 0;

    // turn on gb sound
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    hUGE_init(&song_stereoma);
    music_ready = 1;

    // music setup
    TMA_REG = 224;
    TAC_REG = 0x04;
    add_TIM(play_music_safe);  

    set_interrupts(VBL_IFLAG | TIM_IFLAG);
    enable_interrupts();

    setup_menu_font(); 

    while(1) {
        if(redraw) {
            draw_menu();
        }

        uint8_t joy = joypad();

        if (joy & J_UP) {
            if (selected > 0) {
                selected--; 
                redraw = 1;
            }
            waitpadup();
        }
        else if (joy & J_DOWN) {
            if (selected < MAX_LEVELS - 1) {
                selected++; 
                redraw = 1;
            }
            waitpadup();
        }
        else if (joy & J_A) {
            load_level(selected);
        }

        wait_vbl_done();
    }
}
