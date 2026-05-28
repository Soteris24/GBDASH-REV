#ifndef VERIFY_STEREO_H
#define VERIFY_STEREO_H

#include <stdint.h>

#define VERIFY_STEREO_WIDTH 10
#define VERIFY_STEREO_HEIGHT 9
#define VERIFY_STEREO_TILE_WIDTH (VERIFY_STEREO_WIDTH * 2)
#define VERIFY_STEREO_TILE_HEIGHT (VERIFY_STEREO_HEIGHT * 2)

extern const uint8_t level_map[];

#endif /* VERIFY_STEREO_H */
