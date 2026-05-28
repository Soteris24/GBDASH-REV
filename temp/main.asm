;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _play_level_scroll
	.globl _load_level
	.globl _draw_menu
	.globl _fill_scroll_bg
	.globl _draw_mt_row
	.globl _draw_mt_column
	.globl _draw_metatile_map
	.globl _load_bkg_tileset
	.globl _setup_menu_font
	.globl _play_music_safe
	.globl _hUGE_dosound
	.globl _hUGE_init
	.globl _puts
	.globl _printf
	.globl _zx0_decompress
	.globl _gotoxy
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _fill_bkg_rect
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _waitpadup
	.globl _joypad
	.globl _add_TIM
	.globl _redraw
	.globl _selected
	.globl _music_ready
	.globl _famidash_metatile_collision
	.globl _famidash_metatile_palettes
	.globl _metatiles
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_buffer:
	.ds 2048
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_music_ready::
	.ds 1
_selected::
	.ds 1
_redraw::
	.ds 1
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
;src/main.c:19: void play_music_safe(void) {
;	---------------------------------
; Function play_music_safe
; ---------------------------------
_play_music_safe::
;src/main.c:20: if (music_ready) hUGE_dosound();
	ld	a, (#_music_ready)
	or	a, a
	jp	NZ, _hUGE_dosound
;src/main.c:21: }
	ret
_metatiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0xda	; 218
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0xe0	; 224
	.db #0xe1	; 225
	.db #0xe4	; 228
	.db #0xe5	; 229
	.db #0xe2	; 226
	.db #0xe3	; 227
	.db #0xe6	; 230
	.db #0xe7	; 231
	.db #0xe8	; 232
	.db #0xe9	; 233
	.db #0xec	; 236
	.db #0xed	; 237
	.db #0xea	; 234
	.db #0xeb	; 235
	.db #0xee	; 238
	.db #0xef	; 239
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x2e	; 46
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x46	; 70	'F'
	.db #0x43	; 67	'C'
	.db #0x56	; 86	'V'
	.db #0x53	; 83	'S'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x42	; 66	'B'
	.db #0x47	; 71	'G'
	.db #0x52	; 82	'R'
	.db #0x57	; 87	'W'
	.db #0x40	; 64
	.db #0x45	; 69	'E'
	.db #0x52	; 82	'R'
	.db #0x57	; 87	'W'
	.db #0x44	; 68	'D'
	.db #0x41	; 65	'A'
	.db #0x56	; 86	'V'
	.db #0x53	; 83	'S'
	.db #0x46	; 70	'F'
	.db #0x43	; 67	'C'
	.db #0x54	; 84	'T'
	.db #0x51	; 81	'Q'
	.db #0x42	; 66	'B'
	.db #0x47	; 71	'G'
	.db #0x50	; 80	'P'
	.db #0x55	; 85	'U'
	.db #0x48	; 72	'H'
	.db #0x47	; 71	'G'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x56	; 86	'V'
	.db #0x59	; 89	'Y'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x58	; 88	'X'
	.db #0x57	; 87	'W'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x44	; 68	'D'
	.db #0x41	; 65	'A'
	.db #0x54	; 84	'T'
	.db #0x51	; 81	'Q'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x40	; 64
	.db #0x45	; 69	'E'
	.db #0x50	; 80	'P'
	.db #0x55	; 85	'U'
	.db #0xac	; 172
	.db #0xad	; 173
	.db #0xbc	; 188
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xae	; 174
	.db #0xaf	; 175
	.db #0xbe	; 190
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x01	; 1
	.db #0x04	; 4
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x63	; 99	'c'
	.db #0x76	; 118	'v'
	.db #0x73	; 115	's'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x62	; 98	'b'
	.db #0x67	; 103	'g'
	.db #0x72	; 114	'r'
	.db #0x77	; 119	'w'
	.db #0x60	; 96
	.db #0x65	; 101	'e'
	.db #0x72	; 114	'r'
	.db #0x77	; 119	'w'
	.db #0x64	; 100	'd'
	.db #0x61	; 97	'a'
	.db #0x76	; 118	'v'
	.db #0x73	; 115	's'
	.db #0x66	; 102	'f'
	.db #0x63	; 99	'c'
	.db #0x74	; 116	't'
	.db #0x71	; 113	'q'
	.db #0x62	; 98	'b'
	.db #0x67	; 103	'g'
	.db #0x70	; 112	'p'
	.db #0x75	; 117	'u'
	.db #0x68	; 104	'h'
	.db #0x67	; 103	'g'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x69	; 105	'i'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x76	; 118	'v'
	.db #0x79	; 121	'y'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x78	; 120	'x'
	.db #0x77	; 119	'w'
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x64	; 100	'd'
	.db #0x61	; 97	'a'
	.db #0x74	; 116	't'
	.db #0x71	; 113	'q'
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x60	; 96
	.db #0x65	; 101	'e'
	.db #0x70	; 112	'p'
	.db #0x75	; 117	'u'
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x4b	; 75	'K'
	.db #0x10	; 16
	.db #0x4b	; 75	'K'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x5b	; 91
	.db #0x5b	; 91
	.db #0x4a	; 74	'J'
	.db #0x10	; 16
	.db #0x4a	; 74	'J'
	.db #0x10	; 16
	.db #0x4c	; 76	'L'
	.db #0x5a	; 90	'Z'
	.db #0x4a	; 74	'J'
	.db #0x10	; 16
	.db #0x5a	; 90	'Z'
	.db #0x4d	; 77	'M'
	.db #0x10	; 16
	.db #0x4b	; 75	'K'
	.db #0x10	; 16
	.db #0x4b	; 75	'K'
	.db #0x5b	; 91
	.db #0x5d	; 93
	.db #0x4a	; 74	'J'
	.db #0x10	; 16
	.db #0x5c	; 92
	.db #0x5b	; 91
	.db #0x4e	; 78	'N'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x4f	; 79	'O'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x5f	; 95
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x5e	; 94
	.db #0x10	; 16
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5b	; 91
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x5a	; 90	'Z'
	.db #0x4d	; 77	'M'
	.db #0x5b	; 91
	.db #0x5d	; 93
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x4c	; 76	'L'
	.db #0x5a	; 90	'Z'
	.db #0x5c	; 92
	.db #0x5b	; 91
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0xd0	; 208
	.db #0xd1	; 209
	.db #0xc2	; 194
	.db #0xc3	; 195
	.db #0xd2	; 210
	.db #0xd3	; 211
	.db #0xc4	; 196
	.db #0x00	; 0
	.db #0xd4	; 212
	.db #0xd5	; 213
	.db #0xc6	; 198
	.db #0xc7	; 199
	.db #0xd6	; 214
	.db #0xd7	; 215
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x7c	; 124
	.db #0x7d	; 125
	.db #0xc8	; 200
	.db #0xc9	; 201
	.db #0xd8	; 216
	.db #0xd9	; 217
	.db #0xca	; 202
	.db #0xcb	; 203
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0xcc	; 204
	.db #0xcd	; 205
	.db #0xdc	; 220
	.db #0xdd	; 221
	.db #0xce	; 206
	.db #0xcf	; 207
	.db #0xde	; 222
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc5	; 197
	.db #0xda	; 218
	.db #0xdf	; 223
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x7a	; 122	'z'
	.db #0x7b	; 123
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc5	; 197
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x7f	; 127
	.db #0x8f	; 143
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x7a	; 122	'z'
	.db #0x7b	; 123
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x00	; 0
	.db #0x6a	; 106	'j'
	.db #0x6e	; 110	'n'
	.db #0x7a	; 122	'z'
	.db #0x6b	; 107	'k'
	.db #0x00	; 0
	.db #0x7b	; 123
	.db #0x6e	; 110	'n'
	.db #0x00	; 0
	.db #0x6a	; 106	'j'
	.db #0x00	; 0
	.db #0x7a	; 122	'z'
	.db #0x6b	; 107	'k'
	.db #0x00	; 0
	.db #0x7b	; 123
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xaf	; 175
	.db #0xae	; 174
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x90	; 144
	.db #0xbb	; 187
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xba	; 186
	.db #0x91	; 145
	.db #0x82	; 130
	.db #0xab	; 171
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0xaa	; 170
	.db #0x83	; 131
	.db #0x93	; 147
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x94	; 148
	.db #0x95	; 149
	.db #0x84	; 132
	.db #0x85	; 133
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0x86	; 134
	.db #0x87	; 135
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x96	; 150
	.db #0x97	; 151
	.db #0x88	; 136
	.db #0x89	; 137
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x98	; 152
	.db #0x99	; 153
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x9a	; 154
	.db #0x9b	; 155
	.db #0x8a	; 138
	.db #0x8b	; 139
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa1	; 161
	.db #0x00	; 0
	.db #0xb1	; 177
	.db #0xa0	; 160
	.db #0xab	; 171
	.db #0xb0	; 176
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0xa3	; 163
	.db #0xba	; 186
	.db #0xb3	; 179
	.db #0xa2	; 162
	.db #0x00	; 0
	.db #0xb2	; 178
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa5	; 165
	.db #0x00	; 0
	.db #0xb5	; 181
	.db #0xa4	; 164
	.db #0xab	; 171
	.db #0xb4	; 180
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0xa7	; 167
	.db #0xba	; 186
	.db #0xb7	; 183
	.db #0xa6	; 166
	.db #0x00	; 0
	.db #0xb6	; 182
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0xab	; 171
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0xa9	; 169
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xba	; 186
	.db #0xb9	; 185
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xb8	; 184
	.db #0xbb	; 187
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x08	; 8
	.db #0x2d	; 45
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2f	; 47
	.db #0x3c	; 60
	.db #0x19	; 25
	.db #0x2e	; 46
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x3d	; 61
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x56	; 86	'V'
	.db #0x10	; 16
	.db #0x46	; 70	'F'
	.db #0x10	; 16
	.db #0x56	; 86	'V'
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x94	; 148
	.db #0x95	; 149
	.db #0x84	; 132
	.db #0x85	; 133
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x42	; 66	'B'
	.db #0x47	; 71	'G'
	.db #0x52	; 82	'R'
	.db #0x57	; 87	'W'
	.db #0x42	; 66	'B'
	.db #0x47	; 71	'G'
	.db #0x50	; 80	'P'
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x40	; 64
	.db #0x45	; 69	'E'
	.db #0x52	; 82	'R'
	.db #0x57	; 87	'W'
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0xac	; 172
	.db #0x00	; 0
	.db #0xbc	; 188
	.db #0xad	; 173
	.db #0x00	; 0
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xae	; 174
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xaf	; 175
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xbe	; 190
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xac	; 172
	.db #0xad	; 173
	.db #0xbc	; 188
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2d	; 45
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x32	; 50	'2'
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x23	; 35
	.db #0x22	; 34
	.db #0x33	; 51	'3'
	.db #0x32	; 50	'2'
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0x71	; 113	'q'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x35	; 53	'5'
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x24	; 36
	.db #0x35	; 53	'5'
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x41	; 65	'A'
	.db #0x56	; 86	'V'
	.db #0x53	; 83	'S'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_metatile_palettes:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_famidash_metatile_collision:
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x80	; 128
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x80	; 128
	.db #0x04	; 4
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x80	; 128
	.db #0x03	; 3
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x80	; 128
	.db #0x05	; 5
	.db #0x80	; 128
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
;src/main.c:23: void setup_menu_font(void) {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
_setup_menu_font::
;src/main.c:24: font_init();
	call	_font_init
;src/main.c:25: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/main.c:26: }
	ret
;src/main.c:28: void load_bkg_tileset(const uint8_t *tiles, uint16_t tile_count) {
;	---------------------------------
; Function load_bkg_tileset
; ---------------------------------
_load_bkg_tileset::
;src/main.c:29: if (tile_count == 256u) {
	ld	l, c
	ld	h, b
	ld	a, l
	or	a, a
	jr	NZ, 00102$
	dec	h
	jr	NZ, 00102$
;src/main.c:30: set_bkg_data(0,   128, tiles);
	push	de
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
	pop	de
;src/main.c:31: set_bkg_data(128, 128, tiles + (128u * 16u));
	ld	hl, #0x0800
	add	hl, de
	push	hl
	ld	hl, #0x8080
	push	hl
	call	_set_bkg_data
	add	sp, #4
	ret
00102$:
;src/main.c:33: set_bkg_data(0, (uint8_t)tile_count, tiles);
	ld	a, c
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:35: }
	ret
;src/main.c:37: void draw_metatile_map(uint16_t map_w, uint8_t cols, uint8_t rows,
;	---------------------------------
; Function draw_metatile_map
; ---------------------------------
_draw_metatile_map::
	add	sp, #-12
	ldhl	sp,	#8
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;src/main.c:39: for (uint8_t y = 0; y < rows; y++) {
	ldhl	sp,	#10
	ld	(hl), #0x00
00107$:
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#14
	sub	a, (hl)
	jp	NC, 00109$
;src/main.c:40: for (uint8_t x = 0; x < cols; x++) {
	ldhl	sp,	#10
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#11
	ld	(hl), #0x00
00104$:
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#7
	sub	a, (hl)
	jp	NC, 00108$
;src/main.c:41: uint8_t mt = map[(uint16_t)y * map_w + x];
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	e, a
	xor	a, a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	d, a
	call	__mulint
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	pop	de
	push	de
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;src/main.c:42: set_bkg_tiles(x << 1, y << 1,       2, 1, &metatiles[mt][0]);
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00141$:
	ldhl	sp,	#3
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00141$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_metatiles
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#3
	ld	(hl-), a
	pop	de
	push	de
	push	de
	ld	de, #0x102
	push	de
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:43: set_bkg_tiles(x << 1, (y << 1) + 1, 2, 1, &metatiles[mt][2]);
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	inc	(hl)
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	de, #0x102
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:40: for (uint8_t x = 0; x < cols; x++) {
	ldhl	sp,	#11
	inc	(hl)
	jp	00104$
00108$:
;src/main.c:39: for (uint8_t y = 0; y < rows; y++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	00107$
00109$:
;src/main.c:46: }
	add	sp, #12
	pop	hl
	add	sp, #3
	jp	(hl)
;src/main.c:61: void draw_mt_column(uint8_t bkg_col, uint16_t map_col,
;	---------------------------------
; Function draw_mt_column
; ---------------------------------
_draw_mt_column::
	add	sp, #-4
	ldhl	sp,	#1
	ld	(hl), e
	inc	hl
	ld	(hl), d
;src/main.c:63: uint8_t bx = bkg_col << 1;
	dec	hl
	dec	hl
	add	a, a
	ld	(hl), a
;src/main.c:64: for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
	ldhl	sp,	#3
	ld	(hl), #0x00
00104$:
	ldhl	sp,	#3
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00106$
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00106$
;src/main.c:65: uint8_t mt = map[(uint16_t)r * map_w + map_col];
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#1
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;src/main.c:66: uint8_t by = (r & (BKG_MT_H - 1)) << 1;   // ring wrap on Y
	ldhl	sp,	#3
	ld	a, (hl)
	and	a, #0x0f
	add	a, a
	ld	e, a
;src/main.c:67: set_bkg_tiles(bx, by,     2, 1, &metatiles[mt][0]);
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_metatiles)
	ld	c, a
	ld	a, h
	adc	a, #>(_metatiles)
	ld	b, a
	ld	l, c
	ld	h, b
	push	de
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	d, #0x02
	push	de
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/main.c:68: set_bkg_tiles(bx, by + 1, 2, 1, &metatiles[mt][2]);
	inc	bc
	inc	bc
	inc	e
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	ld	d, #0x02
	push	de
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:64: for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
	ldhl	sp,	#3
	inc	(hl)
	jr	00104$
00106$:
;src/main.c:70: }
	add	sp, #4
	pop	hl
	add	sp, #6
	jp	(hl)
;src/main.c:73: void draw_mt_row(uint8_t bkg_row, uint16_t map_row,
;	---------------------------------
; Function draw_mt_row
; ---------------------------------
_draw_mt_row::
	add	sp, #-6
;src/main.c:76: uint8_t by = bkg_row << 1;
	add	a, a
	ldhl	sp,	#2
	ld	(hl), a
;src/main.c:77: for (uint16_t c = 0; c < visible_cols; c++) {
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#3
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	bc, #0x0000
00105$:
	ldhl	sp,	#10
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00107$
;src/main.c:78: uint16_t mc = cam_x_col + c;
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
;src/main.c:79: if (mc >= map_w) break;
	ldhl	sp,	#0
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00107$
;src/main.c:80: uint8_t mt = map[(uint16_t)map_row * map_w + mc];
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
;src/main.c:81: uint8_t bx = (uint8_t)((mc & (BKG_MT_W - 1)) << 1);
	ldhl	sp,	#0
	ld	a, (hl)
	and	a, #0x0f
	add	a, a
	ldhl	sp,	#5
	ld	(hl), a
;src/main.c:82: set_bkg_tiles(bx, by,     2, 1, &metatiles[mt][0]);
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_metatiles)
	ld	e, a
	ld	a, h
	adc	a, #>(_metatiles)
	ld	d, a
	ld	l, e
	ld	h, d
	push	de
	push	hl
	ld	hl, #0x102
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/main.c:83: set_bkg_tiles(bx, by + 1, 2, 1, &metatiles[mt][2]);
	inc	de
	inc	de
	ldhl	sp,	#2
	ld	a, (hl)
	inc	a
	push	de
	ld	h, #0x01
	push	hl
	inc	sp
	ld	h, #0x02
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:77: for (uint16_t c = 0; c < visible_cols; c++) {
	inc	bc
	jp	00105$
00107$:
;src/main.c:85: }
	add	sp, #6
	pop	hl
	add	sp, #8
	jp	(hl)
;src/main.c:88: void fill_scroll_bg(const uint8_t *map, uint16_t map_w, uint16_t map_h) {
;	---------------------------------
; Function fill_scroll_bg
; ---------------------------------
_fill_scroll_bg::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:89: uint16_t cols = (map_w < BKG_MT_W) ? map_w : BKG_MT_W;
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x10
	ld	a, d
	sbc	a, #0x00
	jr	C, 00108$
	ld	e, #0x10
00108$:
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
;src/main.c:90: for (uint16_t c = 0; c < cols; c++) {
	ld	de, #0x0000
	ld	(hl), e
00103$:
	ldhl	sp,	#0
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00105$
;src/main.c:91: draw_mt_column((uint8_t)(c % BKG_MT_W), c, map, map_w, map_h);
	ld	a, e
	and	a, #0x0f
	push	bc
	push	de
	push	af
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	push	bc
	push	af
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	call	_draw_mt_column
	pop	de
	pop	bc
;src/main.c:90: for (uint16_t c = 0; c < cols; c++) {
	inc	de
	jr	00103$
00105$:
;src/main.c:93: }
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/main.c:98: void draw_menu(void) {
;	---------------------------------
; Function draw_menu
; ---------------------------------
_draw_menu::
;src/main.c:99: fill_bkg_rect(0, 0, 20, 18, 0x00);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/main.c:100: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/main.c:101: printf("GBDREV PREBUILD 01 \n\n");
	ld	de, #___str_1
	call	_puts
;src/main.c:102: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/main.c:103: gotoxy(1, 2 + i);
	ld	a,c
	cp	a,b
	jr	NC, 00104$
	add	a, #0x02
	push	bc
	ld	h, a
	ld	l, #0x01
	push	hl
	call	_gotoxy
	pop	hl
	pop	bc
;src/main.c:104: if (i == selected) printf("0 %s", game_levels[i]->name);
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	ld	b, l
	ld	e, h
	ld	a, (#_selected)
	sub	a, c
	jr	NZ, 00102$
	ld	l, b
	ld	h, e
	ld	de, #_game_levels
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
	pop	bc
	jr	00107$
00102$:
;src/main.c:105: else               printf("  %s", game_levels[i]->name);
	ld	a, #<(_game_levels)
	add	a, b
	ld	l, a
	ld	a, #>(_game_levels)
	adc	a, e
	ld	h, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00107$:
;src/main.c:102: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/main.c:107: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:108: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/main.c:109: }
	ret
___str_1:
	.ascii "GBDREV PREBUILD 01 "
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "0 %s"
	.db 0x00
___str_3:
	.ascii "  %s"
	.db 0x00
;src/main.c:114: void load_level(uint8_t idx) {
;	---------------------------------
; Function load_level
; ---------------------------------
_load_level::
	add	sp, #-7
	ld	e, a
;src/main.c:115: const Level *l = game_levels[idx];
	ld	bc, #_game_levels+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:119: DISPLAY_OFF;
	call	_display_off
;src/main.c:121: if (l->tiles_are_compressed) {
	pop	de
	push	de
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;src/main.c:122: zx0_decompress(l->tiles, buffer);
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:121: if (l->tiles_are_compressed) {
	ld	a, c
	or	a, a
	jr	Z, 00102$
;src/main.c:122: zx0_decompress(l->tiles, buffer);
	ld	bc, #_buffer
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_zx0_decompress
;src/main.c:123: tile_data = buffer;
	ldhl	sp,	#5
	ld	a, #<(_buffer)
	ld	(hl+), a
	ld	(hl), #>(_buffer)
;src/main.c:125: tile_data = l->tiles;
00102$:
;src/main.c:127: load_bkg_tileset(tile_data, l->tile_count);
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/main.c:129: if (l->map_is_compressed) {
	pop	de
	push	de
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#6
	ld	(hl), a
;src/main.c:130: zx0_decompress(l->map, buffer);
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:129: if (l->map_is_compressed) {
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
;src/main.c:130: zx0_decompress(l->map, buffer);
	ld	e, c
	ld	d, b
	ld	bc, #_buffer
	call	_zx0_decompress
;src/main.c:131: map_data = buffer;
	ldhl	sp,	#2
	ld	a, #<(_buffer)
	ld	(hl+), a
	ld	(hl), #>(_buffer)
	jr	00106$
00105$:
;src/main.c:133: map_data = l->map;
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00106$:
;src/main.c:136: uint8_t cols = (l->map_width  > VIEW_MT_W) ? VIEW_MT_W : (uint8_t)l->map_width;
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	e, l
	ld	d, h
	ld	a, #0x0a
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00112$
	ld	a, #0x0a
	jr	00113$
00112$:
	ld	a, l
00113$:
	ldhl	sp,	#4
	ld	(hl), a
;src/main.c:137: uint8_t rows = (l->map_height > VIEW_MT_H) ? VIEW_MT_H : (uint8_t)l->map_height;
	pop	de
	push	de
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	e, l
	ld	d, h
	ld	a, #0x09
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00114$
	ld	e, #0x09
	jr	00115$
00114$:
	ld	e, l
00115$:
	ldhl	sp,	#6
	ld	(hl), e
;src/main.c:139: fill_bkg_rect(0, 0, 20, 18, 0);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/main.c:140: draw_metatile_map(l->map_width, cols, rows, map_data);
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#8
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	ld	e, c
	ld	d, b
	call	_draw_metatile_map
;src/main.c:142: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:143: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:145: waitpadup();
	call	_waitpadup
;src/main.c:146: while (!(joypad() & J_START)) wait_vbl_done();
00107$:
	call	_joypad
	rlca
	jr	C, 00109$
	call	_wait_vbl_done
	jr	00107$
00109$:
;src/main.c:147: waitpadup();
	call	_waitpadup
;src/main.c:148: setup_menu_font();
	call	_setup_menu_font
;src/main.c:149: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/main.c:150: }
	add	sp, #7
	ret
;src/main.c:167: void play_level_scroll(uint8_t idx) {
;	---------------------------------
; Function play_level_scroll
; ---------------------------------
_play_level_scroll::
	add	sp, #-21
	ld	e, a
;src/main.c:168: const Level *l     = game_levels[idx];
	ld	bc, #_game_levels+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#17
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:169: const uint8_t *map = l->map;
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:170: uint16_t map_w     = l->map_width;
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:171: uint16_t map_h     = l->map_height;   // 16
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:173: uint16_t cam_px    = 0;               // horizontal camera, pixels
	xor	a, a
	ldhl	sp,	#19
	ld	(hl+), a
	ld	(hl), a
;src/main.c:174: uint16_t cam_py    = 0;               // vertical camera, pixels
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
;src/main.c:177: uint16_t max_px    = (map_w - VIEW_MT_W) << 4;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#16
	ld	(hl-), a
	ld	(hl), e
	ld	a, #0x04
00280$:
	ldhl	sp,	#15
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00280$
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;src/main.c:180: uint16_t max_py    = (map_h - VIEW_MT_H) << 4;  // (16-9)*16 = 112
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#16
	ld	(hl-), a
	ld	(hl), e
	ld	a, #0x04
00281$:
	ldhl	sp,	#15
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00281$
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#13
;src/main.c:183: uint16_t loaded_right = BKG_MT_W - 1;
	ld	(hl+), a
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/main.c:185: DISPLAY_OFF;
	call	_display_off
;src/main.c:186: load_bkg_tileset(l->tiles, l->tile_count);
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	l, (hl)
	ld	e, a
	ld	d, l
	call	_load_bkg_tileset
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/main.c:188: fill_scroll_bg(map, map_w, map_h);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/main.c:189: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:190: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:192: waitpadup();
	call	_waitpadup
;src/main.c:194: while (1) {
00140$:
;src/main.c:195: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:197: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#16
	ld	(hl), a
;src/main.c:198: if (joy & J_START) break;
	push	hl
	bit	7, (hl)
	pop	hl
	jp	NZ, 00141$
;src/main.c:204: cam_px += SCROLL_SPEED;
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/main.c:201: if (joy & J_RIGHT) {
	push	hl
	dec	hl
	dec	hl
	bit	0, (hl)
	pop	hl
	jp	Z, 00123$
;src/main.c:202: if (cam_px < max_px) {
	ldhl	sp,	#19
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00124$
;src/main.c:203: uint16_t prev_col = cam_px >> 4;
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/main.c:204: cam_px += SCROLL_SPEED;
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	inc	bc
	inc	bc
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:205: if (cam_px > max_px) cam_px = max_px;
	ldhl	sp,	#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#19
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00104$
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
00104$:
;src/main.c:206: uint16_t curr_col = cam_px >> 4;
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/main.c:208: if (curr_col != prev_col) {
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NZ, 00285$
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#18
	sub	a, (hl)
	jp	Z, 00124$
00285$:
;src/main.c:209: uint16_t need_col = curr_col + VIEW_MT_W;
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;src/main.c:210: if (need_col > loaded_right && need_col < map_w) {
	ldhl	sp,	#14
	ld	e, l
	ld	d, h
	ldhl	sp,	#17
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00124$
	ldhl	sp,	#17
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00124$
;src/main.c:211: loaded_right = need_col;
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#15
;src/main.c:212: draw_mt_column((uint8_t)(need_col % BKG_MT_W),
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	ld	c, (hl)
	and	a, #0x0f
	ldhl	sp,	#6
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#6
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#6
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#23
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_draw_mt_column
	jr	00124$
00123$:
;src/main.c:217: } else if (joy & J_LEFT) {
	push	hl
	ldhl	sp,	#18
	bit	1, (hl)
	pop	hl
	jr	Z, 00124$
;src/main.c:218: if (cam_px > 0) {
	ldhl	sp,	#20
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00124$
;src/main.c:219: if (cam_px < SCROLL_SPEED) cam_px = 0;
	dec	hl
	dec	hl
	ld	a, (hl+)
	sub	a, #0x02
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00113$
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00114$
00113$:
;src/main.c:220: else cam_px -= SCROLL_SPEED;
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#20
	ld	(hl-), a
	ld	(hl), e
00114$:
;src/main.c:223: uint16_t curr_col = cam_px >> 4;
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/main.c:224: if (curr_col < loaded_right && loaded_right > BKG_MT_W) {
	ldhl	sp,	#14
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00124$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x10
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00124$
;src/main.c:225: draw_mt_column((uint8_t)(curr_col % BKG_MT_W),
	ld	a, e
	and	a, #0x0f
	ldhl	sp,	#6
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ldhl	sp,	#6
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ldhl	sp,	#6
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_draw_mt_column
00124$:
;src/main.c:235: cam_py += SCROLL_SPEED;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:233: if (joy & J_DOWN) {
	push	hl
	ldhl	sp,	#18
	bit	3, (hl)
	pop	hl
	jr	Z, 00137$
;src/main.c:234: if (cam_py < max_py) {
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00138$
;src/main.c:235: cam_py += SCROLL_SPEED;
	inc	bc
	inc	bc
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:236: if (cam_py > max_py) cam_py = max_py;
	ldhl	sp,	#12
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00138$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	jr	00138$
00137$:
;src/main.c:238: } else if (joy & J_UP) {
	push	hl
	ldhl	sp,	#18
	bit	2, (hl)
	pop	hl
	jr	Z, 00138$
;src/main.c:239: if (cam_py > 0) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00138$
;src/main.c:240: if (cam_py < SCROLL_SPEED) cam_py = 0;
	ld	a, c
	sub	a, #0x02
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00130$
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00138$
00130$:
;src/main.c:241: else cam_py -= SCROLL_SPEED;
	dec	bc
	dec	bc
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00138$:
;src/main.c:247: move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
	ldhl	sp,	#8
	ld	c, (hl)
	ldhl	sp,	#19
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/main.c:247: move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
	jp	00140$
00141$:
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/main.c:251: waitpadup();
	call	_waitpadup
;src/main.c:252: setup_menu_font();
	call	_setup_menu_font
;src/main.c:253: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/main.c:254: }
	add	sp, #21
	ret
;src/main.c:259: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:260: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/main.c:261: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:262: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:263: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:265: hUGE_init(&song_stereoma);
	ld	de, #_song_stereoma
	call	_hUGE_init
;src/main.c:266: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;src/main.c:268: TMA_REG = 224;
	ld	a, #0xe0
	ldh	(_TMA_REG + 0), a
;src/main.c:269: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/main.c:270: add_TIM(play_music_safe);
	ld	de, #_play_music_safe
	call	_add_TIM
;src/main.c:272: set_interrupts(VBL_IFLAG | TIM_IFLAG);
	ld	a, #0x05
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:275: setup_menu_font();
	call	_setup_menu_font
;src/main.c:277: while (1) {
00119$:
;src/main.c:278: if (redraw) draw_menu();
	ld	a, (#_redraw)
	or	a, a
	jr	Z, 00102$
	call	_draw_menu
00102$:
;src/main.c:279: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:281: if (joy & J_UP) {
	push	hl
	bit	2, (hl)
	pop	hl
	jr	Z, 00116$
;src/main.c:282: if (selected > 0) { selected--; redraw = 1; }
	ld	hl, #_selected
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	dec	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00104$:
;src/main.c:283: waitpadup();
	call	_waitpadup
	jr	00117$
00116$:
;src/main.c:284: } else if (joy & J_DOWN) {
	push	hl
	ldhl	sp,	#2
	bit	3, (hl)
	pop	hl
	jr	Z, 00113$
;src/main.c:285: if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
	ld	a, (_MAX_LEVELS)
	ld	b, #0x00
	ld	c, a
	dec	bc
	ld	a, (_selected)
	ld	l, a
	ld	h, #0x00
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 00182$
	bit	7, d
	jr	NZ, 00183$
	cp	a, a
	jr	00183$
00182$:
	bit	7, d
	jr	Z, 00183$
	scf
00183$:
	jr	NC, 00106$
	ld	hl, #_selected
	inc	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00106$:
;src/main.c:286: waitpadup();
	call	_waitpadup
	jr	00117$
00113$:
;src/main.c:287: } else if (joy & J_A) {
	push	hl
	ldhl	sp,	#2
	bit	4, (hl)
	pop	hl
	jr	Z, 00117$
;src/main.c:288: if (selected == 4) play_level_scroll(selected);
	ld	a, (#_selected)
	sub	a, #0x04
	jr	NZ, 00108$
	ld	a, (_selected)
	call	_play_level_scroll
	jr	00117$
00108$:
;src/main.c:289: else               load_level(selected);
	ld	a, (_selected)
	call	_load_level
00117$:
;src/main.c:292: wait_vbl_done();
	call	_wait_vbl_done
	jp	00119$
;src/main.c:294: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__music_ready:
	.db #0x00	; 0
__xinit__selected:
	.db #0x00	; 0
__xinit__redraw:
	.db #0x01	; 1
	.area _CABS (ABS)
