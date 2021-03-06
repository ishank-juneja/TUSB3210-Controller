;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.0 Mon May 13 19:58:47 2019

;--------------------------------------------------------
	.module usbiofun
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fn_cmd_08
	.globl _fn_cmd_07
	.globl _fn_cmd_06
	.globl _fn_cmd_05
	.globl _fn_cmd_04
	.globl _fn_cmd_03
	.globl _fn_cmd_02
	.globl _fn_cmd_01
	.globl _oep1_buffer
	.globl _iep1_buffer
	.globl _nixie_digits
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_P2	=	0x00a0
_IE	=	0x00a8
_P3	=	0x00b0
_IP	=	0x00b8
_PSW	=	0x00d0
_ACC	=	0x00e0
_B	=	0x00f0
_T2CON	=	0x00c8
_RCAP2L	=	0x00ca
_RCAP2H	=	0x00cb
_TL2	=	0x00cc
_TH2	=	0x00cd
;--------------------------------------------------------
; special function bits 
;--------------------------------------------------------
_P0_0	=	0x0080
_P0_1	=	0x0081
_P0_2	=	0x0082
_P0_3	=	0x0083
_P0_4	=	0x0084
_P0_5	=	0x0085
_P0_6	=	0x0086
_P0_7	=	0x0087
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_P1_0	=	0x0090
_P1_1	=	0x0091
_P1_2	=	0x0092
_P1_3	=	0x0093
_P1_4	=	0x0094
_P1_5	=	0x0095
_P1_6	=	0x0096
_P1_7	=	0x0097
_RI	=	0x0098
_TI	=	0x0099
_RB8	=	0x009a
_TB8	=	0x009b
_REN	=	0x009c
_SM2	=	0x009d
_SM1	=	0x009e
_SM0	=	0x009f
_P2_0	=	0x00a0
_P2_1	=	0x00a1
_P2_2	=	0x00a2
_P2_3	=	0x00a3
_P2_4	=	0x00a4
_P2_5	=	0x00a5
_P2_6	=	0x00a6
_P2_7	=	0x00a7
_EX0	=	0x00a8
_ET0	=	0x00a9
_EX1	=	0x00aa
_ET1	=	0x00ab
_ES	=	0x00ac
_EA	=	0x00af
_P3_0	=	0x00b0
_P3_1	=	0x00b1
_P3_2	=	0x00b2
_P3_3	=	0x00b3
_P3_4	=	0x00b4
_P3_5	=	0x00b5
_P3_6	=	0x00b6
_P3_7	=	0x00b7
_RXD	=	0x00b0
_TXD	=	0x00b1
_INT0	=	0x00b2
_INT1	=	0x00b3
_T0	=	0x00b4
_T1	=	0x00b5
_WR	=	0x00b6
_RD	=	0x00b7
_PX0	=	0x00b8
_PT0	=	0x00b9
_PX1	=	0x00ba
_PT1	=	0x00bb
_PS	=	0x00bc
_P	=	0x00d0
_F1	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
_ET2	=	0x00ad
_T2CON_0	=	0x00c8
_T2CON_1	=	0x00c9
_T2CON_2	=	0x00ca
_T2CON_3	=	0x00cb
_T2CON_4	=	0x00cc
_T2CON_5	=	0x00cd
_T2CON_6	=	0x00ce
_T2CON_7	=	0x00cf
_CP_RL2	=	0x00c8
_C_T2	=	0x00c9
_TR2	=	0x00ca
_EXEN2	=	0x00cb
_TCLK	=	0x00cc
_RCLK	=	0x00cd
_EXF2	=	0x00ce
_TF2	=	0x00cf
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_nixie_digits::
	.ds 6
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area _DUMMY
	.area	OSEG    (OVR,DATA)
	.area _DUMMY
	.area	OSEG    (OVR,DATA)
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_iep1_buffer	=	0xfe00
_oep1_buffer	=	0xfd80
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME	 (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_01'
;------------------------------------------------------------
;	usbiofun.c 13
;	-----------------------------------------
;	 function fn_cmd_01
;	-----------------------------------------
_fn_cmd_01:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	usbiofun.c 16
	mov	dptr,#_iep1_buffer
	mov	a,#0x1B
	movx	@dptr,a
;	usbiofun.c 17
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x4A)
	mov	a,#0x01
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_02'
;------------------------------------------------------------
;	usbiofun.c 21
;	-----------------------------------------
;	 function fn_cmd_02
;	-----------------------------------------
_fn_cmd_02:
;	usbiofun.c 22
	mov	dptr,#_iep1_buffer
	mov	a,#0x4E
	movx	@dptr,a
