;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _play_level
	.globl _draw_menu
	.globl _fill_scroll_bg
	.globl _draw_mt_column
	.globl _load_bkg_tileset
	.globl _setup_menu_font
	.globl _play_music_safe
	.globl _hUGE_dosound
	.globl _hUGE_init
	.globl _puts
	.globl _printf
	.globl _gotoxy
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _waitpadup
	.globl _joypad
	.globl _add_TIM
	.globl _selected
	.globl _redraw
	.globl _music_ready
	.globl _cube_tiles
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_music_ready::
	.ds 1
_redraw::
	.ds 1
_selected::
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
;include/collision.h:39: static inline uint8_t col_of(uint8_t tile_id) {
;	---------------------------------
; Function col_of
; ---------------------------------
_col_of:
	ld	c, a
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	hl, #_famidash_metatile_collision
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
;include/collision.h:41: }
	ret
;include/collision.h:46: static inline uint8_t col_at(
;	---------------------------------
; Function col_at
; ---------------------------------
_col_at:
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ld	h, b
	bit	7, h
	jr	Z, 00102$
	xor	a, a
	jr	00107$
00102$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#2
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#3
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ld	e, c
	ld	d, b
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00103$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00104$
00103$:
	ld	a, #0x07
	jr	00107$
00104$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	pop	hl
	push	hl
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
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	hl, #_famidash_metatile_collision
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
00107$:
;include/collision.h:58: }
	add	sp, #4
	pop	hl
	add	sp, #6
	jp	(hl)
;include/player.h:35: static inline void player_init(Player *p, uint16_t start_x, int16_t start_y) {
;	---------------------------------
; Function player_init
; ---------------------------------
_player_init:
;include/player.h:36: p->world_x   = start_x;
	ld	l, e
	ld	h, d
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:37: p->world_y   = start_y;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;include/player.h:38: p->vel_y     = 0;
	ld	hl, #0x0004
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:39: p->on_ground  = 0;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
;include/player.h:40: p->dead       = 0;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x00
;include/player.h:41: p->jump_held  = 0;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x00
;include/player.h:42: }
	pop	hl
	pop	af
	jp	(hl)
;include/player.h:47: static inline uint8_t col_point(
;	---------------------------------
; Function col_point
; ---------------------------------
_col_point:
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;include/player.h:51: return col_at(px, py, map, map_w, map_h);
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ld	h, b
	bit	7, h
	jr	Z, 00102$
	ld	c, #0x00
	jr	00107$
00102$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ld	e, c
	ld	d, b
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00104$
	ldhl	sp,	#14
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00105$
00104$:
	ld	c, #0x07
	jr	00107$
00105$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	pop	bc
	push	bc
	call	__mulint
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	hl, #_famidash_metatile_collision
	ld	b, #0x00
	add	hl, bc
	ld	c, (hl)
;include/player.h:51: return col_at(px, py, map, map_w, map_h);
00107$:
	ld	a, c
;include/player.h:52: }
	add	sp, #8
	pop	hl
	add	sp, #6
	jp	(hl)
;include/player.h:58: static inline uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update:
	add	sp, #-37
	ldhl	sp,	#34
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;include/player.h:65: if (p->dead) return 1;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#36
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00245$
00102$:
;include/player.h:67: uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#25
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00179$
	ldhl	sp,	#36
	ld	(hl), #0x00
	jp	00184$
00179$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#29
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#30
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#32
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
;include/player.h:67: uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#27
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00181$
	ldhl	sp,	#31
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00182$
00181$:
	ldhl	sp,	#36
	ld	(hl), #0x07
	jr	00184$
00182$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#29
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#36
	ld	(hl), a
	ld	de, #_famidash_metatile_collision
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#36
	ld	(hl), a
00184$:
;include/player.h:68: uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00187$
	ld	c, #0x00
	jr	00192$
00187$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#32
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#23
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
;include/player.h:68: uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	push	de
	ldhl	sp,	#33
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00189$
	ldhl	sp,	#4
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00190$
00189$:
	ld	c, #0x07
	jr	00192$
00190$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	hl, #_famidash_metatile_collision
	ld	b, #0x00
	add	hl, bc
	ld	c, (hl)
00192$:
;include/player.h:69: p->on_ground = (IS_SOLID(foot_l) || IS_SOLID(foot_r)) ? 1 : 0;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00250$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00250$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00250$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00250$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00250$
	cp	a,#0x09
	jr	Z, 00250$
	cp	a,#0x05
	jr	Z, 00250$
	sub	a, #0x06
	jr	NZ, 00247$
00250$:
	ld	c, #0x01
	jr	00248$
00247$:
	ld	c, #0x00
