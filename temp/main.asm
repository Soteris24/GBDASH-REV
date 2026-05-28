;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _load_level
	.globl _draw_menu
	.globl _load_bkg_tileset
	.globl _draw_metatile_map
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
	.ds 4096
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
;src/main.c:18: void play_music_safe(void) {
;	---------------------------------
; Function play_music_safe
; ---------------------------------
_play_music_safe::
;src/main.c:19: if (music_ready) {
	ld	a, (#_music_ready)
	or	a, a
;src/main.c:20: hUGE_dosound();
	jp	NZ, _hUGE_dosound
;src/main.c:22: }
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
;src/main.c:24: void setup_menu_font(void) {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
_setup_menu_font::
;src/main.c:25: font_init();
	call	_font_init
;src/main.c:26: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/main.c:27: }
	ret
;src/main.c:30: void draw_metatile_map(uint16_t map_width, uint8_t width, uint8_t height, const uint8_t *map_array) {
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
;src/main.c:31: for (uint8_t y = 0; y < height; y++) {
	ldhl	sp,	#10
	ld	(hl), #0x00
00107$:
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#14
	sub	a, (hl)
	jp	NC, 00109$
;src/main.c:32: for (uint8_t x = 0; x < width; x++) {
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
;src/main.c:33: uint8_t metatile_id = map_array[(uint16_t)y * map_width + x];
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
;src/main.c:35: set_bkg_tiles(x << 1, y << 1, 2, 1, &metatiles[metatile_id][0]);
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
;src/main.c:36: set_bkg_tiles(x << 1, (y << 1) + 1, 2, 1, &metatiles[metatile_id][2]);
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
;src/main.c:32: for (uint8_t x = 0; x < width; x++) {
	ldhl	sp,	#11
	inc	(hl)
	jp	00104$
00108$:
;src/main.c:31: for (uint8_t y = 0; y < height; y++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	00107$
00109$:
;src/main.c:39: }
	add	sp, #12
	pop	hl
	add	sp, #3
	jp	(hl)
;src/main.c:41: void load_bkg_tileset(const uint8_t *tiles, uint16_t tile_count) {
;	---------------------------------
; Function load_bkg_tileset
; ---------------------------------
_load_bkg_tileset::
;src/main.c:42: if (tile_count == 256u) {
	ld	l, c
	ld	h, b
	ld	a, l
	or	a, a
	jr	NZ, 00102$
	dec	h
	jr	NZ, 00102$
;src/main.c:43: set_bkg_data(0, 128, tiles);
	push	de
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
	pop	de
;src/main.c:44: set_bkg_data(128, 128, tiles + (128u * 16u));
	ld	hl, #0x0800
	add	hl, de
	push	hl
	ld	hl, #0x8080
	push	hl
	call	_set_bkg_data
	add	sp, #4
	ret
00102$:
;src/main.c:46: set_bkg_data(0, (uint8_t)tile_count, tiles);
	ld	a, c
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:48: }
	ret
;src/main.c:50: void draw_menu(void) {   
;	---------------------------------
; Function draw_menu
; ---------------------------------
_draw_menu::
;src/main.c:51: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/main.c:52: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/main.c:53: printf("GBDREV PREBUILD 01 \n\n");
	ld	de, #___str_1
	call	_puts
;src/main.c:54: for(uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/main.c:55: gotoxy(1, 2 + i); 
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
;src/main.c:57: printf("0 %s", game_levels[i]->name);
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	ld	b, l
	ld	e, h
;src/main.c:56: if (i == selected) {
	ld	a, (#_selected)
	sub	a, c
	jr	NZ, 00102$
;src/main.c:57: printf("0 %s", game_levels[i]->name);
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
;src/main.c:59: printf("  %s", game_levels[i]->name);
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
;src/main.c:54: for(uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/main.c:62: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:63: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/main.c:64: }
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
;src/main.c:66: void load_level(uint8_t idx) {
;	---------------------------------
; Function load_level
; ---------------------------------
_load_level::
	add	sp, #-8
	ld	e, a
;src/main.c:67: const Level *l = game_levels[idx];
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
;src/main.c:73: DISPLAY_OFF;
	call	_display_off
;src/main.c:76: if (l->tiles_are_compressed) {
	pop	de
	push	de
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;src/main.c:77: zx0_decompress(l->tiles, buffer);
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:76: if (l->tiles_are_compressed) {
	ld	a, c
	or	a, a
	jr	Z, 00102$
;src/main.c:77: zx0_decompress(l->tiles, buffer);
	ld	bc, #_buffer
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_zx0_decompress
;src/main.c:78: tile_data = buffer;
	ldhl	sp,	#6
	ld	a, #<(_buffer)
	ld	(hl+), a
	ld	(hl), #>(_buffer)
;src/main.c:80: tile_data = l->tiles;
00102$:
;src/main.c:82: load_bkg_tileset(tile_data, l->tile_count);
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_load_bkg_tileset
;src/main.c:85: if (l->map_is_compressed) {
	pop	de
	push	de
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#7
	ld	(hl), a
;src/main.c:86: zx0_decompress(l->map, buffer);
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:85: if (l->map_is_compressed) {
	ldhl	sp,	#7
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
;src/main.c:86: zx0_decompress(l->map, buffer);
	ld	e, c
	ld	d, b
	ld	bc, #_buffer
	call	_zx0_decompress
;src/main.c:87: map_data = buffer;
	ldhl	sp,	#2
	ld	a, #<(_buffer)
	ld	(hl+), a
	ld	(hl), #>(_buffer)
	jr	00106$
00105$:
;src/main.c:89: map_data = l->map;
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00106$:
;src/main.c:92: draw_width = (l->map_width > 10) ? 10 : l->map_width;
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	e, c
	ld	d, b
	ld	a, #0x0a
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00112$
	ld	bc, #0x000a
00112$:
	ldhl	sp,	#6
	ld	(hl), c
;src/main.c:93: draw_height = (l->map_height > 9) ? 9 : l->map_height;
	pop	de
	push	de
	ld	hl, #0x000a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, c
	ld	d, b
	ld	a, #0x09
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00114$
	ld	bc, #0x0009
00114$:
	ldhl	sp,	#7
	ld	(hl), c
;src/main.c:96: fill_bkg_rect(0, 0, 20, 18, 0); 
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
;src/main.c:97: draw_metatile_map(l->map_width, draw_width, draw_height, map_data);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#9
	ld	a, (hl-)
	push	af
	inc	sp
	ld	a, (hl)
	ld	e, c
	ld	d, b
	call	_draw_metatile_map
;src/main.c:99: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:100: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:103: waitpadup();
	call	_waitpadup
;src/main.c:104: while(!(joypad() & J_START)) {
00107$:
	call	_joypad
	rlca
	jr	C, 00109$
;src/main.c:105: wait_vbl_done();
	call	_wait_vbl_done
	jr	00107$
00109$:
;src/main.c:108: waitpadup();
	call	_waitpadup
;src/main.c:109: setup_menu_font();
	call	_setup_menu_font
;src/main.c:110: redraw = 1; 
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/main.c:111: }
	add	sp, #8
	ret
;src/main.c:113: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:114: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/main.c:117: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:118: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:119: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:121: hUGE_init(&song_stereoma);
	ld	de, #_song_stereoma
	call	_hUGE_init
;src/main.c:122: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;src/main.c:125: TMA_REG = 224;
	ld	a, #0xe0
	ldh	(_TMA_REG + 0), a
;src/main.c:126: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/main.c:127: add_TIM(play_music_safe);  
	ld	de, #_play_music_safe
	call	_add_TIM
;src/main.c:129: set_interrupts(VBL_IFLAG | TIM_IFLAG);
	ld	a, #0x05
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:132: setup_menu_font(); 
	call	_setup_menu_font
;src/main.c:134: while(1) {
00116$:
;src/main.c:135: if(redraw) {
	ld	a, (#_redraw)
	or	a, a
	jr	Z, 00102$
;src/main.c:136: draw_menu();
	call	_draw_menu
00102$:
;src/main.c:139: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:141: if (joy & J_UP) {
	push	hl
	bit	2, (hl)
	pop	hl
	jr	Z, 00113$
;src/main.c:142: if (selected > 0) {
	ld	hl, #_selected
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
;src/main.c:143: selected--; 
	dec	(hl)
;src/main.c:144: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
00104$:
;src/main.c:146: waitpadup();
	call	_waitpadup
	jr	00114$
00113$:
;src/main.c:148: else if (joy & J_DOWN) {
	push	hl
	ldhl	sp,	#2
	bit	3, (hl)
	pop	hl
	jr	Z, 00110$
;src/main.c:149: if (selected < MAX_LEVELS - 1) {
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
	jr	Z, 00172$
	bit	7, d
	jr	NZ, 00173$
	cp	a, a
	jr	00173$
00172$:
	bit	7, d
	jr	Z, 00173$
	scf
00173$:
	jr	NC, 00106$
;src/main.c:150: selected++; 
	ld	hl, #_selected
	inc	(hl)
;src/main.c:151: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
00106$:
;src/main.c:153: waitpadup();
	call	_waitpadup
	jr	00114$
00110$:
;src/main.c:155: else if (joy & J_A) {
	push	hl
	ldhl	sp,	#2
	bit	4, (hl)
	pop	hl
	jr	Z, 00114$
;src/main.c:156: load_level(selected);
	ld	a, (_selected)
	call	_load_level
00114$:
;src/main.c:159: wait_vbl_done();
	call	_wait_vbl_done
	jr	00116$
;src/main.c:161: }
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
