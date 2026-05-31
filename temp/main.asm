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
	.globl _font_set
	.globl _font_load
	.globl _font_init
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
;include/player.h:25: static inline void player_init(Player *p, uint16_t start_x, int16_t start_y) {
;	---------------------------------
; Function player_init
; ---------------------------------
_player_init:
;include/player.h:26: p->world_x   = start_x;
	ld	l, e
	ld	h, d
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:27: p->world_y   = start_y;
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
;include/player.h:28: p->vel_y     = 0;
	ld	hl, #0x0004
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:29: p->on_ground = 0;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
;include/player.h:30: p->dead      = 0;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x00
;include/player.h:31: }
	pop	hl
	pop	af
	jp	(hl)
;include/player.h:33: static inline uint8_t col_point(
;	---------------------------------
; Function col_point
; ---------------------------------
_col_point:
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
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
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00107$:
	ld	a, c
;include/player.h:38: }
	add	sp, #8
	pop	hl
	add	sp, #6
	jp	(hl)
;include/player.h:40: static inline uint8_t player_update(
;	---------------------------------
; Function player_update
; ---------------------------------
_player_update:
	add	sp, #-41
	ldhl	sp,	#38
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;include/player.h:47: if (p->dead) return 1;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
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
	ldhl	sp,	#40
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
	ld	a, #0x01
	jp	00377$
00102$:
;include/player.h:50: if (!p->on_ground) {
	ldhl	sp,#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;include/player.h:51: p->vel_y += GRAVITY;
	ldhl	sp,#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#37
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#36
	ld	(hl), a
;include/player.h:50: if (!p->on_ground) {
	ld	a, c
	or	a, a
	jr	NZ, 00106$
;include/player.h:51: p->vel_y += GRAVITY;
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
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
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:52: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x50
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 01111$
	bit	7, d
	jr	NZ, 01112$
	cp	a, a
	jr	01112$
01111$:
	bit	7, d
	jr	Z, 01112$
	scf
01112$:
	jr	NC, 00106$
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x50
	ld	(hl+), a
	ld	(hl), #0x00
00106$:
;include/player.h:56: if ((joy & J_A) && p->on_ground) {
	push	hl
	ldhl	sp,	#39
	bit	4, (hl)
	pop	hl
	jr	Z, 00108$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00108$
;include/player.h:57: p->vel_y     = JUMP_FORCE;
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xab
	ld	(hl+), a
	ld	(hl), #0xff
;include/player.h:58: p->on_ground = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00108$:
;include/player.h:62: int8_t pixels = (int8_t)(p->vel_y >> 4);
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,#35
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
	ldhl	sp,	#40
	ld	(hl), c
;include/player.h:63: int8_t step   = (pixels >= 0) ? 1 : -1;
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#36
	ld	(hl), a
	bit	0, (hl)
	ld	a, #0x01
	jr	Z, 00380$
	ld	a, #0xff
00380$:
	ldhl	sp,	#10
	ld	(hl), a
;include/player.h:64: int8_t steps  = (pixels >= 0) ? pixels : -pixels;
	ldhl	sp,	#36
	bit	0, (hl)
	jr	Z, 00382$
	xor	a, a
	ldhl	sp,	#40
	sub	a, (hl)
	ld	(hl), a
00382$:
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;include/player.h:65: if (steps > 16) steps = 16;
	ld	e, (hl)
	ld	a,#0x10
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 01114$
	bit	7, d
	jr	NZ, 01115$
	cp	a, a
	jr	01115$
01114$:
	bit	7, d
	jr	Z, 01115$
	scf
01115$:
	jr	NC, 00111$
	ldhl	sp,	#11
	ld	(hl), #0x10
00111$:
;include/player.h:67: p->on_ground = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;include/player.h:69: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#47
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#10
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 01116$
	bit	7, d
	jr	NZ, 01117$
	cp	a, a
	jr	01117$
01116$:
	bit	7, d
	jr	Z, 01117$
	scf
01117$:
	ld	a, #0x00
	rla
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#40
	ld	(hl), #0x00
00375$:
;include/player.h:70: int16_t ny = p->world_y + step;
	ldhl	sp,#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#27
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#26
	ld	(hl), a
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/player.h:69: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#40
	ld	a,(hl)
	ld	d,a
	ldhl	sp,	#11
	sub	a, (hl)
	bit	7, e
	jr	Z, 01118$
	bit	7, d
	jr	NZ, 01119$
	cp	a, a
	jr	01119$
01118$:
	bit	7, d
	jr	Z, 01119$
	scf
01119$:
	jp	NC, 00133$
;include/player.h:70: int16_t ny = p->world_y + step;
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ldhl	sp,	#29
	ld	(hl), c
	inc	hl
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#31
	ld	(hl+), a
	inc	de
	ld	a, (de)
;include/player.h:75: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl+)
	ld	b, (hl)
	add	a, #0x0f
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ldhl	sp,	#35
	ld	(hl), c
	inc	hl
	ld	(hl), a
;include/player.h:72: if (step > 0) {
	ldhl	sp,	#18
	ld	a, (hl)
	or	a, a
	jp	Z, 00131$
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	h, b
	bit	7, h
	jr	Z, 00167$
	xor	a, a
	jr	00172$
00167$:
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
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	push	de
	ldhl	sp,	#33
	ld	e, l
	ld	d, h
	ldhl	sp,	#16
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00169$
	ldhl	sp,	#12
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00170$
00169$:
	ld	a, #0x07
	jr	00172$
00170$:
	ldhl	sp,	#14
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
	ldhl	sp,	#16
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
00172$:
	ldhl	sp,	#32
;include/player.h:75: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl+), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00175$
	inc	hl
	inc	hl
	ld	(hl), #0x00
	jr	00180$
00175$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#36
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
;include/player.h:75: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#35
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00177$
	ldhl	sp,	#33
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00178$
00177$:
	ldhl	sp,	#36
	ld	(hl), #0x07
	jr	00180$
00178$:
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#35
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#16
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
00180$:
;include/player.h:76: if (IS_SOLID(cl) || IS_SOLID(cr)) {
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00112$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00112$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00112$
	ldhl	sp,	#32
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00112$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00112$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00112$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00112$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x06
	jp	NZ, 00132$
00112$:
;include/player.h:77: p->world_y   = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#2
	ld	a, (hl+)
	and	a, #0xf0
	ld	c, a
	ld	b, (hl)
	ld	a, c
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:78: p->vel_y     = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:79: p->on_ground = 1;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;include/player.h:80: break;
	jp	00133$
00131$:
;include/player.h:84: uint8_t cl = col_point(p->world_x,               ny, map, map_w, map_h);
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#31
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
;include/player.h:84: uint8_t cl = col_point(p->world_x,               ny, map, map_w, map_h);
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00183$
	ldhl	sp,	#34
	ld	(hl), #0x00
	jr	00188$
00183$:
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
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;include/player.h:84: uint8_t cl = col_point(p->world_x,               ny, map, map_w, map_h);
	ldhl	sp,	#0
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00185$
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ldhl	sp,	#19
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00186$
00185$:
	ldhl	sp,	#34
	ld	(hl), #0x07
	jr	00188$
00186$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#23
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
	ldhl	sp,	#34
	ld	(hl), a
00188$:
;include/player.h:85: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny, map, map_w, map_h);
	ldhl	sp,	#31
	ld	a, (hl)
	or	a, a
	jr	Z, 00191$
	ldhl	sp,	#36
	ld	(hl), #0x00
	jr	00196$
00191$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#36
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
;include/player.h:85: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny, map, map_w, map_h);
	ldhl	sp,	#35
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00193$
	ldhl	sp,	#32
	ld	e, l
	ld	d, h
	ldhl	sp,	#19
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00194$
00193$:
	ldhl	sp,	#36
	ld	(hl), #0x07
	jr	00196$
00194$:
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#35
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#23
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
00196$:
;include/player.h:86: if (IS_SOLID(cl) || IS_SOLID(cr)) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00121$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00121$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00121$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00121$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00121$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00121$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00121$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00132$
00121$:
;include/player.h:87: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,#29
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	l, c
	ld	h, b
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:88: p->vel_y   = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:89: break;
	jr	00133$
00132$:
;include/player.h:92: p->world_y = ny;
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;include/player.h:69: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#40
	inc	(hl)
	jp	00375$
00133$:
;include/player.h:97: uint16_t hx1 = p->world_x  + PLAYER_HBOX;
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#35
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#30
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
;include/player.h:98: uint16_t hx2 = p->world_x  + PLAYER_SIZE - PLAYER_HBOX;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#31
	ld	(hl), c
	inc	hl
	ld	(hl), a
;include/player.h:99: int16_t  hy1 = p->world_y  + PLAYER_HBOX;
	ldhl	sp,#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#33
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
;include/player.h:100: int16_t  hy2 = p->world_y  + PLAYER_SIZE - PLAYER_HBOX;
	ld	a, (hl-)
	ld	b, a
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), e
	inc	hl
	ld	(hl), a
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ld	a, b
	rlca
	and	a,#0x01
	ldhl	sp,	#40
	ld	(hl), a
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#24
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
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00199$
	ld	c, #0x00
	jr	00204$
00199$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#16
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00201$
	ldhl	sp,	#12
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00202$
00201$:
	ld	c, #0x07
	jr	00204$
00202$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00204$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x08
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00207$
	ld	c, #0x00
	jr	00212$
00207$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00209$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00210$
00209$:
	ld	c, #0x07
	jr	00212$
00210$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00212$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x03
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00215$
	ld	c, #0x00
	jr	00220$
00215$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00217$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00218$
00217$:
	ld	c, #0x07
	jr	00220$
00218$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00220$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x04
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00223$
	ld	c, #0x00
	jr	00228$
00223$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00225$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00226$
00225$:
	ld	c, #0x07
	jr	00228$
00226$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00228$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x02
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00231$
	ld	e, #0x00
	jr	00236$
00231$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00233$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00234$
00233$:
	ld	e, #0x07
	jr	00236$
00234$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	e, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00236$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	dec	e
	jp	Z, 00134$
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
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00239$
	ld	c, #0x00
	jr	00244$
00239$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00241$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00242$
00241$:
	ld	c, #0x07
	jr	00244$
00242$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00244$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x08
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00247$
	ld	c, #0x00
	jr	00252$
00247$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00249$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00250$
00249$:
	ld	c, #0x07
	jr	00252$
00250$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00252$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x03
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00255$
	ld	c, #0x00
	jr	00260$
00255$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00257$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00258$
00257$:
	ld	c, #0x07
	jr	00260$
00258$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00260$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x04
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00263$
	ld	c, #0x00
	jr	00268$
00263$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00265$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00266$
00265$:
	ld	c, #0x07
	jr	00268$
00266$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00268$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x02
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00271$
	ld	(hl), #0x00
	jr	00276$
00271$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	ldhl	sp,	#17
	ld	e, l
	ld	d, h
	ldhl	sp,	#19
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00273$
	ldhl	sp,	#27
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00274$
00273$:
	ldhl	sp,	#40
	ld	(hl), #0x07
	jr	00276$
00274$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#17
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00276$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ldhl	sp,	#40
	ld	a, (hl)
	dec	a
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#40
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#25
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
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00279$
	ld	c, #0x00
	jr	00284$
00279$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00281$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00282$
00281$:
	ld	c, #0x07
	jr	00284$
00282$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00284$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x08
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00287$
	ld	c, #0x00
	jr	00292$
00287$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00289$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00290$
00289$:
	ld	c, #0x07
	jr	00292$
00290$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00292$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x03
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00295$
	ld	c, #0x00
	jr	00300$
00295$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00297$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00298$
00297$:
	ld	c, #0x07
	jr	00300$
00298$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00300$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x04
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00303$
	ld	c, #0x00
	jr	00308$
00303$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00305$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00306$
00305$:
	ld	c, #0x07
	jr	00308$
00306$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00308$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x02
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00311$
	ld	c, #0x00
	jr	00316$
00311$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00313$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00314$
00313$:
	ld	c, #0x07
	jr	00316$
00314$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00316$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	dec	c
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00319$
	ld	c, #0x00
	jr	00324$
00319$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00321$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00322$
00321$:
	ld	c, #0x07
	jr	00324$
00322$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00324$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x08
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00327$
	ld	c, #0x00
	jr	00332$
00327$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00329$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00330$
00329$:
	ld	c, #0x07
	jr	00332$
00330$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00332$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x03
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00335$
	ld	c, #0x00
	jr	00340$
00335$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00337$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00338$
00337$:
	ld	c, #0x07
	jr	00340$
00338$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00340$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x04
	jp	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00343$
	ld	c, #0x00
	jr	00348$
00343$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#29
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00345$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00346$
00345$:
	ld	c, #0x07
	jr	00348$
00346$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00348$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x02
	jr	Z, 00134$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	Z, 00351$
	ld	(hl), #0x00
	jr	00356$
00351$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#25
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	ldhl	sp,	#31
	ld	e, l
	ld	d, h
	ldhl	sp,	#19
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00353$
	ldhl	sp,	#27
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00354$
00353$:
	ldhl	sp,	#40
	ld	(hl), #0x07
	jr	00356$
00354$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#27
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
	ldhl	sp,	#21
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#40
	ld	(hl), a
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00356$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ldhl	sp,	#40
	ld	a, (hl)
	dec	a
	jr	NZ, 00135$
00134$:
;include/player.h:106: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;include/player.h:107: return 1;
	ld	a,#0x01
	ld	(hl),a
	jp	00377$
00135$:
;include/player.h:111: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
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
	ldhl	sp,	#27
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#28
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#32
	ld	(hl-), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00359$
	xor	a, a
	jr	00364$
00359$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#36
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
	ldhl	sp,	#31
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
;include/player.h:111: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	push	de
	ldhl	sp,	#37
	ld	e, l
	ld	d, h
	ldhl	sp,	#21
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00361$
	ldhl	sp,	#10
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00362$
00361$:
	ld	a, #0x07
	jr	00364$
00362$:
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#35
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#21
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
00364$:
	ldhl	sp,	#40
	ld	(hl), a
;include/player.h:112: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,#29
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#35
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, b
	jr	Z, 00367$
	ldhl	sp,	#36
	ld	(hl), #0x00
	jp	00372$
00367$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#36
	ld	a, (hl)
	ldhl	sp,	#32
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
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#36
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
;include/player.h:112: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#31
	ld	e, l
	ld	d, h
	ldhl	sp,	#19
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00369$
	ldhl	sp,	#35
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00370$
00369$:
	ldhl	sp,	#36
	ld	(hl), #0x07
	jr	00372$
00370$:
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#35
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
	ldhl	sp,	#21
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
00372$:
;include/player.h:113: if (IS_SOLID(cm_l) || IS_SOLID(cm_r)) {
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00155$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00155$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00155$
	ldhl	sp,	#40
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00155$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00155$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00155$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00155$
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00156$
00155$:
;include/player.h:114: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;include/player.h:115: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00377$
00156$:
;include/player.h:119: if (p->world_y > (int16_t)((uint16_t)map_h << 4)) {
	ldhl	sp,	#10
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
	ldhl	sp,	#33
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 01169$
	bit	7, d
	jr	NZ, 01170$
	cp	a, a
	jr	01170$
01169$:
	bit	7, d
	jr	Z, 01170$
	scf
01170$:
	jr	NC, 00165$
;include/player.h:120: p->dead = 1;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
;include/player.h:121: return 1;
	ld	a,#0x01
	ld	(hl),a
	jr	00377$
00165$:
;include/player.h:124: return 0;
	xor	a, a
00377$:
;include/player.h:125: }
	add	sp, #41
	pop	hl
	add	sp, #6
	jp	(hl)
;include/player.h:127: static inline int16_t player_screen_y(const Player *p, uint16_t cam_py) {
;	---------------------------------
; Function player_screen_y
; ---------------------------------
_player_screen_y:
;include/player.h:128: return p->world_y - (int16_t)cam_py;
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
;include/player.h:129: }
	ret
;src/main.c:26: void play_music_safe(void) {
;	---------------------------------
; Function play_music_safe
; ---------------------------------
_play_music_safe::
;src/main.c:27: if (music_ready) hUGE_dosound();
	ld	a, (#_music_ready)
	or	a, a
	jp	NZ, _hUGE_dosound
;src/main.c:28: }
	ret
_cube_tiles:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x90	; 144
	.db #0xd0	; 208
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x09	; 9
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0xd0	; 208
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x0b	; 11
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
;src/main.c:30: void setup_menu_font(void) {
;	---------------------------------
; Function setup_menu_font
; ---------------------------------
_setup_menu_font::
;src/main.c:31: font_init();
	call	_font_init
;src/main.c:32: font_set(font_load(font_min));
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/main.c:33: }
	ret
;src/main.c:35: void load_bkg_tileset(const uint8_t* tiles, uint16_t tile_count) {
;	---------------------------------
; Function load_bkg_tileset
; ---------------------------------
_load_bkg_tileset::
;src/main.c:36: if (tile_count == 256u) {
	ld	l, c
	ld	h, b
	ld	a, l
	or	a, a
	jr	NZ, 00102$
	dec	h
	jr	NZ, 00102$
;src/main.c:37: set_bkg_data(0, 128, tiles);
	push	de
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
	pop	de
;src/main.c:38: set_bkg_data(128, 128, tiles + (128u * 16u));
	ld	hl, #0x0800
	add	hl, de
	push	hl
	ld	hl, #0x8080
	push	hl
	call	_set_bkg_data
	add	sp, #4
	ret
00102$:
;src/main.c:41: set_bkg_data(0, (uint8_t)tile_count, tiles);
	ld	a, c
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:43: }
	ret
;src/main.c:56: void draw_mt_column(uint8_t ring_col, uint16_t map_col,
;	---------------------------------
; Function draw_mt_column
; ---------------------------------
_draw_mt_column::
	add	sp, #-10
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
	ld	(hl), d
;src/main.c:60: uint8_t bx = ring_col << 1;
	add	a, a
	ldhl	sp,	#2
;src/main.c:63: uint8_t _prev = _current_bank;
	ld	(hl+), a
	ldh	a, (__current_bank + 0)
	ld	(hl), a
;src/main.c:64: SWITCH_ROM(map_bank);
	ldhl	sp,	#18
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/main.c:66: for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
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
;src/main.c:67: uint8_t mt = map[(uint16_t)r * map_w + map_col];
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
;src/main.c:68: uint8_t by = (r & (BKG_MT_H - 1)) << 1;
	ldhl	sp,	#9
	ld	a, (hl)
	and	a, #0x0f
	ldhl	sp,	#6
	ld	(hl), a
	sla	(hl)
;src/main.c:69: set_bkg_tiles(bx, by, 2, 1, &metatiles[mt][0]);
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
;src/main.c:70: set_bkg_tiles(bx, by + 1, 2, 1, &metatiles[mt][2]);
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
;src/main.c:66: for (uint8_t r = 0; r < map_h && r < BKG_MT_H; r++) {
	ldhl	sp,	#9
	inc	(hl)
	jp	00104$
00101$:
;src/main.c:74: SWITCH_ROM(_prev);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/main.c:75: }
	add	sp, #10
	pop	hl
	add	sp, #7
	jp	(hl)
;src/main.c:77: void fill_scroll_bg(const uint8_t* map, uint16_t map_w, uint16_t map_h, uint8_t map_bank) {
;	---------------------------------
; Function fill_scroll_bg
; ---------------------------------
_fill_scroll_bg::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:78: uint16_t cols = (map_w < BKG_MT_W) ? map_w : BKG_MT_W;
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
;src/main.c:79: for (uint16_t c = 0; c < cols; c++) {
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
;src/main.c:81: draw_mt_column((uint8_t)(c % BKG_MT_W), c, map, map_w, map_h, map_bank);
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
;src/main.c:79: for (uint16_t c = 0; c < cols; c++) {
	inc	de
	jr	00103$
00105$:
;src/main.c:83: }
	add	sp, #4
	pop	hl
	add	sp, #3
	jp	(hl)
;src/main.c:88: void draw_menu(void) {
;	---------------------------------
; Function draw_menu
; ---------------------------------
_draw_menu::
;src/main.c:90: }
	ret
;src/main.c:95: void play_level(uint8_t idx) {
;	---------------------------------
; Function play_level
; ---------------------------------
_play_level::
	add	sp, #-50
	ld	e, a
;src/main.c:97: const Level* l = game_levels[idx];
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
;src/main.c:98: const uint8_t* map = l->map;
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
	ldhl	sp,	#8
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:99: uint16_t map_w = l->map_width;
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
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:100: uint16_t map_h = l->map_height;
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
	ldhl	sp,	#12
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:102: uint16_t cam_px = 0;
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;src/main.c:106: uint16_t loaded_r = BKG_MT_W - 1;
	ld	(hl+), a
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/main.c:116: player_init(&player, 32, 160);
;include/player.h:26: p->world_x   = start_x;
	ldhl	sp,	#0
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
;include/player.h:27: p->world_y   = start_y;
	ld	(hl+), a
	ld	a, #0xa0
	ld	(hl+), a
;include/player.h:28: p->vel_y     = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
;include/player.h:29: p->on_ground = 0;
	ld	(hl+), a
;include/player.h:30: p->dead      = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:118: DISPLAY_OFF;
	call	_display_off
;src/main.c:120: uint8_t _tb = _current_bank;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#41
	ld	(hl), a
;src/main.c:121: SWITCH_ROM(BANK(famidash_chr_tiles));
	ld	a, #<(___bank_famidash_chr_tiles)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/main.c:122: if (l->tile_count == 256u) {
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#42
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:123: set_bkg_data(0,   128, l->tiles);
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#46
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#45
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:122: if (l->tile_count == 256u) {
	ldhl	sp,	#42
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
	inc	hl
	ld	a, (hl)
	dec	a
	jr	NZ, 00102$
;src/main.c:123: set_bkg_data(0,   128, l->tiles);
	ldhl	sp,	#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:124: set_bkg_data(128, 128, l->tiles + (128u * 16u));
	ldhl	sp,#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	add	a, #0x08
	ld	b, a
	push	bc
	ld	hl, #0x8080
	push	hl
	call	_set_bkg_data
	add	sp, #4
	jr	00103$
00102$:
;src/main.c:126: set_bkg_data(0, (uint8_t)l->tile_count, l->tiles);
	ldhl	sp,	#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	h, c
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
00103$:
;src/main.c:128: SWITCH_ROM(_tb);
	ldhl	sp,	#41
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/main.c:131: set_sprite_data(0, 4, cube_tiles);
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
;src/main.c:136: fill_scroll_bg(map, map_w, map_h, l->map_bank);
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
;src/main.c:139: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/main.c:140: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/main.c:141: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/main.c:143: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:144: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:145: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:147: waitpadup();
	call	_waitpadup
;src/main.c:150: while (1) {
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#21
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#27
	ld	(hl), a
	ld	a, #0x04
01202$:
	ldhl	sp,	#26
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01202$
00116$:
;src/main.c:151: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:152: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#49
	ld	(hl), a
;src/main.c:153: if (joy & J_START) break;
	push	hl
	ldhl	sp,	#51
	bit	7, (hl)
	pop	hl
	jp	NZ, 00117$
;src/main.c:156: if (cam_px < ((map_w - VIEW_MT_W) << 4)) {
	ldhl	sp,	#10
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
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jr	NC, 00112$
;src/main.c:157: uint16_t prev = cam_px >> 4;
	dec	hl
	ld	a, (hl+)
	ld	e, a
;src/main.c:158: cam_px += SCROLL_SPEED;
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
;src/main.c:159: uint16_t curr = cam_px >> 4;
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
;src/main.c:160: if (curr != prev) {
	ld	a, c
	sub	a, e
	jr	NZ, 01205$
	ld	a, b
	sub	a, d
	jr	Z, 00112$
01205$:
;src/main.c:161: uint16_t need = curr + VIEW_MT_W;
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
;src/main.c:162: if (need > loaded_r && need < map_w) {
	ldhl	sp,	#16
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00112$
	ldhl	sp,	#10
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00112$
;src/main.c:163: loaded_r = need;
	ldhl	sp,	#16
	ld	a, c
	ld	(hl+), a
;src/main.c:164: draw_mt_column((uint8_t)(need % BKG_MT_W), need, map, map_w, map_h, l->map_bank);
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
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	e, c
	ld	d, b
	call	_draw_mt_column
00112$:
;src/main.c:170: player.world_x = cam_px + PLAYER_SCREEN_X;
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0020
	add	hl, bc
	ld	c, h
	ld	a, l
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), c
;src/main.c:172: _prev = _current_bank;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#28
	ld	(hl), a
;src/main.c:173: SWITCH_ROM(l->map_bank);
	ldhl	sp,#18
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
;src/main.c:174: died = player_update(&player, joy, map, map_w, map_h);
	ldhl	sp,	#49
	ld	a, (hl-)
	ld	(hl), a
;include/player.h:47: if (p->dead) return 1;
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/player.h:50: if (!p->on_ground) {
;include/player.h:51: p->vel_y += GRAVITY;
;include/player.h:47: if (p->dead) return 1;
	ld	a, (hl)
	or	a, a
	jr	Z, 00125$
	ld	(hl), #0x01
	jp	00397$
00125$:
;include/player.h:50: if (!p->on_ground) {
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	NZ, 00129$
;include/player.h:51: p->vel_y += GRAVITY;
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:52: if (p->vel_y > MAX_FALL_SPEED) p->vel_y = MAX_FALL_SPEED;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x50
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 01206$
	bit	7, d
	jr	NZ, 01207$
	cp	a, a
	jr	01207$
01206$:
	bit	7, d
	jr	Z, 01207$
	scf
01207$:
	jr	NC, 00129$
	ldhl	sp,	#4
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00129$:
;include/player.h:56: if ((joy & J_A) && p->on_ground) {
;include/player.h:57: p->vel_y     = JUMP_FORCE;
;include/player.h:56: if ((joy & J_A) && p->on_ground) {
	push	hl
	ldhl	sp,	#50
	bit	4, (hl)
	pop	hl
	jr	Z, 00132$
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00132$
;include/player.h:57: p->vel_y     = JUMP_FORCE;
	dec	hl
	dec	hl
	ld	a, #0xab
	ld	(hl+), a
;include/player.h:58: p->on_ground = 0;
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0x00
00132$:
;include/player.h:62: int8_t pixels = (int8_t)(p->vel_y >> 4);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#49
	ld	(hl), c
;include/player.h:63: int8_t step   = (pixels >= 0) ? 1 : -1;
	ld	a, (hl-)
	rlca
	and	a,#0x01
	ld	(hl), a
	bit	0, (hl)
	ld	a, #0x01
	jr	Z, 00413$
	ld	a, #0xff
00413$:
	ldhl	sp,	#38
	ld	(hl), a
;include/player.h:64: int8_t steps  = (pixels >= 0) ? pixels : -pixels;
	ldhl	sp,	#48
	bit	0, (hl)
	jr	Z, 00415$
	xor	a, a
	ldhl	sp,	#49
	sub	a, (hl)
	ld	(hl), a
00415$:
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#39
	ld	(hl), a
;include/player.h:65: if (steps > 16) steps = 16;
	ld	e, (hl)
	ld	a,#0x10
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 01209$
	bit	7, d
	jr	NZ, 01210$
	cp	a, a
	jr	01210$
01209$:
	bit	7, d
	jr	Z, 01210$
	scf
01210$:
	jr	NC, 00134$
	ldhl	sp,	#39
	ld	(hl), #0x10
00134$:
;include/player.h:67: p->on_ground = 0;
	ldhl	sp,	#6
	ld	(hl), #0x00
;src/main.c:69: set_bkg_tiles(bx, by, 2, 1, &metatiles[mt][0]);
	ldhl	sp,	#38
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 01211$
	bit	7, d
	jr	NZ, 01212$
	cp	a, a
	jr	01212$
01211$:
	bit	7, d
	jr	Z, 01212$
	scf
01212$:
	ld	a, #0x00
	rla
	ldhl	sp,	#40
	ld	(hl), a
	ldhl	sp,	#49
	ld	(hl), #0x00
00408$:
;include/player.h:70: int16_t ny = p->world_y + step;
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
;include/player.h:69: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#39
	ld	e, (hl)
	ldhl	sp,	#49
	ld	d, (hl)
	ld	a, (hl)
	ldhl	sp,	#39
	sub	a, (hl)
	bit	7, e
	jr	Z, 01213$
	bit	7, d
	jr	NZ, 01214$
	cp	a, a
	jr	01214$
01213$:
	bit	7, d
	jr	Z, 01214$
	scf
01214$:
	jp	NC, 00188$
;include/player.h:70: int16_t ny = p->world_y + step;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#38
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ldhl	sp,	#41
	ld	(hl), c
	inc	hl
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#44
;include/player.h:75: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl+)
	ld	b, (hl)
	add	a, #0x0f
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ldhl	sp,	#47
	ld	(hl), c
	inc	hl
	ld	(hl), a
;include/player.h:72: if (step > 0) {
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jp	Z, 00186$
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,#45
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#38
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#37
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	h, b
	bit	7, h
	jr	Z, 00136$
	xor	a, a
	jr	00141$
00136$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#44
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
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	push	de
	ldhl	sp,	#45
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00138$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00139$
00138$:
	ld	a, #0x07
	jr	00141$
00139$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#43
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
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
00141$:
	ldhl	sp,	#44
;include/player.h:75: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl+), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00144$
	inc	hl
	inc	hl
	ld	(hl), #0x00
	jr	00149$
00144$:
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
	dec	hl
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
;include/player.h:75: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00146$
	ldhl	sp,	#45
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00147$
00146$:
	ldhl	sp,	#48
	ld	(hl), #0x07
	jr	00149$
00147$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#45
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
	ldhl	sp,	#24
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
00149$:
;include/player.h:76: if (IS_SOLID(cl) || IS_SOLID(cr)) {
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00158$
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00158$
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00158$
	ldhl	sp,	#44
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00158$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00158$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00158$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00158$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x06
	jp	NZ, 00187$
00158$:
;include/player.h:77: p->world_y   = ((ny + PLAYER_SIZE) & ~15) - PLAYER_SIZE - 1;
	ldhl	sp,	#36
	ld	a, (hl+)
	and	a, #0xf0
	ld	c, a
	ld	b, (hl)
	ld	a, c
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
;include/player.h:78: p->vel_y     = 0;
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;include/player.h:79: p->on_ground = 1;
	ld	(hl+), a
	ld	(hl), #0x01
;include/player.h:80: break;
	jp	00188$
00186$:
;include/player.h:84: uint8_t cl = col_point(p->world_x,               ny, map, map_w, map_h);
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl)
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
;include/player.h:84: uint8_t cl = col_point(p->world_x,               ny, map, map_w, map_h);
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00162$
	ldhl	sp,	#46
	ld	(hl), #0x00
	jr	00167$
00162$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#36
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#37
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
	ldhl	sp,	#36
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#37
	ld	(hl), a
;include/player.h:84: uint8_t cl = col_point(p->world_x,               ny, map, map_w, map_h);
	ldhl	sp,	#34
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00164$
	ldhl	sp,	#36
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00165$
00164$:
	ldhl	sp,	#46
	ld	(hl), #0x07
	jr	00167$
00165$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#34
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
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
00167$:
;include/player.h:85: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny, map, map_w, map_h);
	ldhl	sp,	#43
	ld	a, (hl)
	or	a, a
	jr	Z, 00170$
	ldhl	sp,	#48
	ld	(hl), #0x00
	jr	00175$
00170$:
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
;include/player.h:85: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny, map, map_w, map_h);
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00172$
	ldhl	sp,	#44
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00173$
00172$:
	ldhl	sp,	#48
	ld	(hl), #0x07
	jr	00175$
00173$:
	ldhl	sp,	#22
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
	ldhl	sp,	#24
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
00175$:
;include/player.h:86: if (IS_SOLID(cl) || IS_SOLID(cr)) {
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00184$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00184$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00184$
	ldhl	sp,	#46
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00184$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00184$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00184$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00184$
	ldhl	sp,	#48
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00187$
00184$:
;include/player.h:87: p->world_y = ((ny >> 4) + 1) << 4;
	ldhl	sp,#41
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	l, c
	ld	h, b
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
;include/player.h:88: p->vel_y   = 0;
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;include/player.h:89: break;
	jr	00188$
00187$:
;include/player.h:92: p->world_y = ny;
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;include/player.h:69: for (int8_t i = 0; i < steps; i++) {
	ldhl	sp,	#49
	inc	(hl)
	jp	00408$
00188$:
;include/player.h:74: uint8_t cl = col_point(p->world_x,               ny + PLAYER_SIZE, map, map_w, map_h);
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#30
;include/player.h:75: uint8_t cr = col_point(p->world_x + PLAYER_SIZE,  ny + PLAYER_SIZE, map, map_w, map_h);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
;include/player.h:97: uint16_t hx1 = p->world_x  + PLAYER_HBOX;
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ldhl	sp,	#48
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;include/player.h:98: uint16_t hx2 = p->world_x  + PLAYER_SIZE - PLAYER_HBOX;
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#33
	ld	(hl), c
	inc	hl
	ld	(hl), a
;include/player.h:99: int16_t  hy1 = p->world_y  + PLAYER_HBOX;
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
;include/player.h:100: int16_t  hy2 = p->world_y  + PLAYER_SIZE - PLAYER_HBOX;
	ld	a, (hl-)
	ld	b, a
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#39
	ld	(hl), e
	inc	hl
	ld	(hl), a
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ld	a, b
	rlca
	and	a,#0x01
	ldhl	sp,	#41
	ld	(hl), a
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#49
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
	inc	hl
	inc	hl
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
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00190$
	ld	c, #0x00
	jr	00195$
00190$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#50
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00192$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00193$
00192$:
	ld	c, #0x07
	jr	00195$
00193$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
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
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00195$:
;include/player.h:106: p->dead = 1;
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x08
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00198$
	ld	c, #0x00
	jr	00203$
00198$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#50
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00200$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00201$
00200$:
	ld	c, #0x07
	jr	00203$
00201$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
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
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00203$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x03
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00207$
	ld	c, #0x00
	jr	00212$
00207$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#50
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00209$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00210$
00209$:
	ld	c, #0x07
	jr	00212$
00210$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
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
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00212$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x04
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00216$
	ld	c, #0x00
	jr	00221$
00216$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#50
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00218$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00219$
00218$:
	ld	c, #0x07
	jr	00221$
00219$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
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
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00221$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x02
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00225$
	ldhl	sp,	#49
	ld	(hl), #0x00
	jr	00230$
00225$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	ldhl	sp,	#46
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00227$
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00228$
00227$:
	ldhl	sp,	#49
	ld	(hl), #0x07
	jr	00230$
00228$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
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
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00230$:
;include/player.h:102: if (IS_HAZARD(col_point(hx1, hy1, map, map_w, map_h)) ||
	ldhl	sp,	#49
	ld	a, (hl)
	dec	a
	jp	Z, 00368$
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#49
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
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00234$
	ld	c, #0x00
	jr	00239$
00234$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00236$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00237$
00236$:
	ld	c, #0x07
	jr	00239$
00237$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#46
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00239$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x08
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00242$
	ld	c, #0x00
	jr	00247$
00242$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00244$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00245$
00244$:
	ld	c, #0x07
	jr	00247$
00245$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#46
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00247$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x03
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00251$
	ld	c, #0x00
	jr	00256$
00251$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00253$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00254$
00253$:
	ld	c, #0x07
	jr	00256$
00254$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#46
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00256$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x04
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00260$
	ld	c, #0x00
	jr	00265$
00260$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00262$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00263$
00262$:
	ld	c, #0x07
	jr	00265$
00263$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#46
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00265$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x02
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#41
	ld	a, (hl)
	or	a, a
	jr	Z, 00269$
	ldhl	sp,	#47
	ld	(hl), #0x00
	jr	00274$
00269$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#33
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#44
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	ldhl	sp,	#33
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00271$
	ldhl	sp,	#46
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00272$
00271$:
	ldhl	sp,	#47
	ld	(hl), #0x07
	jr	00274$
00272$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#46
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#33
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00274$:
;include/player.h:103: IS_HAZARD(col_point(hx2, hy1, map, map_w, map_h)) ||
	ldhl	sp,	#47
	ld	a, (hl)
	dec	a
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#47
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00279$
	ld	c, #0x00
	jr	00284$
00279$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00281$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00282$
00281$:
	ld	c, #0x07
	jr	00284$
00282$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00284$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x08
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00287$
	ld	c, #0x00
	jr	00292$
00287$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00289$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00290$
00289$:
	ld	c, #0x07
	jr	00292$
00290$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00292$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x03
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00296$
	ld	c, #0x00
	jr	00301$
00296$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00298$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00299$
00298$:
	ld	c, #0x07
	jr	00301$
00299$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00301$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x04
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00305$
	ld	c, #0x00
	jr	00310$
00305$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00307$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00308$
00307$:
	ld	c, #0x07
	jr	00310$
00308$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00310$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	ld	a, c
	sub	a, #0x02
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00314$
	ld	c, #0x00
	jr	00319$
00314$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#42
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00316$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00317$
00316$:
	ld	c, #0x07
	jr	00319$
00317$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00319$:
;include/player.h:104: IS_HAZARD(col_point(hx1, hy2, map, map_w, map_h)) ||
	dec	c
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00324$
	ld	c, #0x00
	jr	00329$
00324$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00326$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00327$
00326$:
	ld	c, #0x07
	jr	00329$
00327$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00329$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x08
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00332$
	ld	c, #0x00
	jr	00337$
00332$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00334$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00335$
00334$:
	ld	c, #0x07
	jr	00337$
00335$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00337$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x03
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00341$
	ld	c, #0x00
	jr	00346$
00341$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00343$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00344$
00343$:
	ld	c, #0x07
	jr	00346$
00344$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00346$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x04
	jp	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00350$
	ld	c, #0x00
	jr	00355$
00350$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#48
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	ldhl	sp,	#49
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	push	de
	ldhl	sp,	#47
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00352$
	ldhl	sp,	#20
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00353$
00352$:
	ld	c, #0x07
	jr	00355$
00353$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#45
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	c, (hl)
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00355$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ld	a, c
	sub	a, #0x02
	jr	Z, 00368$
;include/collision.h:53: if (world_py < 0) return COL_NONE;            // above map = sky
	ldhl	sp,	#47
	ld	a, (hl)
	or	a, a
	jr	Z, 00359$
	inc	hl
	inc	hl
	ld	(hl), #0x00
	jr	00364$
00359$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
;include/collision.h:55: uint16_t my = (uint16_t)world_py >> 4;        // pixel → metatile row
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#47
	ld	(hl), a
;include/collision.h:56: if (mx >= map_w || my >= map_h) return COL_ALL; // out of bounds = solid
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00361$
	ldhl	sp,	#46
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00362$
00361$:
	ldhl	sp,	#49
	ld	(hl), #0x07
	jr	00364$
00362$:
;include/collision.h:57: return col_of(map[(uint16_t)my * map_w + mx]);
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#46
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
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
;include/collision.h:40: return famidash_metatile_collision[tile_id];
	ld	l, a
	ld	h, #0x00
	ld	de, #_famidash_metatile_collision
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
;include/player.h:37: return col_at(px, py, map, map_w, map_h);
00364$:
;include/player.h:105: IS_HAZARD(col_point(hx2, hy2, map, map_w, map_h))) {
	ldhl	sp,	#49
	ld	a, (hl)
	dec	a
	jr	NZ, 00369$
00368$:
;include/player.h:106: p->dead = 1;
	ldhl	sp,	#7
	ld	(hl), #0x01
;include/player.h:107: return 1;
	ldhl	sp,	#49
	ld	(hl), #0x01
	jp	00397$
00369$:
;include/player.h:111: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#44
	ld	(hl), c
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00371$
	inc	hl
	inc	hl
	ld	(hl), #0x00
	jp	00376$
00371$:
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
;include/player.h:111: uint8_t cm_l = col_point(p->world_x,               p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00373$
	ldhl	sp,	#46
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00374$
00373$:
	ldhl	sp,	#49
	ld	(hl), #0x07
	jr	00376$
00374$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#46
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
	ldhl	sp,	#24
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
00376$:
	ldhl	sp,	#49
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;include/player.h:112: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#45
	ld	(hl), c
	inc	hl
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00379$
	ld	(hl), #0x00
	jp	00384$
00379$:
;include/collision.h:54: uint16_t mx = world_px >> 4;                  // pixel → metatile col
	ldhl	sp,	#46
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
	ldhl	sp,	#48
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
;include/player.h:112: uint8_t cm_r = col_point(p->world_x + PLAYER_SIZE,  p->world_y + 7, map, map_w, map_h);
	ldhl	sp,	#45
	ld	e, l
	ld	d, h
	ldhl	sp,	#22
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00381$
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#20
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00382$
00381$:
	ldhl	sp,	#49
	ld	(hl), #0x07
	jr	00384$
00382$:
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#43
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#43
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
	ldhl	sp,	#50
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#49
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#24
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#47
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#46
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#49
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
00384$:
;include/player.h:113: if (IS_SOLID(cm_l) || IS_SOLID(cm_r)) {
	ldhl	sp,	#47
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00393$
	ldhl	sp,	#47
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00393$
	ldhl	sp,	#47
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00393$
	ldhl	sp,	#47
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00393$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00393$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00393$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00393$
	ldhl	sp,	#49
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ, 00394$
00393$:
;include/player.h:114: p->dead = 1;
	ldhl	sp,	#7
	ld	(hl), #0x01
;include/player.h:115: return 1;
	ldhl	sp,	#49
	ld	(hl), #0x01
	jr	00397$
00394$:
;include/player.h:119: if (p->world_y > (int16_t)((uint16_t)map_h << 4)) {
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#48
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#49
	ld	(hl), a
	ldhl	sp,	#48
	ld	e, l
	ld	d, h
	ldhl	sp,	#35
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 01263$
	bit	7, d
	jr	NZ, 01264$
	cp	a, a
	jr	01264$
01263$:
	bit	7, d
	jr	Z, 01264$
	scf
01264$:
	jr	NC, 00396$
;include/player.h:120: p->dead = 1;
	ldhl	sp,	#7
	ld	(hl), #0x01
;include/player.h:121: return 1;
	ldhl	sp,	#49
	ld	(hl), #0x01
	jr	00397$
00396$:
;include/player.h:124: return 0;
	ldhl	sp,	#49
	ld	(hl), #0x00
;src/main.c:174: died = player_update(&player, joy, map, map_w, map_h);
00397$:
;src/main.c:175: SWITCH_ROM(_prev);
	ldhl	sp,	#28
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;include/player.h:27: p->world_y   = start_y;
;src/main.c:177: if (died) {
	ldhl	sp,	#49
	ld	a, (hl)
	or	a, a
	jr	Z, 00114$
;src/main.c:178: cam_px = 0;
	xor	a, a
	ldhl	sp,	#14
	ld	(hl+), a
;src/main.c:179: loaded_r = BKG_MT_W - 1;
	ld	(hl+), a
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;include/player.h:26: p->world_x   = start_x;
	ldhl	sp,	#0
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
;include/player.h:27: p->world_y   = start_y;
	ld	(hl+), a
	ld	a, #0xa0
	ld	(hl+), a
;include/player.h:28: p->vel_y     = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
;include/player.h:29: p->on_ground = 0;
	ld	(hl+), a
;include/player.h:30: p->dead      = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/main.c:182: fill_scroll_bg(map, map_w, map_h, l->map_bank);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_fill_scroll_bg
00114$:
;include/player.h:128: return p->world_y - (int16_t)cam_py;
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0x90
;src/main.c:188: move_sprite(0, PLAYER_SCREEN_X + 8,     py + 16);
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
;src/main.c:190: move_sprite(2, PLAYER_SCREEN_X + 8,     py + 16 + 8);
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
;src/main.c:193: move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
	ldhl	sp,	#14
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, #0x70
	ldh	(_SCY_REG + 0), a
;src/main.c:193: move_bkg((uint8_t)cam_px, (uint8_t)cam_py);
	jp	00116$
00117$:
;src/main.c:197: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/main.c:199: waitpadup();
	call	_waitpadup
;src/main.c:200: setup_menu_font();
	call	_setup_menu_font
;src/main.c:201: redraw = 1;
	ld	hl, #_redraw
	ld	(hl), #0x01
;src/main.c:202: }
	add	sp, #50
	ret
;src/main.c:207: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:208: music_ready = 0;
	xor	a, a
	ld	(#_music_ready),a
;src/main.c:209: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:210: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:211: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:213: SWITCH_ROM(5);
	ld	a, #0x05
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #0x05
;src/main.c:214: hUGE_init(&song_stereoma);
	ld	de, #_song_stereoma
	call	_hUGE_init
;src/main.c:215: SWITCH_ROM(1);
	ld	a, #0x01
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #0x01
;src/main.c:216: music_ready = 1;
	ld	hl, #_music_ready
	ld	(hl), #0x01
;src/main.c:218: TMA_REG = 224;
	ld	a, #0xe0
	ldh	(_TMA_REG + 0), a
;src/main.c:219: TAC_REG = 0x04;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;src/main.c:220: add_TIM(play_music_safe);
	ld	de, #_play_music_safe
	call	_add_TIM
;src/main.c:221: set_interrupts(VBL_IFLAG | TIM_IFLAG);
	ld	a, #0x05
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/main.c:224: setup_menu_font();
	call	_setup_menu_font
;src/main.c:226: while (1) {
00116$:
;src/main.c:227: if (redraw) draw_menu();
	ld	a, (#_redraw)
	or	a, a
	jr	Z, 00102$
	call	_draw_menu
00102$:
;src/main.c:228: uint8_t joy = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:230: if (joy & J_UP) {
	push	hl
	bit	2, (hl)
	pop	hl
	jr	Z, 00113$
;src/main.c:231: if (selected > 0) { selected--; redraw = 1; }
	ld	hl, #_selected
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	dec	(hl)
	ld	hl, #_redraw
	ld	(hl), #0x01
00104$:
;src/main.c:232: waitpadup();
	call	_waitpadup
	jr	00114$
00113$:
;src/main.c:234: else if (joy & J_DOWN) {
	push	hl
	ldhl	sp,	#2
	bit	3, (hl)
	pop	hl
	jr	Z, 00110$
;src/main.c:235: if (selected < MAX_LEVELS - 1) { selected++; redraw = 1; }
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
;src/main.c:236: waitpadup();
	call	_waitpadup
	jr	00114$
00110$:
;src/main.c:238: else if (joy & J_A) {
	push	hl
	ldhl	sp,	#2
	bit	4, (hl)
	pop	hl
	jr	Z, 00114$
;src/main.c:239: play_level(selected);
	ld	a, (_selected)
	call	_play_level
00114$:
;src/main.c:242: wait_vbl_done();
	call	_wait_vbl_done
	jr	00116$
;src/main.c:244: }
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
