                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.0 Mon May 13 16:50:08 2019
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
                             21 ;--------------------------------------------------------
                             22 ; special function registers
                             23 ;--------------------------------------------------------
                    0080     24 _P0	=	0x0080
                    0081     25 _SP	=	0x0081
                    0082     26 _DPL	=	0x0082
                    0083     27 _DPH	=	0x0083
                    0087     28 _PCON	=	0x0087
                    0088     29 _TCON	=	0x0088
                    0089     30 _TMOD	=	0x0089
                    008A     31 _TL0	=	0x008a
                    008B     32 _TL1	=	0x008b
                    008C     33 _TH0	=	0x008c
                    008D     34 _TH1	=	0x008d
                    0090     35 _P1	=	0x0090
                    0098     36 _SCON	=	0x0098
                    0099     37 _SBUF	=	0x0099
                    00A0     38 _P2	=	0x00a0
                    00A8     39 _IE	=	0x00a8
                    00B0     40 _P3	=	0x00b0
                    00B8     41 _IP	=	0x00b8
                    00D0     42 _PSW	=	0x00d0
                    00E0     43 _ACC	=	0x00e0
                    00F0     44 _B	=	0x00f0
                    00C8     45 _T2CON	=	0x00c8
                    00CA     46 _RCAP2L	=	0x00ca
                    00CB     47 _RCAP2H	=	0x00cb
                    00CC     48 _TL2	=	0x00cc
                    00CD     49 _TH2	=	0x00cd
                             50 ;--------------------------------------------------------
                             51 ; special function bits 
                             52 ;--------------------------------------------------------
                    0080     53 _P0_0	=	0x0080
                    0081     54 _P0_1	=	0x0081
                    0082     55 _P0_2	=	0x0082
                    0083     56 _P0_3	=	0x0083
                    0084     57 _P0_4	=	0x0084
                    0085     58 _P0_5	=	0x0085
                    0086     59 _P0_6	=	0x0086
                    0087     60 _P0_7	=	0x0087
                    0088     61 _IT0	=	0x0088
                    0089     62 _IE0	=	0x0089
                    008A     63 _IT1	=	0x008a
                    008B     64 _IE1	=	0x008b
                    008C     65 _TR0	=	0x008c
                    008D     66 _TF0	=	0x008d
                    008E     67 _TR1	=	0x008e
                    008F     68 _TF1	=	0x008f
                    0090     69 _P1_0	=	0x0090
                    0091     70 _P1_1	=	0x0091
                    0092     71 _P1_2	=	0x0092
                    0093     72 _P1_3	=	0x0093
                    0094     73 _P1_4	=	0x0094
                    0095     74 _P1_5	=	0x0095
                    0096     75 _P1_6	=	0x0096
                    0097     76 _P1_7	=	0x0097
                    0098     77 _RI	=	0x0098
                    0099     78 _TI	=	0x0099
                    009A     79 _RB8	=	0x009a
                    009B     80 _TB8	=	0x009b
                    009C     81 _REN	=	0x009c
                    009D     82 _SM2	=	0x009d
                    009E     83 _SM1	=	0x009e
                    009F     84 _SM0	=	0x009f
                    00A0     85 _P2_0	=	0x00a0
                    00A1     86 _P2_1	=	0x00a1
                    00A2     87 _P2_2	=	0x00a2
                    00A3     88 _P2_3	=	0x00a3
                    00A4     89 _P2_4	=	0x00a4
                    00A5     90 _P2_5	=	0x00a5
                    00A6     91 _P2_6	=	0x00a6
                    00A7     92 _P2_7	=	0x00a7
                    00A8     93 _EX0	=	0x00a8
                    00A9     94 _ET0	=	0x00a9
                    00AA     95 _EX1	=	0x00aa
                    00AB     96 _ET1	=	0x00ab
                    00AC     97 _ES	=	0x00ac
                    00AF     98 _EA	=	0x00af
                    00B0     99 _P3_0	=	0x00b0
                    00B1    100 _P3_1	=	0x00b1
                    00B2    101 _P3_2	=	0x00b2
                    00B3    102 _P3_3	=	0x00b3
                    00B4    103 _P3_4	=	0x00b4
                    00B5    104 _P3_5	=	0x00b5
                    00B6    105 _P3_6	=	0x00b6
                    00B7    106 _P3_7	=	0x00b7
                    00B0    107 _RXD	=	0x00b0
                    00B1    108 _TXD	=	0x00b1
                    00B2    109 _INT0	=	0x00b2
                    00B3    110 _INT1	=	0x00b3
                    00B4    111 _T0	=	0x00b4
                    00B5    112 _T1	=	0x00b5
                    00B6    113 _WR	=	0x00b6
                    00B7    114 _RD	=	0x00b7
                    00B8    115 _PX0	=	0x00b8
                    00B9    116 _PT0	=	0x00b9
                    00BA    117 _PX1	=	0x00ba
                    00BB    118 _PT1	=	0x00bb
                    00BC    119 _PS	=	0x00bc
                    00D0    120 _P	=	0x00d0
                    00D1    121 _F1	=	0x00d1
                    00D2    122 _OV	=	0x00d2
                    00D3    123 _RS0	=	0x00d3
                    00D4    124 _RS1	=	0x00d4
                    00D5    125 _F0	=	0x00d5
                    00D6    126 _AC	=	0x00d6
                    00D7    127 _CY	=	0x00d7
                    00AD    128 _ET2	=	0x00ad
                    00C8    129 _T2CON_0	=	0x00c8
                    00C9    130 _T2CON_1	=	0x00c9
                    00CA    131 _T2CON_2	=	0x00ca
                    00CB    132 _T2CON_3	=	0x00cb
                    00CC    133 _T2CON_4	=	0x00cc
                    00CD    134 _T2CON_5	=	0x00cd
                    00CE    135 _T2CON_6	=	0x00ce
                    00CF    136 _T2CON_7	=	0x00cf
                    00C8    137 _CP_RL2	=	0x00c8
                    00C9    138 _C_T2	=	0x00c9
                    00CA    139 _TR2	=	0x00ca
                    00CB    140 _EXEN2	=	0x00cb
                    00CC    141 _TCLK	=	0x00cc
                    00CD    142 _RCLK	=	0x00cd
                    00CE    143 _EXF2	=	0x00ce
                    00CF    144 _TF2	=	0x00cf
                            145 ;--------------------------------------------------------
                            146 ; internal ram data
                            147 ;--------------------------------------------------------
                            148 	.area DSEG    (DATA)
                            149 ;--------------------------------------------------------
                            150 ; overlayable items in internal ram 
                            151 ;--------------------------------------------------------
                            152 	.area OSEG    (OVR,DATA)
                            153 ;--------------------------------------------------------
                            154 ; indirectly addressable internal ram data
                            155 ;--------------------------------------------------------
                            156 	.area ISEG    (DATA)
                            157 ;--------------------------------------------------------
                            158 ; bit data
                            159 ;--------------------------------------------------------
                            160 	.area BSEG    (BIT)
                            161 ;--------------------------------------------------------
                            162 ; external ram data
                            163 ;--------------------------------------------------------
                            164 	.area XSEG    (XDATA)
                    FE00    165 _iep1_buffer	=	0xfe00
                    FD80    166 _oep1_buffer	=	0xfd80
                            167 ;--------------------------------------------------------
                            168 ; global & static initialisations
                            169 ;--------------------------------------------------------
                            170 	.area GSINIT  (CODE)
                            171 	.area GSFINAL (CODE)
                            172 	.area GSINIT  (CODE)
                            173 ;--------------------------------------------------------
                            174 ; Home
                            175 ;--------------------------------------------------------
                            176 	.area HOME	 (CODE)
                            177 	.area CSEG    (CODE)
                            178 ;--------------------------------------------------------
                            179 ; code
                            180 ;--------------------------------------------------------
                            181 	.area CSEG    (CODE)
                            182 ;------------------------------------------------------------
                            183 ;Allocation info for local variables in function 'fn_cmd_01'
                            184 ;------------------------------------------------------------
                            185 ;	usbiofun.c 9
                            186 ;	-----------------------------------------
                            187 ;	 function fn_cmd_01
                            188 ;	-----------------------------------------
   09E1                     189 _fn_cmd_01:
                    0002    190 	ar2 = 0x02
                    0003    191 	ar3 = 0x03
                    0004    192 	ar4 = 0x04
                    0005    193 	ar5 = 0x05
                    0006    194 	ar6 = 0x06
                    0007    195 	ar7 = 0x07
                    0000    196 	ar0 = 0x00
                    0001    197 	ar1 = 0x01
                            198 ;	usbiofun.c 10
   09E1 75 80 00            199 	mov	_P0,#0x00
                            200 ;	usbiofun.c 11
   09E4 75 90 00            201 	mov	_P1,#0x00
                            202 ;	usbiofun.c 15
   09E7 90 FE 00            203 	mov	dptr,#_iep1_buffer
   09EA 74 1B               204 	mov	a,#0x1B
   09EC F0                  205 	movx	@dptr,a
                            206 ;	usbiofun.c 16
                            207 ; Peephole 182   used 16 bit load of dptr
   09ED 90 FF 4A            208 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   09F0 74 01               209 	mov	a,#0x01
   09F2 F0                  210 	movx	@dptr,a
   09F3                     211 00101$:
   09F3 22                  212 	ret
                            213 ;------------------------------------------------------------
                            214 ;Allocation info for local variables in function 'fn_cmd_02'
                            215 ;------------------------------------------------------------
                            216 ;	usbiofun.c 20
                            217 ;	-----------------------------------------
                            218 ;	 function fn_cmd_02
                            219 ;	-----------------------------------------
   09F4                     220 _fn_cmd_02:
                            221 ;	usbiofun.c 21
   09F4 75 80 FF            222 	mov	_P0,#0xFF
                            223 ;	usbiofun.c 22
   09F7 75 90 FF            224 	mov	_P1,#0xFF
                            225 ;	usbiofun.c 26
   09FA 90 FE 00            226 	mov	dptr,#_iep1_buffer
   09FD 74 1B               227 	mov	a,#0x1B
   09FF F0                  228 	movx	@dptr,a
                            229 ;	usbiofun.c 27
                            230 ; Peephole 182   used 16 bit load of dptr
   0A00 90 FF 4A            231 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0A03 74 01               232 	mov	a,#0x01
   0A05 F0                  233 	movx	@dptr,a
   0A06                     234 00101$:
   0A06 22                  235 	ret
                            236 ;------------------------------------------------------------
                            237 ;Allocation info for local variables in function 'fn_cmd_03'
                            238 ;------------------------------------------------------------
                            239 ;	usbiofun.c 30
                            240 ;	-----------------------------------------
                            241 ;	 function fn_cmd_03
                            242 ;	-----------------------------------------
   0A07                     243 _fn_cmd_03:
                            244 ;	usbiofun.c 31
   0A07 75 80 FF            245 	mov	_P0,#0xFF
                            246 ;	usbiofun.c 32
   0A0A 75 90 FF            247 	mov	_P1,#0xFF
                            248 ;	usbiofun.c 33
   0A0D C2 82               249 	clr	_P0_2
                            250 ;	usbiofun.c 34
   0A0F C2 95               251 	clr	_P1_5
                            252 ;	usbiofun.c 35
   0A11 C2 96               253 	clr	_P1_6
                            254 ;	usbiofun.c 39
   0A13 90 FE 00            255 	mov	dptr,#_iep1_buffer
   0A16 74 1B               256 	mov	a,#0x1B
   0A18 F0                  257 	movx	@dptr,a
                            258 ;	usbiofun.c 40
                            259 ; Peephole 182   used 16 bit load of dptr
   0A19 90 FF 4A            260 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0A1C 74 01               261 	mov	a,#0x01
   0A1E F0                  262 	movx	@dptr,a
   0A1F                     263 00101$:
   0A1F 22                  264 	ret
                            265 ;------------------------------------------------------------
                            266 ;Allocation info for local variables in function 'fn_cmd_04'
                            267 ;------------------------------------------------------------
                            268 ;	usbiofun.c 43
                            269 ;	-----------------------------------------
                            270 ;	 function fn_cmd_04
                            271 ;	-----------------------------------------
   0A20                     272 _fn_cmd_04:
                            273 ;	usbiofun.c 44
   0A20 75 80 FF            274 	mov	_P0,#0xFF
                            275 ;	usbiofun.c 45
   0A23 75 90 FF            276 	mov	_P1,#0xFF
                            277 ;	usbiofun.c 49
   0A26 90 FE 00            278 	mov	dptr,#_iep1_buffer
   0A29 74 1B               279 	mov	a,#0x1B
   0A2B F0                  280 	movx	@dptr,a
                            281 ;	usbiofun.c 50
                            282 ; Peephole 182   used 16 bit load of dptr
   0A2C 90 FF 4A            283 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0A2F 74 01               284 	mov	a,#0x01
   0A31 F0                  285 	movx	@dptr,a
   0A32                     286 00101$:
   0A32 22                  287 	ret
                            288 ;------------------------------------------------------------
                            289 ;Allocation info for local variables in function 'fn_cmd_05'
                            290 ;------------------------------------------------------------
                            291 ;	usbiofun.c 53
                            292 ;	-----------------------------------------
                            293 ;	 function fn_cmd_05
                            294 ;	-----------------------------------------
   0A33                     295 _fn_cmd_05:
                            296 ;	usbiofun.c 54
   0A33 75 80 FF            297 	mov	_P0,#0xFF
                            298 ;	usbiofun.c 55
   0A36 75 90 D7            299 	mov	_P1,#0xD7
                            300 ;	usbiofun.c 59
   0A39 90 FE 00            301 	mov	dptr,#_iep1_buffer
   0A3C 74 1B               302 	mov	a,#0x1B
   0A3E F0                  303 	movx	@dptr,a
                            304 ;	usbiofun.c 60
                            305 ; Peephole 182   used 16 bit load of dptr
   0A3F 90 FF 4A            306 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0A42 74 01               307 	mov	a,#0x01
   0A44 F0                  308 	movx	@dptr,a
   0A45                     309 00101$:
   0A45 22                  310 	ret
                            311 ;------------------------------------------------------------
                            312 ;Allocation info for local variables in function 'fn_cmd_06'
                            313 ;------------------------------------------------------------
                            314 ;	usbiofun.c 63
                            315 ;	-----------------------------------------
                            316 ;	 function fn_cmd_06
                            317 ;	-----------------------------------------
   0A46                     318 _fn_cmd_06:
                            319 ;	usbiofun.c 64
   0A46 75 80 FE            320 	mov	_P0,#0xFE
                            321 ;	usbiofun.c 65
   0A49 75 90 3B            322 	mov	_P1,#0x3B
                            323 ;	usbiofun.c 69
   0A4C 90 FE 00            324 	mov	dptr,#_iep1_buffer
   0A4F 74 1B               325 	mov	a,#0x1B
   0A51 F0                  326 	movx	@dptr,a
                            327 ;	usbiofun.c 70
                            328 ; Peephole 182   used 16 bit load of dptr
   0A52 90 FF 4A            329 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0A55 74 01               330 	mov	a,#0x01
   0A57 F0                  331 	movx	@dptr,a
   0A58                     332 00101$:
   0A58 22                  333 	ret
                            334 ;------------------------------------------------------------
                            335 ;Allocation info for local variables in function 'fn_cmd_07'
                            336 ;------------------------------------------------------------
                            337 ;	usbiofun.c 73
                            338 ;	-----------------------------------------
                            339 ;	 function fn_cmd_07
                            340 ;	-----------------------------------------
   0A59                     341 _fn_cmd_07:
   0A59                     342 00101$:
   0A59 22                  343 	ret
                            344 ;------------------------------------------------------------
                            345 ;Allocation info for local variables in function 'fn_cmd_08'
                            346 ;------------------------------------------------------------
                            347 ;	usbiofun.c 75
                            348 ;	-----------------------------------------
                            349 ;	 function fn_cmd_08
                            350 ;	-----------------------------------------
   0A5A                     351 _fn_cmd_08:
   0A5A                     352 00101$:
   0A5A 22                  353 	ret
                            354 	.area CSEG    (CODE)