;	usbiofun.c 23
	mov	dptr,#(_iep1_buffer + 0x0001)
	mov	a,#0x49
	movx	@dptr,a
;	usbiofun.c 24
	mov	dptr,#(_iep1_buffer + 0x0002)
	mov	a,#0x58
	movx	@dptr,a
;	usbiofun.c 25
	mov	dptr,#(_iep1_buffer + 0x0003)
	mov	a,#0x49
	movx	@dptr,a
;	usbiofun.c 26
	mov	dptr,#(_iep1_buffer + 0x0004)
	mov	a,#0x45
	movx	@dptr,a
;	usbiofun.c 27
	mov	dptr,#(_iep1_buffer + 0x0005)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	usbiofun.c 28
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x4A)
	mov	a,#0x06
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_03'
;------------------------------------------------------------
;	usbiofun.c 31
;	-----------------------------------------
;	 function fn_cmd_03
;	-----------------------------------------
_fn_cmd_03:
;	usbiofun.c 34
	mov	r2,#0x00
	mov	r3,#0x00
00101$:
	clr	c
	mov	a,r2
	subb	a,#0x08
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00109$:
;	usbiofun.c 35
	mov	a,r2
	add	a,#_iep1_buffer
	mov	r4,a
	mov	a,r3
	addc	a,#(_iep1_buffer >> 8)
	mov	r5,a
	mov	a,r2
	add	a,#_oep1_buffer
	mov	dpl,a
	mov	a,r3
	addc	a,#(_oep1_buffer >> 8)
	mov	dph,a
	movx	a,@dptr
; Peephole 185   changed order of increment (acc incremented also!)
	inc  a
	mov  r6,a
	mov	dpl,r4
	mov	dph,r5
	mov	a,r6
	movx	@dptr,a
;	usbiofun.c 34
;	tail increment optimized
	inc	r2
	cjne	r2,#0x00,00101$
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	usbiofun.c 37
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x4A)
	mov	a,#0x08
	movx	@dptr,a
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_04'
;------------------------------------------------------------
;	usbiofun.c 44
;	-----------------------------------------
;	 function fn_cmd_04
;	-----------------------------------------
_fn_cmd_04:
;	usbiofun.c 47
	mov	r2,#0x00
	mov	r3,#0x00
00101$:
	clr	c
	mov	a,r2
	subb	a,#0x06
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00109$:
;	usbiofun.c 48
	mov	a,r2
	add	a,#_nixie_digits
	mov	r0,a
	mov	a,#0x02
	add	a,r2
	mov	r4,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,r3
	mov	r5,a
	mov	a,r4
	add	a,#_oep1_buffer
	mov	dpl,a
	mov	a,r5
	addc	a,#(_oep1_buffer >> 8)
	mov	dph,a
	movx	a,@dptr
; Peephole 192   used a instead of ar4 as source
	mov  r4,a
	mov  @r0,a
;	usbiofun.c 49
	mov	a,r2
	add	a,#_iep1_buffer
	mov	dpl,a
	mov	a,r3
	addc	a,#(_iep1_buffer >> 8)
	mov	dph,a
	mov	a,r4
	movx	@dptr,a
;	usbiofun.c 47
	inc	r2
	cjne	r2,#0x00,00110$
	inc	r3
00110$:
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	usbiofun.c 51
	mov	r2,_P0
	mov	dptr,#(_iep1_buffer + 0x0006)
	mov	a,r2
	movx	@dptr,a
;	usbiofun.c 52
	mov	r2,_P1
	mov	dptr,#(_iep1_buffer + 0x0007)
	mov	a,r2
	movx	@dptr,a
;	usbiofun.c 56
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x4A)
	mov	a,#0x08
	movx	@dptr,a
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_05'
;------------------------------------------------------------
;	usbiofun.c 60
;	-----------------------------------------
;	 function fn_cmd_05
;	-----------------------------------------
_fn_cmd_05:
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_06'
;------------------------------------------------------------
;	usbiofun.c 61
;	-----------------------------------------
;	 function fn_cmd_06
;	-----------------------------------------
_fn_cmd_06:
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_07'
;------------------------------------------------------------
;	usbiofun.c 62
;	-----------------------------------------
;	 function fn_cmd_07
;	-----------------------------------------
_fn_cmd_07:
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_cmd_08'
;------------------------------------------------------------
;	usbiofun.c 63
;	-----------------------------------------
;	 function fn_cmd_08
;	-----------------------------------------
_fn_cmd_08:
00101$:
	ret
	.area CSEG    (CODE)
