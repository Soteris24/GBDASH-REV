#ifndef ASSETS_H
#define ASSETS_H

#include <gb/gb.h>
#include <stdint.h>

typedef struct {
    const char * name;      
    const uint8_t * tiles;  
    const uint8_t * map;    
    uint16_t tile_count;
    uint16_t map_width;
    uint16_t map_height;
    uint8_t tiles_are_compressed;
    uint8_t map_is_compressed;
} Level;

extern const Level * const game_levels[];
extern const uint8_t MAX_LEVELS;

#endif
