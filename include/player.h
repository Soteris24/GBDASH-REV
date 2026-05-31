#ifndef PLAYER_H
#define PLAYER_H

#include <gb/gb.h>
#include <stdint.h>
#include "collision.h"

#define PLAYER_SCREEN_X   32
#define PLAYER_SIZE       15    // full hitbox (16px-1) used for solid collision
#define PLAYER_HBOX       2     // inset for hazard hitbox — 2px forgiveness each side

// Fixed-point physics (1 unit = 1/16th pixel)
#define GRAVITY           8
#define JUMP_FORCE       -85
#define MAX_FALL_SPEED    80

typedef struct {
    uint16_t world_x;
    int16_t  world_y;
    int16_t  vel_y;
    uint8_t  on_ground;
    uint8_t  dead;
} Player;

static inline void player_init(Player *p, uint16_t start_x, int16_t start_y) {
    p->world_x   = start_x;
    p->world_y   = start_y;
    p->vel_y     = 0;
    p->on_ground = 0;
    p->dead      = 0;
}

static inline uint8_t col_point(
        uint16_t px, int16_t py,
        const uint8_t *map, uint16_t map_w, uint16_t map_h
) {
    return col_at(px, py, map, map_w, map_h);
}

static inline uint8_t player_update(
        Player *p,
        uint8_t joy,
        const uint8_t *map,
        uint16_t map_w,
        uint16_t map_h
) {
    if (p->dead) return 1;

    // --- Gravity ---
    if (!p->on_ground) {
        p->vel_y += GRAVITY;
        if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
    }

    // --- Jump: hold A to jump, re-jumps when landing (GD style) ---
    if ((joy & J_A) && p->on_ground) {
        p->vel_y     = JUMP_FORCE;
        p->on_ground = 0;
    }

    // --- Vertical movement: step 1px at a time ---
    int8_t pixels = (int8_t)(p->vel_y >> 4);
    int8_t step   = (pixels >= 0) ? 1 : -1;
    int8_t steps  = (pixels >= 0) ? pixels : -pixels;
    if (steps > 16) steps = 16;

    p->on_ground = 0;

    for (int8_t i = 0; i < steps; i++) {
        int16_t ny = p->world_y + step;

        if (step > 0) {
            // Moving DOWN — solid collision uses full hitbox
            uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
            uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
            if (IS_SOLID(cl) || IS_SOLID(cr)) {
                p->world_y   = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
                p->vel_y     = 0;
                p->on_ground = 1;
                break;
            }
        } else {
            // Moving UP — solid collision uses full hitbox
            uint8_t cl = col_point(p->world_x,               ny, map, map_w, map_h);
            uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny, map, map_w, map_h);
            if (IS_SOLID(cl) || IS_SOLID(cr)) {
                p->world_y = ((ny >> 4) + 1) << 4;
                p->vel_y   = 0;
                break;
            }
        }
        p->world_y = ny;
    }

    // --- Hazard check: smaller inner hitbox (2px forgiveness each side) ---
    // This makes spikes feel fair — you have to clearly touch them
    uint16_t hx1 = p->world_x  + PLAYER_HBOX;
    uint16_t hx2 = p->world_x  + PLAYER_SIZE - PLAYER_HBOX;
    int16_t  hy1 = p->world_y  + PLAYER_HBOX;
    int16_t  hy2 = p->world_y  + PLAYER_SIZE - PLAYER_HBOX;

    if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
        IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
        IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
        IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
        p->dead = 1;
        return 1;
    }

    // --- Side wall collision (mid height, full hitbox) ---
    uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
    uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
    if (IS_SOLID(cm_l) || IS_SOLID(cm_r)) {
        p->dead = 1;
        return 1;
    }

    // --- Fell off bottom ---
    if (p->world_y > (int16_t)((uint16_t)map_h << 4)) {
        p->dead = 1;
        return 1;
    }

    return 0;
}

static inline int16_t player_screen_y(const Player *p, uint16_t cam_py) {
    return p->world_y - (int16_t)cam_py;
}

#endif // PLAYER_H