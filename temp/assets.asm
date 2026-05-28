;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module assets
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _MAX_LEVELS
	.globl _game_levels
	.globl _level_4
	.globl _level_3
	.globl _level_2
	.globl _level_1
	.globl _level_0
	.globl b___func_stereomadness_16high
	.globl ___func_stereomadness_16high
	.globl b___func_stereomadness_screen3
	.globl ___func_stereomadness_screen3
	.globl b___func_stereomadness_screen0
	.globl ___func_stereomadness_screen0
	.globl b___func_famidash_chr_tiles
	.globl ___func_famidash_chr_tiles
	.globl b___func_tileset
	.globl ___func_tileset
	.globl b___func_test
	.globl ___func_test
	.globl b___func_map_test
	.globl ___func_map_test
	.globl b___func_tiles_test
	.globl ___func_tiles_test
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/assets.c:4: INCBIN(tiles_test,            "levels/level_data/test_tiles.zx0")
;	---------------------------------
; Function __func_tiles_test
; ---------------------------------
	b___func_tiles_test	= 0
___func_tiles_test::
_tiles_test::
1$:
	.incbin "levels/level_data/test_tiles.zx0" 
2$:
	___size_tiles_test = (2$-1$) 
	.globl ___size_tiles_test 
	.local b___func_tiles_test 
	___bank_tiles_test = b___func_tiles_test 
	.globl ___bank_tiles_test 
;src/assets.c:5: INCBIN(map_test,              "levels/level_data/test_map.zx0")
;	---------------------------------
; Function __func_map_test
; ---------------------------------
	b___func_map_test	= 0
___func_map_test::
_map_test::
1$:
	.incbin "levels/level_data/test_map.zx0" 
2$:
	___size_map_test = (2$-1$) 
	.globl ___size_map_test 
	.local b___func_map_test 
	___bank_map_test = b___func_map_test 
	.globl ___bank_map_test 
;src/assets.c:6: INCBIN(test,                  "levels/level_data/test.zx0")
;	---------------------------------
; Function __func_test
; ---------------------------------
	b___func_test	= 0
___func_test::
_test::
1$:
	.incbin "levels/level_data/test.zx0" 
2$:
	___size_test = (2$-1$) 
	.globl ___size_test 
	.local b___func_test 
	___bank_test = b___func_test 
	.globl ___bank_test 
;src/assets.c:7: INCBIN(tileset,               "levels/level_data/tileset.zx0")
;	---------------------------------
; Function __func_tileset
; ---------------------------------
	b___func_tileset	= 0
___func_tileset::
_tileset::
1$:
	.incbin "levels/level_data/tileset.zx0" 
2$:
	___size_tileset = (2$-1$) 
	.globl ___size_tileset 
	.local b___func_tileset 
	___bank_tileset = b___func_tileset 
	.globl ___bank_tileset 
;src/assets.c:8: INCBIN(famidash_chr_tiles,    "levels/famidash/famidash_chr_tiles.bin")
;	---------------------------------
; Function __func_famidash_chr_tiles
; ---------------------------------
	b___func_famidash_chr_tiles	= 0
___func_famidash_chr_tiles::
_famidash_chr_tiles::
1$:
	.incbin "levels/famidash/famidash_chr_tiles.bin" 
2$:
	___size_famidash_chr_tiles = (2$-1$) 
	.globl ___size_famidash_chr_tiles 
	.local b___func_famidash_chr_tiles 
	___bank_famidash_chr_tiles = b___func_famidash_chr_tiles 
	.globl ___bank_famidash_chr_tiles 
;src/assets.c:9: INCBIN(stereomadness_screen0, "levels/level_data/stereomadness_screen0.bin")
;	---------------------------------
; Function __func_stereomadness_screen0
; ---------------------------------
	b___func_stereomadness_screen0	= 0
___func_stereomadness_screen0::
_stereomadness_screen0::
1$:
	.incbin "levels/level_data/stereomadness_screen0.bin" 
2$:
	___size_stereomadness_screen0 = (2$-1$) 
	.globl ___size_stereomadness_screen0 
	.local b___func_stereomadness_screen0 
	___bank_stereomadness_screen0 = b___func_stereomadness_screen0 
	.globl ___bank_stereomadness_screen0 
;src/assets.c:10: INCBIN(stereomadness_screen3, "levels/level_data/stereomadness_screen3.bin")
;	---------------------------------
; Function __func_stereomadness_screen3
; ---------------------------------
	b___func_stereomadness_screen3	= 0
___func_stereomadness_screen3::
_stereomadness_screen3::
1$:
	.incbin "levels/level_data/stereomadness_screen3.bin" 
2$:
	___size_stereomadness_screen3 = (2$-1$) 
	.globl ___size_stereomadness_screen3 
	.local b___func_stereomadness_screen3 
	___bank_stereomadness_screen3 = b___func_stereomadness_screen3 
	.globl ___bank_stereomadness_screen3 
;src/assets.c:13: INCBIN(stereomadness_16high,  "levels/level_data/stereomadness_16high.bin")
;	---------------------------------
; Function __func_stereomadness_16high
; ---------------------------------
	b___func_stereomadness_16high	= 0
___func_stereomadness_16high::
_stereomadness_16high::
1$:
	.incbin "levels/level_data/stereomadness_16high.bin" 
2$:
	___size_stereomadness_16high = (2$-1$) 
	.globl ___size_stereomadness_16high 
	.local b___func_stereomadness_16high 
	___bank_stereomadness_16high = b___func_stereomadness_16high 
	.globl ___bank_stereomadness_16high 
	.area _CODE
_level_0:
	.dw __str_0
	.dw _tiles_test
	.dw _map_test
	.dw #0x0049
	.dw #0x000a
	.dw #0x0009
	.db #0x01	; 1
	.db #0x01	; 1
_level_1:
	.dw __str_1
	.dw _tileset
	.dw _test
	.dw #0x0040
	.dw #0x000a
	.dw #0x0009
	.db #0x01	; 1
	.db #0x01	; 1
_level_2:
	.dw __str_2
	.dw _famidash_chr_tiles
	.dw _stereomadness_screen0
	.dw #0x0100
	.dw #0x000a
	.dw #0x0009
	.db #0x00	; 0
	.db #0x00	; 0
_level_3:
	.dw __str_3
	.dw _famidash_chr_tiles
	.dw _stereomadness_screen3
	.dw #0x0100
	.dw #0x000a
	.dw #0x0009
	.db #0x00	; 0
	.db #0x00	; 0
_level_4:
	.dw __str_4
	.dw _famidash_chr_tiles
	.dw _stereomadness_16high
	.dw #0x0100
	.dw #0x037e
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
_game_levels:
	.dw _level_0
	.dw _level_1
	.dw _level_2
	.dw _level_3
	.dw _level_4
_MAX_LEVELS:
	.db #0x05	; 5
__str_0:
	.ascii "PRUEBA 1"
	.db 0x00
__str_1:
	.ascii "TEST00"
	.db 0x00
__str_2:
	.ascii "SM START"
	.db 0x00
__str_3:
	.ascii "SM SCREEN3"
	.db 0x00
__str_4:
	.ascii "STEREO MADNESS"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)
