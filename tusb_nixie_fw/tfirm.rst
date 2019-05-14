                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.0 Mon May 13 20:34:34 2019
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module tfirm
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _tUsbRequestList
                             12 	.globl _abromDeviceDescriptor
                             13 	.globl _abromConfigurationDescriptorGroup
                             14 	.globl _main
                             15 	.globl _usbISR
                             16 	.globl _SetupPacketInterruptHandler
                             17 	.globl _IEP1InterruptHandler
                             18 	.globl _OEP1InterruptHandler
                             19 	.globl _IEP0InterruptHandler
                             20 	.globl _OEP0InterruptHandler
                             21 	.globl _usbDecodeAndProcessUsbRequest
                             22 	.globl _usbReceiveNextPacketOnOEP0
                             23 	.globl _SystemInitialization
                             24 	.globl _usbReset
                             25 	.globl _usbNonStandardRequest
                             26 	.globl _usbGetStringDescriptor
                             27 	.globl _usbGetDeviceDescriptor
                             28 	.globl _usbGetHIDDescriptor
                             29 	.globl _usbGetConfigurationDescriptor
                             30 	.globl _usbGetReportDescriptor
                             31 	.globl _usbGetInterfaceStatus
                             32 	.globl _usbGetDeviceStatus
                             33 	.globl _usbGetEndpointStatus
                             34 	.globl _usbSetReport
                             35 	.globl _usbClearRemoteWakeup
                             36 	.globl _usbSetRemoteWakeup
                             37 	.globl _usbSetAddress
                             38 	.globl _usbGetProtocol
                             39 	.globl _usbSetProtocol
                             40 	.globl _usbGetInterface
                             41 	.globl _usbSetInterface
                             42 	.globl _usbGetIdle
                             43 	.globl _usbSetIdle
                             44 	.globl _usbSetConfiguration
                             45 	.globl _usbGetConfiguration
                             46 	.globl _usbClearEndpointHalt
                             47 	.globl _usbSetEndpointHalt
                             48 	.globl _pbIEP1YBufferAddress
                             49 	.globl _pbIEP1XBufferAddress
                             50 	.globl _pbOEP1YBufferAddress
                             51 	.globl _pbOEP1XBufferAddress
                             52 	.globl _abDescriptor
                             53 	.globl _abIEP0Buffer
                             54 	.globl _abOEP0Buffer
                             55 	.globl _tOutputEndPointDescriptorBlock
                             56 	.globl _tInputEndPointDescriptorBlock
                             57 	.globl _tEndPoint0DescriptorBlock
                             58 	.globl _tSetupPacket
                             59 	.globl _abIEP1SaveBuffer
                             60 	.globl _abOEP1SaveBuffer
                             61 	.globl _total
                             62 	.globl _bOEP1SaveBufferPosition
                             63 	.globl _bOEP1RecieveLength
                             64 	.globl _FIRMWARE_VERSION
                             65 	.globl _ID2
                             66 	.globl _ID1
                             67 	.globl _bCurrentBuffer
                             68 	.globl _bHostAskMoreDataThanAvailable
                             69 	.globl _gbProtocol
                             70 	.globl _gbIdleRateH
                             71 	.globl _gbIdleRateL
                             72 	.globl _bSuspended
                             73 	.globl _bInterfaceNumber
                             74 	.globl _bConfigurationNumber
                             75 	.globl _pbOEP0Buffer
                             76 	.globl _pbIEP0Buffer
                             77 	.globl _wBytesRemainingOnOEP0
                             78 	.globl _wBytesRemainingOnIEP0
                             79 	.globl _wDeviceFeatures
                             80 	.globl _bUsbDeviceAddress
                             81 	.globl _bStatusAction
                             82 	.globl _deviceReady
                             83 	.globl _usbSendZeroLengthPacketOnIEP0
                             84 	.globl _usbStallEndpoint0
                             85 	.globl _usbReceiveDataPacketOnEP0
                             86 	.globl _usbSendNextPacketOnIEP0
                             87 	.globl _usbSendDataPacketOnEP0
                             88 ;--------------------------------------------------------
                             89 ; special function registers
                             90 ;--------------------------------------------------------
                    0080     91 _P0	=	0x0080
                    0081     92 _SP	=	0x0081
                    0082     93 _DPL	=	0x0082
                    0083     94 _DPH	=	0x0083
                    0087     95 _PCON	=	0x0087
                    0088     96 _TCON	=	0x0088
                    0089     97 _TMOD	=	0x0089
                    008A     98 _TL0	=	0x008a
                    008B     99 _TL1	=	0x008b
                    008C    100 _TH0	=	0x008c
                    008D    101 _TH1	=	0x008d
                    0090    102 _P1	=	0x0090
                    0098    103 _SCON	=	0x0098
                    0099    104 _SBUF	=	0x0099
                    00A0    105 _P2	=	0x00a0
                    00A8    106 _IE	=	0x00a8
                    00B0    107 _P3	=	0x00b0
                    00B8    108 _IP	=	0x00b8
                    00D0    109 _PSW	=	0x00d0
                    00E0    110 _ACC	=	0x00e0
                    00F0    111 _B	=	0x00f0
                    00C8    112 _T2CON	=	0x00c8
                    00CA    113 _RCAP2L	=	0x00ca
                    00CB    114 _RCAP2H	=	0x00cb
                    00CC    115 _TL2	=	0x00cc
                    00CD    116 _TH2	=	0x00cd
                            117 ;--------------------------------------------------------
                            118 ; special function bits 
                            119 ;--------------------------------------------------------
                    0080    120 _P0_0	=	0x0080
                    0081    121 _P0_1	=	0x0081
                    0082    122 _P0_2	=	0x0082
                    0083    123 _P0_3	=	0x0083
                    0084    124 _P0_4	=	0x0084
                    0085    125 _P0_5	=	0x0085
                    0086    126 _P0_6	=	0x0086
                    0087    127 _P0_7	=	0x0087
                    0088    128 _IT0	=	0x0088
                    0089    129 _IE0	=	0x0089
                    008A    130 _IT1	=	0x008a
                    008B    131 _IE1	=	0x008b
                    008C    132 _TR0	=	0x008c
                    008D    133 _TF0	=	0x008d
                    008E    134 _TR1	=	0x008e
                    008F    135 _TF1	=	0x008f
                    0090    136 _P1_0	=	0x0090
                    0091    137 _P1_1	=	0x0091
                    0092    138 _P1_2	=	0x0092
                    0093    139 _P1_3	=	0x0093
                    0094    140 _P1_4	=	0x0094
                    0095    141 _P1_5	=	0x0095
                    0096    142 _P1_6	=	0x0096
                    0097    143 _P1_7	=	0x0097
                    0098    144 _RI	=	0x0098
                    0099    145 _TI	=	0x0099
                    009A    146 _RB8	=	0x009a
                    009B    147 _TB8	=	0x009b
                    009C    148 _REN	=	0x009c
                    009D    149 _SM2	=	0x009d
                    009E    150 _SM1	=	0x009e
                    009F    151 _SM0	=	0x009f
                    00A0    152 _P2_0	=	0x00a0
                    00A1    153 _P2_1	=	0x00a1
                    00A2    154 _P2_2	=	0x00a2
                    00A3    155 _P2_3	=	0x00a3
                    00A4    156 _P2_4	=	0x00a4
                    00A5    157 _P2_5	=	0x00a5
                    00A6    158 _P2_6	=	0x00a6
                    00A7    159 _P2_7	=	0x00a7
                    00A8    160 _EX0	=	0x00a8
                    00A9    161 _ET0	=	0x00a9
                    00AA    162 _EX1	=	0x00aa
                    00AB    163 _ET1	=	0x00ab
                    00AC    164 _ES	=	0x00ac
                    00AF    165 _EA	=	0x00af
                    00B0    166 _P3_0	=	0x00b0
                    00B1    167 _P3_1	=	0x00b1
                    00B2    168 _P3_2	=	0x00b2
                    00B3    169 _P3_3	=	0x00b3
                    00B4    170 _P3_4	=	0x00b4
                    00B5    171 _P3_5	=	0x00b5
                    00B6    172 _P3_6	=	0x00b6
                    00B7    173 _P3_7	=	0x00b7
                    00B0    174 _RXD	=	0x00b0
                    00B1    175 _TXD	=	0x00b1
                    00B2    176 _INT0	=	0x00b2
                    00B3    177 _INT1	=	0x00b3
                    00B4    178 _T0	=	0x00b4
                    00B5    179 _T1	=	0x00b5
                    00B6    180 _WR	=	0x00b6
                    00B7    181 _RD	=	0x00b7
                    00B8    182 _PX0	=	0x00b8
                    00B9    183 _PT0	=	0x00b9
                    00BA    184 _PX1	=	0x00ba
                    00BB    185 _PT1	=	0x00bb
                    00BC    186 _PS	=	0x00bc
                    00D0    187 _P	=	0x00d0
                    00D1    188 _F1	=	0x00d1
                    00D2    189 _OV	=	0x00d2
                    00D3    190 _RS0	=	0x00d3
                    00D4    191 _RS1	=	0x00d4
                    00D5    192 _F0	=	0x00d5
                    00D6    193 _AC	=	0x00d6
                    00D7    194 _CY	=	0x00d7
                    00AD    195 _ET2	=	0x00ad
                    00C8    196 _T2CON_0	=	0x00c8
                    00C9    197 _T2CON_1	=	0x00c9
                    00CA    198 _T2CON_2	=	0x00ca
                    00CB    199 _T2CON_3	=	0x00cb
                    00CC    200 _T2CON_4	=	0x00cc
                    00CD    201 _T2CON_5	=	0x00cd
                    00CE    202 _T2CON_6	=	0x00ce
                    00CF    203 _T2CON_7	=	0x00cf
                    00C8    204 _CP_RL2	=	0x00c8
                    00C9    205 _C_T2	=	0x00c9
                    00CA    206 _TR2	=	0x00ca
                    00CB    207 _EXEN2	=	0x00cb
                    00CC    208 _TCLK	=	0x00cc
                    00CD    209 _RCLK	=	0x00cd
                    00CE    210 _EXF2	=	0x00ce
                    00CF    211 _TF2	=	0x00cf
                            212 ;--------------------------------------------------------
                            213 ; internal ram data
                            214 ;--------------------------------------------------------
                            215 	.area DSEG    (DATA)
   0030                     216 _deviceReady::
   0030                     217 	.ds 1
   0031                     218 _bStatusAction::
   0031                     219 	.ds 1
   0032                     220 _bUsbDeviceAddress::
   0032                     221 	.ds 1
   0033                     222 _wDeviceFeatures::
   0033                     223 	.ds 2
   0035                     224 _wBytesRemainingOnIEP0::
   0035                     225 	.ds 2
   0037                     226 _wBytesRemainingOnOEP0::
   0037                     227 	.ds 2
   0039                     228 _pbIEP0Buffer::
   0039                     229 	.ds 3
   003C                     230 _pbOEP0Buffer::
   003C                     231 	.ds 3
   003F                     232 _bConfigurationNumber::
   003F                     233 	.ds 1
   0040                     234 _bInterfaceNumber::
   0040                     235 	.ds 1
   0041                     236 _bSuspended::
   0041                     237 	.ds 1
   0042                     238 _gbIdleRateL::
   0042                     239 	.ds 1
   0043                     240 _gbIdleRateH::
   0043                     241 	.ds 1
   0044                     242 _gbProtocol::
   0044                     243 	.ds 1
   0045                     244 _bHostAskMoreDataThanAvailable::
   0045                     245 	.ds 2
   0047                     246 _bCurrentBuffer::
   0047                     247 	.ds 2
   0049                     248 _ID1::
   0049                     249 	.ds 1
   004A                     250 _ID2::
   004A                     251 	.ds 1
   004B                     252 _FIRMWARE_VERSION::
   004B                     253 	.ds 1
   004C                     254 _bOEP1RecieveLength::
   004C                     255 	.ds 1
   004D                     256 _bOEP1SaveBufferPosition::
   004D                     257 	.ds 1
   004E                     258 _total::
   004E                     259 	.ds 1
   004F                     260 _usbGetEndpointStatus_wEndpointStatus_1_1::
   004F                     261 	.ds 2
   0051                     262 _usbGetInterfaceStatus_wStatusBuffer_1_1::
   0051                     263 	.ds 2
   0053                     264 _usbDecodeAndProcessUsbRequest_sloc0_1_0::
   0053                     265 	.ds 1
   0054                     266 _usbDecodeAndProcessUsbRequest_sloc1_1_0::
   0054                     267 	.ds 1
   0055                     268 _usbDecodeAndProcessUsbRequest_sloc2_1_0::
   0055                     269 	.ds 1
   0056                     270 _usbDecodeAndProcessUsbRequest_sloc3_1_0::
   0056                     271 	.ds 1
                            272 ;--------------------------------------------------------
                            273 ; overlayable items in internal ram 
                            274 ;--------------------------------------------------------
                            275 	.area _DUMMY
                            276 	.area	OSEG    (OVR,DATA)
                            277 	.area _DUMMY
                            278 	.area	OSEG    (OVR,DATA)
                            279 	.area _DUMMY
                            280 	.area	OSEG    (OVR,DATA)
                            281 ;--------------------------------------------------------
                            282 ; Stack segment in internal ram 
                            283 ;--------------------------------------------------------
                            284 	.area	SSEG	(DATA)
   005D                     285 __start__stack:
   005D                     286 	.ds	1
                            287 
                            288 ;--------------------------------------------------------
                            289 ; indirectly addressable internal ram data
                            290 ;--------------------------------------------------------
                            291 	.area ISEG    (DATA)
   0080                     292 _abOEP1SaveBuffer::
   0080                     293 	.ds 80
   00D0                     294 _abIEP1SaveBuffer::
   00D0                     295 	.ds 80
                            296 ;--------------------------------------------------------
                            297 ; bit data
                            298 ;--------------------------------------------------------
                            299 	.area BSEG    (BIT)
                            300 ;--------------------------------------------------------
                            301 ; external ram data
                            302 ;--------------------------------------------------------
                            303 	.area XSEG    (XDATA)
                    FF00    304 _tSetupPacket	=	0xff00
                    FF80    305 _tEndPoint0DescriptorBlock	=	0xff80
                    FF48    306 _tInputEndPointDescriptorBlock	=	0xff48
                    FF08    307 _tOutputEndPointDescriptorBlock	=	0xff08
                    FEF0    308 _abOEP0Buffer	=	0xfef0
                    FEF8    309 _abIEP0Buffer	=	0xfef8
                    FE80    310 _abDescriptor	=	0xfe80
                    FD80    311 _pbOEP1XBufferAddress	=	0xfd80
                    FDC0    312 _pbOEP1YBufferAddress	=	0xfdc0
                    FE00    313 _pbIEP1XBufferAddress	=	0xfe00
                    FE40    314 _pbIEP1YBufferAddress	=	0xfe40
                            315 ;--------------------------------------------------------
                            316 ; interrupt vector 
                            317 ;--------------------------------------------------------
                            318 	.area CSEG    (CODE)
   0000                     319 __interrupt_vect:
   0000 02 10 6F            320 	ljmp	__sdcc_gsinit_startup
   0003 02 07 7A            321 	ljmp	_usbISR
   0006                     322 	.ds	5
   000B 32                  323 	reti
   000C                     324 	.ds	7
   0013 32                  325 	reti
   0014                     326 	.ds	7
   001B 32                  327 	reti
   001C                     328 	.ds	7
   0023 32                  329 	reti
   0024                     330 	.ds	7
   002B 32                  331 	reti
   002C                     332 	.ds	7
                            333 ;--------------------------------------------------------
                            334 ; global & static initialisations
                            335 ;--------------------------------------------------------
                            336 	.area GSINIT  (CODE)
                            337 	.area GSFINAL (CODE)
                            338 	.area GSINIT  (CODE)
   106F                     339 __sdcc_gsinit_startup:
   106F 75 81 07            340 	mov	sp,#7
   1072 12 10 12            341 	lcall	__sdcc_external_startup
   1075 E5 82               342 	mov	a,dpl
   1077 60 03               343 	jz	__sdcc_init_data
   1079 02 00 33            344 	ljmp	__sdcc_program_startup
   107C                     345 __sdcc_init_data:
                            346 ;	tfirm.c 27
   107C 75 30 00            347 	mov	_deviceReady,#0x00
                            348 ;	tfirm.c 30
   107F E4                  349 	clr	a
   1080 F5 34               350 	mov	(_wDeviceFeatures + 1),a
   1082 F5 33               351 	mov	_wDeviceFeatures,a
                            352 ;	tfirm.c 35
   1084 75 3F 00            353 	mov	_bConfigurationNumber,#0x00
                            354 ;	tfirm.c 36
   1087 75 40 00            355 	mov	_bInterfaceNumber,#0x00
                            356 ;	tfirm.c 38
   108A 75 41 00            357 	mov	_bSuspended,#0x00
                            358 ;	tfirm.c 42
   108D 75 44 01            359 	mov	_gbProtocol,#0x01
                            360 ;	tfirm.c 90
   1090 75 4E 00            361 	mov	_total,#0x00
                            362 	.area GSFINAL (CODE)
   1093 02 00 33            363 	ljmp	__sdcc_program_startup
                            364 ;--------------------------------------------------------
                            365 ; Home
                            366 ;--------------------------------------------------------
                            367 	.area HOME	 (CODE)
                            368 	.area CSEG    (CODE)
                            369 ;--------------------------------------------------------
                            370 ; code
                            371 ;--------------------------------------------------------
                            372 	.area CSEG    (CODE)
   0033                     373 __sdcc_program_startup:
   0033 12 08 8A            374 	lcall	_main
                            375 ;	return from main will lock up
   0036 80 FE               376 	sjmp .
                            377 ;------------------------------------------------------------
                            378 ;Allocation info for local variables in function 'usbSendZeroLengthPacketOnIEP0'
                            379 ;------------------------------------------------------------
                            380 ;	tfirm.c 92
                            381 ;	-----------------------------------------
                            382 ;	 function usbSendZeroLengthPacketOnIEP0
                            383 ;	-----------------------------------------
   0038                     384 _usbSendZeroLengthPacketOnIEP0:
                    0002    385 	ar2 = 0x02
                    0003    386 	ar3 = 0x03
                    0004    387 	ar4 = 0x04
                    0005    388 	ar5 = 0x05
                    0006    389 	ar6 = 0x06
                    0007    390 	ar7 = 0x07
                    0000    391 	ar0 = 0x00
                    0001    392 	ar1 = 0x01
                            393 ;	tfirm.c 93
   0038 75 35 FF            394 	mov	_wBytesRemainingOnIEP0,#0xFF
   003B 75 36 FF            395 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                            396 ;	tfirm.c 94
   003E 75 31 00            397 	mov	_bStatusAction,#0x00
                            398 ;	tfirm.c 95
   0041 90 FF 81            399 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
                            400 ; Peephole 180   changed mov to clr
   0044 E4                  401 	clr  a
   0045 F0                  402 	movx	@dptr,a
   0046                     403 00101$:
   0046 22                  404 	ret
                            405 ;------------------------------------------------------------
                            406 ;Allocation info for local variables in function 'usbSetEndpointHalt'
                            407 ;------------------------------------------------------------
                            408 ;	tfirm.c 98
                            409 ;	-----------------------------------------
                            410 ;	 function usbSetEndpointHalt
                            411 ;	-----------------------------------------
   0047                     412 _usbSetEndpointHalt:
                            413 ;	tfirm.c 99
   0047 90 FF 48            414 	mov	dptr,#_tInputEndPointDescriptorBlock
   004A E0                  415 	movx	a,@dptr
   004B FA                  416 	mov	r2,a
   004C 53 02 7F            417 	anl	ar2,#0x7F
   004F 90 FF 48            418 	mov	dptr,#_tInputEndPointDescriptorBlock
   0052 EA                  419 	mov	a,r2
   0053 F0                  420 	movx	@dptr,a
                            421 ;	tfirm.c 100
   0054 12 00 38            422 	lcall	_usbSendZeroLengthPacketOnIEP0
   0057                     423 00101$:
   0057 22                  424 	ret
                            425 ;------------------------------------------------------------
                            426 ;Allocation info for local variables in function 'usbClearEndpointHalt'
                            427 ;------------------------------------------------------------
                            428 ;	tfirm.c 103
                            429 ;	-----------------------------------------
                            430 ;	 function usbClearEndpointHalt
                            431 ;	-----------------------------------------
   0058                     432 _usbClearEndpointHalt:
                            433 ;	tfirm.c 104
   0058 90 FF 48            434 	mov	dptr,#_tInputEndPointDescriptorBlock
   005B E0                  435 	movx	a,@dptr
   005C FA                  436 	mov	r2,a
   005D 43 02 80            437 	orl	ar2,#0x80
   0060 90 FF 48            438 	mov	dptr,#_tInputEndPointDescriptorBlock
   0063 EA                  439 	mov	a,r2
   0064 F0                  440 	movx	@dptr,a
                            441 ;	tfirm.c 105
   0065 12 00 38            442 	lcall	_usbSendZeroLengthPacketOnIEP0
   0068                     443 00101$:
   0068 22                  444 	ret
                            445 ;------------------------------------------------------------
                            446 ;Allocation info for local variables in function 'usbGetConfiguration'
                            447 ;------------------------------------------------------------
                            448 ;	tfirm.c 109
                            449 ;	-----------------------------------------
                            450 ;	 function usbGetConfiguration
                            451 ;	-----------------------------------------
   0069                     452 _usbGetConfiguration:
                            453 ;	tfirm.c 110
   0069 E4                  454 	clr	a
   006A F5 36               455 	mov	(_wBytesRemainingOnIEP0 + 1),a
   006C 75 35 01            456 	mov	_wBytesRemainingOnIEP0,#0x01
                            457 ;	tfirm.c 111
   006F 7A 3F               458 	mov	r2,#_bConfigurationNumber
   0071 7B 00               459 	mov	r3,#0x00
   0073 7C 00               460 	mov	r4,#0x00
   0075 8A 82               461 	mov	dpl,r2
   0077 8B 83               462 	mov	dph,r3
   0079 8C F0               463 	mov	b,r4
   007B 12 05 48            464 	lcall	_usbSendDataPacketOnEP0
   007E                     465 00101$:
   007E 22                  466 	ret
                            467 ;------------------------------------------------------------
                            468 ;Allocation info for local variables in function 'usbSetConfiguration'
                            469 ;------------------------------------------------------------
                            470 ;	tfirm.c 114
                            471 ;	-----------------------------------------
                            472 ;	 function usbSetConfiguration
                            473 ;	-----------------------------------------
   007F                     474 _usbSetConfiguration:
                            475 ;	tfirm.c 115
   007F 90 FF 82            476 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0082 E0                  477 	movx	a,@dptr
   0083 FA                  478 	mov	r2,a
   0084 43 02 08            479 	orl	ar2,#0x08
   0087 90 FF 82            480 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   008A EA                  481 	mov	a,r2
   008B F0                  482 	movx	@dptr,a
                            483 ;	tfirm.c 116
   008C 90 FF 02            484 	mov	dptr,#(_tSetupPacket + 0x0002)
   008F E0                  485 	movx	a,@dptr
   0090 F5 3F               486 	mov	_bConfigurationNumber,a
                            487 ;	tfirm.c 117
   0092 12 00 38            488 	lcall	_usbSendZeroLengthPacketOnIEP0
   0095                     489 00101$:
   0095 22                  490 	ret
                            491 ;------------------------------------------------------------
                            492 ;Allocation info for local variables in function 'usbSetIdle'
                            493 ;------------------------------------------------------------
                            494 ;	tfirm.c 120
                            495 ;	-----------------------------------------
                            496 ;	 function usbSetIdle
                            497 ;	-----------------------------------------
   0096                     498 _usbSetIdle:
                            499 ;	tfirm.c 121
   0096 90 FF 02            500 	mov	dptr,#(_tSetupPacket + 0x0002)
   0099 E0                  501 	movx	a,@dptr
   009A F5 42               502 	mov	_gbIdleRateL,a
                            503 ;	tfirm.c 122
   009C 90 FF 03            504 	mov	dptr,#(_tSetupPacket + 0x0003)
   009F E0                  505 	movx	a,@dptr
   00A0 F5 43               506 	mov	_gbIdleRateH,a
                            507 ;	tfirm.c 123
   00A2 12 00 38            508 	lcall	_usbSendZeroLengthPacketOnIEP0
   00A5                     509 00101$:
   00A5 22                  510 	ret
                            511 ;------------------------------------------------------------
                            512 ;Allocation info for local variables in function 'usbGetIdle'
                            513 ;------------------------------------------------------------
                            514 ;	tfirm.c 126
                            515 ;	-----------------------------------------
                            516 ;	 function usbGetIdle
                            517 ;	-----------------------------------------
   00A6                     518 _usbGetIdle:
                            519 ;	tfirm.c 127
   00A6 E4                  520 	clr	a
   00A7 F5 36               521 	mov	(_wBytesRemainingOnIEP0 + 1),a
   00A9 75 35 01            522 	mov	_wBytesRemainingOnIEP0,#0x01
                            523 ;	tfirm.c 128
   00AC 7A 43               524 	mov	r2,#_gbIdleRateH
   00AE 7B 00               525 	mov	r3,#0x00
   00B0 7C 00               526 	mov	r4,#0x00
   00B2 8A 82               527 	mov	dpl,r2
   00B4 8B 83               528 	mov	dph,r3
   00B6 8C F0               529 	mov	b,r4
   00B8 12 05 48            530 	lcall	_usbSendDataPacketOnEP0
   00BB                     531 00101$:
   00BB 22                  532 	ret
                            533 ;------------------------------------------------------------
                            534 ;Allocation info for local variables in function 'usbSetInterface'
                            535 ;------------------------------------------------------------
                            536 ;	tfirm.c 131
                            537 ;	-----------------------------------------
                            538 ;	 function usbSetInterface
                            539 ;	-----------------------------------------
   00BC                     540 _usbSetInterface:
                            541 ;	tfirm.c 132
   00BC 90 FF 82            542 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   00BF E0                  543 	movx	a,@dptr
   00C0 FA                  544 	mov	r2,a
   00C1 43 02 08            545 	orl	ar2,#0x08
   00C4 90 FF 82            546 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   00C7 EA                  547 	mov	a,r2
   00C8 F0                  548 	movx	@dptr,a
                            549 ;	tfirm.c 133
   00C9 90 FF 04            550 	mov	dptr,#(_tSetupPacket + 0x0004)
   00CC E0                  551 	movx	a,@dptr
   00CD F5 40               552 	mov	_bInterfaceNumber,a
                            553 ;	tfirm.c 134
   00CF 12 00 38            554 	lcall	_usbSendZeroLengthPacketOnIEP0
   00D2                     555 00101$:
   00D2 22                  556 	ret
                            557 ;------------------------------------------------------------
                            558 ;Allocation info for local variables in function 'usbGetInterface'
                            559 ;------------------------------------------------------------
                            560 ;	tfirm.c 137
                            561 ;	-----------------------------------------
                            562 ;	 function usbGetInterface
                            563 ;	-----------------------------------------
   00D3                     564 _usbGetInterface:
                            565 ;	tfirm.c 138
   00D3 E4                  566 	clr	a
   00D4 F5 36               567 	mov	(_wBytesRemainingOnIEP0 + 1),a
   00D6 75 35 01            568 	mov	_wBytesRemainingOnIEP0,#0x01
                            569 ;	tfirm.c 139
   00D9 7A 40               570 	mov	r2,#_bInterfaceNumber
   00DB 7B 00               571 	mov	r3,#0x00
   00DD 7C 00               572 	mov	r4,#0x00
   00DF 8A 82               573 	mov	dpl,r2
   00E1 8B 83               574 	mov	dph,r3
   00E3 8C F0               575 	mov	b,r4
   00E5 12 05 48            576 	lcall	_usbSendDataPacketOnEP0
   00E8                     577 00101$:
   00E8 22                  578 	ret
                            579 ;------------------------------------------------------------
                            580 ;Allocation info for local variables in function 'usbSetProtocol'
                            581 ;------------------------------------------------------------
                            582 ;	tfirm.c 143
                            583 ;	-----------------------------------------
                            584 ;	 function usbSetProtocol
                            585 ;	-----------------------------------------
   00E9                     586 _usbSetProtocol:
                            587 ;	tfirm.c 144
   00E9 90 FF 02            588 	mov	dptr,#(_tSetupPacket + 0x0002)
   00EC E0                  589 	movx	a,@dptr
   00ED F5 44               590 	mov	_gbProtocol,a
                            591 ;	tfirm.c 145
   00EF 12 00 38            592 	lcall	_usbSendZeroLengthPacketOnIEP0
   00F2                     593 00101$:
   00F2 22                  594 	ret
                            595 ;------------------------------------------------------------
                            596 ;Allocation info for local variables in function 'usbGetProtocol'
                            597 ;------------------------------------------------------------
                            598 ;	tfirm.c 148
                            599 ;	-----------------------------------------
                            600 ;	 function usbGetProtocol
                            601 ;	-----------------------------------------
   00F3                     602 _usbGetProtocol:
                            603 ;	tfirm.c 149
   00F3 E4                  604 	clr	a
   00F4 F5 36               605 	mov	(_wBytesRemainingOnIEP0 + 1),a
   00F6 75 35 01            606 	mov	_wBytesRemainingOnIEP0,#0x01
                            607 ;	tfirm.c 150
   00F9 7A 44               608 	mov	r2,#_gbProtocol
   00FB 7B 00               609 	mov	r3,#0x00
   00FD 7C 00               610 	mov	r4,#0x00
   00FF 8A 82               611 	mov	dpl,r2
   0101 8B 83               612 	mov	dph,r3
   0103 8C F0               613 	mov	b,r4
   0105 12 05 48            614 	lcall	_usbSendDataPacketOnEP0
   0108                     615 00101$:
   0108 22                  616 	ret
                            617 ;------------------------------------------------------------
                            618 ;Allocation info for local variables in function 'usbSetAddress'
                            619 ;------------------------------------------------------------
                            620 ;	tfirm.c 154
                            621 ;	-----------------------------------------
                            622 ;	 function usbSetAddress
                            623 ;	-----------------------------------------
   0109                     624 _usbSetAddress:
                            625 ;	tfirm.c 155
   0109 90 FF 02            626 	mov	dptr,#(_tSetupPacket + 0x0002)
   010C E0                  627 	movx	a,@dptr
   010D FA                  628 	mov	r2,a
   010E 7B 00               629 	mov	r3,#0x00
   0110 C3                  630 	clr	c
   0111 EA                  631 	mov	a,r2
   0112 94 80               632 	subb	a,#0x80
   0114 EB                  633 	mov	a,r3
   0115 94 00               634 	subb	a,#0x00
                            635 ; Peephole 108   removed ljmp by inverse jump logic
   0117 50 1C               636 	jnc  00102$
   0119                     637 00107$:
                            638 ;	tfirm.c 157
   0119 7A FF               639 	mov	r2,#0xFF
   011B 7B FF               640 	mov	r3,#0xFF
   011D 90 FF 02            641 	mov	dptr,#(_tSetupPacket + 0x0002)
   0120 E0                  642 	movx	a,@dptr
                            643 ; Peephole 136   removed redundant moves
   0121 FC                  644 	mov  r4,a
   0122 8A 82               645 	mov  dpl,r2
   0124 8B 83               646 	mov  dph,r3
   0126 F0                  647 	movx	@dptr,a
                            648 ;	tfirm.c 158
   0127 90 FF 02            649 	mov	dptr,#(_tSetupPacket + 0x0002)
   012A E0                  650 	movx	a,@dptr
   012B F5 32               651 	mov	_bUsbDeviceAddress,a
                            652 ;	tfirm.c 159
   012D 75 31 03            653 	mov	_bStatusAction,#0x03
                            654 ;	tfirm.c 160
   0130 12 00 38            655 	lcall	_usbSendZeroLengthPacketOnIEP0
                            656 ; Peephole 132   changed ljmp to sjmp
   0133 80 03               657 	sjmp 00104$
   0135                     658 00102$:
                            659 ;	tfirm.c 163
   0135 12 03 0A            660 	lcall	_usbStallEndpoint0
   0138                     661 00104$:
   0138 22                  662 	ret
                            663 ;------------------------------------------------------------
                            664 ;Allocation info for local variables in function 'usbSetRemoteWakeup'
                            665 ;------------------------------------------------------------
                            666 ;	tfirm.c 167
                            667 ;	-----------------------------------------
                            668 ;	 function usbSetRemoteWakeup
                            669 ;	-----------------------------------------
   0139                     670 _usbSetRemoteWakeup:
                            671 ;	tfirm.c 168
   0139 7A FC               672 	mov	r2,#0xFC
   013B 7B FF               673 	mov	r3,#0xFF
                            674 ; Peephole 182   used 16 bit load of dptr
   013D 90 FF FC            675 	mov  dptr,#(((0xFF)<<8) + 0xFC)
   0140 E0                  676 	movx	a,@dptr
   0141 FC                  677 	mov	r4,a
   0142 43 04 08            678 	orl	ar4,#0x08
   0145 8A 82               679 	mov	dpl,r2
   0147 8B 83               680 	mov	dph,r3
   0149 EC                  681 	mov	a,r4
   014A F0                  682 	movx	@dptr,a
                            683 ;	tfirm.c 169
   014B 43 34 02            684 	orl	(_wDeviceFeatures + 1),#0x02
                            685 ;	tfirm.c 170
   014E 90 FF 82            686 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0151 E0                  687 	movx	a,@dptr
   0152 FA                  688 	mov	r2,a
   0153 43 02 08            689 	orl	ar2,#0x08
   0156 90 FF 82            690 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0159 EA                  691 	mov	a,r2
   015A F0                  692 	movx	@dptr,a
                            693 ;	tfirm.c 171
   015B 12 00 38            694 	lcall	_usbSendZeroLengthPacketOnIEP0
   015E                     695 00101$:
   015E 22                  696 	ret
                            697 ;------------------------------------------------------------
                            698 ;Allocation info for local variables in function 'usbClearRemoteWakeup'
                            699 ;------------------------------------------------------------
                            700 ;	tfirm.c 174
                            701 ;	-----------------------------------------
                            702 ;	 function usbClearRemoteWakeup
                            703 ;	-----------------------------------------
   015F                     704 _usbClearRemoteWakeup:
                            705 ;	tfirm.c 175
   015F 7A FC               706 	mov	r2,#0xFC
   0161 7B FF               707 	mov	r3,#0xFF
                            708 ; Peephole 182   used 16 bit load of dptr
   0163 90 FF FC            709 	mov  dptr,#(((0xFF)<<8) + 0xFC)
   0166 E0                  710 	movx	a,@dptr
   0167 FC                  711 	mov	r4,a
   0168 53 04 F7            712 	anl	ar4,#0xF7
   016B 8A 82               713 	mov	dpl,r2
   016D 8B 83               714 	mov	dph,r3
   016F EC                  715 	mov	a,r4
   0170 F0                  716 	movx	@dptr,a
                            717 ;	tfirm.c 176
   0171 53 34 FD            718 	anl	(_wDeviceFeatures + 1),#0xFD
                            719 ;	tfirm.c 177
   0174 90 FF 82            720 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0177 E0                  721 	movx	a,@dptr
   0178 FA                  722 	mov	r2,a
   0179 43 02 08            723 	orl	ar2,#0x08
   017C 90 FF 82            724 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   017F EA                  725 	mov	a,r2
   0180 F0                  726 	movx	@dptr,a
                            727 ;	tfirm.c 178
   0181 12 00 38            728 	lcall	_usbSendZeroLengthPacketOnIEP0
   0184                     729 00101$:
   0184 22                  730 	ret
                            731 ;------------------------------------------------------------
                            732 ;Allocation info for local variables in function 'usbSetReport'
                            733 ;------------------------------------------------------------
                            734 ;	tfirm.c 181
                            735 ;	-----------------------------------------
                            736 ;	 function usbSetReport
                            737 ;	-----------------------------------------
   0185                     738 _usbSetReport:
                            739 ;	tfirm.c 182
   0185 E4                  740 	clr	a
   0186 F5 38               741 	mov	(_wBytesRemainingOnOEP0 + 1),a
   0188 75 37 01            742 	mov	_wBytesRemainingOnOEP0,#0x01
   018B                     743 00101$:
   018B 22                  744 	ret
                            745 ;------------------------------------------------------------
                            746 ;Allocation info for local variables in function 'usbGetEndpointStatus'
                            747 ;------------------------------------------------------------
                            748 ;wEndpointStatus           Allocated to in memory with name '_usbGetEndpointStatus_wEndpointStatus_1_1'
                            749 ;	tfirm.c 186
                            750 ;	-----------------------------------------
                            751 ;	 function usbGetEndpointStatus
                            752 ;	-----------------------------------------
   018C                     753 _usbGetEndpointStatus:
                            754 ;	tfirm.c 187
   018C 75 4F 00            755 	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,#0x00
   018F 75 50 01            756 	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),#0x01
                            757 ;	tfirm.c 188
   0192 90 FF 48            758 	mov	dptr,#_tInputEndPointDescriptorBlock
   0195 E0                  759 	movx	a,@dptr
                            760 ; Peephole 105   removed redundant mov
   0196 FA                  761 	mov  r2,a
                            762 ; Peephole 111   removed ljmp by inverse jump logic
   0197 30 E7 05            763 	jnb  acc.7,00102$
   019A                     764 00106$:
                            765 ;	tfirm.c 189
   019A E4                  766 	clr	a
   019B F5 50               767 	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),a
   019D F5 4F               768 	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,a
   019F                     769 00102$:
                            770 ;	tfirm.c 191
   019F E4                  771 	clr	a
   01A0 F5 36               772 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01A2 75 35 02            773 	mov	_wBytesRemainingOnIEP0,#0x02
                            774 ;	tfirm.c 192
   01A5 7A 4F               775 	mov	r2,#_usbGetEndpointStatus_wEndpointStatus_1_1
   01A7 7B 00               776 	mov	r3,#0x00
   01A9 7C 00               777 	mov	r4,#0x00
   01AB 8A 82               778 	mov	dpl,r2
   01AD 8B 83               779 	mov	dph,r3
   01AF 8C F0               780 	mov	b,r4
   01B1 12 05 48            781 	lcall	_usbSendDataPacketOnEP0
   01B4                     782 00103$:
   01B4 22                  783 	ret
                            784 ;------------------------------------------------------------
                            785 ;Allocation info for local variables in function 'usbGetDeviceStatus'
                            786 ;------------------------------------------------------------
                            787 ;	tfirm.c 195
                            788 ;	-----------------------------------------
                            789 ;	 function usbGetDeviceStatus
                            790 ;	-----------------------------------------
   01B5                     791 _usbGetDeviceStatus:
                            792 ;	tfirm.c 196
   01B5 E4                  793 	clr	a
   01B6 F5 36               794 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01B8 75 35 02            795 	mov	_wBytesRemainingOnIEP0,#0x02
                            796 ;	tfirm.c 197
   01BB 7A 33               797 	mov	r2,#_wDeviceFeatures
   01BD 7B 00               798 	mov	r3,#0x00
   01BF 7C 00               799 	mov	r4,#0x00
   01C1 8A 82               800 	mov	dpl,r2
   01C3 8B 83               801 	mov	dph,r3
   01C5 8C F0               802 	mov	b,r4
   01C7 12 05 48            803 	lcall	_usbSendDataPacketOnEP0
   01CA                     804 00101$:
   01CA 22                  805 	ret
                            806 ;------------------------------------------------------------
                            807 ;Allocation info for local variables in function 'usbGetInterfaceStatus'
                            808 ;------------------------------------------------------------
                            809 ;wStatusBuffer             Allocated to in memory with name '_usbGetInterfaceStatus_wStatusBuffer_1_1'
                            810 ;	tfirm.c 200
                            811 ;	-----------------------------------------
                            812 ;	 function usbGetInterfaceStatus
                            813 ;	-----------------------------------------
   01CB                     814 _usbGetInterfaceStatus:
                            815 ;	tfirm.c 201
   01CB E4                  816 	clr	a
   01CC F5 52               817 	mov	(_usbGetInterfaceStatus_wStatusBuffer_1_1 + 1),a
   01CE F5 51               818 	mov	_usbGetInterfaceStatus_wStatusBuffer_1_1,a
                            819 ;	tfirm.c 202
   01D0 90 FF 82            820 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   01D3 E0                  821 	movx	a,@dptr
   01D4 FA                  822 	mov	r2,a
   01D5 43 02 08            823 	orl	ar2,#0x08
   01D8 90 FF 82            824 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   01DB EA                  825 	mov	a,r2
   01DC F0                  826 	movx	@dptr,a
                            827 ;	tfirm.c 203
   01DD E4                  828 	clr	a
   01DE F5 36               829 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01E0 75 35 02            830 	mov	_wBytesRemainingOnIEP0,#0x02
                            831 ;	tfirm.c 204
   01E3 7A 51               832 	mov	r2,#_usbGetInterfaceStatus_wStatusBuffer_1_1
   01E5 7B 00               833 	mov	r3,#0x00
   01E7 7C 00               834 	mov	r4,#0x00
   01E9 8A 82               835 	mov	dpl,r2
   01EB 8B 83               836 	mov	dph,r3
   01ED 8C F0               837 	mov	b,r4
   01EF 12 05 48            838 	lcall	_usbSendDataPacketOnEP0
   01F2                     839 00101$:
   01F2 22                  840 	ret
                            841 ;------------------------------------------------------------
                            842 ;Allocation info for local variables in function 'usbGetReportDescriptor'
                            843 ;------------------------------------------------------------
                            844 ;	tfirm.c 208
                            845 ;	-----------------------------------------
                            846 ;	 function usbGetReportDescriptor
                            847 ;	-----------------------------------------
   01F3                     848 _usbGetReportDescriptor:
                            849 ;	tfirm.c 209
   01F3 90 FF 83            850 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                            851 ; Peephole 180   changed mov to clr
   01F6 E4                  852 	clr  a
   01F7 F0                  853 	movx	@dptr,a
                            854 ;	tfirm.c 210
   01F8 E4                  855 	clr	a
   01F9 F5 36               856 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01FB 75 35 3F            857 	mov	_wBytesRemainingOnIEP0,#0x3F
   01FE                     858 00101$:
   01FE 22                  859 	ret
                            860 ;------------------------------------------------------------
                            861 ;Allocation info for local variables in function 'usbGetConfigurationDescriptor'
                            862 ;------------------------------------------------------------
                            863 ;bTemp                     Allocated to registers 
                            864 ;	tfirm.c 214
                            865 ;	-----------------------------------------
                            866 ;	 function usbGetConfigurationDescriptor
                            867 ;	-----------------------------------------
   01FF                     868 _usbGetConfigurationDescriptor:
                            869 ;	tfirm.c 217
   01FF 7A 00               870 	mov	r2,#0x00
   0201                     871 00101$:
   0201 BA 20 00            872 	cjne	r2,#0x20,00109$
   0204                     873 00109$:
                            874 ; Peephole 108   removed ljmp by inverse jump logic
   0204 50 16               875 	jnc  00104$
   0206                     876 00110$:
                            877 ;	tfirm.c 218
   0206 EA                  878 	mov	a,r2
   0207 24 80               879 	add	a,#_abDescriptor
   0209 FB                  880 	mov	r3,a
                            881 ; Peephole 180   changed mov to clr
   020A E4                  882 	clr  a
   020B 34 FE               883 	addc	a,#(_abDescriptor >> 8)
   020D FC                  884 	mov	r4,a
   020E EA                  885 	mov	a,r2
                            886 ; Peephole 180   changed mov to clr
                            887 ; Peephole 186   optimized movc sequence
   020F 90 0E 21            888 	mov  dptr,#_abromConfigurationDescriptorGroup
   0212 93                  889 	movc a,@a+dptr
                            890 ; Peephole 136   removed redundant moves
   0213 FD                  891 	mov  r5,a
   0214 8B 82               892 	mov  dpl,r3
   0216 8C 83               893 	mov  dph,r4
   0218 F0                  894 	movx	@dptr,a
                            895 ;	tfirm.c 217
   0219 0A                  896 	inc	r2
                            897 ; Peephole 132   changed ljmp to sjmp
   021A 80 E5               898 	sjmp 00101$
   021C                     899 00104$:
                            900 ;	tfirm.c 220
   021C 90 FE 87            901 	mov	dptr,#(_abDescriptor + 0x0007)
   021F 74 80               902 	mov	a,#0x80
   0221 F0                  903 	movx	@dptr,a
                            904 ;	tfirm.c 222
   0222 90 FF 83            905 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                            906 ; Peephole 180   changed mov to clr
   0225 E4                  907 	clr  a
   0226 F0                  908 	movx	@dptr,a
                            909 ;	tfirm.c 223
   0227 E4                  910 	clr	a
   0228 F5 36               911 	mov	(_wBytesRemainingOnIEP0 + 1),a
   022A 75 35 20            912 	mov	_wBytesRemainingOnIEP0,#0x20
                            913 ;	tfirm.c 224
   022D 7A 80               914 	mov	r2,#_abDescriptor
   022F 7B FE               915 	mov	r3,#(_abDescriptor >> 8)
   0231 7C 01               916 	mov	r4,#0x01
   0233 8A 82               917 	mov	dpl,r2
   0235 8B 83               918 	mov	dph,r3
   0237 8C F0               919 	mov	b,r4
   0239 12 05 48            920 	lcall	_usbSendDataPacketOnEP0
   023C                     921 00105$:
   023C 22                  922 	ret
                            923 ;------------------------------------------------------------
                            924 ;Allocation info for local variables in function 'usbGetHIDDescriptor'
                            925 ;------------------------------------------------------------
                            926 ;bTemp                     Allocated to registers 
                            927 ;	tfirm.c 228
                            928 ;	-----------------------------------------
                            929 ;	 function usbGetHIDDescriptor
                            930 ;	-----------------------------------------
   023D                     931 _usbGetHIDDescriptor:
                            932 ;	tfirm.c 231
   023D 7A 00               933 	mov	r2,#0x00
   023F                     934 00101$:
   023F BA 12 00            935 	cjne	r2,#0x12,00109$
   0242                     936 00109$:
                            937 ; Peephole 108   removed ljmp by inverse jump logic
   0242 50 18               938 	jnc  00104$
   0244                     939 00110$:
                            940 ;	tfirm.c 232
   0244 EA                  941 	mov	a,r2
   0245 24 80               942 	add	a,#_abDescriptor
   0247 FB                  943 	mov	r3,a
                            944 ; Peephole 180   changed mov to clr
   0248 E4                  945 	clr  a
   0249 34 FE               946 	addc	a,#(_abDescriptor >> 8)
   024B FC                  947 	mov	r4,a
   024C 74 12               948 	mov	a,#0x12
   024E 2A                  949 	add	a,r2
                            950 ; Peephole 180   changed mov to clr
                            951 ; Peephole 186   optimized movc sequence
   024F 90 0E 21            952 	mov  dptr,#_abromConfigurationDescriptorGroup
   0252 93                  953 	movc a,@a+dptr
                            954 ; Peephole 136   removed redundant moves
   0253 FD                  955 	mov  r5,a
   0254 8B 82               956 	mov  dpl,r3
   0256 8C 83               957 	mov  dph,r4
   0258 F0                  958 	movx	@dptr,a
                            959 ;	tfirm.c 231
   0259 0A                  960 	inc	r2
                            961 ; Peephole 132   changed ljmp to sjmp
   025A 80 E3               962 	sjmp 00101$
   025C                     963 00104$:
                            964 ;	tfirm.c 234
   025C 90 FF 83            965 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                            966 ; Peephole 180   changed mov to clr
   025F E4                  967 	clr  a
   0260 F0                  968 	movx	@dptr,a
                            969 ;	tfirm.c 235
   0261 E4                  970 	clr	a
   0262 F5 36               971 	mov	(_wBytesRemainingOnIEP0 + 1),a
   0264 75 35 09            972 	mov	_wBytesRemainingOnIEP0,#0x09
                            973 ;	tfirm.c 236
   0267 7A 80               974 	mov	r2,#_abDescriptor
   0269 7B FE               975 	mov	r3,#(_abDescriptor >> 8)
   026B 7C 01               976 	mov	r4,#0x01
   026D 8A 82               977 	mov	dpl,r2
   026F 8B 83               978 	mov	dph,r3
   0271 8C F0               979 	mov	b,r4
   0273 12 05 48            980 	lcall	_usbSendDataPacketOnEP0
   0276                     981 00105$:
   0276 22                  982 	ret
                            983 ;------------------------------------------------------------
                            984 ;Allocation info for local variables in function 'usbGetDeviceDescriptor'
                            985 ;------------------------------------------------------------
                            986 ;bTemp                     Allocated to registers 
                            987 ;	tfirm.c 239
                            988 ;	-----------------------------------------
                            989 ;	 function usbGetDeviceDescriptor
                            990 ;	-----------------------------------------
   0277                     991 _usbGetDeviceDescriptor:
                            992 ;	tfirm.c 242
   0277 7A 00               993 	mov	r2,#0x00
   0279                     994 00101$:
   0279 BA 12 00            995 	cjne	r2,#0x12,00109$
   027C                     996 00109$:
                            997 ; Peephole 108   removed ljmp by inverse jump logic
   027C 50 16               998 	jnc  00104$
   027E                     999 00110$:
                           1000 ;	tfirm.c 243
   027E EA                 1001 	mov	a,r2
   027F 24 80              1002 	add	a,#_abDescriptor
   0281 FB                 1003 	mov	r3,a
                           1004 ; Peephole 180   changed mov to clr
   0282 E4                 1005 	clr  a
   0283 34 FE              1006 	addc	a,#(_abDescriptor >> 8)
   0285 FC                 1007 	mov	r4,a
   0286 EA                 1008 	mov	a,r2
                           1009 ; Peephole 180   changed mov to clr
                           1010 ; Peephole 186   optimized movc sequence
   0287 90 0E 41           1011 	mov  dptr,#_abromDeviceDescriptor
   028A 93                 1012 	movc a,@a+dptr
                           1013 ; Peephole 136   removed redundant moves
   028B FD                 1014 	mov  r5,a
   028C 8B 82              1015 	mov  dpl,r3
   028E 8C 83              1016 	mov  dph,r4
   0290 F0                 1017 	movx	@dptr,a
                           1018 ;	tfirm.c 242
   0291 0A                 1019 	inc	r2
                           1020 ; Peephole 132   changed ljmp to sjmp
   0292 80 E5              1021 	sjmp 00101$
   0294                    1022 00104$:
                           1023 ;	tfirm.c 245
   0294 90 FE 84           1024 	mov	dptr,#(_abDescriptor + 0x0004)
   0297 74 FF              1025 	mov	a,#0xFF
   0299 F0                 1026 	movx	@dptr,a
                           1027 ;	tfirm.c 246
   029A 90 FE 88           1028 	mov	dptr,#(_abDescriptor + 0x0008)
   029D 74 51              1029 	mov	a,#0x51
   029F F0                 1030 	movx	@dptr,a
                           1031 ;	tfirm.c 247
   02A0 90 FE 89           1032 	mov	dptr,#(_abDescriptor + 0x0009)
   02A3 74 04              1033 	mov	a,#0x04
   02A5 F0                 1034 	movx	@dptr,a
                           1035 ;	tfirm.c 248
   02A6 90 FE 8A           1036 	mov	dptr,#(_abDescriptor + 0x000a)
   02A9 74 10              1037 	mov	a,#0x10
   02AB F0                 1038 	movx	@dptr,a
                           1039 ;	tfirm.c 249
   02AC 90 FE 8B           1040 	mov	dptr,#(_abDescriptor + 0x000b)
   02AF 74 32              1041 	mov	a,#0x32
   02B1 F0                 1042 	movx	@dptr,a
                           1043 ;	tfirm.c 250
   02B2 90 FE 8C           1044 	mov	dptr,#(_abDescriptor + 0x000c)
                           1045 ; Peephole 180   changed mov to clr
   02B5 E4                 1046 	clr  a
   02B6 F0                 1047 	movx	@dptr,a
                           1048 ;	tfirm.c 251
   02B7 90 FE 8D           1049 	mov	dptr,#(_abDescriptor + 0x000d)
   02BA 74 01              1050 	mov	a,#0x01
   02BC F0                 1051 	movx	@dptr,a
                           1052 ;	tfirm.c 253
   02BD 90 FE 8E           1053 	mov	dptr,#(_abDescriptor + 0x000e)
                           1054 ; Peephole 180   changed mov to clr
   02C0 E4                 1055 	clr  a
   02C1 F0                 1056 	movx	@dptr,a
                           1057 ;	tfirm.c 254
   02C2 90 FE 8F           1058 	mov	dptr,#(_abDescriptor + 0x000f)
                           1059 ; Peephole 180   changed mov to clr
   02C5 E4                 1060 	clr  a
   02C6 F0                 1061 	movx	@dptr,a
                           1062 ;	tfirm.c 255
   02C7 90 FE 90           1063 	mov	dptr,#(_abDescriptor + 0x0010)
   02CA 74 01              1064 	mov	a,#0x01
   02CC F0                 1065 	movx	@dptr,a
                           1066 ;	tfirm.c 257
   02CD 90 FF 83           1067 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1068 ; Peephole 180   changed mov to clr
   02D0 E4                 1069 	clr  a
   02D1 F0                 1070 	movx	@dptr,a
                           1071 ;	tfirm.c 258
   02D2 E4                 1072 	clr	a
   02D3 F5 36              1073 	mov	(_wBytesRemainingOnIEP0 + 1),a
   02D5 75 35 12           1074 	mov	_wBytesRemainingOnIEP0,#0x12
                           1075 ;	tfirm.c 259
   02D8 7A 80              1076 	mov	r2,#_abDescriptor
   02DA 7B FE              1077 	mov	r3,#(_abDescriptor >> 8)
   02DC 7C 01              1078 	mov	r4,#0x01
   02DE 8A 82              1079 	mov	dpl,r2
   02E0 8B 83              1080 	mov	dph,r3
   02E2 8C F0              1081 	mov	b,r4
   02E4 12 05 48           1082 	lcall	_usbSendDataPacketOnEP0
                           1083 ;	tfirm.c 263
   02E7 75 30 01           1084 	mov	_deviceReady,#0x01
   02EA                    1085 00105$:
   02EA 22                 1086 	ret
                           1087 ;------------------------------------------------------------
                           1088 ;Allocation info for local variables in function 'usbGetStringDescriptor'
                           1089 ;------------------------------------------------------------
                           1090 ;	tfirm.c 267
                           1091 ;	-----------------------------------------
                           1092 ;	 function usbGetStringDescriptor
                           1093 ;	-----------------------------------------
   02EB                    1094 _usbGetStringDescriptor:
                           1095 ;	tfirm.c 269
   02EB 90 FF 83           1096 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1097 ; Peephole 180   changed mov to clr
   02EE E4                 1098 	clr  a
   02EF F0                 1099 	movx	@dptr,a
                           1100 ;	tfirm.c 270
   02F0 E4                 1101 	clr	a
   02F1 F5 36              1102 	mov	(_wBytesRemainingOnIEP0 + 1),a
   02F3 75 35 12           1103 	mov	_wBytesRemainingOnIEP0,#0x12
                           1104 ;	tfirm.c 271
   02F6 7A 80              1105 	mov	r2,#_abDescriptor
   02F8 7B FE              1106 	mov	r3,#(_abDescriptor >> 8)
   02FA 7C 01              1107 	mov	r4,#0x01
   02FC 8A 82              1108 	mov	dpl,r2
   02FE 8B 83              1109 	mov	dph,r3
   0300 8C F0              1110 	mov	b,r4
   0302 12 05 48           1111 	lcall	_usbSendDataPacketOnEP0
   0305                    1112 00101$:
   0305 22                 1113 	ret
                           1114 ;------------------------------------------------------------
                           1115 ;Allocation info for local variables in function 'usbNonStandardRequest'
                           1116 ;------------------------------------------------------------
                           1117 ;	tfirm.c 275
                           1118 ;	-----------------------------------------
                           1119 ;	 function usbNonStandardRequest
                           1120 ;	-----------------------------------------
   0306                    1121 _usbNonStandardRequest:
                           1122 ;	tfirm.c 276
   0306 12 03 0A           1123 	lcall	_usbStallEndpoint0
   0309                    1124 00101$:
   0309 22                 1125 	ret
                           1126 ;------------------------------------------------------------
                           1127 ;Allocation info for local variables in function 'usbStallEndpoint0'
                           1128 ;------------------------------------------------------------
                           1129 ;	tfirm.c 279
                           1130 ;	-----------------------------------------
                           1131 ;	 function usbStallEndpoint0
                           1132 ;	-----------------------------------------
   030A                    1133 _usbStallEndpoint0:
                           1134 ;	tfirm.c 280
   030A 90 FF 80           1135 	mov	dptr,#_tEndPoint0DescriptorBlock
   030D E0                 1136 	movx	a,@dptr
   030E FA                 1137 	mov	r2,a
   030F 43 02 08           1138 	orl	ar2,#0x08
   0312 90 FF 80           1139 	mov	dptr,#_tEndPoint0DescriptorBlock
   0315 EA                 1140 	mov	a,r2
   0316 F0                 1141 	movx	@dptr,a
                           1142 ;	tfirm.c 281
   0317 90 FF 82           1143 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   031A E0                 1144 	movx	a,@dptr
   031B FA                 1145 	mov	r2,a
   031C 43 02 08           1146 	orl	ar2,#0x08
   031F 90 FF 82           1147 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0322 EA                 1148 	mov	a,r2
   0323 F0                 1149 	movx	@dptr,a
   0324                    1150 00101$:
   0324 22                 1151 	ret
                           1152 ;------------------------------------------------------------
                           1153 ;Allocation info for local variables in function 'usbReset'
                           1154 ;------------------------------------------------------------
                           1155 ;	tfirm.c 494
                           1156 ;	-----------------------------------------
                           1157 ;	 function usbReset
                           1158 ;	-----------------------------------------
   0325                    1159 _usbReset:
                           1160 ;	tfirm.c 495
                           1161 ; Peephole 182   used 16 bit load of dptr
   0325 90 FF FF           1162 	mov  dptr,#(((0xFF)<<8) + 0xFF)
                           1163 ; Peephole 180   changed mov to clr
   0328 E4                 1164 	clr  a
   0329 F0                 1165 	movx	@dptr,a
                           1166 ;	tfirm.c 497
   032A 75 35 FF           1167 	mov	_wBytesRemainingOnIEP0,#0xFF
   032D 75 36 FF           1168 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                           1169 ;	tfirm.c 498
   0330 75 37 FF           1170 	mov	_wBytesRemainingOnOEP0,#0xFF
   0333 75 38 FF           1171 	mov	(_wBytesRemainingOnOEP0 + 1),#0xFF
                           1172 ;	tfirm.c 499
                           1173 ;	tfirm.c 501
                           1174 ; Peephole 3.b   changed mov to clr
   0336 E4                 1175 	clr  a
   0337 F5 31              1176 	mov  _bStatusAction,a
   0339 F5 3B              1177 	mov	(_pbIEP0Buffer + 2),a
   033B F5 3A              1178 	mov	(_pbIEP0Buffer + 1),a
   033D F5 39              1179 	mov	_pbIEP0Buffer,a
                           1180 ;	tfirm.c 502
   033F E4                 1181 	clr	a
   0340 F5 3E              1182 	mov	(_pbOEP0Buffer + 2),a
   0342 F5 3D              1183 	mov	(_pbOEP0Buffer + 1),a
   0344 F5 3C              1184 	mov	_pbOEP0Buffer,a
                           1185 ;	tfirm.c 504
   0346 75 3F 00           1186 	mov	_bConfigurationNumber,#0x00
                           1187 ;	tfirm.c 505
   0349 75 40 00           1188 	mov	_bInterfaceNumber,#0x00
                           1189 ;	tfirm.c 507
   034C 90 FF 80           1190 	mov	dptr,#_tEndPoint0DescriptorBlock
   034F 74 84              1191 	mov	a,#0x84
   0351 F0                 1192 	movx	@dptr,a
                           1193 ;	tfirm.c 508
   0352 90 FF 82           1194 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0355 74 84              1195 	mov	a,#0x84
   0357 F0                 1196 	movx	@dptr,a
                           1197 ;	tfirm.c 510
   0358 90 FF 81           1198 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
   035B 74 80              1199 	mov	a,#0x80
   035D F0                 1200 	movx	@dptr,a
                           1201 ;	tfirm.c 511
   035E 90 FF 83           1202 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
   0361 74 80              1203 	mov	a,#0x80
   0363 F0                 1204 	movx	@dptr,a
                           1205 ;	tfirm.c 514
   0364 90 FF 48           1206 	mov	dptr,#_tInputEndPointDescriptorBlock
                           1207 ; Peephole 180   changed mov to clr
   0367 E4                 1208 	clr  a
   0368 F0                 1209 	movx	@dptr,a
                           1210 ;	tfirm.c 515
   0369 90 FF 48           1211 	mov	dptr,#_tInputEndPointDescriptorBlock
   036C 74 84              1212 	mov	a,#0x84
   036E F0                 1213 	movx	@dptr,a
                           1214 ;	tfirm.c 516
   036F 90 FF 49           1215 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0001)
   0372 74 C0              1216 	mov	a,#0xC0
   0374 F0                 1217 	movx	@dptr,a
                           1218 ;	tfirm.c 517
   0375 90 FF 4A           1219 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
   0378 74 80              1220 	mov	a,#0x80
   037A F0                 1221 	movx	@dptr,a
                           1222 ;	tfirm.c 518
   037B 90 FF 4F           1223 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0007)
   037E 74 40              1224 	mov	a,#0x40
   0380 F0                 1225 	movx	@dptr,a
                           1226 ;	tfirm.c 519
   0381 90 FF 4A           1227 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
   0384 74 80              1228 	mov	a,#0x80
   0386 F0                 1229 	movx	@dptr,a
                           1230 ;	tfirm.c 522
   0387 90 FF 08           1231 	mov	dptr,#_tOutputEndPointDescriptorBlock
                           1232 ; Peephole 180   changed mov to clr
   038A E4                 1233 	clr  a
   038B F0                 1234 	movx	@dptr,a
                           1235 ;	tfirm.c 524
   038C 90 FF 08           1236 	mov	dptr,#_tOutputEndPointDescriptorBlock
   038F E0                 1237 	movx	a,@dptr
   0390 FA                 1238 	mov	r2,a
   0391 43 02 84           1239 	orl	ar2,#0x84
   0394 90 FF 08           1240 	mov	dptr,#_tOutputEndPointDescriptorBlock
   0397 EA                 1241 	mov	a,r2
   0398 F0                 1242 	movx	@dptr,a
                           1243 ;	tfirm.c 525
   0399 90 FF 09           1244 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0001)
   039C 74 B0              1245 	mov	a,#0xB0
   039E F0                 1246 	movx	@dptr,a
                           1247 ;	tfirm.c 526
   039F 90 FF 0A           1248 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
                           1249 ; Peephole 180   changed mov to clr
   03A2 E4                 1250 	clr  a
   03A3 F0                 1251 	movx	@dptr,a
                           1252 ;	tfirm.c 527
   03A4 90 FF 0D           1253 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0005)
   03A7 74 B8              1254 	mov	a,#0xB8
   03A9 F0                 1255 	movx	@dptr,a
                           1256 ;	tfirm.c 528
   03AA 90 FF 0E           1257 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0006)
                           1258 ; Peephole 180   changed mov to clr
   03AD E4                 1259 	clr  a
   03AE F0                 1260 	movx	@dptr,a
                           1261 ;	tfirm.c 529
   03AF 90 FF 0F           1262 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0007)
   03B2 74 40              1263 	mov	a,#0x40
   03B4 F0                 1264 	movx	@dptr,a
                           1265 ;	tfirm.c 531
   03B5 E4                 1266 	clr	a
   03B6 F5 48              1267 	mov	(_bCurrentBuffer + 1),a
   03B8 F5 47              1268 	mov	_bCurrentBuffer,a
                           1269 ;	tfirm.c 532
   03BA 75 4C 00           1270 	mov	_bOEP1RecieveLength,#0x00
                           1271 ;	tfirm.c 533
   03BD 75 4D 00           1272 	mov	_bOEP1SaveBufferPosition,#0x00
                           1273 ;	tfirm.c 535
                           1274 ; Peephole 182   used 16 bit load of dptr
   03C0 90 FF FD           1275 	mov  dptr,#(((0xFF)<<8) + 0xFD)
   03C3 74 E5              1276 	mov	a,#0xE5
   03C5 F0                 1277 	movx	@dptr,a
                           1278 ;	tfirm.c 536
   03C6 7A F7              1279 	mov	r2,#0xF7
   03C8 7B FF              1280 	mov	r3,#0xFF
                           1281 ; Peephole 182   used 16 bit load of dptr
   03CA 90 FF F7           1282 	mov  dptr,#(((0xFF)<<8) + 0xF7)
   03CD E0                 1283 	movx	a,@dptr
   03CE FC                 1284 	mov	r4,a
   03CF 43 04 95           1285 	orl	ar4,#0x95
   03D2 8A 82              1286 	mov	dpl,r2
   03D4 8B 83              1287 	mov	dph,r3
   03D6 EC                 1288 	mov	a,r4
   03D7 F0                 1289 	movx	@dptr,a
                           1290 ;	tfirm.c 538
   03D8 75 49 43           1291 	mov	_ID1,#0x43
                           1292 ;	tfirm.c 539
   03DB 75 4A 4D           1293 	mov	_ID2,#0x4D
                           1294 ;	tfirm.c 540
   03DE 75 4B 00           1295 	mov	_FIRMWARE_VERSION,#0x00
   03E1                    1296 00101$:
   03E1 22                 1297 	ret
                           1298 ;------------------------------------------------------------
                           1299 ;Allocation info for local variables in function 'SystemInitialization'
                           1300 ;------------------------------------------------------------
                           1301 ;	tfirm.c 544
                           1302 ;	-----------------------------------------
                           1303 ;	 function SystemInitialization
                           1304 ;	-----------------------------------------
   03E2                    1305 _SystemInitialization:
                           1306 ;	tfirm.c 546
   03E2 C2 AF              1307 	clr	_EA
                           1308 ;	tfirm.c 548
                           1309 ; Peephole 182   used 16 bit load of dptr
   03E4 90 FF FC           1310 	mov  dptr,#(((0xFF)<<8) + 0xFC)
                           1311 ; Peephole 180   changed mov to clr
   03E7 E4                 1312 	clr  a
   03E8 F0                 1313 	movx	@dptr,a
                           1314 ;	tfirm.c 550
                           1315 ; Peephole 182   used 16 bit load of dptr
   03E9 90 FF 90           1316 	mov  dptr,#(((0xFF)<<8) + 0x90)
   03EC 74 E0              1317 	mov	a,#0xE0
   03EE F0                 1318 	movx	@dptr,a
                           1319 ;	tfirm.c 555
   03EF D2 AF              1320 	setb	_EA
                           1321 ;	tfirm.c 556
   03F1 D2 A8              1322 	setb	_EX0
                           1323 ;	tfirm.c 558
   03F3 12 03 25           1324 	lcall	_usbReset
                           1325 ;	tfirm.c 560
                           1326 ; Peephole 182   used 16 bit load of dptr
   03F6 90 FF FC           1327 	mov  dptr,#(((0xFF)<<8) + 0xFC)
   03F9 74 80              1328 	mov	a,#0x80
   03FB F0                 1329 	movx	@dptr,a
   03FC                    1330 00101$:
   03FC 22                 1331 	ret
                           1332 ;------------------------------------------------------------
                           1333 ;Allocation info for local variables in function 'usbReceiveDataPacketOnEP0'
                           1334 ;------------------------------------------------------------
                           1335 ;	tfirm.c 565
                           1336 ;	-----------------------------------------
                           1337 ;	 function usbReceiveDataPacketOnEP0
                           1338 ;	-----------------------------------------
   03FD                    1339 _usbReceiveDataPacketOnEP0:
                           1340 ;	tfirm.c 576
   03FD 85 82 3C           1341 	mov	_pbOEP0Buffer,dpl
   0400 85 83 3D           1342 	mov	(_pbOEP0Buffer + 1),dph
   0403 85 F0 3E           1343 	mov	(_pbOEP0Buffer + 2),b
                           1344 ;	tfirm.c 570
   0406 90 FF 07           1345 	mov	dptr,#(_tSetupPacket + 0x0007)
   0409 E0                 1346 	movx	a,@dptr
   040A FA                 1347 	mov	r2,a
   040B 7B 00              1348 	mov	r3,#0x00
                           1349 ;	tfirm.c 571
   040D 8A 03              1350 	mov	ar3,r2
   040F 7A 00              1351 	mov	r2,#0x00
                           1352 ;	tfirm.c 572
   0411 90 FF 06           1353 	mov	dptr,#(_tSetupPacket + 0x0006)
   0414 E0                 1354 	movx	a,@dptr
   0415 FC                 1355 	mov	r4,a
   0416 7D 00              1356 	mov	r5,#0x00
                           1357 ;	tfirm.c 574
   0418 EC                 1358 	mov	a,r4
   0419 4A                 1359 	orl	a,r2
   041A F5 37              1360 	mov	_wBytesRemainingOnOEP0,a
   041C ED                 1361 	mov	a,r5
   041D 4B                 1362 	orl	a,r3
   041E F5 38              1363 	mov	(_wBytesRemainingOnOEP0 + 1),a
                           1364 ;	tfirm.c 575
   0420 75 31 02           1365 	mov	_bStatusAction,#0x02
                           1366 ;	tfirm.c 576
   0423 90 FF 83           1367 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1368 ; Peephole 180   changed mov to clr
   0426 E4                 1369 	clr  a
   0427 F0                 1370 	movx	@dptr,a
   0428                    1371 00101$:
   0428 22                 1372 	ret
                           1373 ;------------------------------------------------------------
                           1374 ;Allocation info for local variables in function 'usbReceiveNextPacketOnOEP0'
                           1375 ;------------------------------------------------------------
                           1376 ;	tfirm.c 579
                           1377 ;	-----------------------------------------
                           1378 ;	 function usbReceiveNextPacketOnOEP0
                           1379 ;	-----------------------------------------
   0429                    1380 _usbReceiveNextPacketOnOEP0:
                           1381 ;	tfirm.c 585
   0429 90 FF 83           1382 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
   042C E0                 1383 	movx	a,@dptr
   042D FA                 1384 	mov	r2,a
   042E 53 02 7F           1385 	anl	ar2,#0x7F
                           1386 ;	tfirm.c 592
   0431 8A 03              1387 	mov	ar3,r2
   0433 7C 00              1388 	mov	r4,#0x00
   0435 C3                 1389 	clr	c
   0436 E5 37              1390 	mov	a,_wBytesRemainingOnOEP0
   0438 9B                 1391 	subb	a,r3
   0439 E5 38              1392 	mov	a,(_wBytesRemainingOnOEP0 + 1)
   043B 9C                 1393 	subb	a,r4
   043C 50 03              1394 	jnc	00117$
   043E 02 04 9E           1395 	ljmp	00105$
   0441                    1396 00117$:
                           1397 ;	tfirm.c 596
   0441 7D 00              1398 	mov	r5,#0x00
   0443                    1399 00107$:
   0443 C3                 1400 	clr	c
   0444 ED                 1401 	mov	a,r5
   0445 9A                 1402 	subb	a,r2
                           1403 ; Peephole 108   removed ljmp by inverse jump logic
   0446 50 26              1404 	jnc  00110$
   0448                    1405 00118$:
                           1406 ;	tfirm.c 597
   0448 AE 3C              1407 	mov	r6,_pbOEP0Buffer
   044A AF 3D              1408 	mov	r7,(_pbOEP0Buffer + 1)
   044C A8 3E              1409 	mov	r0,(_pbOEP0Buffer + 2)
   044E 05 3C              1410 	inc	_pbOEP0Buffer
   0450 E4                 1411 	clr	a
   0451 B5 3C 02           1412 	cjne	a,_pbOEP0Buffer,00119$
   0454 05 3D              1413 	inc	(_pbOEP0Buffer + 1)
   0456                    1414 00119$:
   0456 ED                 1415 	mov	a,r5
   0457 24 F0              1416 	add	a,#_abOEP0Buffer
   0459 F5 82              1417 	mov	dpl,a
                           1418 ; Peephole 180   changed mov to clr
   045B E4                 1419 	clr  a
   045C 34 FE              1420 	addc	a,#(_abOEP0Buffer >> 8)
   045E F5 83              1421 	mov	dph,a
   0460 E0                 1422 	movx	a,@dptr
                           1423 ; Peephole 191   removed redundant mov
   0461 F9                 1424 	mov  r1,a
   0462 8E 82              1425 	mov  dpl,r6
   0464 8F 83              1426 	mov  dph,r7
   0466 88 F0              1427 	mov  b,r0
   0468 12 10 16           1428 	lcall	__gptrput
                           1429 ;	tfirm.c 596
   046B 0D                 1430 	inc	r5
                           1431 ; Peephole 132   changed ljmp to sjmp
   046C 80 D5              1432 	sjmp 00107$
   046E                    1433 00110$:
                           1434 ;	tfirm.c 601
   046E C3                 1435 	clr	c
   046F E5 37              1436 	mov	a,_wBytesRemainingOnOEP0
   0471 9B                 1437 	subb	a,r3
   0472 F5 37              1438 	mov	_wBytesRemainingOnOEP0,a
   0474 E5 38              1439 	mov	a,(_wBytesRemainingOnOEP0 + 1)
   0476 9C                 1440 	subb	a,r4
   0477 F5 38              1441 	mov	(_wBytesRemainingOnOEP0 + 1),a
                           1442 ;	tfirm.c 607
   0479 C3                 1443 	clr	c
                           1444 ; Peephole 180   changed mov to clr
   047A E4                 1445 	clr  a
   047B 95 37              1446 	subb	a,_wBytesRemainingOnOEP0
                           1447 ; Peephole 180   changed mov to clr
   047D E4                 1448 	clr  a
   047E 95 38              1449 	subb	a,(_wBytesRemainingOnOEP0 + 1)
                           1450 ; Peephole 108   removed ljmp by inverse jump logic
   0480 50 0A              1451 	jnc  00102$
   0482                    1452 00120$:
                           1453 ;	tfirm.c 609
   0482 90 FF 83           1454 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1455 ; Peephole 180   changed mov to clr
   0485 E4                 1456 	clr  a
   0486 F0                 1457 	movx	@dptr,a
                           1458 ;	tfirm.c 610
   0487 75 31 02           1459 	mov	_bStatusAction,#0x02
                           1460 ; Peephole 132   changed ljmp to sjmp
   048A 80 22              1461 	sjmp 00111$
   048C                    1462 00102$:
                           1463 ;	tfirm.c 622
   048C 90 FF 82           1464 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   048F E0                 1465 	movx	a,@dptr
   0490 FA                 1466 	mov	r2,a
   0491 43 02 08           1467 	orl	ar2,#0x08
   0494 90 FF 82           1468 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0497 EA                 1469 	mov	a,r2
   0498 F0                 1470 	movx	@dptr,a
                           1471 ;	tfirm.c 623
   0499 75 31 00           1472 	mov	_bStatusAction,#0x00
                           1473 ; Peephole 132   changed ljmp to sjmp
   049C 80 10              1474 	sjmp 00111$
   049E                    1475 00105$:
                           1476 ;	tfirm.c 634
   049E 90 FF 82           1477 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   04A1 E0                 1478 	movx	a,@dptr
   04A2 FA                 1479 	mov	r2,a
   04A3 43 02 08           1480 	orl	ar2,#0x08
   04A6 90 FF 82           1481 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   04A9 EA                 1482 	mov	a,r2
   04AA F0                 1483 	movx	@dptr,a
                           1484 ;	tfirm.c 635
   04AB 75 31 00           1485 	mov	_bStatusAction,#0x00
   04AE                    1486 00111$:
   04AE 22                 1487 	ret
                           1488 ;------------------------------------------------------------
                           1489 ;Allocation info for local variables in function 'usbSendNextPacketOnIEP0'
                           1490 ;------------------------------------------------------------
                           1491 ;	tfirm.c 639
                           1492 ;	-----------------------------------------
                           1493 ;	 function usbSendNextPacketOnIEP0
                           1494 ;	-----------------------------------------
   04AF                    1495 _usbSendNextPacketOnIEP0:
                           1496 ;	tfirm.c 643
   04AF E5 35              1497 	mov	a,_wBytesRemainingOnIEP0
   04B1 B4 FF 08           1498 	cjne	a,#0xFF,00125$
   04B4 E5 36              1499 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   04B6 B4 FF 03           1500 	cjne	a,#0xFF,00125$
   04B9 02 05 44           1501 	ljmp	00111$
   04BC                    1502 00125$:
                           1503 ;	tfirm.c 645
   04BC C3                 1504 	clr	c
   04BD 74 08              1505 	mov	a,#0x08
   04BF 95 35              1506 	subb	a,_wBytesRemainingOnIEP0
                           1507 ; Peephole 180   changed mov to clr
   04C1 E4                 1508 	clr  a
   04C2 95 36              1509 	subb	a,(_wBytesRemainingOnIEP0 + 1)
                           1510 ; Peephole 108   removed ljmp by inverse jump logic
   04C4 50 13              1511 	jnc  00108$
   04C6                    1512 00126$:
                           1513 ;	tfirm.c 649
   04C6 7A 08              1514 	mov	r2,#0x08
                           1515 ;	tfirm.c 650
   04C8 E5 35              1516 	mov	a,_wBytesRemainingOnIEP0
   04CA 24 F8              1517 	add	a,#0xf8
   04CC F5 35              1518 	mov	_wBytesRemainingOnIEP0,a
   04CE E5 36              1519 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   04D0 34 FF              1520 	addc	a,#0xff
   04D2 F5 36              1521 	mov	(_wBytesRemainingOnIEP0 + 1),a
                           1522 ;	tfirm.c 651
   04D4 75 31 01           1523 	mov	_bStatusAction,#0x01
                           1524 ; Peephole 132   changed ljmp to sjmp
   04D7 80 38              1525 	sjmp 00124$
   04D9                    1526 00108$:
                           1527 ;	tfirm.c 653
   04D9 C3                 1528 	clr	c
   04DA E5 35              1529 	mov	a,_wBytesRemainingOnIEP0
   04DC 94 08              1530 	subb	a,#0x08
   04DE E5 36              1531 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   04E0 94 00              1532 	subb	a,#0x00
                           1533 ; Peephole 108   removed ljmp by inverse jump logic
   04E2 50 0D              1534 	jnc  00105$
   04E4                    1535 00127$:
                           1536 ;	tfirm.c 657
   04E4 AA 35              1537 	mov	r2,_wBytesRemainingOnIEP0
                           1538 ;	tfirm.c 658
   04E6 75 35 FF           1539 	mov	_wBytesRemainingOnIEP0,#0xFF
   04E9 75 36 FF           1540 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                           1541 ;	tfirm.c 659
   04EC 75 31 00           1542 	mov	_bStatusAction,#0x00
                           1543 ; Peephole 132   changed ljmp to sjmp
   04EF 80 20              1544 	sjmp 00124$
   04F1                    1545 00105$:
                           1546 ;	tfirm.c 664
   04F1 7A 08              1547 	mov	r2,#0x08
                           1548 ;	tfirm.c 665
   04F3 E5 45              1549 	mov	a,_bHostAskMoreDataThanAvailable
   04F5 B4 01 04           1550 	cjne	a,#0x01,00128$
   04F8 E5 46              1551 	mov	a,(_bHostAskMoreDataThanAvailable + 1)
                           1552 ; Peephole 162   removed sjmp by inverse jump logic
   04FA 60 02              1553 	jz   00129$
   04FC                    1554 00128$:
                           1555 ; Peephole 132   changed ljmp to sjmp
   04FC 80 0A              1556 	sjmp 00102$
   04FE                    1557 00129$:
                           1558 ;	tfirm.c 667
   04FE E4                 1559 	clr	a
   04FF F5 36              1560 	mov	(_wBytesRemainingOnIEP0 + 1),a
   0501 F5 35              1561 	mov	_wBytesRemainingOnIEP0,a
                           1562 ;	tfirm.c 668
   0503 75 31 01           1563 	mov	_bStatusAction,#0x01
                           1564 ; Peephole 132   changed ljmp to sjmp
   0506 80 09              1565 	sjmp 00124$
   0508                    1566 00102$:
                           1567 ;	tfirm.c 672
   0508 75 35 FF           1568 	mov	_wBytesRemainingOnIEP0,#0xFF
   050B 75 36 FF           1569 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                           1570 ;	tfirm.c 673
   050E 75 31 00           1571 	mov	_bStatusAction,#0x00
                           1572 ;	tfirm.c 676
   0511                    1573 00124$:
   0511 7B 00              1574 	mov	r3,#0x00
   0513                    1575 00113$:
   0513 C3                 1576 	clr	c
   0514 EB                 1577 	mov	a,r3
   0515 9A                 1578 	subb	a,r2
                           1579 ; Peephole 108   removed ljmp by inverse jump logic
   0516 50 25              1580 	jnc  00116$
   0518                    1581 00130$:
                           1582 ;	tfirm.c 677
   0518 EB                 1583 	mov	a,r3
   0519 24 F8              1584 	add	a,#_abIEP0Buffer
   051B FC                 1585 	mov	r4,a
                           1586 ; Peephole 180   changed mov to clr
   051C E4                 1587 	clr  a
   051D 34 FE              1588 	addc	a,#(_abIEP0Buffer >> 8)
   051F FD                 1589 	mov	r5,a
   0520 85 39 82           1590 	mov	dpl,_pbIEP0Buffer
   0523 85 3A 83           1591 	mov	dph,(_pbIEP0Buffer + 1)
   0526 85 3B F0           1592 	mov	b,(_pbIEP0Buffer + 2)
   0529 05 39              1593 	inc	_pbIEP0Buffer
   052B E4                 1594 	clr	a
   052C B5 39 02           1595 	cjne	a,_pbIEP0Buffer,00131$
   052F 05 3A              1596 	inc	(_pbIEP0Buffer + 1)
   0531                    1597 00131$:
   0531 12 10 47           1598 	lcall	__gptrget
                           1599 ; Peephole 136   removed redundant moves
   0534 FE                 1600 	mov  r6,a
   0535 8C 82              1601 	mov  dpl,r4
   0537 8D 83              1602 	mov  dph,r5
   0539 F0                 1603 	movx	@dptr,a
                           1604 ;	tfirm.c 676
   053A 0B                 1605 	inc	r3
                           1606 ; Peephole 132   changed ljmp to sjmp
   053B 80 D6              1607 	sjmp 00113$
   053D                    1608 00116$:
                           1609 ;	tfirm.c 679
   053D 90 FF 81           1610 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
   0540 EA                 1611 	mov	a,r2
   0541 F0                 1612 	movx	@dptr,a
                           1613 ; Peephole 132   changed ljmp to sjmp
   0542 80 03              1614 	sjmp 00117$
   0544                    1615 00111$:
                           1616 ;	tfirm.c 683
   0544 75 31 00           1617 	mov	_bStatusAction,#0x00
   0547                    1618 00117$:
   0547 22                 1619 	ret
                           1620 ;------------------------------------------------------------
                           1621 ;Allocation info for local variables in function 'usbSendDataPacketOnEP0'
                           1622 ;------------------------------------------------------------
                           1623 ;pbBuffer                  Allocated to registers 
                           1624 ;wh                        Allocated to registers r2 r3 
                           1625 ;wl                        Allocated to registers r4 r5 
                           1626 ;wTemp                     Allocated to registers r2 r3 
                           1627 ;	tfirm.c 687
                           1628 ;	-----------------------------------------
                           1629 ;	 function usbSendDataPacketOnEP0
                           1630 ;	-----------------------------------------
   0548                    1631 _usbSendDataPacketOnEP0:
                           1632 ;	tfirm.c 712
   0548 85 82 39           1633 	mov	_pbIEP0Buffer,dpl
   054B 85 83 3A           1634 	mov	(_pbIEP0Buffer + 1),dph
   054E 85 F0 3B           1635 	mov	(_pbIEP0Buffer + 2),b
                           1636 ;	tfirm.c 694
   0551 90 FF 07           1637 	mov	dptr,#(_tSetupPacket + 0x0007)
   0554 E0                 1638 	movx	a,@dptr
   0555 FA                 1639 	mov	r2,a
   0556 7B 00              1640 	mov	r3,#0x00
                           1641 ;	tfirm.c 695
   0558 8A 03              1642 	mov	ar3,r2
   055A 7A 00              1643 	mov	r2,#0x00
                           1644 ;	tfirm.c 696
   055C 90 FF 06           1645 	mov	dptr,#(_tSetupPacket + 0x0006)
   055F E0                 1646 	movx	a,@dptr
   0560 FC                 1647 	mov	r4,a
   0561 7D 00              1648 	mov	r5,#0x00
                           1649 ;	tfirm.c 698
   0563 EC                 1650 	mov	a,r4
   0564 42 02              1651 	orl	ar2,a
   0566 ED                 1652 	mov	a,r5
   0567 42 03              1653 	orl	ar3,a
                           1654 ;	tfirm.c 702
   0569 C3                 1655 	clr	c
   056A E5 35              1656 	mov	a,_wBytesRemainingOnIEP0
   056C 9A                 1657 	subb	a,r2
   056D E5 36              1658 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   056F 9B                 1659 	subb	a,r3
                           1660 ; Peephole 132   changed ljmp to sjmp
                           1661 ; Peephole 160   removed sjmp by inverse jump logic
   0570 40 0B              1662 	jc   00102$
   0572                    1663 00107$:
                           1664 ;	tfirm.c 704
   0572 8A 35              1665 	mov	_wBytesRemainingOnIEP0,r2
   0574 8B 36              1666 	mov	(_wBytesRemainingOnIEP0 + 1),r3
                           1667 ;	tfirm.c 705
   0576 E4                 1668 	clr	a
   0577 F5 46              1669 	mov	(_bHostAskMoreDataThanAvailable + 1),a
   0579 F5 45              1670 	mov	_bHostAskMoreDataThanAvailable,a
                           1671 ; Peephole 132   changed ljmp to sjmp
   057B 80 06              1672 	sjmp 00103$
   057D                    1673 00102$:
                           1674 ;	tfirm.c 709
   057D E4                 1675 	clr	a
   057E F5 46              1676 	mov	(_bHostAskMoreDataThanAvailable + 1),a
   0580 75 45 01           1677 	mov	_bHostAskMoreDataThanAvailable,#0x01
   0583                    1678 00103$:
                           1679 ;	tfirm.c 712
   0583 12 04 AF           1680 	lcall	_usbSendNextPacketOnIEP0
   0586                    1681 00104$:
   0586 22                 1682 	ret
                           1683 ;------------------------------------------------------------
                           1684 ;Allocation info for local variables in function 'usbDecodeAndProcessUsbRequest'
                           1685 ;------------------------------------------------------------
                           1686 ;bMask                     Allocated to registers r6 
                           1687 ;bResult                   Allocated to registers r5 
                           1688 ;bTemp                     Allocated to registers 
                           1689 ;pbUsbRequestList          Allocated to registers r2 r3 r4 
                           1690 ;sloc0                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc0_1_0'
                           1691 ;sloc1                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc1_1_0'
                           1692 ;sloc2                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc2_1_0'
                           1693 ;sloc3                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc3_1_0'
                           1694 ;	tfirm.c 715
                           1695 ;	-----------------------------------------
                           1696 ;	 function usbDecodeAndProcessUsbRequest
                           1697 ;	-----------------------------------------
   0587                    1698 _usbDecodeAndProcessUsbRequest:
                           1699 ;	tfirm.c 723
   0587 7A 53              1700 	mov	r2,#_tUsbRequestList
   0589 7B 0E              1701 	mov	r3,#(_tUsbRequestList >> 8)
   058B 7C 02              1702 	mov	r4,#0x02
                           1703 ;	tfirm.c 728
   058D                    1704 00106$:
                           1705 ;	tfirm.c 730
   058D 7D 00              1706 	mov	r5,#0x00
                           1707 ;	tfirm.c 731
   058F 7E 80              1708 	mov	r6,#0x80
                           1709 ;	tfirm.c 738
   0591 7F 00              1710 	mov	r7,#0x00
   0593                    1711 00110$:
   0593 BF 08 00           1712 	cjne	r7,#0x08,00122$
   0596                    1713 00122$:
   0596 E4                 1714 	clr	a
   0597 33                 1715 	rlc	a
                           1716 ; Peephole 105   removed redundant mov
   0598 F8                 1717 	mov  r0,a
                           1718 ; Peephole 110   removed ljmp by inverse jump logic
   0599 60 38              1719 	jz  00113$
   059B                    1720 00123$:
                           1721 ;	tfirm.c 740
                           1722 ; Peephole 180   changed mov to clr
   059B E4                 1723 	clr  a
   059C 2F                 1724 	add	a,r7
   059D F5 82              1725 	mov	dpl,a
   059F 74 FF              1726 	mov	a,#0xFF
   05A1 34 00              1727 	addc	a,#0x00
   05A3 F5 83              1728 	mov	dph,a
   05A5 E0                 1729 	movx	a,@dptr
   05A6 F9                 1730 	mov	r1,a
   05A7 EF                 1731 	mov	a,r7
   05A8 2A                 1732 	add	a,r2
   05A9 F5 82              1733 	mov	dpl,a
                           1734 ; Peephole 180   changed mov to clr
   05AB E4                 1735 	clr  a
   05AC 3B                 1736 	addc	a,r3
   05AD F5 83              1737 	mov	dph,a
   05AF 8C F0              1738 	mov	b,r4
   05B1 12 10 47           1739 	lcall	__gptrget
   05B4 F5 53              1740 	mov	_usbDecodeAndProcessUsbRequest_sloc0_1_0,a
   05B6 89 54              1741 	mov	_usbDecodeAndProcessUsbRequest_sloc1_1_0,r1
   05B8 E5 54              1742 	mov	a,_usbDecodeAndProcessUsbRequest_sloc1_1_0
   05BA B5 53 04           1743 	cjne	a,_usbDecodeAndProcessUsbRequest_sloc0_1_0,00124$
   05BD 74 01              1744 	mov	a,#0x01
   05BF 80 01              1745 	sjmp	00125$
   05C1                    1746 00124$:
   05C1 E4                 1747 	clr	a
   05C2                    1748 00125$:
                           1749 ; Peephole 105   removed redundant mov
   05C2 F5 55              1750 	mov  _usbDecodeAndProcessUsbRequest_sloc2_1_0,a
                           1751 ; Peephole 110   removed ljmp by inverse jump logic
   05C4 60 03              1752 	jz  00102$
   05C6                    1753 00126$:
                           1754 ;	tfirm.c 741
   05C6 EE                 1755 	mov	a,r6
   05C7 4D                 1756 	orl	a,r5
   05C8 FD                 1757 	mov	r5,a
   05C9                    1758 00102$:
                           1759 ;	tfirm.c 742
   05C9 EE                 1760 	mov	a,r6
   05CA C3                 1761 	clr	c
   05CB 13                 1762 	rrc	a
   05CC F5 56              1763 	mov	_usbDecodeAndProcessUsbRequest_sloc3_1_0,a
   05CE AE 56              1764 	mov	r6,_usbDecodeAndProcessUsbRequest_sloc3_1_0
                           1765 ;	tfirm.c 738
   05D0 0F                 1766 	inc	r7
                           1767 ; Peephole 132   changed ljmp to sjmp
   05D1 80 C0              1768 	sjmp 00110$
   05D3                    1769 00113$:
                           1770 ;	tfirm.c 753
   05D3 EF                 1771 	mov	a,r7
   05D4 2A                 1772 	add	a,r2
   05D5 F5 82              1773 	mov	dpl,a
                           1774 ; Peephole 180   changed mov to clr
   05D7 E4                 1775 	clr  a
   05D8 3B                 1776 	addc	a,r3
   05D9 F5 83              1777 	mov	dph,a
   05DB 8C F0              1778 	mov	b,r4
   05DD 12 10 47           1779 	lcall	__gptrget
                           1780 ; Peephole 105   removed redundant mov
   05E0 FF                 1781 	mov  r7,a
   05E1 52 05              1782 	anl	ar5,a
   05E3 ED                 1783 	mov	a,r5
   05E4 B5 07 02           1784 	cjne	a,ar7,00127$
                           1785 ; Peephole 132   changed ljmp to sjmp
   05E7 80 0A              1786 	sjmp 00107$
   05E9                    1787 00127$:
                           1788 ;	tfirm.c 757
   05E9 74 0B              1789 	mov	a,#0x0B
   05EB 2A                 1790 	add	a,r2
   05EC FA                 1791 	mov	r2,a
                           1792 ; Peephole 180   changed mov to clr
   05ED E4                 1793 	clr  a
   05EE 3B                 1794 	addc	a,r3
   05EF FB                 1795 	mov	r3,a
   05F0 02 05 8D           1796 	ljmp	00106$
   05F3                    1797 00107$:
                           1798 ;	tfirm.c 762
                           1799 ; Peephole 182   used 16 bit load of dptr
   05F3 90 FF FE           1800 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   05F6 E0                 1801 	movx	a,@dptr
                           1802 ; Peephole 105   removed redundant mov
   05F7 FD                 1803 	mov  r5,a
   05F8 33                 1804 	rlc	a
   05F9 95 E0              1805 	subb	a,acc
   05FB FE                 1806 	mov	r6,a
   05FC ED                 1807 	mov	a,r5
                           1808 ; Peephole 111   removed ljmp by inverse jump logic
   05FD 30 E0 02           1809 	jnb  acc.0,00109$
   0600                    1810 00128$:
                           1811 ;	tfirm.c 763
                           1812 ; Peephole 132   changed ljmp to sjmp
   0600 80 21              1813 	sjmp 00114$
   0602                    1814 00109$:
                           1815 ;	tfirm.c 767
   0602 74 09              1816 	mov	a,#0x09
   0604 2A                 1817 	add	a,r2
   0605 F5 82              1818 	mov	dpl,a
                           1819 ; Peephole 180   changed mov to clr
   0607 E4                 1820 	clr  a
   0608 3B                 1821 	addc	a,r3
   0609 F5 83              1822 	mov	dph,a
   060B 8C F0              1823 	mov	b,r4
   060D 12 10 47           1824 	lcall	__gptrget
   0610 FA                 1825 	mov	r2,a
   0611 A3                 1826 	inc	dptr
   0612 12 10 47           1827 	lcall	__gptrget
   0615 FB                 1828 	mov	r3,a
   0616 74 23              1829 	mov	a,#00129$
   0618 C0 E0              1830 	push	acc
   061A 74 06              1831 	mov	a,#(00129$ >> 8)
   061C C0 E0              1832 	push	acc
   061E C0 02              1833 	push	ar2
   0620 C0 03              1834 	push	ar3
   0622 22                 1835 	ret
   0623                    1836 00129$:
   0623                    1837 00114$:
   0623 22                 1838 	ret
                           1839 ;------------------------------------------------------------
                           1840 ;Allocation info for local variables in function 'OEP0InterruptHandler'
                           1841 ;------------------------------------------------------------
                           1842 ;	tfirm.c 770
                           1843 ;	-----------------------------------------
                           1844 ;	 function OEP0InterruptHandler
                           1845 ;	-----------------------------------------
   0624                    1846 _OEP0InterruptHandler:
                           1847 ;	tfirm.c 772
   0624 90 FF 81           1848 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
                           1849 ; Peephole 180   changed mov to clr
   0627 E4                 1850 	clr  a
   0628 F0                 1851 	movx	@dptr,a
                           1852 ;	tfirm.c 780
   0629 E5 31              1853 	mov	a,_bStatusAction
                           1854 ; Peephole 132   changed ljmp to sjmp
                           1855 ; Peephole 199   optimized misc jump sequence
   062B B4 02 05           1856 	cjne a,#0x02,00102$
                           1857 ;00107$:
                           1858 ; Peephole 200   removed redundant sjmp
   062E                    1859 00108$:
                           1860 ;	tfirm.c 781
   062E 12 04 29           1861 	lcall	_usbReceiveNextPacketOnOEP0
                           1862 ; Peephole 132   changed ljmp to sjmp
   0631 80 0D              1863 	sjmp 00104$
   0633                    1864 00102$:
                           1865 ;	tfirm.c 783
   0633 90 FF 82           1866 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0636 E0                 1867 	movx	a,@dptr
   0637 FA                 1868 	mov	r2,a
   0638 43 02 08           1869 	orl	ar2,#0x08
   063B 90 FF 82           1870 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   063E EA                 1871 	mov	a,r2
   063F F0                 1872 	movx	@dptr,a
   0640                    1873 00104$:
   0640 22                 1874 	ret
                           1875 ;------------------------------------------------------------
                           1876 ;Allocation info for local variables in function 'IEP0InterruptHandler'
                           1877 ;------------------------------------------------------------
                           1878 ;	tfirm.c 786
                           1879 ;	-----------------------------------------
                           1880 ;	 function IEP0InterruptHandler
                           1881 ;	-----------------------------------------
   0641                    1882 _IEP0InterruptHandler:
                           1883 ;	tfirm.c 788
   0641 90 FF 83           1884 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1885 ; Peephole 180   changed mov to clr
   0644 E4                 1886 	clr  a
   0645 F0                 1887 	movx	@dptr,a
                           1888 ;	tfirm.c 796
   0646 E5 31              1889 	mov	a,_bStatusAction
                           1890 ; Peephole 132   changed ljmp to sjmp
                           1891 ; Peephole 199   optimized misc jump sequence
   0648 B4 01 05           1892 	cjne a,#0x01,00102$
                           1893 ;00107$:
                           1894 ; Peephole 200   removed redundant sjmp
   064B                    1895 00108$:
                           1896 ;	tfirm.c 797
   064B 12 04 AF           1897 	lcall	_usbSendNextPacketOnIEP0
                           1898 ; Peephole 132   changed ljmp to sjmp
   064E 80 0D              1899 	sjmp 00104$
   0650                    1900 00102$:
                           1901 ;	tfirm.c 803
   0650 90 FF 80           1902 	mov	dptr,#_tEndPoint0DescriptorBlock
   0653 E0                 1903 	movx	a,@dptr
   0654 FA                 1904 	mov	r2,a
   0655 43 02 08           1905 	orl	ar2,#0x08
   0658 90 FF 80           1906 	mov	dptr,#_tEndPoint0DescriptorBlock
   065B EA                 1907 	mov	a,r2
   065C F0                 1908 	movx	@dptr,a
   065D                    1909 00104$:
   065D 22                 1910 	ret
                           1911 ;------------------------------------------------------------
                           1912 ;Allocation info for local variables in function 'OEP1InterruptHandler'
                           1913 ;------------------------------------------------------------
                           1914 ;bSize                     Allocated to registers r2 
                           1915 ;bTemp                     Allocated to registers 
                           1916 ;xmt_size                  Allocated to in memory with name '_OEP1InterruptHandler_xmt_size_1_1'
                           1917 ;rcv_size                  Allocated to in memory with name '_OEP1InterruptHandler_rcv_size_1_1'
                           1918 ;	tfirm.c 807
                           1919 ;	-----------------------------------------
                           1920 ;	 function OEP1InterruptHandler
                           1921 ;	-----------------------------------------
   065E                    1922 _OEP1InterruptHandler:
                           1923 ;	tfirm.c 813
                           1924 ; Peephole 182   used 16 bit load of dptr
   065E 90 FF 4A           1925 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0661 74 80              1926 	mov	a,#0x80
   0663 F0                 1927 	movx	@dptr,a
                           1928 ;	tfirm.c 817
   0664 E5 4C              1929 	mov	a,_bOEP1RecieveLength
                           1930 ; Peephole 162   removed sjmp by inverse jump logic
   0666 60 02              1931 	jz   00135$
   0668                    1932 00134$:
                           1933 ; Peephole 132   changed ljmp to sjmp
   0668 80 33              1934 	sjmp 00102$
   066A                    1935 00135$:
                           1936 ;	tfirm.c 818
   066A 90 FD 81           1937 	mov	dptr,#(_pbOEP1XBufferAddress + 0x0001)
   066D E0                 1938 	movx	a,@dptr
   066E F5 4C              1939 	mov	_bOEP1RecieveLength,a
                           1940 ;	tfirm.c 819
   0670 90 FF 0A           1941 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
   0673 E0                 1942 	movx	a,@dptr
   0674 FA                 1943 	mov	r2,a
   0675 53 02 7F           1944 	anl	ar2,#0x7F
                           1945 ;	tfirm.c 820
   0678 7B 00              1946 	mov	r3,#0x00
   067A                    1947 00116$:
   067A C3                 1948 	clr	c
   067B EB                 1949 	mov	a,r3
   067C 9A                 1950 	subb	a,r2
                           1951 ; Peephole 108   removed ljmp by inverse jump logic
   067D 50 17              1952 	jnc  00119$
   067F                    1953 00136$:
                           1954 ;	tfirm.c 821
   067F E5 4D              1955 	mov	a,_bOEP1SaveBufferPosition
   0681 24 80              1956 	add	a,#_abOEP1SaveBuffer
   0683 F8                 1957 	mov	r0,a
   0684 EB                 1958 	mov	a,r3
   0685 24 80              1959 	add	a,#_pbOEP1XBufferAddress
   0687 F5 82              1960 	mov	dpl,a
                           1961 ; Peephole 180   changed mov to clr
   0689 E4                 1962 	clr  a
   068A 34 FD              1963 	addc	a,#(_pbOEP1XBufferAddress >> 8)
   068C F5 83              1964 	mov	dph,a
   068E E0                 1965 	movx	a,@dptr
                           1966 ; Peephole 192   used a instead of ar4 as source
   068F FC                 1967 	mov  r4,a
   0690 F6                 1968 	mov  @r0,a
                           1969 ;	tfirm.c 823
   0691 05 4D              1970 	inc	_bOEP1SaveBufferPosition
                           1971 ;	tfirm.c 820
   0693 0B                 1972 	inc	r3
                           1973 ; Peephole 132   changed ljmp to sjmp
   0694 80 E4              1974 	sjmp 00116$
   0696                    1975 00119$:
                           1976 ;	tfirm.c 825
   0696 90 FF 0A           1977 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
                           1978 ; Peephole 180   changed mov to clr
   0699 E4                 1979 	clr  a
   069A F0                 1980 	movx	@dptr,a
                           1981 ; Peephole 132   changed ljmp to sjmp
   069B 80 2C              1982 	sjmp 00103$
   069D                    1983 00102$:
                           1984 ;	tfirm.c 830
   069D 90 FF 0A           1985 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
   06A0 E0                 1986 	movx	a,@dptr
   06A1 FB                 1987 	mov	r3,a
   06A2 74 7F              1988 	mov	a,#0x7F
   06A4 5B                 1989 	anl	a,r3
   06A5 FA                 1990 	mov	r2,a
                           1991 ;	tfirm.c 831
   06A6 7B 00              1992 	mov	r3,#0x00
   06A8                    1993 00120$:
   06A8 C3                 1994 	clr	c
   06A9 EB                 1995 	mov	a,r3
   06AA 9A                 1996 	subb	a,r2
                           1997 ; Peephole 108   removed ljmp by inverse jump logic
   06AB 50 17              1998 	jnc  00123$
   06AD                    1999 00137$:
                           2000 ;	tfirm.c 832
   06AD E5 4D              2001 	mov	a,_bOEP1SaveBufferPosition
   06AF 24 80              2002 	add	a,#_abOEP1SaveBuffer
   06B1 F8                 2003 	mov	r0,a
   06B2 EB                 2004 	mov	a,r3
   06B3 24 80              2005 	add	a,#_pbOEP1XBufferAddress
   06B5 F5 82              2006 	mov	dpl,a
                           2007 ; Peephole 180   changed mov to clr
   06B7 E4                 2008 	clr  a
   06B8 34 FD              2009 	addc	a,#(_pbOEP1XBufferAddress >> 8)
   06BA F5 83              2010 	mov	dph,a
   06BC E0                 2011 	movx	a,@dptr
                           2012 ; Peephole 192   used a instead of ar4 as source
   06BD FC                 2013 	mov  r4,a
   06BE F6                 2014 	mov  @r0,a
                           2015 ;	tfirm.c 834
   06BF 05 4D              2016 	inc	_bOEP1SaveBufferPosition
                           2017 ;	tfirm.c 831
   06C1 0B                 2018 	inc	r3
                           2019 ; Peephole 132   changed ljmp to sjmp
   06C2 80 E4              2020 	sjmp 00120$
   06C4                    2021 00123$:
                           2022 ;	tfirm.c 836
   06C4 90 FF 0A           2023 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
                           2024 ; Peephole 180   changed mov to clr
   06C7 E4                 2025 	clr  a
   06C8 F0                 2026 	movx	@dptr,a
   06C9                    2027 00103$:
                           2028 ;	tfirm.c 841
   06C9 C3                 2029 	clr	c
   06CA E5 4D              2030 	mov	a,_bOEP1SaveBufferPosition
   06CC 95 4C              2031 	subb	a,_bOEP1RecieveLength
                           2032 ; Peephole 108   removed ljmp by inverse jump logic
   06CE 50 02              2033 	jnc  00105$
   06D0                    2034 00138$:
                           2035 ;	tfirm.c 842
                           2036 ; Peephole 132   changed ljmp to sjmp
   06D0 80 5C              2037 	sjmp 00124$
   06D2                    2038 00105$:
                           2039 ;	tfirm.c 844
   06D2 75 4C 00           2040 	mov	_bOEP1RecieveLength,#0x00
                           2041 ;	tfirm.c 846
   06D5 75 4D 00           2042 	mov	_bOEP1SaveBufferPosition,#0x00
                           2043 ;	tfirm.c 848
   06D8 78 80              2044 	mov	r0,#_abOEP1SaveBuffer
   06DA 86 02              2045 	mov	ar2,@r0
   06DC BA 01 00           2046 	cjne	r2,#0x01,00139$
   06DF                    2047 00139$:
                           2048 ; Peephole 132   changed ljmp to sjmp
                           2049 ; Peephole 160   removed sjmp by inverse jump logic
   06DF 40 4D              2050 	jc   00115$
   06E1                    2051 00140$:
   06E1 C3                 2052 	clr	c
   06E2 74 08              2053 	mov	a,#0x08
   06E4 9A                 2054 	subb	a,r2
                           2055 ; Peephole 132   changed ljmp to sjmp
                           2056 ; Peephole 160   removed sjmp by inverse jump logic
   06E5 40 47              2057 	jc   00115$
   06E7                    2058 00141$:
   06E7 1A                 2059 	dec	r2
   06E8 EA                 2060 	mov	a,r2
   06E9 25 E0              2061 	add	a,acc
   06EB 2A                 2062 	add	a,r2
   06EC 90 06 F0           2063 	mov	dptr,#00142$
   06EF 73                 2064 	jmp	@a+dptr
   06F0                    2065 00142$:
   06F0 02 07 08           2066 	ljmp	00106$
   06F3 02 07 0D           2067 	ljmp	00107$
   06F6 02 07 12           2068 	ljmp	00108$
   06F9 02 07 17           2069 	ljmp	00109$
   06FC 02 07 1C           2070 	ljmp	00110$
   06FF 02 07 21           2071 	ljmp	00111$
   0702 02 07 26           2072 	ljmp	00112$
   0705 02 07 2B           2073 	ljmp	00113$
                           2074 ;	tfirm.c 851
   0708                    2075 00106$:
   0708 12 0F 50           2076 	lcall	_fn_cmd_01
                           2077 ;	tfirm.c 852
                           2078 ;	tfirm.c 855
                           2079 ; Peephole 132   changed ljmp to sjmp
   070B 80 21              2080 	sjmp 00115$
   070D                    2081 00107$:
   070D 12 0F 5D           2082 	lcall	_fn_cmd_02
                           2083 ;	tfirm.c 856
                           2084 ;	tfirm.c 859
                           2085 ; Peephole 132   changed ljmp to sjmp
   0710 80 1C              2086 	sjmp 00115$
   0712                    2087 00108$:
   0712 12 0F 87           2088 	lcall	_fn_cmd_03
                           2089 ;	tfirm.c 860
                           2090 ;	tfirm.c 863
                           2091 ; Peephole 132   changed ljmp to sjmp
   0715 80 17              2092 	sjmp 00115$
   0717                    2093 00109$:
   0717 12 0F BF           2094 	lcall	_fn_cmd_04
                           2095 ;	tfirm.c 864
                           2096 ;	tfirm.c 867
                           2097 ; Peephole 132   changed ljmp to sjmp
   071A 80 12              2098 	sjmp 00115$
   071C                    2099 00110$:
   071C 12 10 0E           2100 	lcall	_fn_cmd_05
                           2101 ;	tfirm.c 868
                           2102 ;	tfirm.c 871
                           2103 ; Peephole 132   changed ljmp to sjmp
   071F 80 0D              2104 	sjmp 00115$
   0721                    2105 00111$:
   0721 12 10 0F           2106 	lcall	_fn_cmd_06
                           2107 ;	tfirm.c 872
                           2108 ;	tfirm.c 875
                           2109 ; Peephole 132   changed ljmp to sjmp
   0724 80 08              2110 	sjmp 00115$
   0726                    2111 00112$:
   0726 12 10 10           2112 	lcall	_fn_cmd_07
                           2113 ;	tfirm.c 876
                           2114 ;	tfirm.c 879
                           2115 ; Peephole 132   changed ljmp to sjmp
   0729 80 03              2116 	sjmp 00115$
   072B                    2117 00113$:
   072B 12 10 11           2118 	lcall	_fn_cmd_08
                           2119 ;	tfirm.c 884
   072E                    2120 00115$:
                           2121 ;	tfirm.c 886
   072E                    2122 00124$:
   072E 22                 2123 	ret
                           2124 ;------------------------------------------------------------
                           2125 ;Allocation info for local variables in function 'IEP1InterruptHandler'
                           2126 ;------------------------------------------------------------
                           2127 ;	tfirm.c 890
                           2128 ;	-----------------------------------------
                           2129 ;	 function IEP1InterruptHandler
                           2130 ;	-----------------------------------------
   072F                    2131 _IEP1InterruptHandler:
                           2132 ;	tfirm.c 891
   072F                    2133 00101$:
   072F 22                 2134 	ret
                           2135 ;------------------------------------------------------------
                           2136 ;Allocation info for local variables in function 'SetupPacketInterruptHandler'
                           2137 ;------------------------------------------------------------
                           2138 ;	tfirm.c 894
                           2139 ;	-----------------------------------------
                           2140 ;	 function SetupPacketInterruptHandler
                           2141 ;	-----------------------------------------
   0730                    2142 _SetupPacketInterruptHandler:
                           2143 ;	tfirm.c 897
   0730 90 FF 81           2144 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
   0733 74 80              2145 	mov	a,#0x80
   0735 F0                 2146 	movx	@dptr,a
                           2147 ;	tfirm.c 898
   0736 90 FF 83           2148 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
   0739 74 80              2149 	mov	a,#0x80
   073B F0                 2150 	movx	@dptr,a
                           2151 ;	tfirm.c 900
                           2152 ; Peephole 182   used 16 bit load of dptr
   073C 90 FF FE           2153 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   073F 74 04              2154 	mov	a,#0x04
   0741 F0                 2155 	movx	@dptr,a
                           2156 ;	tfirm.c 904
   0742 90 FF 00           2157 	mov	dptr,#_tSetupPacket
   0745 E0                 2158 	movx	a,@dptr
   0746 FA                 2159 	mov	r2,a
   0747 53 02 80           2160 	anl	ar2,#0x80
                           2161 ; Peephole 132   changed ljmp to sjmp
                           2162 ; Peephole 199   optimized misc jump sequence
   074A BA 80 14           2163 	cjne r2,#0x80,00102$
                           2164 ;00107$:
                           2165 ; Peephole 200   removed redundant sjmp
   074D                    2166 00108$:
                           2167 ;	tfirm.c 905
   074D 7A FC              2168 	mov	r2,#0xFC
   074F 7B FF              2169 	mov	r3,#0xFF
                           2170 ; Peephole 182   used 16 bit load of dptr
   0751 90 FF FC           2171 	mov  dptr,#(((0xFF)<<8) + 0xFC)
   0754 E0                 2172 	movx	a,@dptr
   0755 FC                 2173 	mov	r4,a
   0756 43 04 01           2174 	orl	ar4,#0x01
   0759 8A 82              2175 	mov	dpl,r2
   075B 8B 83              2176 	mov	dph,r3
   075D EC                 2177 	mov	a,r4
   075E F0                 2178 	movx	@dptr,a
                           2179 ; Peephole 132   changed ljmp to sjmp
   075F 80 12              2180 	sjmp 00103$
   0761                    2181 00102$:
                           2182 ;	tfirm.c 907
   0761 7A FC              2183 	mov	r2,#0xFC
   0763 7B FF              2184 	mov	r3,#0xFF
                           2185 ; Peephole 182   used 16 bit load of dptr
   0765 90 FF FC           2186 	mov  dptr,#(((0xFF)<<8) + 0xFC)
   0768 E0                 2187 	movx	a,@dptr
   0769 FC                 2188 	mov	r4,a
   076A 53 04 FE           2189 	anl	ar4,#0xFE
   076D 8A 82              2190 	mov	dpl,r2
   076F 8B 83              2191 	mov	dph,r3
   0771 EC                 2192 	mov	a,r4
   0772 F0                 2193 	movx	@dptr,a
   0773                    2194 00103$:
                           2195 ;	tfirm.c 912
   0773 75 31 00           2196 	mov	_bStatusAction,#0x00
                           2197 ;	tfirm.c 916
   0776 12 05 87           2198 	lcall	_usbDecodeAndProcessUsbRequest
   0779                    2199 00104$:
   0779 22                 2200 	ret
                           2201 ;------------------------------------------------------------
                           2202 ;Allocation info for local variables in function 'usbISR'
                           2203 ;------------------------------------------------------------
                           2204 ;	tfirm.c 920
                           2205 ;	-----------------------------------------
                           2206 ;	 function usbISR
                           2207 ;	-----------------------------------------
   077A                    2208 _usbISR:
   077A C0 E0              2209 	push	acc
   077C C0 F0              2210 	push	b
   077E C0 82              2211 	push	dpl
   0780 C0 83              2212 	push	dph
   0782 C0 02              2213 	push	(0+2)
   0784 C0 03              2214 	push	(0+3)
   0786 C0 04              2215 	push	(0+4)
   0788 C0 05              2216 	push	(0+5)
   078A C0 06              2217 	push	(0+6)
   078C C0 07              2218 	push	(0+7)
   078E C0 00              2219 	push	(0+0)
   0790 C0 01              2220 	push	(0+1)
   0792 C0 D0              2221 	push	psw
   0794 75 D0 00           2222 	mov	psw,#0x00
                           2223 ;	tfirm.c 921
   0797 C2 AF              2224 	clr	_EA
                           2225 ;	tfirm.c 923
                           2226 ; Peephole 182   used 16 bit load of dptr
   0799 90 FF 92           2227 	mov  dptr,#(((0xFF)<<8) + 0x92)
   079C E0                 2228 	movx	a,@dptr
   079D FA                 2229 	mov	r2,a
   079E 8A 03              2230 	mov	ar3,r2
   07A0 BB 12 02           2231 	cjne	r3,#0x12,00123$
                           2232 ; Peephole 132   changed ljmp to sjmp
   07A3 80 53              2233 	sjmp 00103$
   07A5                    2234 00123$:
   07A5 8A 03              2235 	mov	ar3,r2
   07A7 BB 22 02           2236 	cjne	r3,#0x22,00124$
                           2237 ; Peephole 132   changed ljmp to sjmp
   07AA 80 57              2238 	sjmp 00104$
   07AC                    2239 00124$:
   07AC 8A 03              2240 	mov	ar3,r2
   07AE BB 30 02           2241 	cjne	r3,#0x30,00125$
                           2242 ; Peephole 132   changed ljmp to sjmp
   07B1 80 58              2243 	sjmp 00105$
   07B3                    2244 00125$:
   07B3 8A 03              2245 	mov	ar3,r2
   07B5 BB 32 03           2246 	cjne	r3,#0x32,00126$
   07B8 02 08 1C           2247 	ljmp	00106$
   07BB                    2248 00126$:
   07BB 8A 03              2249 	mov	ar3,r2
   07BD BB 38 03           2250 	cjne	r3,#0x38,00127$
   07C0 02 08 3F           2251 	ljmp	00108$
   07C3                    2252 00127$:
   07C3 8A 03              2253 	mov	ar3,r2
   07C5 BB 3A 03           2254 	cjne	r3,#0x3A,00128$
   07C8 02 08 52           2255 	ljmp	00109$
   07CB                    2256 00128$:
   07CB 8A 03              2257 	mov	ar3,r2
   07CD BB 3C 03           2258 	cjne	r3,#0x3C,00129$
   07D0 02 08 2C           2259 	ljmp	00107$
   07D3                    2260 00129$:
   07D3 8A 03              2261 	mov	ar3,r2
   07D5 BB 44 02           2262 	cjne	r3,#0x44,00130$
                           2263 ; Peephole 132   changed ljmp to sjmp
   07D8 80 13              2264 	sjmp 00102$
   07DA                    2265 00130$:
   07DA BA 46 02           2266 	cjne	r2,#0x46,00131$
   07DD 80 03              2267 	sjmp	00132$
   07DF                    2268 00131$:
   07DF 02 08 65           2269 	ljmp	00110$
   07E2                    2270 00132$:
                           2271 ;	tfirm.c 926
                           2272 ; Peephole 182   used 16 bit load of dptr
   07E2 90 FF 92           2273 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2274 ; Peephole 180   changed mov to clr
   07E5 E4                 2275 	clr  a
   07E6 F0                 2276 	movx	@dptr,a
                           2277 ;	tfirm.c 927
   07E7 12 06 24           2278 	lcall	_OEP0InterruptHandler
                           2279 ;	tfirm.c 928
   07EA 02 08 6D           2280 	ljmp	00111$
                           2281 ;	tfirm.c 931
   07ED                    2282 00102$:
                           2283 ; Peephole 182   used 16 bit load of dptr
   07ED 90 FF 92           2284 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2285 ; Peephole 180   changed mov to clr
   07F0 E4                 2286 	clr  a
   07F1 F0                 2287 	movx	@dptr,a
                           2288 ;	tfirm.c 932
   07F2 12 06 41           2289 	lcall	_IEP0InterruptHandler
                           2290 ;	tfirm.c 933
   07F5 02 08 6D           2291 	ljmp	00111$
                           2292 ;	tfirm.c 936
   07F8                    2293 00103$:
                           2294 ; Peephole 182   used 16 bit load of dptr
   07F8 90 FF 92           2295 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2296 ; Peephole 180   changed mov to clr
   07FB E4                 2297 	clr  a
   07FC F0                 2298 	movx	@dptr,a
                           2299 ;	tfirm.c 937
   07FD 12 06 5E           2300 	lcall	_OEP1InterruptHandler
                           2301 ;	tfirm.c 939
   0800 02 08 6D           2302 	ljmp	00111$
                           2303 ;	tfirm.c 942
   0803                    2304 00104$:
                           2305 ; Peephole 182   used 16 bit load of dptr
   0803 90 FF 92           2306 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2307 ; Peephole 180   changed mov to clr
   0806 E4                 2308 	clr  a
   0807 F0                 2309 	movx	@dptr,a
                           2310 ;	tfirm.c 945
   0808 02 08 6D           2311 	ljmp	00111$
                           2312 ;	tfirm.c 948
   080B                    2313 00105$:
                           2314 ; Peephole 182   used 16 bit load of dptr
   080B 90 FF 92           2315 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2316 ; Peephole 180   changed mov to clr
   080E E4                 2317 	clr  a
   080F F0                 2318 	movx	@dptr,a
                           2319 ;	tfirm.c 949
                           2320 ; Peephole 182   used 16 bit load of dptr
   0810 90 FF FE           2321 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   0813 74 01              2322 	mov	a,#0x01
   0815 F0                 2323 	movx	@dptr,a
                           2324 ;	tfirm.c 950
   0816 12 07 30           2325 	lcall	_SetupPacketInterruptHandler
                           2326 ;	tfirm.c 951
   0819 02 08 6D           2327 	ljmp	00111$
                           2328 ;	tfirm.c 954
   081C                    2329 00106$:
                           2330 ; Peephole 182   used 16 bit load of dptr
   081C 90 FF 92           2331 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2332 ; Peephole 180   changed mov to clr
   081F E4                 2333 	clr  a
   0820 F0                 2334 	movx	@dptr,a
                           2335 ;	tfirm.c 955
                           2336 ; Peephole 182   used 16 bit load of dptr
   0821 90 FF FE           2337 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   0824 74 04              2338 	mov	a,#0x04
   0826 F0                 2339 	movx	@dptr,a
                           2340 ;	tfirm.c 956
   0827 12 07 30           2341 	lcall	_SetupPacketInterruptHandler
                           2342 ;	tfirm.c 957
                           2343 ;	tfirm.c 960
                           2344 ; Peephole 132   changed ljmp to sjmp
   082A 80 41              2345 	sjmp 00111$
   082C                    2346 00107$:
   082C 75 82 92           2347 	mov	dpl,#0x92
   082F 75 83 FF           2348 	mov	dph,#0xFF
                           2349 ; Peephole 180   changed mov to clr
   0832 E4                 2350 	clr  a
   0833 F0                 2351 	movx	@dptr,a
                           2352 ;	tfirm.c 961
                           2353 ; Peephole 182   used 16 bit load of dptr
   0834 90 FF FE           2354 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   0837 74 80              2355 	mov	a,#0x80
   0839 F0                 2356 	movx	@dptr,a
                           2357 ;	tfirm.c 962
   083A 12 03 25           2358 	lcall	_usbReset
                           2359 ;	tfirm.c 964
                           2360 ;	tfirm.c 967
                           2361 ; Peephole 132   changed ljmp to sjmp
   083D 80 2E              2362 	sjmp 00111$
   083F                    2363 00108$:
   083F 75 82 92           2364 	mov	dpl,#0x92
   0842 75 83 FF           2365 	mov	dph,#0xFF
                           2366 ; Peephole 180   changed mov to clr
   0845 E4                 2367 	clr  a
   0846 F0                 2368 	movx	@dptr,a
                           2369 ;	tfirm.c 968
                           2370 ; Peephole 182   used 16 bit load of dptr
   0847 90 FF FE           2371 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   084A 74 20              2372 	mov	a,#0x20
   084C F0                 2373 	movx	@dptr,a
                           2374 ;	tfirm.c 969
   084D 75 41 00           2375 	mov	_bSuspended,#0x00
                           2376 ;	tfirm.c 970
                           2377 ;	tfirm.c 973
                           2378 ; Peephole 132   changed ljmp to sjmp
   0850 80 1B              2379 	sjmp 00111$
   0852                    2380 00109$:
   0852 75 82 92           2381 	mov	dpl,#0x92
   0855 75 83 FF           2382 	mov	dph,#0xFF
                           2383 ; Peephole 180   changed mov to clr
   0858 E4                 2384 	clr  a
   0859 F0                 2385 	movx	@dptr,a
                           2386 ;	tfirm.c 974
                           2387 ; Peephole 182   used 16 bit load of dptr
   085A 90 FF FE           2388 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   085D 74 40              2389 	mov	a,#0x40
   085F F0                 2390 	movx	@dptr,a
                           2391 ;	tfirm.c 975
   0860 75 41 01           2392 	mov	_bSuspended,#0x01
                           2393 ;	tfirm.c 976
                           2394 ;	tfirm.c 979
                           2395 ; Peephole 132   changed ljmp to sjmp
   0863 80 08              2396 	sjmp 00111$
   0865                    2397 00110$:
   0865 75 82 92           2398 	mov	dpl,#0x92
   0868 75 83 FF           2399 	mov	dph,#0xFF
                           2400 ; Peephole 180   changed mov to clr
   086B E4                 2401 	clr  a
   086C F0                 2402 	movx	@dptr,a
                           2403 ;	tfirm.c 981
   086D                    2404 00111$:
                           2405 ;	tfirm.c 983
   086D D2 AF              2406 	setb	_EA
   086F                    2407 00112$:
   086F D0 D0              2408 	pop	psw
   0871 D0 01              2409 	pop	(0+1)
   0873 D0 00              2410 	pop	(0+0)
   0875 D0 07              2411 	pop	(0+7)
   0877 D0 06              2412 	pop	(0+6)
   0879 D0 05              2413 	pop	(0+5)
   087B D0 04              2414 	pop	(0+4)
   087D D0 03              2415 	pop	(0+3)
   087F D0 02              2416 	pop	(0+2)
   0881 D0 83              2417 	pop	dph
   0883 D0 82              2418 	pop	dpl
   0885 D0 F0              2419 	pop	b
   0887 D0 E0              2420 	pop	acc
   0889 32                 2421 	reti
                           2422 ;------------------------------------------------------------
                           2423 ;Allocation info for local variables in function 'main'
                           2424 ;------------------------------------------------------------
                           2425 ;i                         Allocated to registers 
                           2426 ;temp_dig                  Allocated to registers r2 
                           2427 ;	tfirm.c 987
                           2428 ;	-----------------------------------------
                           2429 ;	 function main
                           2430 ;	-----------------------------------------
   088A                    2431 _main:
                           2432 ;	tfirm.c 992
                           2433 ; Peephole 182   used 16 bit load of dptr
   088A 90 FF 94           2434 	mov  dptr,#(((0xFF)<<8) + 0x94)
                           2435 ; Peephole 180   changed mov to clr
   088D E4                 2436 	clr  a
   088E F0                 2437 	movx	@dptr,a
                           2438 ;	tfirm.c 993
                           2439 ; Peephole 182   used 16 bit load of dptr
   088F 90 FF 95           2440 	mov  dptr,#(((0xFF)<<8) + 0x95)
                           2441 ; Peephole 180   changed mov to clr
   0892 E4                 2442 	clr  a
   0893 F0                 2443 	movx	@dptr,a
                           2444 ;	tfirm.c 994
                           2445 ; Peephole 182   used 16 bit load of dptr
   0894 90 FF 96           2446 	mov  dptr,#(((0xFF)<<8) + 0x96)
   0897 74 FF              2447 	mov	a,#0xFF
   0899 F0                 2448 	movx	@dptr,a
                           2449 ;	tfirm.c 995
                           2450 ; Peephole 182   used 16 bit load of dptr
   089A 90 FF 97           2451 	mov  dptr,#(((0xFF)<<8) + 0x97)
   089D 74 80              2452 	mov	a,#0x80
   089F F0                 2453 	movx	@dptr,a
                           2454 ;	tfirm.c 997
   08A0 75 B0 FF           2455 	mov	_P3,#0xFF
                           2456 ;	tfirm.c 998
   08A3 75 A0 FF           2457 	mov	_P2,#0xFF
                           2458 ;	tfirm.c 999
   08A6 75 90 FF           2459 	mov	_P1,#0xFF
                           2460 ;	tfirm.c 1001
   08A9 53 A8 F5           2461 	anl	_IE,#0xF5
                           2462 ;	tfirm.c 1003
   08AC D2 B2              2463 	setb	_P3_2
                           2464 ;	tfirm.c 1005
   08AE 12 03 E2           2465 	lcall	_SystemInitialization
                           2466 ;	tfirm.c 1007
   08B1 75 80 FF           2467 	mov	_P0,#0xFF
                           2468 ;	tfirm.c 1008
   08B4 75 90 FF           2469 	mov	_P1,#0xFF
                           2470 ;	tfirm.c 1010
   08B7                    2471 00102$:
                           2472 ;	tfirm.c 1013
   08B7 C2 83              2473 	clr	_P0_3
                           2474 ;	tfirm.c 1014
   08B9 D2 82              2475 	setb	_P0_2
                           2476 ;	tfirm.c 1015
   08BB D2 81              2477 	setb	_P0_1
                           2478 ;	tfirm.c 1016
   08BD D2 94              2479 	setb	_P1_4
                           2480 ;	tfirm.c 1017
   08BF D2 93              2481 	setb	_P1_3
                           2482 ;	tfirm.c 1018
   08C1 D2 92              2483 	setb	_P1_2
                           2484 ;	tfirm.c 1022
   08C3 E5 57              2485 	mov	a,_nixie_digits
   08C5 F4                 2486 	cpl	a
                           2487 ; Peephole 105   removed redundant mov
   08C6 FA                 2488 	mov  r2,a
   08C7 64 02              2489 	xrl	a,#0x02
   08C9 C0 E0              2490 	push	acc
   08CB 74 02              2491 	mov	a,#0x02
   08CD 30 E7 02           2492 	jnb	acc.7,00143$
   08D0 F4                 2493 	cpl	a
   08D1 04                 2494 	inc	a
   08D2                    2495 00143$:
   08D2 F5 F0              2496 	mov	b,a
   08D4 EA                 2497 	mov	a,r2
   08D5 30 E7 02           2498 	jnb	acc.7,00144$
   08D8 F4                 2499 	cpl	a
   08D9 04                 2500 	inc	a
   08DA                    2501 00144$:
   08DA 84                 2502 	div	ab
   08DB D0 E0              2503 	pop	acc
   08DD 20 D2 09           2504 	jb	ov,00145$
   08E0 30 E7 06           2505 	jnb	acc.7,00145$
   08E3 C3                 2506 	clr	c
   08E4 E4                 2507 	clr	a
   08E5 95 F0              2508 	subb	a,b
   08E7 F5 F0              2509 	mov	b,a
   08E9                    2510 00145$:
   08E9 E5 F0              2511 	mov	a,b
   08EB C3                 2512 	clr	c; oops
   08EC 60 01              2513 	jz	00146$
   08EE B3                 2514 	cpl	c
   08EF                    2515 00146$:
   08EF 92 80              2516 	mov	_P0_0,c
                           2517 ;	tfirm.c 1023
   08F1 E5 57              2518 	mov	a,_nixie_digits
   08F3 A2 E7              2519 	mov	c,acc.7
   08F5 13                 2520 	rrc	a
                           2521 ;	tfirm.c 1024
                           2522 ; Peephole 105   removed redundant mov
   08F6 FA                 2523 	mov  r2,a
   08F7 F4                 2524 	cpl	a
                           2525 ; Peephole 105   removed redundant mov
   08F8 FB                 2526 	mov  r3,a
   08F9 64 02              2527 	xrl	a,#0x02
   08FB C0 E0              2528 	push	acc
   08FD 74 02              2529 	mov	a,#0x02
   08FF 30 E7 02           2530 	jnb	acc.7,00147$
   0902 F4                 2531 	cpl	a
   0903 04                 2532 	inc	a
   0904                    2533 00147$:
   0904 F5 F0              2534 	mov	b,a
   0906 EB                 2535 	mov	a,r3
   0907 30 E7 02           2536 	jnb	acc.7,00148$
   090A F4                 2537 	cpl	a
   090B 04                 2538 	inc	a
   090C                    2539 00148$:
   090C 84                 2540 	div	ab
   090D D0 E0              2541 	pop	acc
   090F 20 D2 09           2542 	jb	ov,00149$
   0912 30 E7 06           2543 	jnb	acc.7,00149$
   0915 C3                 2544 	clr	c
   0916 E4                 2545 	clr	a
   0917 95 F0              2546 	subb	a,b
   0919 F5 F0              2547 	mov	b,a
   091B                    2548 00149$:
   091B E5 F0              2549 	mov	a,b
   091D C3                 2550 	clr	c; oops
   091E 60 01              2551 	jz	00150$
   0920 B3                 2552 	cpl	c
   0921                    2553 00150$:
   0921 92 96              2554 	mov	_P1_6,c
                           2555 ;	tfirm.c 1025
   0923 EA                 2556 	mov	a,r2
   0924 A2 E7              2557 	mov	c,acc.7
   0926 13                 2558 	rrc	a
                           2559 ;	tfirm.c 1026
                           2560 ; Peephole 105   removed redundant mov
   0927 FA                 2561 	mov  r2,a
   0928 F4                 2562 	cpl	a
                           2563 ; Peephole 105   removed redundant mov
   0929 FB                 2564 	mov  r3,a
   092A 64 02              2565 	xrl	a,#0x02
   092C C0 E0              2566 	push	acc
   092E 74 02              2567 	mov	a,#0x02
   0930 30 E7 02           2568 	jnb	acc.7,00151$
   0933 F4                 2569 	cpl	a
   0934 04                 2570 	inc	a
   0935                    2571 00151$:
   0935 F5 F0              2572 	mov	b,a
   0937 EB                 2573 	mov	a,r3
   0938 30 E7 02           2574 	jnb	acc.7,00152$
   093B F4                 2575 	cpl	a
   093C 04                 2576 	inc	a
   093D                    2577 00152$:
   093D 84                 2578 	div	ab
   093E D0 E0              2579 	pop	acc
   0940 20 D2 09           2580 	jb	ov,00153$
   0943 30 E7 06           2581 	jnb	acc.7,00153$
   0946 C3                 2582 	clr	c
   0947 E4                 2583 	clr	a
   0948 95 F0              2584 	subb	a,b
   094A F5 F0              2585 	mov	b,a
   094C                    2586 00153$:
   094C E5 F0              2587 	mov	a,b
   094E C3                 2588 	clr	c; oops
   094F 60 01              2589 	jz	00154$
   0951 B3                 2590 	cpl	c
   0952                    2591 00154$:
   0952 92 95              2592 	mov	_P1_5,c
                           2593 ;	tfirm.c 1027
   0954 EA                 2594 	mov	a,r2
   0955 A2 E7              2595 	mov	c,acc.7
   0957 13                 2596 	rrc	a
                           2597 ;	tfirm.c 1028
                           2598 ; Peephole 105   removed redundant mov
   0958 FA                 2599 	mov  r2,a
   0959 F4                 2600 	cpl	a
                           2601 ; Peephole 105   removed redundant mov
   095A FB                 2602 	mov  r3,a
   095B 64 02              2603 	xrl	a,#0x02
   095D C0 E0              2604 	push	acc
   095F 74 02              2605 	mov	a,#0x02
   0961 30 E7 02           2606 	jnb	acc.7,00155$
   0964 F4                 2607 	cpl	a
   0965 04                 2608 	inc	a
   0966                    2609 00155$:
   0966 F5 F0              2610 	mov	b,a
   0968 EB                 2611 	mov	a,r3
   0969 30 E7 02           2612 	jnb	acc.7,00156$
   096C F4                 2613 	cpl	a
   096D 04                 2614 	inc	a
   096E                    2615 00156$:
   096E 84                 2616 	div	ab
   096F D0 E0              2617 	pop	acc
   0971 20 D2 09           2618 	jb	ov,00157$
   0974 30 E7 06           2619 	jnb	acc.7,00157$
   0977 C3                 2620 	clr	c
   0978 E4                 2621 	clr	a
   0979 95 F0              2622 	subb	a,b
   097B F5 F0              2623 	mov	b,a
   097D                    2624 00157$:
   097D E5 F0              2625 	mov	a,b
   097F C3                 2626 	clr	c; oops
   0980 60 01              2627 	jz	00158$
   0982 B3                 2628 	cpl	c
   0983                    2629 00158$:
   0983 92 97              2630 	mov	_P1_7,c
                           2631 ;	tfirm.c 1032
   0985 7B 00              2632 	mov	r3,#0x00
   0987 7C 00              2633 	mov	r4,#0x00
   0989                    2634 00104$:
   0989 C3                 2635 	clr	c
   098A EB                 2636 	mov	a,r3
   098B 94 E8              2637 	subb	a,#0xE8
   098D EC                 2638 	mov	a,r4
   098E 64 80              2639 	xrl	a,#0x80
   0990 94 83              2640 	subb	a,#0x83
   0992 E4                 2641 	clr	a
   0993 33                 2642 	rlc	a
                           2643 ; Peephole 105   removed redundant mov
   0994 FD                 2644 	mov  r5,a
                           2645 ; Peephole 110   removed ljmp by inverse jump logic
   0995 60 07              2646 	jz  00107$
   0997                    2647 00159$:
                           2648 ;	tail increment optimized
   0997 0B                 2649 	inc	r3
   0998 BB 00 EE           2650 	cjne	r3,#0x00,00104$
   099B 0C                 2651 	inc	r4
                           2652 ; Peephole 132   changed ljmp to sjmp
   099C 80 EB              2653 	sjmp 00104$
   099E                    2654 00107$:
                           2655 ;	tfirm.c 1036
   099E D2 83              2656 	setb	_P0_3
                           2657 ;	tfirm.c 1037
   09A0 C2 82              2658 	clr	_P0_2
                           2659 ;	tfirm.c 1038
   09A2 D2 81              2660 	setb	_P0_1
                           2661 ;	tfirm.c 1039
   09A4 D2 94              2662 	setb	_P1_4
                           2663 ;	tfirm.c 1040
   09A6 D2 93              2664 	setb	_P1_3
                           2665 ;	tfirm.c 1041
   09A8 D2 92              2666 	setb	_P1_2
                           2667 ;	tfirm.c 1044
                           2668 ; Peephole 221a remove redundant move
   09AA E5 58              2669 	mov	a,0x0001 + _nixie_digits
   09AC F4                 2670 	cpl	a
                           2671 ; Peephole 105   removed redundant mov
   09AD FB                 2672 	mov  r3,a
   09AE 64 02              2673 	xrl	a,#0x02
   09B0 C0 E0              2674 	push	acc
   09B2 74 02              2675 	mov	a,#0x02
   09B4 30 E7 02           2676 	jnb	acc.7,00160$
   09B7 F4                 2677 	cpl	a
   09B8 04                 2678 	inc	a
   09B9                    2679 00160$:
   09B9 F5 F0              2680 	mov	b,a
   09BB EB                 2681 	mov	a,r3
   09BC 30 E7 02           2682 	jnb	acc.7,00161$
   09BF F4                 2683 	cpl	a
   09C0 04                 2684 	inc	a
   09C1                    2685 00161$:
   09C1 84                 2686 	div	ab
   09C2 D0 E0              2687 	pop	acc
   09C4 20 D2 09           2688 	jb	ov,00162$
   09C7 30 E7 06           2689 	jnb	acc.7,00162$
   09CA C3                 2690 	clr	c
   09CB E4                 2691 	clr	a
   09CC 95 F0              2692 	subb	a,b
   09CE F5 F0              2693 	mov	b,a
   09D0                    2694 00162$:
   09D0 E5 F0              2695 	mov	a,b
   09D2 C3                 2696 	clr	c; oops
   09D3 60 01              2697 	jz	00163$
   09D5 B3                 2698 	cpl	c
   09D6                    2699 00163$:
   09D6 92 80              2700 	mov	_P0_0,c
                           2701 ;	tfirm.c 1045
   09D8 E5 58              2702 	mov	a,0x0001 + _nixie_digits
   09DA A2 E7              2703 	mov	c,acc.7
   09DC 13                 2704 	rrc	a
                           2705 ;	tfirm.c 1046
                           2706 ; Peephole 105   removed redundant mov
   09DD FA                 2707 	mov  r2,a
   09DE F4                 2708 	cpl	a
                           2709 ; Peephole 105   removed redundant mov
   09DF FB                 2710 	mov  r3,a
   09E0 64 02              2711 	xrl	a,#0x02
   09E2 C0 E0              2712 	push	acc
   09E4 74 02              2713 	mov	a,#0x02
   09E6 30 E7 02           2714 	jnb	acc.7,00164$
   09E9 F4                 2715 	cpl	a
   09EA 04                 2716 	inc	a
   09EB                    2717 00164$:
   09EB F5 F0              2718 	mov	b,a
   09ED EB                 2719 	mov	a,r3
   09EE 30 E7 02           2720 	jnb	acc.7,00165$
   09F1 F4                 2721 	cpl	a
   09F2 04                 2722 	inc	a
   09F3                    2723 00165$:
   09F3 84                 2724 	div	ab
   09F4 D0 E0              2725 	pop	acc
   09F6 20 D2 09           2726 	jb	ov,00166$
   09F9 30 E7 06           2727 	jnb	acc.7,00166$
   09FC C3                 2728 	clr	c
   09FD E4                 2729 	clr	a
   09FE 95 F0              2730 	subb	a,b
   0A00 F5 F0              2731 	mov	b,a
   0A02                    2732 00166$:
   0A02 E5 F0              2733 	mov	a,b
   0A04 C3                 2734 	clr	c; oops
   0A05 60 01              2735 	jz	00167$
   0A07 B3                 2736 	cpl	c
   0A08                    2737 00167$:
   0A08 92 96              2738 	mov	_P1_6,c
                           2739 ;	tfirm.c 1047
   0A0A EA                 2740 	mov	a,r2
   0A0B A2 E7              2741 	mov	c,acc.7
   0A0D 13                 2742 	rrc	a
                           2743 ;	tfirm.c 1048
                           2744 ; Peephole 105   removed redundant mov
   0A0E FA                 2745 	mov  r2,a
   0A0F F4                 2746 	cpl	a
                           2747 ; Peephole 105   removed redundant mov
   0A10 FB                 2748 	mov  r3,a
   0A11 64 02              2749 	xrl	a,#0x02
   0A13 C0 E0              2750 	push	acc
   0A15 74 02              2751 	mov	a,#0x02
   0A17 30 E7 02           2752 	jnb	acc.7,00168$
   0A1A F4                 2753 	cpl	a
   0A1B 04                 2754 	inc	a
   0A1C                    2755 00168$:
   0A1C F5 F0              2756 	mov	b,a
   0A1E EB                 2757 	mov	a,r3
   0A1F 30 E7 02           2758 	jnb	acc.7,00169$
   0A22 F4                 2759 	cpl	a
   0A23 04                 2760 	inc	a
   0A24                    2761 00169$:
   0A24 84                 2762 	div	ab
   0A25 D0 E0              2763 	pop	acc
   0A27 20 D2 09           2764 	jb	ov,00170$
   0A2A 30 E7 06           2765 	jnb	acc.7,00170$
   0A2D C3                 2766 	clr	c
   0A2E E4                 2767 	clr	a
   0A2F 95 F0              2768 	subb	a,b
   0A31 F5 F0              2769 	mov	b,a
   0A33                    2770 00170$:
   0A33 E5 F0              2771 	mov	a,b
   0A35 C3                 2772 	clr	c; oops
   0A36 60 01              2773 	jz	00171$
   0A38 B3                 2774 	cpl	c
   0A39                    2775 00171$:
   0A39 92 95              2776 	mov	_P1_5,c
                           2777 ;	tfirm.c 1049
   0A3B EA                 2778 	mov	a,r2
   0A3C A2 E7              2779 	mov	c,acc.7
   0A3E 13                 2780 	rrc	a
                           2781 ;	tfirm.c 1050
                           2782 ; Peephole 105   removed redundant mov
   0A3F FA                 2783 	mov  r2,a
   0A40 F4                 2784 	cpl	a
                           2785 ; Peephole 105   removed redundant mov
   0A41 FB                 2786 	mov  r3,a
   0A42 64 02              2787 	xrl	a,#0x02
   0A44 C0 E0              2788 	push	acc
   0A46 74 02              2789 	mov	a,#0x02
   0A48 30 E7 02           2790 	jnb	acc.7,00172$
   0A4B F4                 2791 	cpl	a
   0A4C 04                 2792 	inc	a
   0A4D                    2793 00172$:
   0A4D F5 F0              2794 	mov	b,a
   0A4F EB                 2795 	mov	a,r3
   0A50 30 E7 02           2796 	jnb	acc.7,00173$
   0A53 F4                 2797 	cpl	a
   0A54 04                 2798 	inc	a
   0A55                    2799 00173$:
   0A55 84                 2800 	div	ab
   0A56 D0 E0              2801 	pop	acc
   0A58 20 D2 09           2802 	jb	ov,00174$
   0A5B 30 E7 06           2803 	jnb	acc.7,00174$
   0A5E C3                 2804 	clr	c
   0A5F E4                 2805 	clr	a
   0A60 95 F0              2806 	subb	a,b
   0A62 F5 F0              2807 	mov	b,a
   0A64                    2808 00174$:
   0A64 E5 F0              2809 	mov	a,b
   0A66 C3                 2810 	clr	c; oops
   0A67 60 01              2811 	jz	00175$
   0A69 B3                 2812 	cpl	c
   0A6A                    2813 00175$:
   0A6A 92 97              2814 	mov	_P1_7,c
                           2815 ;	tfirm.c 1052
   0A6C 7B 00              2816 	mov	r3,#0x00
   0A6E 7C 00              2817 	mov	r4,#0x00
   0A70                    2818 00108$:
   0A70 C3                 2819 	clr	c
   0A71 EB                 2820 	mov	a,r3
   0A72 94 E8              2821 	subb	a,#0xE8
   0A74 EC                 2822 	mov	a,r4
   0A75 64 80              2823 	xrl	a,#0x80
   0A77 94 83              2824 	subb	a,#0x83
   0A79 E4                 2825 	clr	a
   0A7A 33                 2826 	rlc	a
                           2827 ; Peephole 105   removed redundant mov
   0A7B FD                 2828 	mov  r5,a
                           2829 ; Peephole 110   removed ljmp by inverse jump logic
   0A7C 60 07              2830 	jz  00111$
   0A7E                    2831 00176$:
                           2832 ;	tail increment optimized
   0A7E 0B                 2833 	inc	r3
   0A7F BB 00 EE           2834 	cjne	r3,#0x00,00108$
   0A82 0C                 2835 	inc	r4
                           2836 ; Peephole 132   changed ljmp to sjmp
   0A83 80 EB              2837 	sjmp 00108$
   0A85                    2838 00111$:
                           2839 ;	tfirm.c 1056
   0A85 D2 83              2840 	setb	_P0_3
                           2841 ;	tfirm.c 1057
   0A87 D2 82              2842 	setb	_P0_2
                           2843 ;	tfirm.c 1058
   0A89 C2 81              2844 	clr	_P0_1
                           2845 ;	tfirm.c 1059
   0A8B D2 94              2846 	setb	_P1_4
                           2847 ;	tfirm.c 1060
   0A8D D2 93              2848 	setb	_P1_3
                           2849 ;	tfirm.c 1061
   0A8F D2 92              2850 	setb	_P1_2
                           2851 ;	tfirm.c 1065
                           2852 ; Peephole 221a remove redundant move
   0A91 E5 59              2853 	mov	a,0x0002 + _nixie_digits
   0A93 F4                 2854 	cpl	a
                           2855 ; Peephole 105   removed redundant mov
   0A94 FB                 2856 	mov  r3,a
   0A95 64 02              2857 	xrl	a,#0x02
   0A97 C0 E0              2858 	push	acc
   0A99 74 02              2859 	mov	a,#0x02
   0A9B 30 E7 02           2860 	jnb	acc.7,00177$
   0A9E F4                 2861 	cpl	a
   0A9F 04                 2862 	inc	a
   0AA0                    2863 00177$:
   0AA0 F5 F0              2864 	mov	b,a
   0AA2 EB                 2865 	mov	a,r3
   0AA3 30 E7 02           2866 	jnb	acc.7,00178$
   0AA6 F4                 2867 	cpl	a
   0AA7 04                 2868 	inc	a
   0AA8                    2869 00178$:
   0AA8 84                 2870 	div	ab
   0AA9 D0 E0              2871 	pop	acc
   0AAB 20 D2 09           2872 	jb	ov,00179$
   0AAE 30 E7 06           2873 	jnb	acc.7,00179$
   0AB1 C3                 2874 	clr	c
   0AB2 E4                 2875 	clr	a
   0AB3 95 F0              2876 	subb	a,b
   0AB5 F5 F0              2877 	mov	b,a
   0AB7                    2878 00179$:
   0AB7 E5 F0              2879 	mov	a,b
   0AB9 C3                 2880 	clr	c; oops
   0ABA 60 01              2881 	jz	00180$
   0ABC B3                 2882 	cpl	c
   0ABD                    2883 00180$:
   0ABD 92 80              2884 	mov	_P0_0,c
                           2885 ;	tfirm.c 1066
   0ABF E5 59              2886 	mov	a,0x0002 + _nixie_digits
   0AC1 A2 E7              2887 	mov	c,acc.7
   0AC3 13                 2888 	rrc	a
                           2889 ;	tfirm.c 1067
                           2890 ; Peephole 105   removed redundant mov
   0AC4 FA                 2891 	mov  r2,a
   0AC5 F4                 2892 	cpl	a
                           2893 ; Peephole 105   removed redundant mov
   0AC6 FB                 2894 	mov  r3,a
   0AC7 64 02              2895 	xrl	a,#0x02
   0AC9 C0 E0              2896 	push	acc
   0ACB 74 02              2897 	mov	a,#0x02
   0ACD 30 E7 02           2898 	jnb	acc.7,00181$
   0AD0 F4                 2899 	cpl	a
   0AD1 04                 2900 	inc	a
   0AD2                    2901 00181$:
   0AD2 F5 F0              2902 	mov	b,a
   0AD4 EB                 2903 	mov	a,r3
   0AD5 30 E7 02           2904 	jnb	acc.7,00182$
   0AD8 F4                 2905 	cpl	a
   0AD9 04                 2906 	inc	a
   0ADA                    2907 00182$:
   0ADA 84                 2908 	div	ab
   0ADB D0 E0              2909 	pop	acc
   0ADD 20 D2 09           2910 	jb	ov,00183$
   0AE0 30 E7 06           2911 	jnb	acc.7,00183$
   0AE3 C3                 2912 	clr	c
   0AE4 E4                 2913 	clr	a
   0AE5 95 F0              2914 	subb	a,b
   0AE7 F5 F0              2915 	mov	b,a
   0AE9                    2916 00183$:
   0AE9 E5 F0              2917 	mov	a,b
   0AEB C3                 2918 	clr	c; oops
   0AEC 60 01              2919 	jz	00184$
   0AEE B3                 2920 	cpl	c
   0AEF                    2921 00184$:
   0AEF 92 96              2922 	mov	_P1_6,c
                           2923 ;	tfirm.c 1068
   0AF1 EA                 2924 	mov	a,r2
   0AF2 A2 E7              2925 	mov	c,acc.7
   0AF4 13                 2926 	rrc	a
                           2927 ;	tfirm.c 1069
                           2928 ; Peephole 105   removed redundant mov
   0AF5 FA                 2929 	mov  r2,a
   0AF6 F4                 2930 	cpl	a
                           2931 ; Peephole 105   removed redundant mov
   0AF7 FB                 2932 	mov  r3,a
   0AF8 64 02              2933 	xrl	a,#0x02
   0AFA C0 E0              2934 	push	acc
   0AFC 74 02              2935 	mov	a,#0x02
   0AFE 30 E7 02           2936 	jnb	acc.7,00185$
   0B01 F4                 2937 	cpl	a
   0B02 04                 2938 	inc	a
   0B03                    2939 00185$:
   0B03 F5 F0              2940 	mov	b,a
   0B05 EB                 2941 	mov	a,r3
   0B06 30 E7 02           2942 	jnb	acc.7,00186$
   0B09 F4                 2943 	cpl	a
   0B0A 04                 2944 	inc	a
   0B0B                    2945 00186$:
   0B0B 84                 2946 	div	ab
   0B0C D0 E0              2947 	pop	acc
   0B0E 20 D2 09           2948 	jb	ov,00187$
   0B11 30 E7 06           2949 	jnb	acc.7,00187$
   0B14 C3                 2950 	clr	c
   0B15 E4                 2951 	clr	a
   0B16 95 F0              2952 	subb	a,b
   0B18 F5 F0              2953 	mov	b,a
   0B1A                    2954 00187$:
   0B1A E5 F0              2955 	mov	a,b
   0B1C C3                 2956 	clr	c; oops
   0B1D 60 01              2957 	jz	00188$
   0B1F B3                 2958 	cpl	c
   0B20                    2959 00188$:
   0B20 92 95              2960 	mov	_P1_5,c
                           2961 ;	tfirm.c 1070
   0B22 EA                 2962 	mov	a,r2
   0B23 A2 E7              2963 	mov	c,acc.7
   0B25 13                 2964 	rrc	a
                           2965 ;	tfirm.c 1071
                           2966 ; Peephole 105   removed redundant mov
   0B26 FA                 2967 	mov  r2,a
   0B27 F4                 2968 	cpl	a
                           2969 ; Peephole 105   removed redundant mov
   0B28 FB                 2970 	mov  r3,a
   0B29 64 02              2971 	xrl	a,#0x02
   0B2B C0 E0              2972 	push	acc
   0B2D 74 02              2973 	mov	a,#0x02
   0B2F 30 E7 02           2974 	jnb	acc.7,00189$
   0B32 F4                 2975 	cpl	a
   0B33 04                 2976 	inc	a
   0B34                    2977 00189$:
   0B34 F5 F0              2978 	mov	b,a
   0B36 EB                 2979 	mov	a,r3
   0B37 30 E7 02           2980 	jnb	acc.7,00190$
   0B3A F4                 2981 	cpl	a
   0B3B 04                 2982 	inc	a
   0B3C                    2983 00190$:
   0B3C 84                 2984 	div	ab
   0B3D D0 E0              2985 	pop	acc
   0B3F 20 D2 09           2986 	jb	ov,00191$
   0B42 30 E7 06           2987 	jnb	acc.7,00191$
   0B45 C3                 2988 	clr	c
   0B46 E4                 2989 	clr	a
   0B47 95 F0              2990 	subb	a,b
   0B49 F5 F0              2991 	mov	b,a
   0B4B                    2992 00191$:
   0B4B E5 F0              2993 	mov	a,b
   0B4D C3                 2994 	clr	c; oops
   0B4E 60 01              2995 	jz	00192$
   0B50 B3                 2996 	cpl	c
   0B51                    2997 00192$:
   0B51 92 97              2998 	mov	_P1_7,c
                           2999 ;	tfirm.c 1075
   0B53 7B 00              3000 	mov	r3,#0x00
   0B55 7C 00              3001 	mov	r4,#0x00
   0B57                    3002 00112$:
   0B57 C3                 3003 	clr	c
   0B58 EB                 3004 	mov	a,r3
   0B59 94 E8              3005 	subb	a,#0xE8
   0B5B EC                 3006 	mov	a,r4
   0B5C 64 80              3007 	xrl	a,#0x80
   0B5E 94 83              3008 	subb	a,#0x83
   0B60 E4                 3009 	clr	a
   0B61 33                 3010 	rlc	a
                           3011 ; Peephole 105   removed redundant mov
   0B62 FD                 3012 	mov  r5,a
                           3013 ; Peephole 110   removed ljmp by inverse jump logic
   0B63 60 07              3014 	jz  00115$
   0B65                    3015 00193$:
                           3016 ;	tail increment optimized
   0B65 0B                 3017 	inc	r3
   0B66 BB 00 EE           3018 	cjne	r3,#0x00,00112$
   0B69 0C                 3019 	inc	r4
                           3020 ; Peephole 132   changed ljmp to sjmp
   0B6A 80 EB              3021 	sjmp 00112$
   0B6C                    3022 00115$:
                           3023 ;	tfirm.c 1079
   0B6C D2 83              3024 	setb	_P0_3
                           3025 ;	tfirm.c 1080
   0B6E D2 82              3026 	setb	_P0_2
                           3027 ;	tfirm.c 1081
   0B70 D2 81              3028 	setb	_P0_1
                           3029 ;	tfirm.c 1082
   0B72 C2 94              3030 	clr	_P1_4
                           3031 ;	tfirm.c 1083
   0B74 D2 93              3032 	setb	_P1_3
                           3033 ;	tfirm.c 1084
   0B76 D2 92              3034 	setb	_P1_2
                           3035 ;	tfirm.c 1087
                           3036 ; Peephole 221a remove redundant move
   0B78 E5 5A              3037 	mov	a,0x0003 + _nixie_digits
   0B7A F4                 3038 	cpl	a
                           3039 ; Peephole 105   removed redundant mov
   0B7B FB                 3040 	mov  r3,a
   0B7C 64 02              3041 	xrl	a,#0x02
   0B7E C0 E0              3042 	push	acc
   0B80 74 02              3043 	mov	a,#0x02
   0B82 30 E7 02           3044 	jnb	acc.7,00194$
   0B85 F4                 3045 	cpl	a
   0B86 04                 3046 	inc	a
   0B87                    3047 00194$:
   0B87 F5 F0              3048 	mov	b,a
   0B89 EB                 3049 	mov	a,r3
   0B8A 30 E7 02           3050 	jnb	acc.7,00195$
   0B8D F4                 3051 	cpl	a
   0B8E 04                 3052 	inc	a
   0B8F                    3053 00195$:
   0B8F 84                 3054 	div	ab
   0B90 D0 E0              3055 	pop	acc
   0B92 20 D2 09           3056 	jb	ov,00196$
   0B95 30 E7 06           3057 	jnb	acc.7,00196$
   0B98 C3                 3058 	clr	c
   0B99 E4                 3059 	clr	a
   0B9A 95 F0              3060 	subb	a,b
   0B9C F5 F0              3061 	mov	b,a
   0B9E                    3062 00196$:
   0B9E E5 F0              3063 	mov	a,b
   0BA0 C3                 3064 	clr	c; oops
   0BA1 60 01              3065 	jz	00197$
   0BA3 B3                 3066 	cpl	c
   0BA4                    3067 00197$:
   0BA4 92 80              3068 	mov	_P0_0,c
                           3069 ;	tfirm.c 1088
   0BA6 E5 5A              3070 	mov	a,0x0003 + _nixie_digits
   0BA8 A2 E7              3071 	mov	c,acc.7
   0BAA 13                 3072 	rrc	a
                           3073 ;	tfirm.c 1089
                           3074 ; Peephole 105   removed redundant mov
   0BAB FA                 3075 	mov  r2,a
   0BAC F4                 3076 	cpl	a
                           3077 ; Peephole 105   removed redundant mov
   0BAD FB                 3078 	mov  r3,a
   0BAE 64 02              3079 	xrl	a,#0x02
   0BB0 C0 E0              3080 	push	acc
   0BB2 74 02              3081 	mov	a,#0x02
   0BB4 30 E7 02           3082 	jnb	acc.7,00198$
   0BB7 F4                 3083 	cpl	a
   0BB8 04                 3084 	inc	a
   0BB9                    3085 00198$:
   0BB9 F5 F0              3086 	mov	b,a
   0BBB EB                 3087 	mov	a,r3
   0BBC 30 E7 02           3088 	jnb	acc.7,00199$
   0BBF F4                 3089 	cpl	a
   0BC0 04                 3090 	inc	a
   0BC1                    3091 00199$:
   0BC1 84                 3092 	div	ab
   0BC2 D0 E0              3093 	pop	acc
   0BC4 20 D2 09           3094 	jb	ov,00200$
   0BC7 30 E7 06           3095 	jnb	acc.7,00200$
   0BCA C3                 3096 	clr	c
   0BCB E4                 3097 	clr	a
   0BCC 95 F0              3098 	subb	a,b
   0BCE F5 F0              3099 	mov	b,a
   0BD0                    3100 00200$:
   0BD0 E5 F0              3101 	mov	a,b
   0BD2 C3                 3102 	clr	c; oops
   0BD3 60 01              3103 	jz	00201$
   0BD5 B3                 3104 	cpl	c
   0BD6                    3105 00201$:
   0BD6 92 96              3106 	mov	_P1_6,c
                           3107 ;	tfirm.c 1090
   0BD8 EA                 3108 	mov	a,r2
   0BD9 A2 E7              3109 	mov	c,acc.7
   0BDB 13                 3110 	rrc	a
                           3111 ;	tfirm.c 1091
                           3112 ; Peephole 105   removed redundant mov
   0BDC FA                 3113 	mov  r2,a
   0BDD F4                 3114 	cpl	a
                           3115 ; Peephole 105   removed redundant mov
   0BDE FB                 3116 	mov  r3,a
   0BDF 64 02              3117 	xrl	a,#0x02
   0BE1 C0 E0              3118 	push	acc
   0BE3 74 02              3119 	mov	a,#0x02
   0BE5 30 E7 02           3120 	jnb	acc.7,00202$
   0BE8 F4                 3121 	cpl	a
   0BE9 04                 3122 	inc	a
   0BEA                    3123 00202$:
   0BEA F5 F0              3124 	mov	b,a
   0BEC EB                 3125 	mov	a,r3
   0BED 30 E7 02           3126 	jnb	acc.7,00203$
   0BF0 F4                 3127 	cpl	a
   0BF1 04                 3128 	inc	a
   0BF2                    3129 00203$:
   0BF2 84                 3130 	div	ab
   0BF3 D0 E0              3131 	pop	acc
   0BF5 20 D2 09           3132 	jb	ov,00204$
   0BF8 30 E7 06           3133 	jnb	acc.7,00204$
   0BFB C3                 3134 	clr	c
   0BFC E4                 3135 	clr	a
   0BFD 95 F0              3136 	subb	a,b
   0BFF F5 F0              3137 	mov	b,a
   0C01                    3138 00204$:
   0C01 E5 F0              3139 	mov	a,b
   0C03 C3                 3140 	clr	c; oops
   0C04 60 01              3141 	jz	00205$
   0C06 B3                 3142 	cpl	c
   0C07                    3143 00205$:
   0C07 92 95              3144 	mov	_P1_5,c
                           3145 ;	tfirm.c 1092
   0C09 EA                 3146 	mov	a,r2
   0C0A A2 E7              3147 	mov	c,acc.7
   0C0C 13                 3148 	rrc	a
                           3149 ;	tfirm.c 1093
                           3150 ; Peephole 105   removed redundant mov
   0C0D FA                 3151 	mov  r2,a
   0C0E F4                 3152 	cpl	a
                           3153 ; Peephole 105   removed redundant mov
   0C0F FB                 3154 	mov  r3,a
   0C10 64 02              3155 	xrl	a,#0x02
   0C12 C0 E0              3156 	push	acc
   0C14 74 02              3157 	mov	a,#0x02
   0C16 30 E7 02           3158 	jnb	acc.7,00206$
   0C19 F4                 3159 	cpl	a
   0C1A 04                 3160 	inc	a
   0C1B                    3161 00206$:
   0C1B F5 F0              3162 	mov	b,a
   0C1D EB                 3163 	mov	a,r3
   0C1E 30 E7 02           3164 	jnb	acc.7,00207$
   0C21 F4                 3165 	cpl	a
   0C22 04                 3166 	inc	a
   0C23                    3167 00207$:
   0C23 84                 3168 	div	ab
   0C24 D0 E0              3169 	pop	acc
   0C26 20 D2 09           3170 	jb	ov,00208$
   0C29 30 E7 06           3171 	jnb	acc.7,00208$
   0C2C C3                 3172 	clr	c
   0C2D E4                 3173 	clr	a
   0C2E 95 F0              3174 	subb	a,b
   0C30 F5 F0              3175 	mov	b,a
   0C32                    3176 00208$:
   0C32 E5 F0              3177 	mov	a,b
   0C34 C3                 3178 	clr	c; oops
   0C35 60 01              3179 	jz	00209$
   0C37 B3                 3180 	cpl	c
   0C38                    3181 00209$:
   0C38 92 97              3182 	mov	_P1_7,c
                           3183 ;	tfirm.c 1095
   0C3A 7B 00              3184 	mov	r3,#0x00
   0C3C 7C 00              3185 	mov	r4,#0x00
   0C3E                    3186 00116$:
   0C3E C3                 3187 	clr	c
   0C3F EB                 3188 	mov	a,r3
   0C40 94 E8              3189 	subb	a,#0xE8
   0C42 EC                 3190 	mov	a,r4
   0C43 64 80              3191 	xrl	a,#0x80
   0C45 94 83              3192 	subb	a,#0x83
   0C47 E4                 3193 	clr	a
   0C48 33                 3194 	rlc	a
                           3195 ; Peephole 105   removed redundant mov
   0C49 FD                 3196 	mov  r5,a
                           3197 ; Peephole 110   removed ljmp by inverse jump logic
   0C4A 60 07              3198 	jz  00119$
   0C4C                    3199 00210$:
                           3200 ;	tail increment optimized
   0C4C 0B                 3201 	inc	r3
   0C4D BB 00 EE           3202 	cjne	r3,#0x00,00116$
   0C50 0C                 3203 	inc	r4
                           3204 ; Peephole 132   changed ljmp to sjmp
   0C51 80 EB              3205 	sjmp 00116$
   0C53                    3206 00119$:
                           3207 ;	tfirm.c 1099
   0C53 D2 83              3208 	setb	_P0_3
                           3209 ;	tfirm.c 1100
   0C55 D2 82              3210 	setb	_P0_2
                           3211 ;	tfirm.c 1101
   0C57 D2 81              3212 	setb	_P0_1
                           3213 ;	tfirm.c 1102
   0C59 D2 94              3214 	setb	_P1_4
                           3215 ;	tfirm.c 1103
   0C5B C2 93              3216 	clr	_P1_3
                           3217 ;	tfirm.c 1104
   0C5D D2 92              3218 	setb	_P1_2
                           3219 ;	tfirm.c 1108
                           3220 ; Peephole 221a remove redundant move
   0C5F E5 5B              3221 	mov	a,0x0004 + _nixie_digits
   0C61 F4                 3222 	cpl	a
                           3223 ; Peephole 105   removed redundant mov
   0C62 FB                 3224 	mov  r3,a
   0C63 64 02              3225 	xrl	a,#0x02
   0C65 C0 E0              3226 	push	acc
   0C67 74 02              3227 	mov	a,#0x02
   0C69 30 E7 02           3228 	jnb	acc.7,00211$
   0C6C F4                 3229 	cpl	a
   0C6D 04                 3230 	inc	a
   0C6E                    3231 00211$:
   0C6E F5 F0              3232 	mov	b,a
   0C70 EB                 3233 	mov	a,r3
   0C71 30 E7 02           3234 	jnb	acc.7,00212$
   0C74 F4                 3235 	cpl	a
   0C75 04                 3236 	inc	a
   0C76                    3237 00212$:
   0C76 84                 3238 	div	ab
   0C77 D0 E0              3239 	pop	acc
   0C79 20 D2 09           3240 	jb	ov,00213$
   0C7C 30 E7 06           3241 	jnb	acc.7,00213$
   0C7F C3                 3242 	clr	c
   0C80 E4                 3243 	clr	a
   0C81 95 F0              3244 	subb	a,b
   0C83 F5 F0              3245 	mov	b,a
   0C85                    3246 00213$:
   0C85 E5 F0              3247 	mov	a,b
   0C87 C3                 3248 	clr	c; oops
   0C88 60 01              3249 	jz	00214$
   0C8A B3                 3250 	cpl	c
   0C8B                    3251 00214$:
   0C8B 92 80              3252 	mov	_P0_0,c
                           3253 ;	tfirm.c 1109
   0C8D E5 5B              3254 	mov	a,0x0004 + _nixie_digits
   0C8F A2 E7              3255 	mov	c,acc.7
   0C91 13                 3256 	rrc	a
                           3257 ;	tfirm.c 1110
                           3258 ; Peephole 105   removed redundant mov
   0C92 FA                 3259 	mov  r2,a
   0C93 F4                 3260 	cpl	a
                           3261 ; Peephole 105   removed redundant mov
   0C94 FB                 3262 	mov  r3,a
   0C95 64 02              3263 	xrl	a,#0x02
   0C97 C0 E0              3264 	push	acc
   0C99 74 02              3265 	mov	a,#0x02
   0C9B 30 E7 02           3266 	jnb	acc.7,00215$
   0C9E F4                 3267 	cpl	a
   0C9F 04                 3268 	inc	a
   0CA0                    3269 00215$:
   0CA0 F5 F0              3270 	mov	b,a
   0CA2 EB                 3271 	mov	a,r3
   0CA3 30 E7 02           3272 	jnb	acc.7,00216$
   0CA6 F4                 3273 	cpl	a
   0CA7 04                 3274 	inc	a
   0CA8                    3275 00216$:
   0CA8 84                 3276 	div	ab
   0CA9 D0 E0              3277 	pop	acc
   0CAB 20 D2 09           3278 	jb	ov,00217$
   0CAE 30 E7 06           3279 	jnb	acc.7,00217$
   0CB1 C3                 3280 	clr	c
   0CB2 E4                 3281 	clr	a
   0CB3 95 F0              3282 	subb	a,b
   0CB5 F5 F0              3283 	mov	b,a
   0CB7                    3284 00217$:
   0CB7 E5 F0              3285 	mov	a,b
   0CB9 C3                 3286 	clr	c; oops
   0CBA 60 01              3287 	jz	00218$
   0CBC B3                 3288 	cpl	c
   0CBD                    3289 00218$:
   0CBD 92 96              3290 	mov	_P1_6,c
                           3291 ;	tfirm.c 1111
   0CBF EA                 3292 	mov	a,r2
   0CC0 A2 E7              3293 	mov	c,acc.7
   0CC2 13                 3294 	rrc	a
                           3295 ;	tfirm.c 1112
                           3296 ; Peephole 105   removed redundant mov
   0CC3 FA                 3297 	mov  r2,a
   0CC4 F4                 3298 	cpl	a
                           3299 ; Peephole 105   removed redundant mov
   0CC5 FB                 3300 	mov  r3,a
   0CC6 64 02              3301 	xrl	a,#0x02
   0CC8 C0 E0              3302 	push	acc
   0CCA 74 02              3303 	mov	a,#0x02
   0CCC 30 E7 02           3304 	jnb	acc.7,00219$
   0CCF F4                 3305 	cpl	a
   0CD0 04                 3306 	inc	a
   0CD1                    3307 00219$:
   0CD1 F5 F0              3308 	mov	b,a
   0CD3 EB                 3309 	mov	a,r3
   0CD4 30 E7 02           3310 	jnb	acc.7,00220$
   0CD7 F4                 3311 	cpl	a
   0CD8 04                 3312 	inc	a
   0CD9                    3313 00220$:
   0CD9 84                 3314 	div	ab
   0CDA D0 E0              3315 	pop	acc
   0CDC 20 D2 09           3316 	jb	ov,00221$
   0CDF 30 E7 06           3317 	jnb	acc.7,00221$
   0CE2 C3                 3318 	clr	c
   0CE3 E4                 3319 	clr	a
   0CE4 95 F0              3320 	subb	a,b
   0CE6 F5 F0              3321 	mov	b,a
   0CE8                    3322 00221$:
   0CE8 E5 F0              3323 	mov	a,b
   0CEA C3                 3324 	clr	c; oops
   0CEB 60 01              3325 	jz	00222$
   0CED B3                 3326 	cpl	c
   0CEE                    3327 00222$:
   0CEE 92 95              3328 	mov	_P1_5,c
                           3329 ;	tfirm.c 1113
   0CF0 EA                 3330 	mov	a,r2
   0CF1 A2 E7              3331 	mov	c,acc.7
   0CF3 13                 3332 	rrc	a
                           3333 ;	tfirm.c 1114
                           3334 ; Peephole 105   removed redundant mov
   0CF4 FA                 3335 	mov  r2,a
   0CF5 F4                 3336 	cpl	a
                           3337 ; Peephole 105   removed redundant mov
   0CF6 FB                 3338 	mov  r3,a
   0CF7 64 02              3339 	xrl	a,#0x02
   0CF9 C0 E0              3340 	push	acc
   0CFB 74 02              3341 	mov	a,#0x02
   0CFD 30 E7 02           3342 	jnb	acc.7,00223$
   0D00 F4                 3343 	cpl	a
   0D01 04                 3344 	inc	a
   0D02                    3345 00223$:
   0D02 F5 F0              3346 	mov	b,a
   0D04 EB                 3347 	mov	a,r3
   0D05 30 E7 02           3348 	jnb	acc.7,00224$
   0D08 F4                 3349 	cpl	a
   0D09 04                 3350 	inc	a
   0D0A                    3351 00224$:
   0D0A 84                 3352 	div	ab
   0D0B D0 E0              3353 	pop	acc
   0D0D 20 D2 09           3354 	jb	ov,00225$
   0D10 30 E7 06           3355 	jnb	acc.7,00225$
   0D13 C3                 3356 	clr	c
   0D14 E4                 3357 	clr	a
   0D15 95 F0              3358 	subb	a,b
   0D17 F5 F0              3359 	mov	b,a
   0D19                    3360 00225$:
   0D19 E5 F0              3361 	mov	a,b
   0D1B C3                 3362 	clr	c; oops
   0D1C 60 01              3363 	jz	00226$
   0D1E B3                 3364 	cpl	c
   0D1F                    3365 00226$:
   0D1F 92 97              3366 	mov	_P1_7,c
                           3367 ;	tfirm.c 1118
   0D21 7B 00              3368 	mov	r3,#0x00
   0D23 7C 00              3369 	mov	r4,#0x00
   0D25                    3370 00120$:
   0D25 C3                 3371 	clr	c
   0D26 EB                 3372 	mov	a,r3
   0D27 94 E8              3373 	subb	a,#0xE8
   0D29 EC                 3374 	mov	a,r4
   0D2A 64 80              3375 	xrl	a,#0x80
   0D2C 94 83              3376 	subb	a,#0x83
   0D2E E4                 3377 	clr	a
   0D2F 33                 3378 	rlc	a
                           3379 ; Peephole 105   removed redundant mov
   0D30 FD                 3380 	mov  r5,a
                           3381 ; Peephole 110   removed ljmp by inverse jump logic
   0D31 60 07              3382 	jz  00123$
   0D33                    3383 00227$:
                           3384 ;	tail increment optimized
   0D33 0B                 3385 	inc	r3
   0D34 BB 00 EE           3386 	cjne	r3,#0x00,00120$
   0D37 0C                 3387 	inc	r4
                           3388 ; Peephole 132   changed ljmp to sjmp
   0D38 80 EB              3389 	sjmp 00120$
   0D3A                    3390 00123$:
                           3391 ;	tfirm.c 1122
   0D3A D2 83              3392 	setb	_P0_3
                           3393 ;	tfirm.c 1123
   0D3C D2 82              3394 	setb	_P0_2
                           3395 ;	tfirm.c 1124
   0D3E D2 81              3396 	setb	_P0_1
                           3397 ;	tfirm.c 1125
   0D40 D2 94              3398 	setb	_P1_4
                           3399 ;	tfirm.c 1126
   0D42 D2 93              3400 	setb	_P1_3
                           3401 ;	tfirm.c 1127
   0D44 C2 92              3402 	clr	_P1_2
                           3403 ;	tfirm.c 1130
                           3404 ; Peephole 221a remove redundant move
   0D46 E5 5C              3405 	mov	a,0x0005 + _nixie_digits
   0D48 F4                 3406 	cpl	a
                           3407 ; Peephole 105   removed redundant mov
   0D49 FB                 3408 	mov  r3,a
   0D4A 64 02              3409 	xrl	a,#0x02
   0D4C C0 E0              3410 	push	acc
   0D4E 74 02              3411 	mov	a,#0x02
   0D50 30 E7 02           3412 	jnb	acc.7,00228$
   0D53 F4                 3413 	cpl	a
   0D54 04                 3414 	inc	a
   0D55                    3415 00228$:
   0D55 F5 F0              3416 	mov	b,a
   0D57 EB                 3417 	mov	a,r3
   0D58 30 E7 02           3418 	jnb	acc.7,00229$
   0D5B F4                 3419 	cpl	a
   0D5C 04                 3420 	inc	a
   0D5D                    3421 00229$:
   0D5D 84                 3422 	div	ab
   0D5E D0 E0              3423 	pop	acc
   0D60 20 D2 09           3424 	jb	ov,00230$
   0D63 30 E7 06           3425 	jnb	acc.7,00230$
   0D66 C3                 3426 	clr	c
   0D67 E4                 3427 	clr	a
   0D68 95 F0              3428 	subb	a,b
   0D6A F5 F0              3429 	mov	b,a
   0D6C                    3430 00230$:
   0D6C E5 F0              3431 	mov	a,b
   0D6E C3                 3432 	clr	c; oops
   0D6F 60 01              3433 	jz	00231$
   0D71 B3                 3434 	cpl	c
   0D72                    3435 00231$:
   0D72 92 80              3436 	mov	_P0_0,c
                           3437 ;	tfirm.c 1131
   0D74 E5 5C              3438 	mov	a,0x0005 + _nixie_digits
   0D76 A2 E7              3439 	mov	c,acc.7
   0D78 13                 3440 	rrc	a
                           3441 ;	tfirm.c 1132
                           3442 ; Peephole 105   removed redundant mov
   0D79 FA                 3443 	mov  r2,a
   0D7A F4                 3444 	cpl	a
                           3445 ; Peephole 105   removed redundant mov
   0D7B FB                 3446 	mov  r3,a
   0D7C 64 02              3447 	xrl	a,#0x02
   0D7E C0 E0              3448 	push	acc
   0D80 74 02              3449 	mov	a,#0x02
   0D82 30 E7 02           3450 	jnb	acc.7,00232$
   0D85 F4                 3451 	cpl	a
   0D86 04                 3452 	inc	a
   0D87                    3453 00232$:
   0D87 F5 F0              3454 	mov	b,a
   0D89 EB                 3455 	mov	a,r3
   0D8A 30 E7 02           3456 	jnb	acc.7,00233$
   0D8D F4                 3457 	cpl	a
   0D8E 04                 3458 	inc	a
   0D8F                    3459 00233$:
   0D8F 84                 3460 	div	ab
   0D90 D0 E0              3461 	pop	acc
   0D92 20 D2 09           3462 	jb	ov,00234$
   0D95 30 E7 06           3463 	jnb	acc.7,00234$
   0D98 C3                 3464 	clr	c
   0D99 E4                 3465 	clr	a
   0D9A 95 F0              3466 	subb	a,b
   0D9C F5 F0              3467 	mov	b,a
   0D9E                    3468 00234$:
   0D9E E5 F0              3469 	mov	a,b
   0DA0 C3                 3470 	clr	c; oops
   0DA1 60 01              3471 	jz	00235$
   0DA3 B3                 3472 	cpl	c
   0DA4                    3473 00235$:
   0DA4 92 96              3474 	mov	_P1_6,c
                           3475 ;	tfirm.c 1133
   0DA6 EA                 3476 	mov	a,r2
   0DA7 A2 E7              3477 	mov	c,acc.7
   0DA9 13                 3478 	rrc	a
                           3479 ;	tfirm.c 1134
                           3480 ; Peephole 105   removed redundant mov
   0DAA FA                 3481 	mov  r2,a
   0DAB F4                 3482 	cpl	a
                           3483 ; Peephole 105   removed redundant mov
   0DAC FB                 3484 	mov  r3,a
   0DAD 64 02              3485 	xrl	a,#0x02
   0DAF C0 E0              3486 	push	acc
   0DB1 74 02              3487 	mov	a,#0x02
   0DB3 30 E7 02           3488 	jnb	acc.7,00236$
   0DB6 F4                 3489 	cpl	a
   0DB7 04                 3490 	inc	a
   0DB8                    3491 00236$:
   0DB8 F5 F0              3492 	mov	b,a
   0DBA EB                 3493 	mov	a,r3
   0DBB 30 E7 02           3494 	jnb	acc.7,00237$
   0DBE F4                 3495 	cpl	a
   0DBF 04                 3496 	inc	a
   0DC0                    3497 00237$:
   0DC0 84                 3498 	div	ab
   0DC1 D0 E0              3499 	pop	acc
   0DC3 20 D2 09           3500 	jb	ov,00238$
   0DC6 30 E7 06           3501 	jnb	acc.7,00238$
   0DC9 C3                 3502 	clr	c
   0DCA E4                 3503 	clr	a
   0DCB 95 F0              3504 	subb	a,b
   0DCD F5 F0              3505 	mov	b,a
   0DCF                    3506 00238$:
   0DCF E5 F0              3507 	mov	a,b
   0DD1 C3                 3508 	clr	c; oops
   0DD2 60 01              3509 	jz	00239$
   0DD4 B3                 3510 	cpl	c
   0DD5                    3511 00239$:
   0DD5 92 95              3512 	mov	_P1_5,c
                           3513 ;	tfirm.c 1135
   0DD7 EA                 3514 	mov	a,r2
   0DD8 A2 E7              3515 	mov	c,acc.7
   0DDA 13                 3516 	rrc	a
                           3517 ;	tfirm.c 1136
                           3518 ; Peephole 105   removed redundant mov
                           3519 ; Peephole 105   removed redundant mov
                           3520 ; Peephole 184   removed redundant mov
   0DDB F4                 3521 	cpl  a
   0DDC FA                 3522 	mov  r2,a
   0DDD 64 02              3523 	xrl	a,#0x02
   0DDF C0 E0              3524 	push	acc
   0DE1 74 02              3525 	mov	a,#0x02
   0DE3 30 E7 02           3526 	jnb	acc.7,00240$
   0DE6 F4                 3527 	cpl	a
   0DE7 04                 3528 	inc	a
   0DE8                    3529 00240$:
   0DE8 F5 F0              3530 	mov	b,a
   0DEA EA                 3531 	mov	a,r2
   0DEB 30 E7 02           3532 	jnb	acc.7,00241$
   0DEE F4                 3533 	cpl	a
   0DEF 04                 3534 	inc	a
   0DF0                    3535 00241$:
   0DF0 84                 3536 	div	ab
   0DF1 D0 E0              3537 	pop	acc
   0DF3 20 D2 09           3538 	jb	ov,00242$
   0DF6 30 E7 06           3539 	jnb	acc.7,00242$
   0DF9 C3                 3540 	clr	c
   0DFA E4                 3541 	clr	a
   0DFB 95 F0              3542 	subb	a,b
   0DFD F5 F0              3543 	mov	b,a
   0DFF                    3544 00242$:
   0DFF E5 F0              3545 	mov	a,b
   0E01 C3                 3546 	clr	c; oops
   0E02 60 01              3547 	jz	00243$
   0E04 B3                 3548 	cpl	c
   0E05                    3549 00243$:
   0E05 92 97              3550 	mov	_P1_7,c
                           3551 ;	tfirm.c 1138
   0E07 7A 00              3552 	mov	r2,#0x00
   0E09 7B 00              3553 	mov	r3,#0x00
   0E0B                    3554 00124$:
   0E0B C3                 3555 	clr	c
   0E0C EA                 3556 	mov	a,r2
   0E0D 94 E8              3557 	subb	a,#0xE8
   0E0F EB                 3558 	mov	a,r3
   0E10 64 80              3559 	xrl	a,#0x80
   0E12 94 83              3560 	subb	a,#0x83
   0E14 40 03              3561 	jc	00244$
   0E16 02 08 B7           3562 	ljmp	00102$
   0E19                    3563 00244$:
                           3564 ;	tail increment optimized
   0E19 0A                 3565 	inc	r2
   0E1A BA 00 EE           3566 	cjne	r2,#0x00,00124$
   0E1D 0B                 3567 	inc	r3
                           3568 ; Peephole 132   changed ljmp to sjmp
   0E1E 80 EB              3569 	sjmp 00124$
   0E20                    3570 00128$:
   0E20 22                 3571 	ret
                           3572 	.area CSEG    (CODE)
   0E21                    3573 _abromConfigurationDescriptorGroup:
   0E21 09                 3574 	.db #0x09
   0E22 02                 3575 	.db #0x02
   0E23 20                 3576 	.db #0x20
   0E24 00                 3577 	.db #0x00
   0E25 01                 3578 	.db #0x01
   0E26 01                 3579 	.db #0x01
   0E27 00                 3580 	.db #0x00
   0E28 A0                 3581 	.db #0xA0
   0E29 32                 3582 	.db #0x32
   0E2A 09                 3583 	.db #0x09
   0E2B 04                 3584 	.db #0x04
   0E2C 00                 3585 	.db #0x00
   0E2D 00                 3586 	.db #0x00
   0E2E 02                 3587 	.db #0x02
   0E2F FF                 3588 	.db #0xFF
   0E30 01                 3589 	.db #0x01
   0E31 01                 3590 	.db #0x01
   0E32 01                 3591 	.db #0x01
   0E33 07                 3592 	.db #0x07
   0E34 05                 3593 	.db #0x05
   0E35 81                 3594 	.db #0x81
   0E36 02                 3595 	.db #0x02
   0E37 40                 3596 	.db #0x40
   0E38 00                 3597 	.db #0x00
   0E39 00                 3598 	.db #0x00
   0E3A 07                 3599 	.db #0x07
   0E3B 05                 3600 	.db #0x05
   0E3C 01                 3601 	.db #0x01
   0E3D 02                 3602 	.db #0x02
   0E3E 40                 3603 	.db #0x40
   0E3F 00                 3604 	.db #0x00
   0E40 00                 3605 	.db #0x00
   0E41                    3606 _abromDeviceDescriptor:
   0E41 12                 3607 	.db #0x12
   0E42 01                 3608 	.db #0x01
   0E43 10                 3609 	.db #0x10
   0E44 01                 3610 	.db #0x01
   0E45 00                 3611 	.db #0x00
   0E46 00                 3612 	.db #0x00
   0E47 00                 3613 	.db #0x00
   0E48 08                 3614 	.db #0x08
   0E49 FF                 3615 	.db #0xFF
   0E4A FF                 3616 	.db #0xFF
   0E4B FF                 3617 	.db #0xFF
   0E4C FF                 3618 	.db #0xFF
   0E4D 00                 3619 	.db #0x00
   0E4E 01                 3620 	.db #0x01
   0E4F 01                 3621 	.db #0x01
   0E50 02                 3622 	.db #0x02
   0E51 03                 3623 	.db #0x03
   0E52 01                 3624 	.db #0x01
   0E53                    3625 _tUsbRequestList:
   0E53 02                 3626 	.db #0x02
   0E54 03                 3627 	.db #0x03
   0E55 00                 3628 	.db #0x00
   0E56 00                 3629 	.db #0x00
   0E57 FF                 3630 	.db #0xFF
   0E58 00                 3631 	.db #0x00
   0E59 00                 3632 	.db #0x00
   0E5A 00                 3633 	.db #0x00
   0E5B F7                 3634 	.db #0xF7
   0E5C 47 00              3635 	.byte _usbSetEndpointHalt,(_usbSetEndpointHalt >> 8)
   0E5E 02                 3636 	.db #0x02
   0E5F 01                 3637 	.db #0x01
   0E60 00                 3638 	.db #0x00
   0E61 00                 3639 	.db #0x00
   0E62 FF                 3640 	.db #0xFF
   0E63 00                 3641 	.db #0x00
   0E64 00                 3642 	.db #0x00
   0E65 00                 3643 	.db #0x00
   0E66 F7                 3644 	.db #0xF7
   0E67 58 00              3645 	.byte _usbClearEndpointHalt,(_usbClearEndpointHalt >> 8)
   0E69 80                 3646 	.db #0x80
   0E6A 08                 3647 	.db #0x08
   0E6B 00                 3648 	.db #0x00
   0E6C 00                 3649 	.db #0x00
   0E6D 00                 3650 	.db #0x00
   0E6E 00                 3651 	.db #0x00
   0E6F 01                 3652 	.db #0x01
   0E70 00                 3653 	.db #0x00
   0E71 FF                 3654 	.db #0xFF
   0E72 69 00              3655 	.byte _usbGetConfiguration,(_usbGetConfiguration >> 8)
   0E74 00                 3656 	.db #0x00
   0E75 09                 3657 	.db #0x09
   0E76 FF                 3658 	.db #0xFF
   0E77 00                 3659 	.db #0x00
   0E78 00                 3660 	.db #0x00
   0E79 00                 3661 	.db #0x00
   0E7A 00                 3662 	.db #0x00
   0E7B 00                 3663 	.db #0x00
   0E7C DF                 3664 	.db #0xDF
   0E7D 7F 00              3665 	.byte _usbSetConfiguration,(_usbSetConfiguration >> 8)
   0E7F 80                 3666 	.db #0x80
   0E80 06                 3667 	.db #0x06
   0E81 FF                 3668 	.db #0xFF
   0E82 01                 3669 	.db #0x01
   0E83 FF                 3670 	.db #0xFF
   0E84 FF                 3671 	.db #0xFF
   0E85 FF                 3672 	.db #0xFF
   0E86 FF                 3673 	.db #0xFF
   0E87 D0                 3674 	.db #0xD0
   0E88 77 02              3675 	.byte _usbGetDeviceDescriptor,(_usbGetDeviceDescriptor >> 8)
   0E8A 80                 3676 	.db #0x80
   0E8B 06                 3677 	.db #0x06
   0E8C FF                 3678 	.db #0xFF
   0E8D 02                 3679 	.db #0x02
   0E8E FF                 3680 	.db #0xFF
   0E8F FF                 3681 	.db #0xFF
   0E90 FF                 3682 	.db #0xFF
   0E91 FF                 3683 	.db #0xFF
   0E92 D0                 3684 	.db #0xD0
   0E93 FF 01              3685 	.byte _usbGetConfigurationDescriptor,(_usbGetConfigurationDescriptor >> 8)
   0E95 81                 3686 	.db #0x81
   0E96 06                 3687 	.db #0x06
   0E97 FF                 3688 	.db #0xFF
   0E98 21                 3689 	.db #0x21
   0E99 FF                 3690 	.db #0xFF
   0E9A FF                 3691 	.db #0xFF
   0E9B FF                 3692 	.db #0xFF
   0E9C FF                 3693 	.db #0xFF
   0E9D D0                 3694 	.db #0xD0
   0E9E 3D 02              3695 	.byte _usbGetHIDDescriptor,(_usbGetHIDDescriptor >> 8)
   0EA0 80                 3696 	.db #0x80
   0EA1 06                 3697 	.db #0x06
   0EA2 FF                 3698 	.db #0xFF
   0EA3 03                 3699 	.db #0x03
   0EA4 FF                 3700 	.db #0xFF
   0EA5 FF                 3701 	.db #0xFF
   0EA6 FF                 3702 	.db #0xFF
   0EA7 FF                 3703 	.db #0xFF
   0EA8 D0                 3704 	.db #0xD0
   0EA9 EB 02              3705 	.byte _usbGetStringDescriptor,(_usbGetStringDescriptor >> 8)
   0EAB 81                 3706 	.db #0x81
   0EAC 06                 3707 	.db #0x06
   0EAD FF                 3708 	.db #0xFF
   0EAE 22                 3709 	.db #0x22
   0EAF FF                 3710 	.db #0xFF
   0EB0 FF                 3711 	.db #0xFF
   0EB1 FF                 3712 	.db #0xFF
   0EB2 FF                 3713 	.db #0xFF
   0EB3 D0                 3714 	.db #0xD0
   0EB4 F3 01              3715 	.byte _usbGetReportDescriptor,(_usbGetReportDescriptor >> 8)
   0EB6 21                 3716 	.db #0x21
   0EB7 09                 3717 	.db #0x09
   0EB8 FF                 3718 	.db #0xFF
   0EB9 FF                 3719 	.db #0xFF
   0EBA FF                 3720 	.db #0xFF
   0EBB FF                 3721 	.db #0xFF
   0EBC FF                 3722 	.db #0xFF
   0EBD FF                 3723 	.db #0xFF
   0EBE C0                 3724 	.db #0xC0
   0EBF 85 01              3725 	.byte _usbSetReport,(_usbSetReport >> 8)
   0EC1 21                 3726 	.db #0x21
   0EC2 0A                 3727 	.db #0x0A
   0EC3 FF                 3728 	.db #0xFF
   0EC4 FF                 3729 	.db #0xFF
   0EC5 FF                 3730 	.db #0xFF
   0EC6 FF                 3731 	.db #0xFF
   0EC7 00                 3732 	.db #0x00
   0EC8 00                 3733 	.db #0x00
   0EC9 C3                 3734 	.db #0xC3
   0ECA 96 00              3735 	.byte _usbSetIdle,(_usbSetIdle >> 8)
   0ECC 21                 3736 	.db #0x21
   0ECD 0B                 3737 	.db #0x0B
   0ECE FF                 3738 	.db #0xFF
   0ECF FF                 3739 	.db #0xFF
   0ED0 FF                 3740 	.db #0xFF
   0ED1 FF                 3741 	.db #0xFF
   0ED2 00                 3742 	.db #0x00
   0ED3 00                 3743 	.db #0x00
   0ED4 C3                 3744 	.db #0xC3
   0ED5 E9 00              3745 	.byte _usbSetProtocol,(_usbSetProtocol >> 8)
   0ED7 A1                 3746 	.db #0xA1
   0ED8 02                 3747 	.db #0x02
   0ED9 FF                 3748 	.db #0xFF
   0EDA FF                 3749 	.db #0xFF
   0EDB FF                 3750 	.db #0xFF
   0EDC FF                 3751 	.db #0xFF
   0EDD 01                 3752 	.db #0x01
   0EDE 00                 3753 	.db #0x00
   0EDF C3                 3754 	.db #0xC3
   0EE0 A6 00              3755 	.byte _usbGetIdle,(_usbGetIdle >> 8)
   0EE2 A1                 3756 	.db #0xA1
   0EE3 03                 3757 	.db #0x03
   0EE4 FF                 3758 	.db #0xFF
   0EE5 FF                 3759 	.db #0xFF
   0EE6 FF                 3760 	.db #0xFF
   0EE7 FF                 3761 	.db #0xFF
   0EE8 01                 3762 	.db #0x01
   0EE9 00                 3763 	.db #0x00
   0EEA C3                 3764 	.db #0xC3
   0EEB F3 00              3765 	.byte _usbGetProtocol,(_usbGetProtocol >> 8)
   0EED 81                 3766 	.db #0x81
   0EEE 0A                 3767 	.db #0x0A
   0EEF 00                 3768 	.db #0x00
   0EF0 00                 3769 	.db #0x00
   0EF1 FF                 3770 	.db #0xFF
   0EF2 FF                 3771 	.db #0xFF
   0EF3 01                 3772 	.db #0x01
   0EF4 00                 3773 	.db #0x00
   0EF5 F3                 3774 	.db #0xF3
   0EF6 D3 00              3775 	.byte _usbGetInterface,(_usbGetInterface >> 8)
   0EF8 80                 3776 	.db #0x80
   0EF9 00                 3777 	.db #0x00
   0EFA 00                 3778 	.db #0x00
   0EFB 00                 3779 	.db #0x00
   0EFC 00                 3780 	.db #0x00
   0EFD 00                 3781 	.db #0x00
   0EFE 02                 3782 	.db #0x02
   0EFF 00                 3783 	.db #0x00
   0F00 FF                 3784 	.db #0xFF
   0F01 B5 01              3785 	.byte _usbGetDeviceStatus,(_usbGetDeviceStatus >> 8)
   0F03 81                 3786 	.db #0x81
   0F04 00                 3787 	.db #0x00
   0F05 00                 3788 	.db #0x00
   0F06 00                 3789 	.db #0x00
   0F07 FF                 3790 	.db #0xFF
   0F08 00                 3791 	.db #0x00
   0F09 02                 3792 	.db #0x02
   0F0A 00                 3793 	.db #0x00
   0F0B F7                 3794 	.db #0xF7
   0F0C CB 01              3795 	.byte _usbGetInterfaceStatus,(_usbGetInterfaceStatus >> 8)
   0F0E 82                 3796 	.db #0x82
   0F0F 00                 3797 	.db #0x00
   0F10 00                 3798 	.db #0x00
   0F11 00                 3799 	.db #0x00
   0F12 FF                 3800 	.db #0xFF
   0F13 00                 3801 	.db #0x00
   0F14 02                 3802 	.db #0x02
   0F15 00                 3803 	.db #0x00
   0F16 F7                 3804 	.db #0xF7
   0F17 8C 01              3805 	.byte _usbGetEndpointStatus,(_usbGetEndpointStatus >> 8)
   0F19 00                 3806 	.db #0x00
   0F1A 05                 3807 	.db #0x05
   0F1B FF                 3808 	.db #0xFF
   0F1C 00                 3809 	.db #0x00
   0F1D 00                 3810 	.db #0x00
   0F1E 00                 3811 	.db #0x00
   0F1F 00                 3812 	.db #0x00
   0F20 00                 3813 	.db #0x00
   0F21 DF                 3814 	.db #0xDF
   0F22 09 01              3815 	.byte _usbSetAddress,(_usbSetAddress >> 8)
   0F24 00                 3816 	.db #0x00
   0F25 03                 3817 	.db #0x03
   0F26 01                 3818 	.db #0x01
   0F27 00                 3819 	.db #0x00
   0F28 00                 3820 	.db #0x00
   0F29 00                 3821 	.db #0x00
   0F2A 00                 3822 	.db #0x00
   0F2B 00                 3823 	.db #0x00
   0F2C FF                 3824 	.db #0xFF
   0F2D 39 01              3825 	.byte _usbSetRemoteWakeup,(_usbSetRemoteWakeup >> 8)
   0F2F 00                 3826 	.db #0x00
   0F30 01                 3827 	.db #0x01
   0F31 01                 3828 	.db #0x01
   0F32 00                 3829 	.db #0x00
   0F33 00                 3830 	.db #0x00
   0F34 00                 3831 	.db #0x00
   0F35 00                 3832 	.db #0x00
   0F36 00                 3833 	.db #0x00
   0F37 FF                 3834 	.db #0xFF
   0F38 5F 01              3835 	.byte _usbClearRemoteWakeup,(_usbClearRemoteWakeup >> 8)
   0F3A 01                 3836 	.db #0x01
   0F3B 0B                 3837 	.db #0x0B
   0F3C FF                 3838 	.db #0xFF
   0F3D 00                 3839 	.db #0x00
   0F3E FF                 3840 	.db #0xFF
   0F3F 00                 3841 	.db #0x00
   0F40 00                 3842 	.db #0x00
   0F41 00                 3843 	.db #0x00
   0F42 D7                 3844 	.db #0xD7
   0F43 BC 00              3845 	.byte _usbSetInterface,(_usbSetInterface >> 8)
   0F45 FF                 3846 	.db #0xFF
   0F46 FF                 3847 	.db #0xFF
   0F47 FF                 3848 	.db #0xFF
   0F48 FF                 3849 	.db #0xFF
   0F49 FF                 3850 	.db #0xFF
   0F4A FF                 3851 	.db #0xFF
   0F4B FF                 3852 	.db #0xFF
   0F4C FF                 3853 	.db #0xFF
   0F4D 00                 3854 	.db #0x00
   0F4E 06 03              3855 	.byte _usbNonStandardRequest,(_usbNonStandardRequest >> 8)
