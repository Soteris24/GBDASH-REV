// assets.c — NO #pragma bank = bank 0 (home bank, always accessible)
// Level structs must be in bank 0 so main.c can read them without switching.
#include <gbdk/incbin.h>
#include "assets.h"

// Forward declarations — data lives in their own bank files
BANKREF_EXTERN(famidash_chr_tiles)
        extern const uint8_t famidash_chr_tiles[];

                BANKREF_EXTERN(stereomadness_map)
extern const uint8_t stereomadness_map[];

BANKREF_EXTERN(backontrack_map)
        extern const uint8_t backontrack_map[];

                BANKREF_EXTERN(polargeist_map)
extern const uint8_t polargeist_map[];

const Level level_sm = {
        "STEREO MAD",
        famidash_chr_tiles,
        stereomadness_map,
        256, 894, 16, 0, 0,
        BANK(stereomadness_map)
};

const Level level_bot = {
        "BACK ON TRACK",
        famidash_chr_tiles,
        backontrack_map,
        256, 846, 16, 0, 0,
        BANK(backontrack_map)
};

const Level level_pg = {
        "POLARGEIST",
        famidash_chr_tiles,
        polargeist_map,
        256, 934, 16, 0, 0,
        BANK(polargeist_map)
};

const Level * const game_levels[] = { &level_sm, &level_bot, &level_pg };
const uint8_t MAX_LEVELS = 3;