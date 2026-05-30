#ifndef PLAYER_H
#define PLAYER_H

#include <gb/gb.h>
#include <stdint.h>
#include "collision.h"

// -------------------------------------------------------
// Player constants — tweak these to feel right
// -------------------------------------------------------
#define PLAYER_SCREEN_X   32    // fixed screen X (pixels from left)
#define PLAYER_SIZE       15    // hitbox size (16px - 1 for zero-index)

// Fixed-point physics (1 unit = 1/16th pixel)
#define GRAVITY           8
#define JUMP_FORCE       -85
#define MAX_FALL_SPEED    80

// -------------------------------------------------------
// Player state
// -------------------------------------------------------
typedef struct {
    uint16_t world_x;       // world X in pixels (follows auto-scroll)
    int16_t  world_y;       // world Y in pixels (0 = top of 16high map)
    int16_t  vel_y;         // vertical velocity (fixed-point /16)
    uint8_t  on_ground;     // 1 = standing on solid tile
    uint8_t  dead;          // 1 = hit hazard or fell off
    uint8_t  jump_held;     // tracks previous A button state
} Player;

// -------------------------------------------------------
// Init
// -------------------------------------------------------
static inline void player_init(Player *p, uint16_t start_x, int16_t start_y) {
    p->world_x   = start_x;
    p->world_y   = start_y;
    p->vel_y     = 0;
    p->on_ground  = 0;
    p->dead       = 0;
    p->jump_held  = 0;
}

// -------------------------------------------------------
// Collision point helpers
// -------------------------------------------------------
static inline uint8_t col_point(
    uint16_t px, int16_t py,
    const uint8_t *map, uint16_t map_w, uint16_t map_h
) {
    return col_at(px, py, map, map_w, map_h);
}

// -------------------------------------------------------
// Update — call once per frame
// Returns 1 if player died, 0 if alive
// -------------------------------------------------------
static inline uint8_t player_update(
    Player *p,
    uint8_t joy,
    const uint8_t *map,
    uint16_t map_w,
    uint16_t map_h
) {
    if (p->dead) return 1;

    uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
    uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
    p->on_ground = (IS_SOLID(foot_l) || IS_SOLID(foot_r)) ? 1 : 0;

    // --- Gravity ---
    if (!p->on_ground) {
        p->vel_y += GRAVITY;
        if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
    }

    // --- Jump: A button, only on ground, no hold-to-rejump ---
    uint8_t a_now = (joy & J_A) ? 1u : 0u;
    if (a_now && !p->jump_held && p->on_ground) {
        p->vel_y = JUMP_FORCE;
        p->on_ground = 0; // We just jumped, so we aren't on the ground anymore
    }
    p->jump_held = a_now;

    // --- Vertical movement: step 1px at a time to avoid tunneling ---
    int8_t pixels = (int8_t)(p->vel_y >> 4);
    int8_t step   = (pixels >= 0) ? 1 : -1;
    int8_t steps  = (pixels >= 0) ? pixels : -pixels;
    if (steps > 16) steps = 16;

    p->on_ground = 0;

    for (int8_t i = 0; i < steps; i++) {
        int16_t ny = p->world_y + step;

        if (step > 0) {
            // Moving DOWN — check bottom-left and bottom-right corners
            uint8_t cl = col_point(p->world_x,              ny + PLAYER_SIZE, map, map_w, map_h);
            uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny + PLAYER_SIZE, map, map_w, map_h);

            if (IS_HAZARD(cl) || IS_HAZARD(cr)) { p->dead = 1; return 1; }
            if (IS_SOLID(cl)  || IS_SOLID(cr)) {
                // Snap to top of tile
                p->world_y   = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
                p->vel_y     = 0;
                p->on_ground = 1;
                break;
            }
        } else {
            // Moving UP — check top-left and top-right corners
            uint8_t cl = col_point(p->world_x,              ny, map, map_w, map_h);
            uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny, map, map_w, map_h);

            if (IS_HAZARD(cl) || IS_HAZARD(cr)) { p->dead = 1; return 1; }
            if (IS_SOLID(cl)  || IS_SOLID(cr)) {
                // Snap to bottom of tile (hit ceiling)
                p->world_y = ((ny >> 4) + 1) << 4;
                p->vel_y   = 0;
                break;
            }
        }
        p->world_y = ny;
    }

    // --- Side collision: check left/right mid-height ---
    // In GD, hitting a wall always kills you
    uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
    uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
    if (IS_HAZARD(cm_l) || IS_HAZARD(cm_r) ||
        IS_SOLID(cm_l)  || IS_SOLID(cm_r)) {
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

// -------------------------------------------------------
// Screen Y position for drawing the sprite
// cam_py = camera vertical offset in pixels
// -------------------------------------------------------
static inline int16_t player_screen_y(const Player *p, uint16_t cam_py) {
    return p->world_y - (int16_t)cam_py;
}

#endif // PLAYER_H