00248$:
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;include/player.h:73: p->vel_y += GRAVITY;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl), a
;include/player.h:72: if (!p->on_ground) {
	ld	a, c
	or	a, a
	jr	NZ, 00106$
;include/player.h:73: p->vel_y += GRAVITY;
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:74: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x50
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00888$
	bit	7, d
	jr	NZ, 00889$
	cp	a, a
	jr	00889$
00888$:
	bit	7, d
	jr	Z, 00889$
	scf
00889$:
	jr	NC, 00106$
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x50
	ld	(hl+), a
	ld	(hl), #0x00
00106$:
;include/player.h:78: uint8_t a_now = (joy & J_A) ? 1u : 0u;
	push	hl
	ldhl	sp,	#35
	bit	4, (hl)
	pop	hl
	ld	a, #0x01
	jr	NZ, 00271$
	xor	a, a
00271$:
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#28
	ld	(hl), a
;include/player.h:79: if (a_now && !p->jump_held && p->on_ground) {
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	or	a, a
	jr	Z, 00108$
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#36
	ld	(hl), a
	or	a, a
	jr	NZ, 00108$
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00108$
;include/player.h:80: p->vel_y = JUMP_FORCE;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xab
	ld	(hl+), a
	ld	(hl), #0xff
;include/player.h:81: p->on_ground = 0; // We just jumped, so we aren't on the ground anymore
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00108$:
;include/player.h:83: p->jump_held = a_now;
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;include/player.h:86: int8_t pixels = (int8_t)(p->vel_y >> 4);
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
;include/player.h:87: int8_t step   = (pixels >= 0) ? 1 : -1;
	ld	a, c
	rlca
	and	a,#0x01
	ld	b, a
	bit	0, b
	ld	a, #0x01
	jr	Z, 00273$
	ld	a, #0xff
00273$:
	ldhl	sp,	#18
	ld	(hl), a
;include/player.h:88: int8_t steps  = (pixels >= 0) ? pixels : -pixels;
	bit	0, b
	jr	Z, 00275$
	xor	a, a
	sub	a, c
	ld	c, a
00275$:
	ldhl	sp,	#19
	ld	(hl), c
;include/player.h:89: if (steps > 16) steps = 16;
	ld	e, (hl)
	ld	a,#0x10
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00891$
	bit	7, d
	jr	NZ, 00892$
	cp	a, a
	jr	00892$
00891$:
	bit	7, d
	jr	Z, 00892$
	scf
00892$:
	jr	NC, 00112$
	ldhl	sp,	#19
	ld	(hl), #0x10
00112$:
;include/player.h:91: p->on_ground = 0;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;include/player.h:93: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#18
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00893$
	bit	7, d
	jr	NZ, 00894$
	cp	a, a
	jr	00894$
00893$:
	bit	7, d
	jr	Z, 00894$
	scf
00894$:
	ld	a, #0x00
	rla
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#36
	ld	(hl), #0x00
00243$:
	ldhl	sp,	#19
	ld	e, (hl)
	ldhl	sp,	#36
	ld	a,(hl)
	ld	d,a
	ldhl	sp,	#19
	sub	a, (hl)
	bit	7, e
	jr	Z, 00895$
	bit	7, d
	jr	NZ, 00896$
	cp	a, a
	jr	00896$
00895$:
	bit	7, d
	jr	Z, 00896$
	scf
00896$:
	jp	NC, 00156$
;include/player.h:94: int16_t ny = p->world_y + step;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#33
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#32
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
;include/player.h:67: uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;include/player.h:98: uint8_t cl = col_point(p->world_x,              ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#30
;include/player.h:99: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
;include/player.h:96: if (step > 0) {
	ldhl	sp,	#20
	ld	a, (hl)
	or	a, a
	jp	Z, 00154$
;include/player.h:98: uint8_t cl = col_point(p->world_x,              ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00195$
	ldhl	sp,	#32
	ld	(hl), #0x00
	jr	00200$
00195$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#32
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	dec	hl
	dec	hl
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
;include/player.h:98: uint8_t cl = col_point(p->world_x,              ny + PLAYER_SIZE, map, map_w, map_h);
	push	de
	ldhl	sp,	#33
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00197$
	ldhl	sp,	#4
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00198$
00197$:
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00200$
00198$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00200$:
	ldhl	sp,	#32
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;include/player.h:99: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, b
	jr	Z, 00203$
	ldhl	sp,	#32
	ld	(hl), #0x00
	jp	00208$
00203$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#32
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#29
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
;include/player.h:99: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#31
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00205$
	ldhl	sp,	#28
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00206$
00205$:
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00208$
00206$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00208$:
;include/player.h:101: if (IS_HAZARD(cl) || IS_HAZARD(cr)) { p->dead = 1; return 1; }
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00113$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00113$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00113$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00113$
	ldhl	sp,	#30
	ld	a, (hl)
	dec	a
	jr	Z, 00113$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00113$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00113$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00113$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00113$
	ldhl	sp,	#32
	ld	a, (hl)
	dec	a
	jr	NZ, 00114$
00113$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,#0x01
	ld	(hl),a
	jp	00245$
00114$:
;include/player.h:102: if (IS_SOLID(cl)  || IS_SOLID(cr)) {
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00124$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00124$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00124$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00124$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00124$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00124$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00124$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x06
	jp	NZ, 00155$
00124$:
;include/player.h:104: p->world_y   = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#25
	ld	a, (hl)
	and	a, #0xf0
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;include/player.h:105: p->vel_y     = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:106: p->on_ground = 1;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;include/player.h:107: break;
	jp	00156$
00154$:
;include/player.h:111: uint8_t cl = col_point(p->world_x,              ny, map, map_w, map_h);
	ldhl	sp,	#30
	ld	a, (hl)
	rlca
	and	a,#0x01
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#28
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;include/player.h:111: uint8_t cl = col_point(p->world_x,              ny, map, map_w, map_h);
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00211$
	inc	hl
	inc	hl
	ld	(hl), #0x00
	jr	00216$
00211$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#32
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#28
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;include/player.h:111: uint8_t cl = col_point(p->world_x,              ny, map, map_w, map_h);
	ldhl	sp,	#31
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00213$
	ldhl	sp,	#26
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00214$
00213$:
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00216$
00214$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00216$:
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
;include/player.h:112: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny, map, map_w, map_h);
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00219$
	inc	hl
	inc	hl
	ld	(hl), #0x00
	jr	00224$
00219$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#32
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
;include/player.h:112: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny, map, map_w, map_h);
	ldhl	sp,	#31
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00221$
	ldhl	sp,	#25
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00222$
00221$:
	ldhl	sp,	#32
	ld	(hl), #0x07
	jr	00224$
00222$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#31
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
00224$:
;include/player.h:114: if (IS_HAZARD(cl) || IS_HAZARD(cr)) { p->dead = 1; return 1; }
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00133$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00133$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00133$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00133$
	ldhl	sp,	#27
	ld	a, (hl)
	dec	a
	jr	Z, 00133$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00133$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00133$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00133$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00133$
	ldhl	sp,	#32
	ld	a, (hl)
	dec	a
	jr	NZ, 00134$
00133$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a,#0x01
	ld	(hl),a
	jp	00245$
00134$:
;include/player.h:115: if (IS_SOLID(cl)  || IS_SOLID(cr)) {
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00144$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00144$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00144$
	ldhl	sp,	#27
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00144$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00144$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00144$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00144$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00155$
00144$:
;include/player.h:117: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x04
00937$:
	ldhl	sp,	#31
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00937$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;include/player.h:118: p->vel_y   = 0;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:119: break;
	jr	00156$
00155$:
;include/player.h:122: p->world_y = ny;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;include/player.h:93: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#36
	inc	(hl)
	jp	00243$
00156$:
;include/player.h:67: uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
;include/player.h:127: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, (hl)
	add	a, #0x07
	ld	b, a
	ld	a, c
	adc	a, #0x00
	ldhl	sp,	#25
	ld	(hl), b
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#29
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00227$
	ldhl	sp,	#36
	ld	(hl), #0x00
	jp	00232$
00227$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#24
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;include/player.h:127: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#23
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00229$
	ldhl	sp,	#27
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00230$
00229$:
	ldhl	sp,	#36
	ld	(hl), #0x07
	jr	00232$
00230$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#23
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
00232$:
;include/player.h:128: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#25
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, (hl)
	dec	hl
	add	a, #0x0f
	ld	b, a
	ld	a, c
	adc	a, #0x00
	ld	(hl), b
	inc	hl
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, b
	jr	Z, 00235$
	inc	hl
	inc	hl
	ld	(hl), #0x00
	jp	00240$
00235$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#26
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	inc	hl
	inc	hl
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
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
;include/player.h:128: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#25
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00237$
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00238$
00237$:
	ldhl	sp,	#30
	ld	(hl), #0x07
	jr	00240$
00238$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #_famidash_metatile_collision
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
00240$:
;include/player.h:129: if (IS_HAZARD(cm_l) || IS_HAZARD(cm_r) ||
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00157$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00157$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00157$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00157$
	ldhl	sp,	#36
	ld	a, (hl)
	dec	a
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	dec	a
	jr	Z, 00157$
;include/player.h:130: IS_SOLID(cm_l)  || IS_SOLID(cm_r)) {
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00157$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00157$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00157$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00157$
	ldhl	sp,	#30
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00158$
00157$:
;include/player.h:131: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;include/player.h:132: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00245$
00158$:
;include/player.h:136: if (p->world_y > (int16_t)((uint16_t)map_h << 4)) {
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	b, (hl)
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	ld	c, a
	ldhl	sp,	#31
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00958$
	bit	7, d
	jr	NZ, 00959$
	cp	a, a
	jr	00959$
00958$:
	bit	7, d
	jr	Z, 00959$
	scf
00959$:
	jr	NC, 00177$
;include/player.h:137: p->dead = 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;include/player.h:138: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00245$
00177$:
;include/player.h:141: return 0;
	xor	a, a
00245$:
;include/player.h:142: }
	add	sp, #37
	pop	hl
	add	sp, #6
	jp	(hl)
;include/player.h:148: static inline int16_t player_screen_y(const Player *p, uint16_t cam_py) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y:
;include/player.h:149: return p->world_y - (int16_t)cam_py;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	l, (hl)
	sub	a, c
	ld	c, a
	ld	a, l
	sbc	a, b
	ld	b, a
;include/player.h:150: }
	ret
;src/main.c:24: void play_music_safe(void) {
;	---------------------------------
; Function play_music_safe
; ---------------------------------
_play_music_safe::
;src/main.c:25: if (music_ready) hUGE_dosound();
	ld	a, (#_music_ready)
	or	a, a
	jp	NZ, _hUGE_dosound
;src/main.c:26: }
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
_cube_tiles:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
;src/main.c:28: void setup_menu_font(void) {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
_setup_menu_font::
;src/main.c:29: font_init();
	call	_font_init
;src/main.c:30: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/main.c:31: }
	ret
;src/main.c:33: void load_bkg_tileset(const uint8_t* tiles, uint16_t tile_count) {
;	---------------------------------
; Function load_bkg_tileset
; ---------------------------------
_load_bkg_tileset::
;src/main.c:34: if (tile_count == 256u) {
	ld	l, c
	ld	h, b
	ld	a, l
	or	a, a
	jr	NZ, 00102$
	dec	h
	jr	NZ, 00102$
;src/main.c:35: set_bkg_data(0, 128, tiles);
	push	de
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
	pop	de
;src/main.c:36: set_bkg_data(128, 128, tiles + (128u * 16u));
	ld	hl, #0x0800
	add	hl, de
	push	hl
	ld	hl, #0x8080
	push	hl
	call	_set_bkg_data
	add	sp, #4
	ret
00102$:
;src/main.c:39: set_bkg_data(0, (uint8_t)tile_count, tiles);
	ld	a, c
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:41: }
	ret
;src/main.c:54: void draw_mt_column(uint8_t ring_col, uint16_t map_col,
;	---------------------------------
; Function draw_mt_column
; ---------------------------------
_draw_mt_column::
	add	sp, #-10
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
	ld	(hl), d
;src/main.c:58: uint8_t bx = ring_col << 1;
	add	a, a
	ldhl	sp,	#2
;src/main.c:61: uint8_t _prev = _current_bank;
	ld	(hl+), a
	ldh	a, (__current_bank + 0)
	ld	(hl), a
;src/main.c:62: SWITCH_ROM(map_bank);
	ldhl	sp,	#18
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/main.c:64: for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
	ldhl	sp,	#9
	ld	(hl), #0x00
00104$:
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#5
	ld	e, l
	ld	d, h
	ldhl	sp,	#16
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00101$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x10
	jp	NC, 00101$
;src/main.c:65: uint8_t mt = map[(uint16_t)r * map_w + map_col];
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#5
	ld	e, (hl)
	ld	d, #0x00
	call	__mulint
	pop	hl
	push	bc
	pop	de
	push	de
	ldhl	sp,	#7
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
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl), a
;src/main.c:66: uint8_t by = (r & (BKG_MT_H - 1)) << 1;
	ldhl	sp,	#9
	ld	a, (hl)
	and	a, #0x0f
	ldhl	sp,	#6
	ld	(hl), a
	sla	(hl)
;src/main.c:67: set_bkg_tiles(bx, by, 2, 1, &metatiles[mt][0]);
	dec	hl
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00130$:
	ldhl	sp,	#4
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00130$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_metatiles
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
	ld	(hl-), a
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
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:68: set_bkg_tiles(bx, by + 1, 2, 1, &metatiles[mt][2]);
	pop	de
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl+), a
	ld	a, (hl-)
	dec	hl
	inc	a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	h, #0x01
	push	hl
	inc	sp
	ld	h, #0x02
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:64: for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
	ldhl	sp,	#9
	inc	(hl)
	jp	00104$
00101$:
;src/main.c:72: SWITCH_ROM(_prev);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/main.c:73: }
	add	sp, #10
	pop	hl
	add	sp, #7
	jp	(hl)
;src/main.c:75: void fill_scroll_bg(const uint8_t* map, uint16_t map_w, uint16_t map_h, uint8_t map_bank) {
;	---------------------------------
; Function fill_scroll_bg
; ---------------------------------
_fill_scroll_bg::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:76: uint16_t cols = (map_w < BKG_MT_W) ? map_w : BKG_MT_W;
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
;src/main.c:77: for (uint16_t c = 0; c < cols; c++) {
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
;src/main.c:79: draw_mt_column((uint8_t)(c % BKG_MT_W), c, map, map_w, map_h, map_bank);
	ld	a, e
	and	a, #0x0f
	push	bc
	push	de
	ldhl	sp,	#12
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	push	bc
	push	af
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	call	_draw_mt_column
	pop	de
	pop	bc
;src/main.c:77: for (uint16_t c = 0; c < cols; c++) {
	inc	de
	jr	00103$
00105$:
;src/main.c:81: }
	add	sp, #4
	pop	hl
	add	sp, #3
	jp	(hl)
;src/main.c:86: void draw_menu(void) {
;	---------------------------------
; Function draw_menu
; ---------------------------------
_draw_menu::
;src/main.c:87: fill_bkg_rect(0, 0, 20, 18, 0x00);
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
;src/main.c:88: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/main.c:89: printf("GBDASH\n\n");
	ld	de, #___str_1
	call	_puts
;src/main.c:90: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	ld	c, #0x00
00106$:
	ld	a, (_MAX_LEVELS)
	ld	b, a
;src/main.c:91: gotoxy(1, 2 + i);
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
;src/main.c:92: if (i == selected) printf("> %s", game_levels[i]->name);
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
;src/main.c:93: else               printf("  %s", game_levels[i]->name);
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
;src/main.c:90: for (uint8_t i = 0; i < MAX_LEVELS; i++) {
	inc	c
	jr	00106$
00104$:
;src/main.c:95: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:96: redraw = 0;
	xor	a, a
	ld	(#_redraw),a
;src/main.c:97: }
	ret
___str_1:
	.ascii "GBDASH"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "> %s"
	.db 0x00
___str_3:
	.ascii "  %s"
	.db 0x00
;src/main.c:102: void play_level(uint8_t idx) {
;	---------------------------------
; Function play_level
; ---------------------------------
_play_level::
	add	sp, #-50
	ld	e, a
;src/main.c:104: const Level* l = game_levels[idx];
	ld	bc, #_game_levels+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#48
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:105: const uint8_t* map = l->map;
	ldhl	sp,#48
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
	ldhl	sp,	#17
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:106: uint16_t map_w = l->map_width;
	ldhl	sp,#48
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
	ldhl	sp,	#19
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:107: uint16_t map_h = l->map_height;
	ldhl	sp,#48
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
	ldhl	sp,	#21
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:109: uint16_t cam_px = 0;
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;src/main.c:113: uint16_t loaded_r = BKG_MT_W - 1;
	ld	(hl+), a
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/main.c:123: player_init(&player, 32, 160);
;include/player.h:36: p->world_x   = start_x;
	ldhl	sp,	#8
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
;include/player.h:37: p->world_y   = start_y;
	ld	(hl+), a
	ld	a, #0xa0
	ld	(hl+), a
;include/player.h:38: p->vel_y     = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
;include/player.h:39: p->on_ground  = 0;
	ld	(hl+), a
;include/player.h:40: p->dead       = 0;
;include/player.h:41: p->jump_held  = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:125: DISPLAY_OFF;
	call	_display_off
;src/main.c:126: load_bkg_tileset(l->tiles, l->tile_count);
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#48
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
;src/main.c:128: set_sprite_data(0, 4, cube_tiles);
	ld	de, #_cube_tiles
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/main.c:133: fill_scroll_bg(map, map_w, map_h, l->map_bank);
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	af
	inc	sp
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/main.c:136: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/main.c:137: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/main.c:138: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/main.c:140: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:141: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:142: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:144: waitpadup();
	call	_waitpadup
;src/main.c:147: while (1) {
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ld	a, #0x04
00958$:
	ldhl	sp,	#35
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00958$
00113$:
;src/main.c:148: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:149: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#49
	ld	(hl), a
;src/main.c:150: if (joy & J_START) break;
	push	hl
	ldhl	sp,	#51
	bit	7, (hl)
	pop	hl
	jp	NZ, 00114$
;src/main.c:153: if (cam_px < ((map_w - VIEW_MT_W) << 4)) {
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, (hl)
	add	a, #0xf6
	ld	l, a
	ld	a, c
	adc	a, #0xff
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jr	NC, 00109$
;src/main.c:154: uint16_t prev = cam_px >> 4;
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/main.c:155: cam_px += SCROLL_SPEED;
	ld	a, (hl-)
	ld	d, a
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	inc	bc
	inc	bc
	inc	bc
	ld	a, c
	ld	(hl+), a
;src/main.c:156: uint16_t curr = cam_px >> 4;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/main.c:157: if (curr != prev) {
	ld	a, c
	sub	a, e
	jr	NZ, 00961$
	ld	a, b
	sub	a, d
	jr	Z, 00109$
00961$:
;src/main.c:158: uint16_t need = curr + VIEW_MT_W;
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
;src/main.c:159: if (need > loaded_r && need < map_w) {
	ldhl	sp,	#25
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00109$
	ldhl	sp,	#19
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00109$
;src/main.c:160: loaded_r = need;
	ldhl	sp,	#25
	ld	a, c
	ld	(hl+), a
;src/main.c:161: draw_mt_column((uint8_t)(need % BKG_MT_W), need, map, map_w, map_h, l->map_bank);
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	h, a
	ld	a, c
	and	a, #0x0f
	push	hl
	inc	sp
	ldhl	sp,	#22
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#22
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#22
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	e, c
	ld	d, b
	call	_draw_mt_column
00109$:
;src/main.c:167: player.world_x = cam_px + PLAYER_SCREEN_X;
	ldhl	sp,	#23
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	(hl), c
	inc	hl
	ld	(hl), b
;src/main.c:169: _prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#37
	ld	(hl), a
;src/main.c:170: SWITCH_ROM(l->map_bank);
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ldh	(__current_bank + 0), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(#_rROMB0),a
;src/main.c:171: died = player_update(&player, joy, map, map_w, map_h);
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
;include/player.h:65: if (p->dead) return 1;
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/player.h:67: uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
;include/player.h:65: if (p->dead) return 1;
	ld	a, (hl)
	or	a, a
	jr	Z, 00122$
	ld	(hl), #0x01
	jp	00262$
00122$:
;include/player.h:67: uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#50
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl+), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00124$
	ld	(hl), #0x00
	jp	00129$
00124$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#46
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#47
	ld	a, (hl)
	ldhl	sp,	#43
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#49
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
;include/player.h:67: uint8_t foot_l = col_point(p->world_x, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#42
	ld	e, l
	ld	d, h
	ldhl	sp,	#19
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00126$
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00127$
00126$:
	ldhl	sp,	#49
	ld	(hl), #0x07
	jr	00129$
00127$:
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#46
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#42
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#46
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#50
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#49
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#48
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#47
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #_famidash_metatile_collision
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#50
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#49
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
00129$:
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
;include/player.h:68: uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#46
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000f
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#48
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00132$
	ld	c, #0x00
	jr	00137$
00132$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#49
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	dec	hl
	dec	hl
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
;include/player.h:68: uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	push	de
	ldhl	sp,	#50
	ld	e, l
	ld	d, h
	ldhl	sp,	#33
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00134$
	ldhl	sp,	#29
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00135$
00134$:
	ld	c, #0x07
	jr	00137$
00135$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#48
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
00137$:
;include/player.h:69: p->on_ground = (IS_SOLID(foot_l) || IS_SOLID(foot_r)) ? 1 : 0;
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00280$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00280$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00280$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00280$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00280$
	cp	a,#0x09
	jr	Z, 00280$
	cp	a,#0x05
	jr	Z, 00280$
	sub	a, #0x06
	jr	NZ, 00277$
00280$:
	ld	c, #0x01
	jr	00278$
00277$:
	ld	c, #0x00
00278$:
	ldhl	sp,	#14
	ld	(hl), c
;include/player.h:73: p->vel_y += GRAVITY;
;include/player.h:72: if (!p->on_ground) {
	ld	a, c
	or	a, a
	jr	NZ, 00142$
;include/player.h:73: p->vel_y += GRAVITY;
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:74: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x50
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00971$
	bit	7, d
	jr	NZ, 00972$
	cp	a, a
	jr	00972$
00971$:
	bit	7, d
	jr	Z, 00972$
	scf
00972$:
	jr	NC, 00142$
	ldhl	sp,	#12
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00142$:
;include/player.h:78: uint8_t a_now = (joy & J_A) ? 1u : 0u;
	push	hl
	ldhl	sp,	#46
	bit	4, (hl)
	pop	hl
	jr	Z, 00300$
	ld	b, #0x01
	jr	00301$
00300$:
	ld	b, #0x00
00301$:
	ld	c, b
;include/player.h:79: if (a_now && !p->jump_held && p->on_ground) {
	ld	a, b
	or	a, a
	jr	Z, 00146$
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jr	NZ, 00146$
	dec	hl
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00146$
;include/player.h:80: p->vel_y = JUMP_FORCE;
	dec	hl
	dec	hl
	ld	a, #0xab
	ld	(hl+), a
;include/player.h:81: p->on_ground = 0; // We just jumped, so we aren't on the ground anymore
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0x00
00146$:
;include/player.h:83: p->jump_held = a_now;
	ldhl	sp,	#16
	ld	(hl), c
;include/player.h:86: int8_t pixels = (int8_t)(p->vel_y >> 4);
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, h
;include/player.h:87: int8_t step   = (pixels >= 0) ? 1 : -1;
	ld	a, c
	rlca
	and	a,#0x01
	ld	b, a
	bit	0, b
	ld	a, #0x01
	jr	Z, 00303$
	ld	a, #0xff
00303$:
	ldhl	sp,	#38
	ld	(hl), a
;include/player.h:88: int8_t steps  = (pixels >= 0) ? pixels : -pixels;
	bit	0, b
	jr	Z, 00305$
	xor	a, a
	sub	a, c
	ld	c, a
00305$:
	ldhl	sp,	#39
	ld	(hl), c
;include/player.h:89: if (steps > 16) steps = 16;
	ld	e, (hl)
	ld	a,#0x10
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00975$
	bit	7, d
	jr	NZ, 00976$
	cp	a, a
	jr	00976$
00975$:
	bit	7, d
	jr	Z, 00976$
	scf
00976$:
	jr	NC, 00148$
	ldhl	sp,	#39
	ld	(hl), #0x10
00148$:
;include/player.h:91: p->on_ground = 0;
	ldhl	sp,	#14
	ld	(hl), #0x00
;src/main.c:93: else               printf("  %s", game_levels[i]->name);
	ldhl	sp,	#38
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00977$
	bit	7, d
	jr	NZ, 00978$
	cp	a, a
	jr	00978$
00977$:
	bit	7, d
	jr	Z, 00978$
	scf
00978$:
	ld	a, #0x00
	rla
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#49
	ld	(hl), #0x00
00273$:
;include/player.h:101: if (IS_HAZARD(cl) || IS_HAZARD(cr)) { p->dead = 1; return 1; }
;include/player.h:93: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#39
	ld	e, (hl)
	ldhl	sp,	#49
	ld	d, (hl)
	ld	a, (hl)
	ldhl	sp,	#39
	sub	a, (hl)
	bit	7, e
	jr	Z, 00979$
	bit	7, d
	jr	NZ, 00980$
	cp	a, a
	jr	00980$
00979$:
	bit	7, d
	jr	Z, 00980$
	scf
00980$:
	jp	NC, 00224$
;include/player.h:94: int16_t ny = p->world_y + step;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#38
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	l, c
	ld	h, b
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#41
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:68: uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;include/player.h:98: uint8_t cl = col_point(p->world_x,              ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;include/player.h:99: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#47
	ld	(hl), e
	inc	hl
	ld	(hl), a
;include/player.h:96: if (step > 0) {
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jp	Z, 00222$
;include/player.h:98: uint8_t cl = col_point(p->world_x,              ny + PLAYER_SIZE, map, map_w, map_h);
	ld	hl, #0x000f
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	h, b
	bit	7, h
	jr	Z, 00150$
	xor	a, a
	jr	00155$
00150$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ld	e, c
	ld	d, b
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;include/player.h:98: uint8_t cl = col_point(p->world_x,              ny + PLAYER_SIZE, map, map_w, map_h);
	push	de
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#33
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00152$
	ldhl	sp,	#29
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00153$
00152$:
	ld	a, #0x07
	jr	00155$
00153$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
00155$:
	ldhl	sp,	#46
;include/player.h:99: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00158$
	ld	c, #0x00
	jr	00163$
00158$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
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
;include/player.h:99: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny + PLAYER_SIZE, map, map_w, map_h);
	push	de
	ldhl	sp,	#49
	ld	e, l
	ld	d, h
	ldhl	sp,	#33
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00160$
	ldhl	sp,	#29
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00161$
00160$:
	ld	c, #0x07
	jr	00163$
00161$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#47
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
00163$:
;include/player.h:101: if (IS_HAZARD(cl) || IS_HAZARD(cr)) { p->dead = 1; return 1; }
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00174$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00174$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00174$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00174$
	ldhl	sp,	#46
	ld	a, (hl)
	dec	a
	jr	Z, 00174$
	ld	a,c
	cp	a,#0x08
	jr	Z, 00174$
	cp	a,#0x03
	jr	Z, 00174$
	cp	a,#0x04
	jr	Z, 00174$
	cp	a,#0x02
	jr	Z, 00174$
	dec	a
	jr	NZ, 00175$
00174$:
	ldhl	sp,	#15
	ld	(hl), #0x01
	ldhl	sp,	#49
	ld	(hl), #0x01
	jp	00262$
00175$:
;include/player.h:102: if (IS_SOLID(cl)  || IS_SOLID(cr)) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00183$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00183$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00183$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00183$
	ld	a,c
	cp	a,#0x07
	jr	Z, 00183$
	cp	a,#0x09
	jr	Z, 00183$
	cp	a,#0x05
	jr	Z, 00183$
	sub	a, #0x06
	jp	NZ, 00223$
00183$:
;include/player.h:104: p->world_y   = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#6
	ld	a, (hl+)
	and	a, #0xf0
	ld	b, (hl)
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
;include/player.h:105: p->vel_y     = 0;
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;include/player.h:106: p->on_ground = 1;
	ld	(hl+), a
	ld	(hl), #0x01
;include/player.h:107: break;
	jp	00224$
00222$:
;include/player.h:111: uint8_t cl = col_point(p->world_x,              ny, map, map_w, map_h);
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, b
	rlca
	and	a,#0x01
	ldhl	sp,	#43
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;include/player.h:111: uint8_t cl = col_point(p->world_x,              ny, map, map_w, map_h);
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00187$
	ldhl	sp,	#46
	ld	(hl), #0x00
	jr	00192$
00187$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
;include/player.h:111: uint8_t cl = col_point(p->world_x,              ny, map, map_w, map_h);
	ldhl	sp,	#4
	ld	e, l
	ld	d, h
	ldhl	sp,	#31
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00189$
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#29
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00190$
00189$:
	ldhl	sp,	#46
	ld	(hl), #0x07
	jr	00192$
00190$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
00192$:
;include/player.h:112: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny, map, map_w, map_h);
	ldhl	sp,	#43
	ld	a, (hl)
	or	a, a
	jr	Z, 00195$
	ldhl	sp,	#48
	ld	(hl), #0x00
	jr	00200$
00195$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
;include/player.h:112: uint8_t cr = col_point(p->world_x + PLAYER_SIZE, ny, map, map_w, map_h);
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#31
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00197$
	ldhl	sp,	#44
	ld	e, l
	ld	d, h
	ldhl	sp,	#29
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00198$
00197$:
	ldhl	sp,	#48
	ld	(hl), #0x07
	jr	00200$
00198$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#47
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
00200$:
;include/player.h:114: if (IS_HAZARD(cl) || IS_HAZARD(cr)) { p->dead = 1; return 1; }
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00211$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00211$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00211$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00211$
	ldhl	sp,	#46
	ld	a, (hl)
	dec	a
	jr	Z, 00211$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00211$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00211$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00211$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00211$
	ldhl	sp,	#48
	ld	a, (hl)
	dec	a
	jr	NZ, 00212$
00211$:
	ldhl	sp,	#15
	ld	(hl), #0x01
	ldhl	sp,	#49
	ld	(hl), #0x01
	jp	00262$
00212$:
;include/player.h:115: if (IS_SOLID(cl)  || IS_SOLID(cr)) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00220$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00220$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00220$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00220$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00220$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00220$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00220$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00223$
00220$:
;include/player.h:117: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#48
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#47
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x04
01021$:
	ldhl	sp,	#48
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01021$
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#11
;include/player.h:118: p->vel_y   = 0;
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:119: break;
	jr	00224$
00223$:
;include/player.h:122: p->world_y = ny;
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;include/player.h:93: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#49
	inc	(hl)
	jp	00273$
00224$:
;include/player.h:68: uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#41
;include/player.h:127: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, (hl)
	inc	hl
	add	a, #0x07
	ld	b, a
	ld	a, c
	adc	a, #0x00
	ld	(hl), b
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;include/player.h:68: uint8_t foot_r = col_point(p->world_x + PLAYER_SIZE, p->world_y + PLAYER_SIZE + 1, map, map_w, map_h);
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#47
;include/player.h:127: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00226$
	ldhl	sp,	#49
	ld	(hl), #0x00
	jp	00231$
00226$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#49
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;include/player.h:127: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#31
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00228$
	ldhl	sp,	#44
	ld	e, l
	ld	d, h
	ldhl	sp,	#29
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00229$
00228$:
	ldhl	sp,	#49
	ld	(hl), #0x07
	jr	00231$
00229$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#48
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
00231$:
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
;include/player.h:128: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl+)
	ld	c, (hl)
	dec	hl
	add	a, #0x0f
	ld	b, a
	ld	a, c
	adc	a, #0x00
	ld	(hl), b
	inc	hl
	ld	(hl+), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00234$
	ld	(hl), #0x00
	jp	00239$
00234$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#47
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
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#49
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
;include/player.h:128: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#46
	ld	e, l
	ld	d, h
	ldhl	sp,	#31
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00236$
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#29
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00237$
00236$:
	ldhl	sp,	#49
	ld	(hl), #0x07
	jr	00239$
00237$:
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#46
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
00239$:
;include/player.h:129: if (IS_HAZARD(cm_l) || IS_HAZARD(cm_r) ||
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00258$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00258$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00258$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00258$
	ldhl	sp,	#45
	ld	a, (hl)
	dec	a
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	dec	a
	jr	Z, 00258$
;include/player.h:130: IS_SOLID(cm_l)  || IS_SOLID(cm_r)) {
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00258$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00258$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00258$
	ldhl	sp,	#45
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00258$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00259$
00258$:
;include/player.h:131: p->dead = 1;
	ldhl	sp,	#15
	ld	(hl), #0x01
;include/player.h:132: return 1;
	ldhl	sp,	#49
	ld	(hl), #0x01
	jr	00262$
00259$:
;include/player.h:136: if (p->world_y > (int16_t)((uint16_t)map_h << 4)) {
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#40
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 01041$
	bit	7, d
	jr	NZ, 01042$
	cp	a, a
	jr	01042$
01041$:
	bit	7, d
	jr	Z, 01042$
	scf
01042$:
	jr	NC, 00261$
;include/player.h:137: p->dead = 1;
	ldhl	sp,	#15
	ld	(hl), #0x01
;include/player.h:138: return 1;
	ldhl	sp,	#49
	ld	(hl), #0x01
	jr	00262$
00261$:
;include/player.h:141: return 0;
	ldhl	sp,	#49
	ld	(hl), #0x00
;src/main.c:171: died = player_update(&player, joy, map, map_w, map_h);
00262$:
;src/main.c:172: SWITCH_ROM(_prev);
	ldhl	sp,	#37
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/main.c:174: if (died) {
	ldhl	sp,	#49
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
;src/main.c:175: cam_px = 0;
	xor	a, a
	ldhl	sp,	#23
	ld	(hl+), a
;src/main.c:176: loaded_r = BKG_MT_W - 1;
	ld	(hl+), a
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;include/player.h:36: p->world_x   = start_x;
	ldhl	sp,	#8
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
;include/player.h:37: p->world_y   = start_y;
	ld	(hl+), a
	ld	a, #0xa0
	ld	(hl+), a
;include/player.h:38: p->vel_y     = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
;include/player.h:39: p->on_ground  = 0;
	ld	(hl+), a
;include/player.h:40: p->dead       = 0;
;include/player.h:41: p->jump_held  = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), #0x00
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/main.c:179: fill_scroll_bg(map, map_w, map_h, l->map_bank);
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	af
	inc	sp
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
00111$:
;include/player.h:149: return p->world_y - (int16_t)cam_py;
	ldhl	sp,	#10
	ld	a, (hl)
	add	a, #0x90
;src/main.c:185: move_sprite(0, PLAYER_SCREEN_X + 8,     py + 16);
	ld	c, a
	add	a, #0x10
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	b, a
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), #0x28
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x30
;src/main.c:187: move_sprite(2, PLAYER_SCREEN_X + 8,     py + 16 + 8);
	ld	a, c
	add	a, #0x18
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	c, a
	ld	hl, #(_shadow_OAM + 8)
	ld	(hl+), a
	ld	(hl), #0x28
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x30
;src/main.c:190: move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
	ldhl	sp,	#23
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/main.c:190: move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
	jp	00113$
00114$:
;src/main.c:194: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/main.c:196: waitpadup();
	call	_waitpadup
;src/main.c:197: setup_menu_font();
	call	_setup_menu_font
;src/main.c:198: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/main.c:199: }
	add	sp, #50
	ret
;src/main.c:204: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:205: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/main.c:206: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:207: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:208: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:210: hUGE_init(&song_stereoma);
	ld	de, #_song_stereoma
	call	_hUGE_init
;src/main.c:211: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;src/main.c:213: TMA_REG = 224;
	ld	a, #0xe0
	ldh	(_TMA_REG + 0), a
;src/main.c:214: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/main.c:215: add_TIM(play_music_safe);
	ld	de, #_play_music_safe
	call	_add_TIM
;src/main.c:216: set_interrupts(VBL_IFLAG | TIM_IFLAG);
	ld	a, #0x05
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:219: setup_menu_font();
	call	_setup_menu_font
;src/main.c:221: while (1) {
00116$:
;src/main.c:222: if (redraw) draw_menu();
	ld	a, (#_redraw)
	or	a, a
	jr	Z, 00102$
	call	_draw_menu
00102$:
;src/main.c:223: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:225: if (joy & J_UP) {
	push	hl
	bit	2, (hl)
	pop	hl
	jr	Z, 00113$
;src/main.c:226: if (selected > 0) { selected--; redraw = 1; }
	ld	hl, #_selected
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	dec	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00104$:
;src/main.c:227: waitpadup();
	call	_waitpadup
	jr	00114$
00113$:
;src/main.c:229: else if (joy & J_DOWN) {
	push	hl
	ldhl	sp,	#2
	bit	3, (hl)
	pop	hl
	jr	Z, 00110$
;src/main.c:230: if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
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
	ld	hl, #_selected
	inc	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00106$:
;src/main.c:231: waitpadup();
	call	_waitpadup
	jr	00114$
00110$:
;src/main.c:233: else if (joy & J_A) {
	push	hl
	ldhl	sp,	#2
	bit	4, (hl)
	pop	hl
	jr	Z, 00114$
;src/main.c:234: play_level(selected);
	ld	a, (_selected)
	call	_play_level
00114$:
;src/main.c:237: wait_vbl_done();
	call	_wait_vbl_done
	jr	00116$
;src/main.c:239: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__music_ready:
	.db #0x00	; 0
__xinit__redraw:
	.db #0x01	; 1
__xinit__selected:
	.db #0x00	; 0
	.area _CABS (ABS)
