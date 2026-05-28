#ifndef TEST_LEVEL_H
#define TEST_LEVEL_H

#include <stdint.h>

#define TEST_LEVEL_WIDTH 10
#define TEST_LEVEL_HEIGHT 9
#define TEST_LEVEL_TILE_WIDTH (TEST_LEVEL_WIDTH * 2)
#define TEST_LEVEL_TILE_HEIGHT (TEST_LEVEL_HEIGHT * 2)

extern const uint8_t level_map[];

#endif /* TEST_LEVEL_H */
