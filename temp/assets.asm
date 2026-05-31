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
	.globl _level_pg
	.globl _level_bot
	.globl _level_sm
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
	.area _CODE
_level_sm:
	.dw __str_0
	.dw _famidash_chr_tiles
	.dw _stereomadness_map
	.dw #0x0100
	.dw #0x037e
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_stereomadness_map
_level_bot:
	.dw __str_1
	.dw _famidash_chr_tiles
	.dw _backontrack_map
	.dw #0x0100
	.dw #0x034e
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_backontrack_map
_level_pg:
	.dw __str_2
	.dw _famidash_chr_tiles
	.dw _polargeist_map
	.dw #0x0100
	.dw #0x03a6
	.dw #0x0010
	.db #0x00	; 0
	.db #0x00	; 0
	.byte ___bank_polargeist_map
_game_levels:
	.dw _level_sm
	.dw _level_bot
	.dw _level_pg
_MAX_LEVELS:
	.db #0x03	; 3
__str_0:
	.ascii "STEREO MAD"
	.db 0x00
__str_1:
	.ascii "BACK ON TRACK"
	.db 0x00
__str_2:
	.ascii "POLARGEIST"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)
