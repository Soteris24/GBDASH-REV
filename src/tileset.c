// tileset.c — famidash graphics in bank 1
// Kept separate so it never competes with code in bank 0.
#pragma bank 1
#include <gbdk/incbin.h>

INCBIN(famidash_chr_tiles, "levels/famidash/famidash_chr_tiles.bin")
INCBIN_EXTERN(famidash_chr_tiles)