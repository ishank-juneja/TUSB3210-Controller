                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.0 Mon May 13 19:58:47 2019
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module usbiofun
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _fn_cmd_08
                             12 	.globl _fn_cmd_07
                             13 	.globl _fn_cmd_06
                             14 	.globl _fn_cmd_05
                             15 	.globl _fn_cmd_04
                             16 	.globl _fn_cmd_03
                             17 	.globl _fn_cmd_02
                             18 	.globl _fn_cmd_01
                             19 	.globl _oep1_buffer
                             20 	.globl _iep1_buffer
                             21 	.globl _nixie_digits
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                    0080     25 _P0	=	0x0080
                    0081     26 _SP	=	0x0081
                    0082     27 _DPL	=	0x0082
                    0083     28 _DPH	=	0x0083
                    0087     29 _PCON	=	0x0087
                    0088     30 _TCON	=	0x0088
                    0089     31 _TMOD	=	0x0089
                    008A     32 _TL0	=	0x008a
                    008B     33 _TL1	=	0x008b
                    008C     34 _TH0	=	0x008c
                    008D     35 _TH1	=	0x008d
                    0090     36 _P1	=	0x0090
                    0098     37 _SCON	=	0x0098
                    0099     38 _SBUF	=	0x0099
                    00A0     39 _P2	=	0x00a0
                    00A8     40 _IE	=	0x00a8
                    00B0     41 _P3	=	0x00b0
                    00B8     42 _IP	=	0x00b8
                    00D0     43 _PSW	=	0x00d0
                    00E0     44 _ACC	=	0x00e0
                    00F0     45 _B	=	0x00f0
                    00C8     46 _T2CON	=	0x00c8
                    00CA     47 _RCAP2L	=	0x00ca
                    00CB     48 _RCAP2H	=	0x00cb
                    00CC     49 _TL2	=	0x00cc
                    00CD     50 _TH2	=	0x00cd
                             51 ;--------------------------------------------------------
                             52 ; special function bits 
                             53 ;--------------------------------------------------------
                    0080     54 _P0_0	=	0x0080
                    0081     55 _P0_1	=	0x0081
                    0082     56 _P0_2	=	0x0082
                    0083     57 _P0_3	=	0x0083
                    0084     58 _P0_4	=	0x0084
                    0085     59 _P0_5	=	0x0085
                    0086     60 _P0_6	=	0x0086
                    0087     61 _P0_7	=	0x0087
                    0088     62 _IT0	=	0x0088
                    0089     63 _IE0	=	0x0089
                    008A     64 _IT1	=	0x008a
                    008B     65 _IE1	=	0x008b
                    008C     66 _TR0	=	0x008c
                    008D     67 _TF0	=	0x008d
                    008E     68 _TR1	=	0x008e
                    008F     69 _TF1	=	0x008f
                    0090     70 _P1_0	=	0x0090
                    0091     71 _P1_1	=	0x0091
                    0092     72 _P1_2	=	0x0092
                    0093     73 _P1_3	=	0x0093
                    0094     74 _P1_4	=	0x0094
                    0095     75 _P1_5	=	0x0095
                    0096     76 _P1_6	=	0x0096
                    0097     77 _P1_7	=	0x0097
                    0098     78 _RI	=	0x0098
                    0099     79 _TI	=	0x0099
                    009A     80 _RB8	=	0x009a
                    009B     81 _TB8	=	0x009b
                    009C     82 _REN	=	0x009c
                    009D     83 _SM2	=	0x009d
                    009E     84 _SM1	=	0x009e
                    009F     85 _SM0	=	0x009f
                    00A0     86 _P2_0	=	0x00a0
                    00A1     87 _P2_1	=	0x00a1
                    00A2     88 _P2_2	=	0x00a2
                    00A3     89 _P2_3	=	0x00a3
                    00A4     90 _P2_4	=	0x00a4
                    00A5     91 _P2_5	=	0x00a5
                    00A6     92 _P2_6	=	0x00a6
                    00A7     93 _P2_7	=	0x00a7
                    00A8     94 _EX0	=	0x00a8
                    00A9     95 _ET0	=	0x00a9
                    00AA     96 _EX1	=	0x00aa
                    00AB     97 _ET1	=	0x00ab
                    00AC     98 _ES	=	0x00ac
                    00AF     99 _EA	=	0x00af
                    00B0    100 _P3_0	=	0x00b0
                    00B1    101 _P3_1	=	0x00b1
                    00B2    102 _P3_2	=	0x00b2
                    00B3    103 _P3_3	=	0x00b3
                    00B4    104 _P3_4	=	0x00b4
                    00B5    105 _P3_5	=	0x00b5
                    00B6    106 _P3_6	=	0x00b6
                    00B7    107 _P3_7	=	0x00b7
                    00B0    108 _RXD	=	0x00b0
                    00B1    109 _TXD	=	0x00b1
                    00B2    110 _INT0	=	0x00b2
                    00B3    111 _INT1	=	0x00b3
                    00B4    112 _T0	=	0x00b4
                    00B5    113 _T1	=	0x00b5
                    00B6    114 _WR	=	0x00b6
                    00B7    115 _RD	=	0x00b7
                    00B8    116 _PX0	=	0x00b8
                    00B9    117 _PT0	=	0x00b9
                    00BA    118 _PX1	=	0x00ba
                    00BB    119 _PT1	=	0x00bb
                    00BC    120 _PS	=	0x00bc
                    00D0    121 _P	=	0x00d0
                    00D1    122 _F1	=	0x00d1
                    00D2    123 _OV	=	0x00d2
                    00D3    124 _RS0	=	0x00d3
                    00D4    125 _RS1	=	0x00d4
                    00D5    126 _F0	=	0x00d5
                    00D6    127 _AC	=	0x00d6
                    00D7    128 _CY	=	0x00d7
                    00AD    129 _ET2	=	0x00ad
                    00C8    130 _T2CON_0	=	0x00c8
                    00C9    131 _T2CON_1	=	0x00c9
                    00CA    132 _T2CON_2	=	0x00ca
                    00CB    133 _T2CON_3	=	0x00cb
                    00CC    134 _T2CON_4	=	0x00cc
                    00CD    135 _T2CON_5	=	0x00cd
                    00CE    136 _T2CON_6	=	0x00ce
                    00CF    137 _T2CON_7	=	0x00cf
                    00C8    138 _CP_RL2	=	0x00c8
                    00C9    139 _C_T2	=	0x00c9
                    00CA    140 _TR2	=	0x00ca
                    00CB    141 _EXEN2	=	0x00cb
                    00CC    142 _TCLK	=	0x00cc
                    00CD    143 _RCLK	=	0x00cd
                    00CE    144 _EXF2	=	0x00ce
                    00CF    145 _TF2	=	0x00cf
                            146 ;--------------------------------------------------------
                            147 ; internal ram data
                            148 ;--------------------------------------------------------
                            149 	.area DSEG    (DATA)
   0057                     150 _nixie_digits::
   0057                     151 	.ds 6
                            152 ;--------------------------------------------------------
                            153 ; overlayable items in internal ram 
                            154 ;--------------------------------------------------------
                            155 	.area _DUMMY
                            156 	.area	OSEG    (OVR,DATA)
                            157 	.area _DUMMY
                            158 	.area	OSEG    (OVR,DATA)
                            159 ;--------------------------------------------------------
                            160 ; indirectly addressable internal ram data
                            161 ;--------------------------------------------------------
                            162 	.area ISEG    (DATA)
                            163 ;--------------------------------------------------------
                            164 ; bit data
                            165 ;--------------------------------------------------------
                            166 	.area BSEG    (BIT)
                            167 ;--------------------------------------------------------
                            168 ; external ram data
                            169 ;--------------------------------------------------------
                            170 	.area XSEG    (XDATA)
                    FE00    171 _iep1_buffer	=	0xfe00
                    FD80    172 _oep1_buffer	=	0xfd80
                            173 ;--------------------------------------------------------
                            174 ; global & static initialisations
                            175 ;--------------------------------------------------------
                            176 	.area GSINIT  (CODE)
                            177 	.area GSFINAL (CODE)
                            178 	.area GSINIT  (CODE)
                            179 ;--------------------------------------------------------
                            180 ; Home
                            181 ;--------------------------------------------------------
                            182 	.area HOME	 (CODE)
                            183 	.area CSEG    (CODE)
                            184 ;--------------------------------------------------------
                            185 ; code
                            186 ;--------------------------------------------------------
                            187 	.area CSEG    (CODE)
                            188 ;------------------------------------------------------------
                            189 ;Allocation info for local variables in function 'fn_cmd_01'
                            190 ;------------------------------------------------------------
                            191 ;	usbiofun.c 13
                            192 ;	-----------------------------------------
                            193 ;	 function fn_cmd_01
                            194 ;	-----------------------------------------
   0F50                     195 _fn_cmd_01:
                    0002    196 	ar2 = 0x02
                    0003    197 	ar3 = 0x03
                    0004    198 	ar4 = 0x04
                    0005    199 	ar5 = 0x05
                    0006    200 	ar6 = 0x06
                    0007    201 	ar7 = 0x07
                    0000    202 	ar0 = 0x00
                    0001    203 	ar1 = 0x01
                            204 ;	usbiofun.c 16
   0F50 90 FE 00            205 	mov	dptr,#_iep1_buffer
   0F53 74 1B               206 	mov	a,#0x1B
   0F55 F0                  207 	movx	@dptr,a
                            208 ;	usbiofun.c 17
                            209 ; Peephole 182   used 16 bit load of dptr
   0F56 90 FF 4A            210 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0F59 74 01               211 	mov	a,#0x01
   0F5B F0                  212 	movx	@dptr,a
   0F5C                     213 00101$:
   0F5C 22                  214 	ret
                            215 ;------------------------------------------------------------
                            216 ;Allocation info for local variables in function 'fn_cmd_02'
                            217 ;------------------------------------------------------------
                            218 ;	usbiofun.c 21
                            219 ;	-----------------------------------------
                            220 ;	 function fn_cmd_02
                            221 ;	-----------------------------------------
   0F5D                     222 _fn_cmd_02:
                            223 ;	usbiofun.c 22
   0F5D 90 FE 00            224 	mov	dptr,#_iep1_buffer
   0F60 74 4E               225 	mov	a,#0x4E
   0F62 F0                  226 	movx	@dptr,a
                            227 ;	usbiofun.c 23
   0F63 90 FE 01            228 	mov	dptr,#(_iep1_buffer + 0x0001)
   0F66 74 49               229 	mov	a,#0x49
   0F68 F0                  230 	movx	@dptr,a
                            231 ;	usbiofun.c 24
   0F69 90 FE 02            232 	mov	dptr,#(_iep1_buffer + 0x0002)
   0F6C 74 58               233 	mov	a,#0x58
   0F6E F0                  234 	movx	@dptr,a
                            235 ;	usbiofun.c 25
   0F6F 90 FE 03            236 	mov	dptr,#(_iep1_buffer + 0x0003)
   0F72 74 49               237 	mov	a,#0x49
   0F74 F0                  238 	movx	@dptr,a
                            239 ;	usbiofun.c 26
   0F75 90 FE 04            240 	mov	dptr,#(_iep1_buffer + 0x0004)
   0F78 74 45               241 	mov	a,#0x45
   0F7A F0                  242 	movx	@dptr,a
                            243 ;	usbiofun.c 27
   0F7B 90 FE 05            244 	mov	dptr,#(_iep1_buffer + 0x0005)
                            245 ; Peephole 180   changed mov to clr
   0F7E E4                  246 	clr  a
   0F7F F0                  247 	movx	@dptr,a
                            248 ;	usbiofun.c 28
                            249 ; Peephole 182   used 16 bit load of dptr
   0F80 90 FF 4A            250 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0F83 74 06               251 	mov	a,#0x06
   0F85 F0                  252 	movx	@dptr,a
   0F86                     253 00101$:
   0F86 22                  254 	ret
                            255 ;------------------------------------------------------------
                            256 ;Allocation info for local variables in function 'fn_cmd_03'
                            257 ;------------------------------------------------------------
                            258 ;	usbiofun.c 31
                            259 ;	-----------------------------------------
                            260 ;	 function fn_cmd_03
                            261 ;	-----------------------------------------
   0F87                     262 _fn_cmd_03:
                            263 ;	usbiofun.c 34
   0F87 7A 00               264 	mov	r2,#0x00
   0F89 7B 00               265 	mov	r3,#0x00
   0F8B                     266 00101$:
   0F8B C3                  267 	clr	c
   0F8C EA                  268 	mov	a,r2
   0F8D 94 08               269 	subb	a,#0x08
   0F8F EB                  270 	mov	a,r3
   0F90 64 80               271 	xrl	a,#0x80
   0F92 94 80               272 	subb	a,#0x80
                            273 ; Peephole 108   removed ljmp by inverse jump logic
   0F94 50 22               274 	jnc  00104$
   0F96                     275 00109$:
                            276 ;	usbiofun.c 35
   0F96 EA                  277 	mov	a,r2
   0F97 24 00               278 	add	a,#_iep1_buffer
   0F99 FC                  279 	mov	r4,a
   0F9A EB                  280 	mov	a,r3
   0F9B 34 FE               281 	addc	a,#(_iep1_buffer >> 8)
   0F9D FD                  282 	mov	r5,a
   0F9E EA                  283 	mov	a,r2
   0F9F 24 80               284 	add	a,#_oep1_buffer
   0FA1 F5 82               285 	mov	dpl,a
   0FA3 EB                  286 	mov	a,r3
   0FA4 34 FD               287 	addc	a,#(_oep1_buffer >> 8)
   0FA6 F5 83               288 	mov	dph,a
   0FA8 E0                  289 	movx	a,@dptr
                            290 ; Peephole 185   changed order of increment (acc incremented also!)
   0FA9 04                  291 	inc  a
   0FAA FE                  292 	mov  r6,a
   0FAB 8C 82               293 	mov	dpl,r4
   0FAD 8D 83               294 	mov	dph,r5
   0FAF EE                  295 	mov	a,r6
   0FB0 F0                  296 	movx	@dptr,a
                            297 ;	usbiofun.c 34
                            298 ;	tail increment optimized
   0FB1 0A                  299 	inc	r2
   0FB2 BA 00 D6            300 	cjne	r2,#0x00,00101$
   0FB5 0B                  301 	inc	r3
                            302 ; Peephole 132   changed ljmp to sjmp
   0FB6 80 D3               303 	sjmp 00101$
   0FB8                     304 00104$:
                            305 ;	usbiofun.c 37
                            306 ; Peephole 182   used 16 bit load of dptr
   0FB8 90 FF 4A            307 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0FBB 74 08               308 	mov	a,#0x08
   0FBD F0                  309 	movx	@dptr,a
   0FBE                     310 00105$:
   0FBE 22                  311 	ret
                            312 ;------------------------------------------------------------
                            313 ;Allocation info for local variables in function 'fn_cmd_04'
                            314 ;------------------------------------------------------------
                            315 ;	usbiofun.c 44
                            316 ;	-----------------------------------------
                            317 ;	 function fn_cmd_04
                            318 ;	-----------------------------------------
   0FBF                     319 _fn_cmd_04:
                            320 ;	usbiofun.c 47
   0FBF 7A 00               321 	mov	r2,#0x00
   0FC1 7B 00               322 	mov	r3,#0x00
   0FC3                     323 00101$:
   0FC3 C3                  324 	clr	c
   0FC4 EA                  325 	mov	a,r2
   0FC5 94 06               326 	subb	a,#0x06
   0FC7 EB                  327 	mov	a,r3
   0FC8 64 80               328 	xrl	a,#0x80
   0FCA 94 80               329 	subb	a,#0x80
                            330 ; Peephole 108   removed ljmp by inverse jump logic
   0FCC 50 2B               331 	jnc  00104$
   0FCE                     332 00109$:
                            333 ;	usbiofun.c 48
   0FCE EA                  334 	mov	a,r2
   0FCF 24 57               335 	add	a,#_nixie_digits
   0FD1 F8                  336 	mov	r0,a
   0FD2 74 02               337 	mov	a,#0x02
   0FD4 2A                  338 	add	a,r2
   0FD5 FC                  339 	mov	r4,a
                            340 ; Peephole 180   changed mov to clr
   0FD6 E4                  341 	clr  a
   0FD7 3B                  342 	addc	a,r3
   0FD8 FD                  343 	mov	r5,a
   0FD9 EC                  344 	mov	a,r4
   0FDA 24 80               345 	add	a,#_oep1_buffer
   0FDC F5 82               346 	mov	dpl,a
   0FDE ED                  347 	mov	a,r5
   0FDF 34 FD               348 	addc	a,#(_oep1_buffer >> 8)
   0FE1 F5 83               349 	mov	dph,a
   0FE3 E0                  350 	movx	a,@dptr
                            351 ; Peephole 192   used a instead of ar4 as source
   0FE4 FC                  352 	mov  r4,a
   0FE5 F6                  353 	mov  @r0,a
                            354 ;	usbiofun.c 49
   0FE6 EA                  355 	mov	a,r2
   0FE7 24 00               356 	add	a,#_iep1_buffer
   0FE9 F5 82               357 	mov	dpl,a
   0FEB EB                  358 	mov	a,r3
   0FEC 34 FE               359 	addc	a,#(_iep1_buffer >> 8)
   0FEE F5 83               360 	mov	dph,a
   0FF0 EC                  361 	mov	a,r4
   0FF1 F0                  362 	movx	@dptr,a
                            363 ;	usbiofun.c 47
   0FF2 0A                  364 	inc	r2
   0FF3 BA 00 01            365 	cjne	r2,#0x00,00110$
   0FF6 0B                  366 	inc	r3
   0FF7                     367 00110$:
                            368 ; Peephole 132   changed ljmp to sjmp
   0FF7 80 CA               369 	sjmp 00101$
   0FF9                     370 00104$:
                            371 ;	usbiofun.c 51
   0FF9 AA 80               372 	mov	r2,_P0
   0FFB 90 FE 06            373 	mov	dptr,#(_iep1_buffer + 0x0006)
   0FFE EA                  374 	mov	a,r2
   0FFF F0                  375 	movx	@dptr,a
                            376 ;	usbiofun.c 52
   1000 AA 90               377 	mov	r2,_P1
   1002 90 FE 07            378 	mov	dptr,#(_iep1_buffer + 0x0007)
   1005 EA                  379 	mov	a,r2
   1006 F0                  380 	movx	@dptr,a
                            381 ;	usbiofun.c 56
                            382 ; Peephole 182   used 16 bit load of dptr
   1007 90 FF 4A            383 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   100A 74 08               384 	mov	a,#0x08
   100C F0                  385 	movx	@dptr,a
   100D                     386 00105$:
   100D 22                  387 	ret
                            388 ;------------------------------------------------------------
                            389 ;Allocation info for local variables in function 'fn_cmd_05'
                            390 ;------------------------------------------------------------
                            391 ;	usbiofun.c 60
                            392 ;	-----------------------------------------
                            393 ;	 function fn_cmd_05
                            394 ;	-----------------------------------------
   100E                     395 _fn_cmd_05:
   100E                     396 00101$:
   100E 22                  397 	ret
                            398 ;------------------------------------------------------------
                            399 ;Allocation info for local variables in function 'fn_cmd_06'
                            400 ;------------------------------------------------------------
                            401 ;	usbiofun.c 61
                            402 ;	-----------------------------------------
                            403 ;	 function fn_cmd_06
                            404 ;	-----------------------------------------
   100F                     405 _fn_cmd_06:
   100F                     406 00101$:
   100F 22                  407 	ret
                            408 ;------------------------------------------------------------
                            409 ;Allocation info for local variables in function 'fn_cmd_07'
                            410 ;------------------------------------------------------------
                            411 ;	usbiofun.c 62
                            412 ;	-----------------------------------------
                            413 ;	 function fn_cmd_07
                            414 ;	-----------------------------------------
   1010                     415 _fn_cmd_07:
   1010                     416 00101$:
   1010 22                  417 	ret
                            418 ;------------------------------------------------------------
                            419 ;Allocation info for local variables in function 'fn_cmd_08'
                            420 ;------------------------------------------------------------
                            421 ;	usbiofun.c 63
                            422 ;	-----------------------------------------
                            423 ;	 function fn_cmd_08
                            424 ;	-----------------------------------------
   1011                     425 _fn_cmd_08:
   1011                     426 00101$:
   1011 22                  427 	ret
                            428 	.area CSEG    (CODE)
