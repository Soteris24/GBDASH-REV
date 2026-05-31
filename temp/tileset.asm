;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module tileset
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_famidash_chr_tiles
	.globl ___func_famidash_chr_tiles
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
	.area _CODE_1
;src/tileset.c:6: INCBIN(famidash_chr_tiles, "levels/famidash/famidash_chr_tiles.bin")
;	---------------------------------
; Function __func_famidash_chr_tiles
; ---------------------------------
	b___func_famidash_chr_tiles	= 1
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
	.area _CODE_1
	.area _INITIALIZER
	.area _CABS (ABS)
