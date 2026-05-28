#include <gbdk/incbin.h>
#include "assets.h"

INCBIN(tiles_test,            "levels/level_data/test_tiles.zx0")
INCBIN(map_test,              "levels/level_data/test_map.zx0")
INCBIN(test,                  "levels/level_data/test.zx0")
INCBIN(tileset,               "levels/level_data/tileset.zx0")
INCBIN(famidash_chr_tiles,    "levels/famidash/famidash_chr_tiles.bin")
INCBIN(stereomadness_screen0, "levels/level_data/stereomadness_screen0.bin")
INCBIN(stereomadness_screen3, "levels/level_data/stereomadness_screen3.bin")
// 16-row crop (rows 11-26), 894x16 = ~14KB. Fits in one 16KB bank.
// Includes full obstacle height — portals, high blocks, floor all visible.
INCBIN(stereomadness_16high,  "levels/level_data/stereomadness_16high.bin")

INCBIN_EXTERN(tiles_test)
INCBIN_EXTERN(map_test)
INCBIN_EXTERN(test)
INCBIN_EXTERN(tileset)
INCBIN_EXTERN(famidash_chr_tiles)
INCBIN_EXTERN(stereomadness_screen0)
INCBIN_EXTERN(stereomadness_screen3)
INCBIN_EXTERN(stereomadness_16high)

//                      name            tiles                 map                    tile_count  map_w  map_h  tiles_c  map_c
        const Level level_0 = { "PRUEBA 1",    tiles_test,           map_test,               73,         10,    9,     1,       1 };
        const Level level_1 = { "TEST00",      tileset,              test,                   64,         10,    9,     1,       1 };
        const Level level_2 = { "SM START",    famidash_chr_tiles,   stereomadness_screen0,  256,        10,    9,     0,       0 };
        const Level level_3 = { "SM SCREEN3",  famidash_chr_tiles,   stereomadness_screen3,  256,        10,    9,     0,       0 };
        const Level level_4 = { "STEREO MADNESS",   famidash_chr_tiles,   stereomadness_16high,   256,        894,   16,    0,       0 };

        const Level * const game_levels[] = {
                &level_0, &level_1, &level_2, &level_3, &level_4
        };

        const uint8_t MAX_LEVELS = sizeof(game_levels) / sizeof(game_levels[0]);