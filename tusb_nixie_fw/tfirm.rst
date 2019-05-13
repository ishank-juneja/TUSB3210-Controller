                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.0 Mon May 13 16:50:08 2019
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
   0057                     285 __start__stack:
   0057                     286 	.ds	1
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
   0000 02 0A B8            320 	ljmp	__sdcc_gsinit_startup
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
   0AB8                     339 __sdcc_gsinit_startup:
   0AB8 75 81 07            340 	mov	sp,#7
   0ABB 12 0A 5B            341 	lcall	__sdcc_external_startup
   0ABE E5 82               342 	mov	a,dpl
   0AC0 60 03               343 	jz	__sdcc_init_data
   0AC2 02 00 33            344 	ljmp	__sdcc_program_startup
   0AC5                     345 __sdcc_init_data:
                            346 ;	tfirm.c 12
   0AC5 75 30 00            347 	mov	_deviceReady,#0x00
                            348 ;	tfirm.c 15
   0AC8 E4                  349 	clr	a
   0AC9 F5 34               350 	mov	(_wDeviceFeatures + 1),a
   0ACB F5 33               351 	mov	_wDeviceFeatures,a
                            352 ;	tfirm.c 20
   0ACD 75 3F 00            353 	mov	_bConfigurationNumber,#0x00
                            354 ;	tfirm.c 21
   0AD0 75 40 00            355 	mov	_bInterfaceNumber,#0x00
                            356 ;	tfirm.c 23
   0AD3 75 41 00            357 	mov	_bSuspended,#0x00
                            358 ;	tfirm.c 27
   0AD6 75 44 01            359 	mov	_gbProtocol,#0x01
                            360 ;	tfirm.c 75
   0AD9 75 4E 00            361 	mov	_total,#0x00
                            362 	.area GSFINAL (CODE)
   0ADC 02 00 33            363 	ljmp	__sdcc_program_startup
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
                            380 ;	tfirm.c 77
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
                            393 ;	tfirm.c 78
   0038 75 35 FF            394 	mov	_wBytesRemainingOnIEP0,#0xFF
   003B 75 36 FF            395 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                            396 ;	tfirm.c 79
   003E 75 31 00            397 	mov	_bStatusAction,#0x00
                            398 ;	tfirm.c 80
   0041 90 FF 81            399 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
                            400 ; Peephole 180   changed mov to clr
   0044 E4                  401 	clr  a
   0045 F0                  402 	movx	@dptr,a
   0046                     403 00101$:
   0046 22                  404 	ret
                            405 ;------------------------------------------------------------
                            406 ;Allocation info for local variables in function 'usbSetEndpointHalt'
                            407 ;------------------------------------------------------------
                            408 ;	tfirm.c 83
                            409 ;	-----------------------------------------
                            410 ;	 function usbSetEndpointHalt
                            411 ;	-----------------------------------------
   0047                     412 _usbSetEndpointHalt:
                            413 ;	tfirm.c 84
   0047 90 FF 48            414 	mov	dptr,#_tInputEndPointDescriptorBlock
   004A E0                  415 	movx	a,@dptr
   004B FA                  416 	mov	r2,a
   004C 53 02 7F            417 	anl	ar2,#0x7F
   004F 90 FF 48            418 	mov	dptr,#_tInputEndPointDescriptorBlock
   0052 EA                  419 	mov	a,r2
   0053 F0                  420 	movx	@dptr,a
                            421 ;	tfirm.c 85
   0054 12 00 38            422 	lcall	_usbSendZeroLengthPacketOnIEP0
   0057                     423 00101$:
   0057 22                  424 	ret
                            425 ;------------------------------------------------------------
                            426 ;Allocation info for local variables in function 'usbClearEndpointHalt'
                            427 ;------------------------------------------------------------
                            428 ;	tfirm.c 88
                            429 ;	-----------------------------------------
                            430 ;	 function usbClearEndpointHalt
                            431 ;	-----------------------------------------
   0058                     432 _usbClearEndpointHalt:
                            433 ;	tfirm.c 89
   0058 90 FF 48            434 	mov	dptr,#_tInputEndPointDescriptorBlock
   005B E0                  435 	movx	a,@dptr
   005C FA                  436 	mov	r2,a
   005D 43 02 80            437 	orl	ar2,#0x80
   0060 90 FF 48            438 	mov	dptr,#_tInputEndPointDescriptorBlock
   0063 EA                  439 	mov	a,r2
   0064 F0                  440 	movx	@dptr,a
                            441 ;	tfirm.c 90
   0065 12 00 38            442 	lcall	_usbSendZeroLengthPacketOnIEP0
   0068                     443 00101$:
   0068 22                  444 	ret
                            445 ;------------------------------------------------------------
                            446 ;Allocation info for local variables in function 'usbGetConfiguration'
                            447 ;------------------------------------------------------------
                            448 ;	tfirm.c 94
                            449 ;	-----------------------------------------
                            450 ;	 function usbGetConfiguration
                            451 ;	-----------------------------------------
   0069                     452 _usbGetConfiguration:
                            453 ;	tfirm.c 95
   0069 E4                  454 	clr	a
   006A F5 36               455 	mov	(_wBytesRemainingOnIEP0 + 1),a
   006C 75 35 01            456 	mov	_wBytesRemainingOnIEP0,#0x01
                            457 ;	tfirm.c 96
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
                            470 ;	tfirm.c 99
                            471 ;	-----------------------------------------
                            472 ;	 function usbSetConfiguration
                            473 ;	-----------------------------------------
   007F                     474 _usbSetConfiguration:
                            475 ;	tfirm.c 100
   007F 90 FF 82            476 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0082 E0                  477 	movx	a,@dptr
   0083 FA                  478 	mov	r2,a
   0084 43 02 08            479 	orl	ar2,#0x08
   0087 90 FF 82            480 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   008A EA                  481 	mov	a,r2
   008B F0                  482 	movx	@dptr,a
                            483 ;	tfirm.c 101
   008C 90 FF 02            484 	mov	dptr,#(_tSetupPacket + 0x0002)
   008F E0                  485 	movx	a,@dptr
   0090 F5 3F               486 	mov	_bConfigurationNumber,a
                            487 ;	tfirm.c 102
   0092 12 00 38            488 	lcall	_usbSendZeroLengthPacketOnIEP0
   0095                     489 00101$:
   0095 22                  490 	ret
                            491 ;------------------------------------------------------------
                            492 ;Allocation info for local variables in function 'usbSetIdle'
                            493 ;------------------------------------------------------------
                            494 ;	tfirm.c 105
                            495 ;	-----------------------------------------
                            496 ;	 function usbSetIdle
                            497 ;	-----------------------------------------
   0096                     498 _usbSetIdle:
                            499 ;	tfirm.c 106
   0096 90 FF 02            500 	mov	dptr,#(_tSetupPacket + 0x0002)
   0099 E0                  501 	movx	a,@dptr
   009A F5 42               502 	mov	_gbIdleRateL,a
                            503 ;	tfirm.c 107
   009C 90 FF 03            504 	mov	dptr,#(_tSetupPacket + 0x0003)
   009F E0                  505 	movx	a,@dptr
   00A0 F5 43               506 	mov	_gbIdleRateH,a
                            507 ;	tfirm.c 108
   00A2 12 00 38            508 	lcall	_usbSendZeroLengthPacketOnIEP0
   00A5                     509 00101$:
   00A5 22                  510 	ret
                            511 ;------------------------------------------------------------
                            512 ;Allocation info for local variables in function 'usbGetIdle'
                            513 ;------------------------------------------------------------
                            514 ;	tfirm.c 111
                            515 ;	-----------------------------------------
                            516 ;	 function usbGetIdle
                            517 ;	-----------------------------------------
   00A6                     518 _usbGetIdle:
                            519 ;	tfirm.c 112
   00A6 E4                  520 	clr	a
   00A7 F5 36               521 	mov	(_wBytesRemainingOnIEP0 + 1),a
   00A9 75 35 01            522 	mov	_wBytesRemainingOnIEP0,#0x01
                            523 ;	tfirm.c 113
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
                            536 ;	tfirm.c 116
                            537 ;	-----------------------------------------
                            538 ;	 function usbSetInterface
                            539 ;	-----------------------------------------
   00BC                     540 _usbSetInterface:
                            541 ;	tfirm.c 117
   00BC 90 FF 82            542 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   00BF E0                  543 	movx	a,@dptr
   00C0 FA                  544 	mov	r2,a
   00C1 43 02 08            545 	orl	ar2,#0x08
   00C4 90 FF 82            546 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   00C7 EA                  547 	mov	a,r2
   00C8 F0                  548 	movx	@dptr,a
                            549 ;	tfirm.c 118
   00C9 90 FF 04            550 	mov	dptr,#(_tSetupPacket + 0x0004)
   00CC E0                  551 	movx	a,@dptr
   00CD F5 40               552 	mov	_bInterfaceNumber,a
                            553 ;	tfirm.c 119
   00CF 12 00 38            554 	lcall	_usbSendZeroLengthPacketOnIEP0
   00D2                     555 00101$:
   00D2 22                  556 	ret
                            557 ;------------------------------------------------------------
                            558 ;Allocation info for local variables in function 'usbGetInterface'
                            559 ;------------------------------------------------------------
                            560 ;	tfirm.c 122
                            561 ;	-----------------------------------------
                            562 ;	 function usbGetInterface
                            563 ;	-----------------------------------------
   00D3                     564 _usbGetInterface:
                            565 ;	tfirm.c 123
   00D3 E4                  566 	clr	a
   00D4 F5 36               567 	mov	(_wBytesRemainingOnIEP0 + 1),a
   00D6 75 35 01            568 	mov	_wBytesRemainingOnIEP0,#0x01
                            569 ;	tfirm.c 124
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
                            582 ;	tfirm.c 128
                            583 ;	-----------------------------------------
                            584 ;	 function usbSetProtocol
                            585 ;	-----------------------------------------
   00E9                     586 _usbSetProtocol:
                            587 ;	tfirm.c 129
   00E9 90 FF 02            588 	mov	dptr,#(_tSetupPacket + 0x0002)
   00EC E0                  589 	movx	a,@dptr
   00ED F5 44               590 	mov	_gbProtocol,a
                            591 ;	tfirm.c 130
   00EF 12 00 38            592 	lcall	_usbSendZeroLengthPacketOnIEP0
   00F2                     593 00101$:
   00F2 22                  594 	ret
                            595 ;------------------------------------------------------------
                            596 ;Allocation info for local variables in function 'usbGetProtocol'
                            597 ;------------------------------------------------------------
                            598 ;	tfirm.c 133
                            599 ;	-----------------------------------------
                            600 ;	 function usbGetProtocol
                            601 ;	-----------------------------------------
   00F3                     602 _usbGetProtocol:
                            603 ;	tfirm.c 134
   00F3 E4                  604 	clr	a
   00F4 F5 36               605 	mov	(_wBytesRemainingOnIEP0 + 1),a
   00F6 75 35 01            606 	mov	_wBytesRemainingOnIEP0,#0x01
                            607 ;	tfirm.c 135
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
                            620 ;	tfirm.c 139
                            621 ;	-----------------------------------------
                            622 ;	 function usbSetAddress
                            623 ;	-----------------------------------------
   0109                     624 _usbSetAddress:
                            625 ;	tfirm.c 140
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
                            638 ;	tfirm.c 142
   0119 7A FF               639 	mov	r2,#0xFF
   011B 7B FF               640 	mov	r3,#0xFF
   011D 90 FF 02            641 	mov	dptr,#(_tSetupPacket + 0x0002)
   0120 E0                  642 	movx	a,@dptr
                            643 ; Peephole 136   removed redundant moves
   0121 FC                  644 	mov  r4,a
   0122 8A 82               645 	mov  dpl,r2
   0124 8B 83               646 	mov  dph,r3
   0126 F0                  647 	movx	@dptr,a
                            648 ;	tfirm.c 143
   0127 90 FF 02            649 	mov	dptr,#(_tSetupPacket + 0x0002)
   012A E0                  650 	movx	a,@dptr
   012B F5 32               651 	mov	_bUsbDeviceAddress,a
                            652 ;	tfirm.c 144
   012D 75 31 03            653 	mov	_bStatusAction,#0x03
                            654 ;	tfirm.c 145
   0130 12 00 38            655 	lcall	_usbSendZeroLengthPacketOnIEP0
                            656 ; Peephole 132   changed ljmp to sjmp
   0133 80 03               657 	sjmp 00104$
   0135                     658 00102$:
                            659 ;	tfirm.c 148
   0135 12 03 0A            660 	lcall	_usbStallEndpoint0
   0138                     661 00104$:
   0138 22                  662 	ret
                            663 ;------------------------------------------------------------
                            664 ;Allocation info for local variables in function 'usbSetRemoteWakeup'
                            665 ;------------------------------------------------------------
                            666 ;	tfirm.c 152
                            667 ;	-----------------------------------------
                            668 ;	 function usbSetRemoteWakeup
                            669 ;	-----------------------------------------
   0139                     670 _usbSetRemoteWakeup:
                            671 ;	tfirm.c 153
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
                            683 ;	tfirm.c 154
   014B 43 34 02            684 	orl	(_wDeviceFeatures + 1),#0x02
                            685 ;	tfirm.c 155
   014E 90 FF 82            686 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0151 E0                  687 	movx	a,@dptr
   0152 FA                  688 	mov	r2,a
   0153 43 02 08            689 	orl	ar2,#0x08
   0156 90 FF 82            690 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0159 EA                  691 	mov	a,r2
   015A F0                  692 	movx	@dptr,a
                            693 ;	tfirm.c 156
   015B 12 00 38            694 	lcall	_usbSendZeroLengthPacketOnIEP0
   015E                     695 00101$:
   015E 22                  696 	ret
                            697 ;------------------------------------------------------------
                            698 ;Allocation info for local variables in function 'usbClearRemoteWakeup'
                            699 ;------------------------------------------------------------
                            700 ;	tfirm.c 159
                            701 ;	-----------------------------------------
                            702 ;	 function usbClearRemoteWakeup
                            703 ;	-----------------------------------------
   015F                     704 _usbClearRemoteWakeup:
                            705 ;	tfirm.c 160
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
                            717 ;	tfirm.c 161
   0171 53 34 FD            718 	anl	(_wDeviceFeatures + 1),#0xFD
                            719 ;	tfirm.c 162
   0174 90 FF 82            720 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0177 E0                  721 	movx	a,@dptr
   0178 FA                  722 	mov	r2,a
   0179 43 02 08            723 	orl	ar2,#0x08
   017C 90 FF 82            724 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   017F EA                  725 	mov	a,r2
   0180 F0                  726 	movx	@dptr,a
                            727 ;	tfirm.c 163
   0181 12 00 38            728 	lcall	_usbSendZeroLengthPacketOnIEP0
   0184                     729 00101$:
   0184 22                  730 	ret
                            731 ;------------------------------------------------------------
                            732 ;Allocation info for local variables in function 'usbSetReport'
                            733 ;------------------------------------------------------------
                            734 ;	tfirm.c 166
                            735 ;	-----------------------------------------
                            736 ;	 function usbSetReport
                            737 ;	-----------------------------------------
   0185                     738 _usbSetReport:
                            739 ;	tfirm.c 167
   0185 E4                  740 	clr	a
   0186 F5 38               741 	mov	(_wBytesRemainingOnOEP0 + 1),a
   0188 75 37 01            742 	mov	_wBytesRemainingOnOEP0,#0x01
   018B                     743 00101$:
   018B 22                  744 	ret
                            745 ;------------------------------------------------------------
                            746 ;Allocation info for local variables in function 'usbGetEndpointStatus'
                            747 ;------------------------------------------------------------
                            748 ;wEndpointStatus           Allocated to in memory with name '_usbGetEndpointStatus_wEndpointStatus_1_1'
                            749 ;	tfirm.c 171
                            750 ;	-----------------------------------------
                            751 ;	 function usbGetEndpointStatus
                            752 ;	-----------------------------------------
   018C                     753 _usbGetEndpointStatus:
                            754 ;	tfirm.c 172
   018C 75 4F 00            755 	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,#0x00
   018F 75 50 01            756 	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),#0x01
                            757 ;	tfirm.c 173
   0192 90 FF 48            758 	mov	dptr,#_tInputEndPointDescriptorBlock
   0195 E0                  759 	movx	a,@dptr
                            760 ; Peephole 105   removed redundant mov
   0196 FA                  761 	mov  r2,a
                            762 ; Peephole 111   removed ljmp by inverse jump logic
   0197 30 E7 05            763 	jnb  acc.7,00102$
   019A                     764 00106$:
                            765 ;	tfirm.c 174
   019A E4                  766 	clr	a
   019B F5 50               767 	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),a
   019D F5 4F               768 	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,a
   019F                     769 00102$:
                            770 ;	tfirm.c 176
   019F E4                  771 	clr	a
   01A0 F5 36               772 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01A2 75 35 02            773 	mov	_wBytesRemainingOnIEP0,#0x02
                            774 ;	tfirm.c 177
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
                            787 ;	tfirm.c 180
                            788 ;	-----------------------------------------
                            789 ;	 function usbGetDeviceStatus
                            790 ;	-----------------------------------------
   01B5                     791 _usbGetDeviceStatus:
                            792 ;	tfirm.c 181
   01B5 E4                  793 	clr	a
   01B6 F5 36               794 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01B8 75 35 02            795 	mov	_wBytesRemainingOnIEP0,#0x02
                            796 ;	tfirm.c 182
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
                            810 ;	tfirm.c 185
                            811 ;	-----------------------------------------
                            812 ;	 function usbGetInterfaceStatus
                            813 ;	-----------------------------------------
   01CB                     814 _usbGetInterfaceStatus:
                            815 ;	tfirm.c 186
   01CB E4                  816 	clr	a
   01CC F5 52               817 	mov	(_usbGetInterfaceStatus_wStatusBuffer_1_1 + 1),a
   01CE F5 51               818 	mov	_usbGetInterfaceStatus_wStatusBuffer_1_1,a
                            819 ;	tfirm.c 187
   01D0 90 FF 82            820 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   01D3 E0                  821 	movx	a,@dptr
   01D4 FA                  822 	mov	r2,a
   01D5 43 02 08            823 	orl	ar2,#0x08
   01D8 90 FF 82            824 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   01DB EA                  825 	mov	a,r2
   01DC F0                  826 	movx	@dptr,a
                            827 ;	tfirm.c 188
   01DD E4                  828 	clr	a
   01DE F5 36               829 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01E0 75 35 02            830 	mov	_wBytesRemainingOnIEP0,#0x02
                            831 ;	tfirm.c 189
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
                            844 ;	tfirm.c 193
                            845 ;	-----------------------------------------
                            846 ;	 function usbGetReportDescriptor
                            847 ;	-----------------------------------------
   01F3                     848 _usbGetReportDescriptor:
                            849 ;	tfirm.c 194
   01F3 90 FF 83            850 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                            851 ; Peephole 180   changed mov to clr
   01F6 E4                  852 	clr  a
   01F7 F0                  853 	movx	@dptr,a
                            854 ;	tfirm.c 195
   01F8 E4                  855 	clr	a
   01F9 F5 36               856 	mov	(_wBytesRemainingOnIEP0 + 1),a
   01FB 75 35 3F            857 	mov	_wBytesRemainingOnIEP0,#0x3F
   01FE                     858 00101$:
   01FE 22                  859 	ret
                            860 ;------------------------------------------------------------
                            861 ;Allocation info for local variables in function 'usbGetConfigurationDescriptor'
                            862 ;------------------------------------------------------------
                            863 ;bTemp                     Allocated to registers 
                            864 ;	tfirm.c 199
                            865 ;	-----------------------------------------
                            866 ;	 function usbGetConfigurationDescriptor
                            867 ;	-----------------------------------------
   01FF                     868 _usbGetConfigurationDescriptor:
                            869 ;	tfirm.c 202
   01FF 7A 00               870 	mov	r2,#0x00
   0201                     871 00101$:
   0201 BA 20 00            872 	cjne	r2,#0x20,00109$
   0204                     873 00109$:
                            874 ; Peephole 108   removed ljmp by inverse jump logic
   0204 50 16               875 	jnc  00104$
   0206                     876 00110$:
                            877 ;	tfirm.c 203
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
   020F 90 08 B2            888 	mov  dptr,#_abromConfigurationDescriptorGroup
   0212 93                  889 	movc a,@a+dptr
                            890 ; Peephole 136   removed redundant moves
   0213 FD                  891 	mov  r5,a
   0214 8B 82               892 	mov  dpl,r3
   0216 8C 83               893 	mov  dph,r4
   0218 F0                  894 	movx	@dptr,a
                            895 ;	tfirm.c 202
   0219 0A                  896 	inc	r2
                            897 ; Peephole 132   changed ljmp to sjmp
   021A 80 E5               898 	sjmp 00101$
   021C                     899 00104$:
                            900 ;	tfirm.c 205
   021C 90 FE 87            901 	mov	dptr,#(_abDescriptor + 0x0007)
   021F 74 80               902 	mov	a,#0x80
   0221 F0                  903 	movx	@dptr,a
                            904 ;	tfirm.c 207
   0222 90 FF 83            905 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                            906 ; Peephole 180   changed mov to clr
   0225 E4                  907 	clr  a
   0226 F0                  908 	movx	@dptr,a
                            909 ;	tfirm.c 208
   0227 E4                  910 	clr	a
   0228 F5 36               911 	mov	(_wBytesRemainingOnIEP0 + 1),a
   022A 75 35 20            912 	mov	_wBytesRemainingOnIEP0,#0x20
                            913 ;	tfirm.c 209
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
                            927 ;	tfirm.c 213
                            928 ;	-----------------------------------------
                            929 ;	 function usbGetHIDDescriptor
                            930 ;	-----------------------------------------
   023D                     931 _usbGetHIDDescriptor:
                            932 ;	tfirm.c 216
   023D 7A 00               933 	mov	r2,#0x00
   023F                     934 00101$:
   023F BA 12 00            935 	cjne	r2,#0x12,00109$
   0242                     936 00109$:
                            937 ; Peephole 108   removed ljmp by inverse jump logic
   0242 50 18               938 	jnc  00104$
   0244                     939 00110$:
                            940 ;	tfirm.c 217
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
   024F 90 08 B2            952 	mov  dptr,#_abromConfigurationDescriptorGroup
   0252 93                  953 	movc a,@a+dptr
                            954 ; Peephole 136   removed redundant moves
   0253 FD                  955 	mov  r5,a
   0254 8B 82               956 	mov  dpl,r3
   0256 8C 83               957 	mov  dph,r4
   0258 F0                  958 	movx	@dptr,a
                            959 ;	tfirm.c 216
   0259 0A                  960 	inc	r2
                            961 ; Peephole 132   changed ljmp to sjmp
   025A 80 E3               962 	sjmp 00101$
   025C                     963 00104$:
                            964 ;	tfirm.c 219
   025C 90 FF 83            965 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                            966 ; Peephole 180   changed mov to clr
   025F E4                  967 	clr  a
   0260 F0                  968 	movx	@dptr,a
                            969 ;	tfirm.c 220
   0261 E4                  970 	clr	a
   0262 F5 36               971 	mov	(_wBytesRemainingOnIEP0 + 1),a
   0264 75 35 09            972 	mov	_wBytesRemainingOnIEP0,#0x09
                            973 ;	tfirm.c 221
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
                            987 ;	tfirm.c 224
                            988 ;	-----------------------------------------
                            989 ;	 function usbGetDeviceDescriptor
                            990 ;	-----------------------------------------
   0277                     991 _usbGetDeviceDescriptor:
                            992 ;	tfirm.c 227
   0277 7A 00               993 	mov	r2,#0x00
   0279                     994 00101$:
   0279 BA 12 00            995 	cjne	r2,#0x12,00109$
   027C                     996 00109$:
                            997 ; Peephole 108   removed ljmp by inverse jump logic
   027C 50 16               998 	jnc  00104$
   027E                     999 00110$:
                           1000 ;	tfirm.c 228
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
   0287 90 08 D2           1011 	mov  dptr,#_abromDeviceDescriptor
   028A 93                 1012 	movc a,@a+dptr
                           1013 ; Peephole 136   removed redundant moves
   028B FD                 1014 	mov  r5,a
   028C 8B 82              1015 	mov  dpl,r3
   028E 8C 83              1016 	mov  dph,r4
   0290 F0                 1017 	movx	@dptr,a
                           1018 ;	tfirm.c 227
   0291 0A                 1019 	inc	r2
                           1020 ; Peephole 132   changed ljmp to sjmp
   0292 80 E5              1021 	sjmp 00101$
   0294                    1022 00104$:
                           1023 ;	tfirm.c 230
   0294 90 FE 84           1024 	mov	dptr,#(_abDescriptor + 0x0004)
   0297 74 FF              1025 	mov	a,#0xFF
   0299 F0                 1026 	movx	@dptr,a
                           1027 ;	tfirm.c 231
   029A 90 FE 88           1028 	mov	dptr,#(_abDescriptor + 0x0008)
   029D 74 51              1029 	mov	a,#0x51
   029F F0                 1030 	movx	@dptr,a
                           1031 ;	tfirm.c 232
   02A0 90 FE 89           1032 	mov	dptr,#(_abDescriptor + 0x0009)
   02A3 74 04              1033 	mov	a,#0x04
   02A5 F0                 1034 	movx	@dptr,a
                           1035 ;	tfirm.c 233
   02A6 90 FE 8A           1036 	mov	dptr,#(_abDescriptor + 0x000a)
   02A9 74 10              1037 	mov	a,#0x10
   02AB F0                 1038 	movx	@dptr,a
                           1039 ;	tfirm.c 234
   02AC 90 FE 8B           1040 	mov	dptr,#(_abDescriptor + 0x000b)
   02AF 74 32              1041 	mov	a,#0x32
   02B1 F0                 1042 	movx	@dptr,a
                           1043 ;	tfirm.c 235
   02B2 90 FE 8C           1044 	mov	dptr,#(_abDescriptor + 0x000c)
                           1045 ; Peephole 180   changed mov to clr
   02B5 E4                 1046 	clr  a
   02B6 F0                 1047 	movx	@dptr,a
                           1048 ;	tfirm.c 236
   02B7 90 FE 8D           1049 	mov	dptr,#(_abDescriptor + 0x000d)
   02BA 74 01              1050 	mov	a,#0x01
   02BC F0                 1051 	movx	@dptr,a
                           1052 ;	tfirm.c 238
   02BD 90 FE 8E           1053 	mov	dptr,#(_abDescriptor + 0x000e)
                           1054 ; Peephole 180   changed mov to clr
   02C0 E4                 1055 	clr  a
   02C1 F0                 1056 	movx	@dptr,a
                           1057 ;	tfirm.c 239
   02C2 90 FE 8F           1058 	mov	dptr,#(_abDescriptor + 0x000f)
                           1059 ; Peephole 180   changed mov to clr
   02C5 E4                 1060 	clr  a
   02C6 F0                 1061 	movx	@dptr,a
                           1062 ;	tfirm.c 240
   02C7 90 FE 90           1063 	mov	dptr,#(_abDescriptor + 0x0010)
   02CA 74 01              1064 	mov	a,#0x01
   02CC F0                 1065 	movx	@dptr,a
                           1066 ;	tfirm.c 242
   02CD 90 FF 83           1067 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1068 ; Peephole 180   changed mov to clr
   02D0 E4                 1069 	clr  a
   02D1 F0                 1070 	movx	@dptr,a
                           1071 ;	tfirm.c 243
   02D2 E4                 1072 	clr	a
   02D3 F5 36              1073 	mov	(_wBytesRemainingOnIEP0 + 1),a
   02D5 75 35 12           1074 	mov	_wBytesRemainingOnIEP0,#0x12
                           1075 ;	tfirm.c 244
   02D8 7A 80              1076 	mov	r2,#_abDescriptor
   02DA 7B FE              1077 	mov	r3,#(_abDescriptor >> 8)
   02DC 7C 01              1078 	mov	r4,#0x01
   02DE 8A 82              1079 	mov	dpl,r2
   02E0 8B 83              1080 	mov	dph,r3
   02E2 8C F0              1081 	mov	b,r4
   02E4 12 05 48           1082 	lcall	_usbSendDataPacketOnEP0
                           1083 ;	tfirm.c 248
   02E7 75 30 01           1084 	mov	_deviceReady,#0x01
   02EA                    1085 00105$:
   02EA 22                 1086 	ret
                           1087 ;------------------------------------------------------------
                           1088 ;Allocation info for local variables in function 'usbGetStringDescriptor'
                           1089 ;------------------------------------------------------------
                           1090 ;	tfirm.c 252
                           1091 ;	-----------------------------------------
                           1092 ;	 function usbGetStringDescriptor
                           1093 ;	-----------------------------------------
   02EB                    1094 _usbGetStringDescriptor:
                           1095 ;	tfirm.c 254
   02EB 90 FF 83           1096 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1097 ; Peephole 180   changed mov to clr
   02EE E4                 1098 	clr  a
   02EF F0                 1099 	movx	@dptr,a
                           1100 ;	tfirm.c 255
   02F0 E4                 1101 	clr	a
   02F1 F5 36              1102 	mov	(_wBytesRemainingOnIEP0 + 1),a
   02F3 75 35 12           1103 	mov	_wBytesRemainingOnIEP0,#0x12
                           1104 ;	tfirm.c 256
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
                           1117 ;	tfirm.c 260
                           1118 ;	-----------------------------------------
                           1119 ;	 function usbNonStandardRequest
                           1120 ;	-----------------------------------------
   0306                    1121 _usbNonStandardRequest:
                           1122 ;	tfirm.c 261
   0306 12 03 0A           1123 	lcall	_usbStallEndpoint0
   0309                    1124 00101$:
   0309 22                 1125 	ret
                           1126 ;------------------------------------------------------------
                           1127 ;Allocation info for local variables in function 'usbStallEndpoint0'
                           1128 ;------------------------------------------------------------
                           1129 ;	tfirm.c 264
                           1130 ;	-----------------------------------------
                           1131 ;	 function usbStallEndpoint0
                           1132 ;	-----------------------------------------
   030A                    1133 _usbStallEndpoint0:
                           1134 ;	tfirm.c 265
   030A 90 FF 80           1135 	mov	dptr,#_tEndPoint0DescriptorBlock
   030D E0                 1136 	movx	a,@dptr
   030E FA                 1137 	mov	r2,a
   030F 43 02 08           1138 	orl	ar2,#0x08
   0312 90 FF 80           1139 	mov	dptr,#_tEndPoint0DescriptorBlock
   0315 EA                 1140 	mov	a,r2
   0316 F0                 1141 	movx	@dptr,a
                           1142 ;	tfirm.c 266
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
                           1155 ;	tfirm.c 479
                           1156 ;	-----------------------------------------
                           1157 ;	 function usbReset
                           1158 ;	-----------------------------------------
   0325                    1159 _usbReset:
                           1160 ;	tfirm.c 480
                           1161 ; Peephole 182   used 16 bit load of dptr
   0325 90 FF FF           1162 	mov  dptr,#(((0xFF)<<8) + 0xFF)
                           1163 ; Peephole 180   changed mov to clr
   0328 E4                 1164 	clr  a
   0329 F0                 1165 	movx	@dptr,a
                           1166 ;	tfirm.c 482
   032A 75 35 FF           1167 	mov	_wBytesRemainingOnIEP0,#0xFF
   032D 75 36 FF           1168 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                           1169 ;	tfirm.c 483
   0330 75 37 FF           1170 	mov	_wBytesRemainingOnOEP0,#0xFF
   0333 75 38 FF           1171 	mov	(_wBytesRemainingOnOEP0 + 1),#0xFF
                           1172 ;	tfirm.c 484
                           1173 ;	tfirm.c 486
                           1174 ; Peephole 3.b   changed mov to clr
   0336 E4                 1175 	clr  a
   0337 F5 31              1176 	mov  _bStatusAction,a
   0339 F5 3B              1177 	mov	(_pbIEP0Buffer + 2),a
   033B F5 3A              1178 	mov	(_pbIEP0Buffer + 1),a
   033D F5 39              1179 	mov	_pbIEP0Buffer,a
                           1180 ;	tfirm.c 487
   033F E4                 1181 	clr	a
   0340 F5 3E              1182 	mov	(_pbOEP0Buffer + 2),a
   0342 F5 3D              1183 	mov	(_pbOEP0Buffer + 1),a
   0344 F5 3C              1184 	mov	_pbOEP0Buffer,a
                           1185 ;	tfirm.c 489
   0346 75 3F 00           1186 	mov	_bConfigurationNumber,#0x00
                           1187 ;	tfirm.c 490
   0349 75 40 00           1188 	mov	_bInterfaceNumber,#0x00
                           1189 ;	tfirm.c 492
   034C 90 FF 80           1190 	mov	dptr,#_tEndPoint0DescriptorBlock
   034F 74 84              1191 	mov	a,#0x84
   0351 F0                 1192 	movx	@dptr,a
                           1193 ;	tfirm.c 493
   0352 90 FF 82           1194 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0355 74 84              1195 	mov	a,#0x84
   0357 F0                 1196 	movx	@dptr,a
                           1197 ;	tfirm.c 495
   0358 90 FF 81           1198 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
   035B 74 80              1199 	mov	a,#0x80
   035D F0                 1200 	movx	@dptr,a
                           1201 ;	tfirm.c 496
   035E 90 FF 83           1202 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
   0361 74 80              1203 	mov	a,#0x80
   0363 F0                 1204 	movx	@dptr,a
                           1205 ;	tfirm.c 499
   0364 90 FF 48           1206 	mov	dptr,#_tInputEndPointDescriptorBlock
                           1207 ; Peephole 180   changed mov to clr
   0367 E4                 1208 	clr  a
   0368 F0                 1209 	movx	@dptr,a
                           1210 ;	tfirm.c 500
   0369 90 FF 48           1211 	mov	dptr,#_tInputEndPointDescriptorBlock
   036C 74 84              1212 	mov	a,#0x84
   036E F0                 1213 	movx	@dptr,a
                           1214 ;	tfirm.c 501
   036F 90 FF 49           1215 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0001)
   0372 74 C0              1216 	mov	a,#0xC0
   0374 F0                 1217 	movx	@dptr,a
                           1218 ;	tfirm.c 502
   0375 90 FF 4A           1219 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
   0378 74 80              1220 	mov	a,#0x80
   037A F0                 1221 	movx	@dptr,a
                           1222 ;	tfirm.c 503
   037B 90 FF 4F           1223 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0007)
   037E 74 40              1224 	mov	a,#0x40
   0380 F0                 1225 	movx	@dptr,a
                           1226 ;	tfirm.c 504
   0381 90 FF 4A           1227 	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
   0384 74 80              1228 	mov	a,#0x80
   0386 F0                 1229 	movx	@dptr,a
                           1230 ;	tfirm.c 507
   0387 90 FF 08           1231 	mov	dptr,#_tOutputEndPointDescriptorBlock
                           1232 ; Peephole 180   changed mov to clr
   038A E4                 1233 	clr  a
   038B F0                 1234 	movx	@dptr,a
                           1235 ;	tfirm.c 509
   038C 90 FF 08           1236 	mov	dptr,#_tOutputEndPointDescriptorBlock
   038F E0                 1237 	movx	a,@dptr
   0390 FA                 1238 	mov	r2,a
   0391 43 02 84           1239 	orl	ar2,#0x84
   0394 90 FF 08           1240 	mov	dptr,#_tOutputEndPointDescriptorBlock
   0397 EA                 1241 	mov	a,r2
   0398 F0                 1242 	movx	@dptr,a
                           1243 ;	tfirm.c 510
   0399 90 FF 09           1244 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0001)
   039C 74 B0              1245 	mov	a,#0xB0
   039E F0                 1246 	movx	@dptr,a
                           1247 ;	tfirm.c 511
   039F 90 FF 0A           1248 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
                           1249 ; Peephole 180   changed mov to clr
   03A2 E4                 1250 	clr  a
   03A3 F0                 1251 	movx	@dptr,a
                           1252 ;	tfirm.c 512
   03A4 90 FF 0D           1253 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0005)
   03A7 74 B8              1254 	mov	a,#0xB8
   03A9 F0                 1255 	movx	@dptr,a
                           1256 ;	tfirm.c 513
   03AA 90 FF 0E           1257 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0006)
                           1258 ; Peephole 180   changed mov to clr
   03AD E4                 1259 	clr  a
   03AE F0                 1260 	movx	@dptr,a
                           1261 ;	tfirm.c 514
   03AF 90 FF 0F           1262 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0007)
   03B2 74 40              1263 	mov	a,#0x40
   03B4 F0                 1264 	movx	@dptr,a
                           1265 ;	tfirm.c 516
   03B5 E4                 1266 	clr	a
   03B6 F5 48              1267 	mov	(_bCurrentBuffer + 1),a
   03B8 F5 47              1268 	mov	_bCurrentBuffer,a
                           1269 ;	tfirm.c 517
   03BA 75 4C 00           1270 	mov	_bOEP1RecieveLength,#0x00
                           1271 ;	tfirm.c 518
   03BD 75 4D 00           1272 	mov	_bOEP1SaveBufferPosition,#0x00
                           1273 ;	tfirm.c 520
                           1274 ; Peephole 182   used 16 bit load of dptr
   03C0 90 FF FD           1275 	mov  dptr,#(((0xFF)<<8) + 0xFD)
   03C3 74 E5              1276 	mov	a,#0xE5
   03C5 F0                 1277 	movx	@dptr,a
                           1278 ;	tfirm.c 521
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
                           1290 ;	tfirm.c 523
   03D8 75 49 43           1291 	mov	_ID1,#0x43
                           1292 ;	tfirm.c 524
   03DB 75 4A 4D           1293 	mov	_ID2,#0x4D
                           1294 ;	tfirm.c 525
   03DE 75 4B 00           1295 	mov	_FIRMWARE_VERSION,#0x00
   03E1                    1296 00101$:
   03E1 22                 1297 	ret
                           1298 ;------------------------------------------------------------
                           1299 ;Allocation info for local variables in function 'SystemInitialization'
                           1300 ;------------------------------------------------------------
                           1301 ;	tfirm.c 529
                           1302 ;	-----------------------------------------
                           1303 ;	 function SystemInitialization
                           1304 ;	-----------------------------------------
   03E2                    1305 _SystemInitialization:
                           1306 ;	tfirm.c 531
   03E2 C2 AF              1307 	clr	_EA
                           1308 ;	tfirm.c 533
                           1309 ; Peephole 182   used 16 bit load of dptr
   03E4 90 FF FC           1310 	mov  dptr,#(((0xFF)<<8) + 0xFC)
                           1311 ; Peephole 180   changed mov to clr
   03E7 E4                 1312 	clr  a
   03E8 F0                 1313 	movx	@dptr,a
                           1314 ;	tfirm.c 535
                           1315 ; Peephole 182   used 16 bit load of dptr
   03E9 90 FF 90           1316 	mov  dptr,#(((0xFF)<<8) + 0x90)
   03EC 74 E0              1317 	mov	a,#0xE0
   03EE F0                 1318 	movx	@dptr,a
                           1319 ;	tfirm.c 540
   03EF D2 AF              1320 	setb	_EA
                           1321 ;	tfirm.c 541
   03F1 D2 A8              1322 	setb	_EX0
                           1323 ;	tfirm.c 543
   03F3 12 03 25           1324 	lcall	_usbReset
                           1325 ;	tfirm.c 545
                           1326 ; Peephole 182   used 16 bit load of dptr
   03F6 90 FF FC           1327 	mov  dptr,#(((0xFF)<<8) + 0xFC)
   03F9 74 80              1328 	mov	a,#0x80
   03FB F0                 1329 	movx	@dptr,a
   03FC                    1330 00101$:
   03FC 22                 1331 	ret
                           1332 ;------------------------------------------------------------
                           1333 ;Allocation info for local variables in function 'usbReceiveDataPacketOnEP0'
                           1334 ;------------------------------------------------------------
                           1335 ;	tfirm.c 550
                           1336 ;	-----------------------------------------
                           1337 ;	 function usbReceiveDataPacketOnEP0
                           1338 ;	-----------------------------------------
   03FD                    1339 _usbReceiveDataPacketOnEP0:
                           1340 ;	tfirm.c 561
   03FD 85 82 3C           1341 	mov	_pbOEP0Buffer,dpl
   0400 85 83 3D           1342 	mov	(_pbOEP0Buffer + 1),dph
   0403 85 F0 3E           1343 	mov	(_pbOEP0Buffer + 2),b
                           1344 ;	tfirm.c 555
   0406 90 FF 07           1345 	mov	dptr,#(_tSetupPacket + 0x0007)
   0409 E0                 1346 	movx	a,@dptr
   040A FA                 1347 	mov	r2,a
   040B 7B 00              1348 	mov	r3,#0x00
                           1349 ;	tfirm.c 556
   040D 8A 03              1350 	mov	ar3,r2
   040F 7A 00              1351 	mov	r2,#0x00
                           1352 ;	tfirm.c 557
   0411 90 FF 06           1353 	mov	dptr,#(_tSetupPacket + 0x0006)
   0414 E0                 1354 	movx	a,@dptr
   0415 FC                 1355 	mov	r4,a
   0416 7D 00              1356 	mov	r5,#0x00
                           1357 ;	tfirm.c 559
   0418 EC                 1358 	mov	a,r4
   0419 4A                 1359 	orl	a,r2
   041A F5 37              1360 	mov	_wBytesRemainingOnOEP0,a
   041C ED                 1361 	mov	a,r5
   041D 4B                 1362 	orl	a,r3
   041E F5 38              1363 	mov	(_wBytesRemainingOnOEP0 + 1),a
                           1364 ;	tfirm.c 560
   0420 75 31 02           1365 	mov	_bStatusAction,#0x02
                           1366 ;	tfirm.c 561
   0423 90 FF 83           1367 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1368 ; Peephole 180   changed mov to clr
   0426 E4                 1369 	clr  a
   0427 F0                 1370 	movx	@dptr,a
   0428                    1371 00101$:
   0428 22                 1372 	ret
                           1373 ;------------------------------------------------------------
                           1374 ;Allocation info for local variables in function 'usbReceiveNextPacketOnOEP0'
                           1375 ;------------------------------------------------------------
                           1376 ;	tfirm.c 564
                           1377 ;	-----------------------------------------
                           1378 ;	 function usbReceiveNextPacketOnOEP0
                           1379 ;	-----------------------------------------
   0429                    1380 _usbReceiveNextPacketOnOEP0:
                           1381 ;	tfirm.c 570
   0429 90 FF 83           1382 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
   042C E0                 1383 	movx	a,@dptr
   042D FA                 1384 	mov	r2,a
   042E 53 02 7F           1385 	anl	ar2,#0x7F
                           1386 ;	tfirm.c 577
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
                           1397 ;	tfirm.c 581
   0441 7D 00              1398 	mov	r5,#0x00
   0443                    1399 00107$:
   0443 C3                 1400 	clr	c
   0444 ED                 1401 	mov	a,r5
   0445 9A                 1402 	subb	a,r2
                           1403 ; Peephole 108   removed ljmp by inverse jump logic
   0446 50 26              1404 	jnc  00110$
   0448                    1405 00118$:
                           1406 ;	tfirm.c 582
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
   0468 12 0A 5F           1428 	lcall	__gptrput
                           1429 ;	tfirm.c 581
   046B 0D                 1430 	inc	r5
                           1431 ; Peephole 132   changed ljmp to sjmp
   046C 80 D5              1432 	sjmp 00107$
   046E                    1433 00110$:
                           1434 ;	tfirm.c 586
   046E C3                 1435 	clr	c
   046F E5 37              1436 	mov	a,_wBytesRemainingOnOEP0
   0471 9B                 1437 	subb	a,r3
   0472 F5 37              1438 	mov	_wBytesRemainingOnOEP0,a
   0474 E5 38              1439 	mov	a,(_wBytesRemainingOnOEP0 + 1)
   0476 9C                 1440 	subb	a,r4
   0477 F5 38              1441 	mov	(_wBytesRemainingOnOEP0 + 1),a
                           1442 ;	tfirm.c 592
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
                           1453 ;	tfirm.c 594
   0482 90 FF 83           1454 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1455 ; Peephole 180   changed mov to clr
   0485 E4                 1456 	clr  a
   0486 F0                 1457 	movx	@dptr,a
                           1458 ;	tfirm.c 595
   0487 75 31 02           1459 	mov	_bStatusAction,#0x02
                           1460 ; Peephole 132   changed ljmp to sjmp
   048A 80 22              1461 	sjmp 00111$
   048C                    1462 00102$:
                           1463 ;	tfirm.c 607
   048C 90 FF 82           1464 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   048F E0                 1465 	movx	a,@dptr
   0490 FA                 1466 	mov	r2,a
   0491 43 02 08           1467 	orl	ar2,#0x08
   0494 90 FF 82           1468 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   0497 EA                 1469 	mov	a,r2
   0498 F0                 1470 	movx	@dptr,a
                           1471 ;	tfirm.c 608
   0499 75 31 00           1472 	mov	_bStatusAction,#0x00
                           1473 ; Peephole 132   changed ljmp to sjmp
   049C 80 10              1474 	sjmp 00111$
   049E                    1475 00105$:
                           1476 ;	tfirm.c 619
   049E 90 FF 82           1477 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   04A1 E0                 1478 	movx	a,@dptr
   04A2 FA                 1479 	mov	r2,a
   04A3 43 02 08           1480 	orl	ar2,#0x08
   04A6 90 FF 82           1481 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
   04A9 EA                 1482 	mov	a,r2
   04AA F0                 1483 	movx	@dptr,a
                           1484 ;	tfirm.c 620
   04AB 75 31 00           1485 	mov	_bStatusAction,#0x00
   04AE                    1486 00111$:
   04AE 22                 1487 	ret
                           1488 ;------------------------------------------------------------
                           1489 ;Allocation info for local variables in function 'usbSendNextPacketOnIEP0'
                           1490 ;------------------------------------------------------------
                           1491 ;	tfirm.c 624
                           1492 ;	-----------------------------------------
                           1493 ;	 function usbSendNextPacketOnIEP0
                           1494 ;	-----------------------------------------
   04AF                    1495 _usbSendNextPacketOnIEP0:
                           1496 ;	tfirm.c 628
   04AF E5 35              1497 	mov	a,_wBytesRemainingOnIEP0
   04B1 B4 FF 08           1498 	cjne	a,#0xFF,00125$
   04B4 E5 36              1499 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   04B6 B4 FF 03           1500 	cjne	a,#0xFF,00125$
   04B9 02 05 44           1501 	ljmp	00111$
   04BC                    1502 00125$:
                           1503 ;	tfirm.c 630
   04BC C3                 1504 	clr	c
   04BD 74 08              1505 	mov	a,#0x08
   04BF 95 35              1506 	subb	a,_wBytesRemainingOnIEP0
                           1507 ; Peephole 180   changed mov to clr
   04C1 E4                 1508 	clr  a
   04C2 95 36              1509 	subb	a,(_wBytesRemainingOnIEP0 + 1)
                           1510 ; Peephole 108   removed ljmp by inverse jump logic
   04C4 50 13              1511 	jnc  00108$
   04C6                    1512 00126$:
                           1513 ;	tfirm.c 634
   04C6 7A 08              1514 	mov	r2,#0x08
                           1515 ;	tfirm.c 635
   04C8 E5 35              1516 	mov	a,_wBytesRemainingOnIEP0
   04CA 24 F8              1517 	add	a,#0xf8
   04CC F5 35              1518 	mov	_wBytesRemainingOnIEP0,a
   04CE E5 36              1519 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   04D0 34 FF              1520 	addc	a,#0xff
   04D2 F5 36              1521 	mov	(_wBytesRemainingOnIEP0 + 1),a
                           1522 ;	tfirm.c 636
   04D4 75 31 01           1523 	mov	_bStatusAction,#0x01
                           1524 ; Peephole 132   changed ljmp to sjmp
   04D7 80 38              1525 	sjmp 00124$
   04D9                    1526 00108$:
                           1527 ;	tfirm.c 638
   04D9 C3                 1528 	clr	c
   04DA E5 35              1529 	mov	a,_wBytesRemainingOnIEP0
   04DC 94 08              1530 	subb	a,#0x08
   04DE E5 36              1531 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   04E0 94 00              1532 	subb	a,#0x00
                           1533 ; Peephole 108   removed ljmp by inverse jump logic
   04E2 50 0D              1534 	jnc  00105$
   04E4                    1535 00127$:
                           1536 ;	tfirm.c 642
   04E4 AA 35              1537 	mov	r2,_wBytesRemainingOnIEP0
                           1538 ;	tfirm.c 643
   04E6 75 35 FF           1539 	mov	_wBytesRemainingOnIEP0,#0xFF
   04E9 75 36 FF           1540 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                           1541 ;	tfirm.c 644
   04EC 75 31 00           1542 	mov	_bStatusAction,#0x00
                           1543 ; Peephole 132   changed ljmp to sjmp
   04EF 80 20              1544 	sjmp 00124$
   04F1                    1545 00105$:
                           1546 ;	tfirm.c 649
   04F1 7A 08              1547 	mov	r2,#0x08
                           1548 ;	tfirm.c 650
   04F3 E5 45              1549 	mov	a,_bHostAskMoreDataThanAvailable
   04F5 B4 01 04           1550 	cjne	a,#0x01,00128$
   04F8 E5 46              1551 	mov	a,(_bHostAskMoreDataThanAvailable + 1)
                           1552 ; Peephole 162   removed sjmp by inverse jump logic
   04FA 60 02              1553 	jz   00129$
   04FC                    1554 00128$:
                           1555 ; Peephole 132   changed ljmp to sjmp
   04FC 80 0A              1556 	sjmp 00102$
   04FE                    1557 00129$:
                           1558 ;	tfirm.c 652
   04FE E4                 1559 	clr	a
   04FF F5 36              1560 	mov	(_wBytesRemainingOnIEP0 + 1),a
   0501 F5 35              1561 	mov	_wBytesRemainingOnIEP0,a
                           1562 ;	tfirm.c 653
   0503 75 31 01           1563 	mov	_bStatusAction,#0x01
                           1564 ; Peephole 132   changed ljmp to sjmp
   0506 80 09              1565 	sjmp 00124$
   0508                    1566 00102$:
                           1567 ;	tfirm.c 657
   0508 75 35 FF           1568 	mov	_wBytesRemainingOnIEP0,#0xFF
   050B 75 36 FF           1569 	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
                           1570 ;	tfirm.c 658
   050E 75 31 00           1571 	mov	_bStatusAction,#0x00
                           1572 ;	tfirm.c 661
   0511                    1573 00124$:
   0511 7B 00              1574 	mov	r3,#0x00
   0513                    1575 00113$:
   0513 C3                 1576 	clr	c
   0514 EB                 1577 	mov	a,r3
   0515 9A                 1578 	subb	a,r2
                           1579 ; Peephole 108   removed ljmp by inverse jump logic
   0516 50 25              1580 	jnc  00116$
   0518                    1581 00130$:
                           1582 ;	tfirm.c 662
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
   0531 12 0A 90           1598 	lcall	__gptrget
                           1599 ; Peephole 136   removed redundant moves
   0534 FE                 1600 	mov  r6,a
   0535 8C 82              1601 	mov  dpl,r4
   0537 8D 83              1602 	mov  dph,r5
   0539 F0                 1603 	movx	@dptr,a
                           1604 ;	tfirm.c 661
   053A 0B                 1605 	inc	r3
                           1606 ; Peephole 132   changed ljmp to sjmp
   053B 80 D6              1607 	sjmp 00113$
   053D                    1608 00116$:
                           1609 ;	tfirm.c 664
   053D 90 FF 81           1610 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
   0540 EA                 1611 	mov	a,r2
   0541 F0                 1612 	movx	@dptr,a
                           1613 ; Peephole 132   changed ljmp to sjmp
   0542 80 03              1614 	sjmp 00117$
   0544                    1615 00111$:
                           1616 ;	tfirm.c 668
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
                           1627 ;	tfirm.c 672
                           1628 ;	-----------------------------------------
                           1629 ;	 function usbSendDataPacketOnEP0
                           1630 ;	-----------------------------------------
   0548                    1631 _usbSendDataPacketOnEP0:
                           1632 ;	tfirm.c 697
   0548 85 82 39           1633 	mov	_pbIEP0Buffer,dpl
   054B 85 83 3A           1634 	mov	(_pbIEP0Buffer + 1),dph
   054E 85 F0 3B           1635 	mov	(_pbIEP0Buffer + 2),b
                           1636 ;	tfirm.c 679
   0551 90 FF 07           1637 	mov	dptr,#(_tSetupPacket + 0x0007)
   0554 E0                 1638 	movx	a,@dptr
   0555 FA                 1639 	mov	r2,a
   0556 7B 00              1640 	mov	r3,#0x00
                           1641 ;	tfirm.c 680
   0558 8A 03              1642 	mov	ar3,r2
   055A 7A 00              1643 	mov	r2,#0x00
                           1644 ;	tfirm.c 681
   055C 90 FF 06           1645 	mov	dptr,#(_tSetupPacket + 0x0006)
   055F E0                 1646 	movx	a,@dptr
   0560 FC                 1647 	mov	r4,a
   0561 7D 00              1648 	mov	r5,#0x00
                           1649 ;	tfirm.c 683
   0563 EC                 1650 	mov	a,r4
   0564 42 02              1651 	orl	ar2,a
   0566 ED                 1652 	mov	a,r5
   0567 42 03              1653 	orl	ar3,a
                           1654 ;	tfirm.c 687
   0569 C3                 1655 	clr	c
   056A E5 35              1656 	mov	a,_wBytesRemainingOnIEP0
   056C 9A                 1657 	subb	a,r2
   056D E5 36              1658 	mov	a,(_wBytesRemainingOnIEP0 + 1)
   056F 9B                 1659 	subb	a,r3
                           1660 ; Peephole 132   changed ljmp to sjmp
                           1661 ; Peephole 160   removed sjmp by inverse jump logic
   0570 40 0B              1662 	jc   00102$
   0572                    1663 00107$:
                           1664 ;	tfirm.c 689
   0572 8A 35              1665 	mov	_wBytesRemainingOnIEP0,r2
   0574 8B 36              1666 	mov	(_wBytesRemainingOnIEP0 + 1),r3
                           1667 ;	tfirm.c 690
   0576 E4                 1668 	clr	a
   0577 F5 46              1669 	mov	(_bHostAskMoreDataThanAvailable + 1),a
   0579 F5 45              1670 	mov	_bHostAskMoreDataThanAvailable,a
                           1671 ; Peephole 132   changed ljmp to sjmp
   057B 80 06              1672 	sjmp 00103$
   057D                    1673 00102$:
                           1674 ;	tfirm.c 694
   057D E4                 1675 	clr	a
   057E F5 46              1676 	mov	(_bHostAskMoreDataThanAvailable + 1),a
   0580 75 45 01           1677 	mov	_bHostAskMoreDataThanAvailable,#0x01
   0583                    1678 00103$:
                           1679 ;	tfirm.c 697
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
                           1694 ;	tfirm.c 700
                           1695 ;	-----------------------------------------
                           1696 ;	 function usbDecodeAndProcessUsbRequest
                           1697 ;	-----------------------------------------
   0587                    1698 _usbDecodeAndProcessUsbRequest:
                           1699 ;	tfirm.c 708
   0587 7A E4              1700 	mov	r2,#_tUsbRequestList
   0589 7B 08              1701 	mov	r3,#(_tUsbRequestList >> 8)
   058B 7C 02              1702 	mov	r4,#0x02
                           1703 ;	tfirm.c 713
   058D                    1704 00106$:
                           1705 ;	tfirm.c 715
   058D 7D 00              1706 	mov	r5,#0x00
                           1707 ;	tfirm.c 716
   058F 7E 80              1708 	mov	r6,#0x80
                           1709 ;	tfirm.c 723
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
                           1721 ;	tfirm.c 725
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
   05B1 12 0A 90           1739 	lcall	__gptrget
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
                           1754 ;	tfirm.c 726
   05C6 EE                 1755 	mov	a,r6
   05C7 4D                 1756 	orl	a,r5
   05C8 FD                 1757 	mov	r5,a
   05C9                    1758 00102$:
                           1759 ;	tfirm.c 727
   05C9 EE                 1760 	mov	a,r6
   05CA C3                 1761 	clr	c
   05CB 13                 1762 	rrc	a
   05CC F5 56              1763 	mov	_usbDecodeAndProcessUsbRequest_sloc3_1_0,a
   05CE AE 56              1764 	mov	r6,_usbDecodeAndProcessUsbRequest_sloc3_1_0
                           1765 ;	tfirm.c 723
   05D0 0F                 1766 	inc	r7
                           1767 ; Peephole 132   changed ljmp to sjmp
   05D1 80 C0              1768 	sjmp 00110$
   05D3                    1769 00113$:
                           1770 ;	tfirm.c 738
   05D3 EF                 1771 	mov	a,r7
   05D4 2A                 1772 	add	a,r2
   05D5 F5 82              1773 	mov	dpl,a
                           1774 ; Peephole 180   changed mov to clr
   05D7 E4                 1775 	clr  a
   05D8 3B                 1776 	addc	a,r3
   05D9 F5 83              1777 	mov	dph,a
   05DB 8C F0              1778 	mov	b,r4
   05DD 12 0A 90           1779 	lcall	__gptrget
                           1780 ; Peephole 105   removed redundant mov
   05E0 FF                 1781 	mov  r7,a
   05E1 52 05              1782 	anl	ar5,a
   05E3 ED                 1783 	mov	a,r5
   05E4 B5 07 02           1784 	cjne	a,ar7,00127$
                           1785 ; Peephole 132   changed ljmp to sjmp
   05E7 80 0A              1786 	sjmp 00107$
   05E9                    1787 00127$:
                           1788 ;	tfirm.c 742
   05E9 74 0B              1789 	mov	a,#0x0B
   05EB 2A                 1790 	add	a,r2
   05EC FA                 1791 	mov	r2,a
                           1792 ; Peephole 180   changed mov to clr
   05ED E4                 1793 	clr  a
   05EE 3B                 1794 	addc	a,r3
   05EF FB                 1795 	mov	r3,a
   05F0 02 05 8D           1796 	ljmp	00106$
   05F3                    1797 00107$:
                           1798 ;	tfirm.c 747
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
                           1811 ;	tfirm.c 748
                           1812 ; Peephole 132   changed ljmp to sjmp
   0600 80 21              1813 	sjmp 00114$
   0602                    1814 00109$:
                           1815 ;	tfirm.c 752
   0602 74 09              1816 	mov	a,#0x09
   0604 2A                 1817 	add	a,r2
   0605 F5 82              1818 	mov	dpl,a
                           1819 ; Peephole 180   changed mov to clr
   0607 E4                 1820 	clr  a
   0608 3B                 1821 	addc	a,r3
   0609 F5 83              1822 	mov	dph,a
   060B 8C F0              1823 	mov	b,r4
   060D 12 0A 90           1824 	lcall	__gptrget
   0610 FA                 1825 	mov	r2,a
   0611 A3                 1826 	inc	dptr
   0612 12 0A 90           1827 	lcall	__gptrget
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
                           1842 ;	tfirm.c 755
                           1843 ;	-----------------------------------------
                           1844 ;	 function OEP0InterruptHandler
                           1845 ;	-----------------------------------------
   0624                    1846 _OEP0InterruptHandler:
                           1847 ;	tfirm.c 757
   0624 90 FF 81           1848 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
                           1849 ; Peephole 180   changed mov to clr
   0627 E4                 1850 	clr  a
   0628 F0                 1851 	movx	@dptr,a
                           1852 ;	tfirm.c 765
   0629 E5 31              1853 	mov	a,_bStatusAction
                           1854 ; Peephole 132   changed ljmp to sjmp
                           1855 ; Peephole 199   optimized misc jump sequence
   062B B4 02 05           1856 	cjne a,#0x02,00102$
                           1857 ;00107$:
                           1858 ; Peephole 200   removed redundant sjmp
   062E                    1859 00108$:
                           1860 ;	tfirm.c 766
   062E 12 04 29           1861 	lcall	_usbReceiveNextPacketOnOEP0
                           1862 ; Peephole 132   changed ljmp to sjmp
   0631 80 0D              1863 	sjmp 00104$
   0633                    1864 00102$:
                           1865 ;	tfirm.c 768
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
                           1878 ;	tfirm.c 771
                           1879 ;	-----------------------------------------
                           1880 ;	 function IEP0InterruptHandler
                           1881 ;	-----------------------------------------
   0641                    1882 _IEP0InterruptHandler:
                           1883 ;	tfirm.c 773
   0641 90 FF 83           1884 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
                           1885 ; Peephole 180   changed mov to clr
   0644 E4                 1886 	clr  a
   0645 F0                 1887 	movx	@dptr,a
                           1888 ;	tfirm.c 781
   0646 E5 31              1889 	mov	a,_bStatusAction
                           1890 ; Peephole 132   changed ljmp to sjmp
                           1891 ; Peephole 199   optimized misc jump sequence
   0648 B4 01 05           1892 	cjne a,#0x01,00102$
                           1893 ;00107$:
                           1894 ; Peephole 200   removed redundant sjmp
   064B                    1895 00108$:
                           1896 ;	tfirm.c 782
   064B 12 04 AF           1897 	lcall	_usbSendNextPacketOnIEP0
                           1898 ; Peephole 132   changed ljmp to sjmp
   064E 80 0D              1899 	sjmp 00104$
   0650                    1900 00102$:
                           1901 ;	tfirm.c 788
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
                           1918 ;	tfirm.c 792
                           1919 ;	-----------------------------------------
                           1920 ;	 function OEP1InterruptHandler
                           1921 ;	-----------------------------------------
   065E                    1922 _OEP1InterruptHandler:
                           1923 ;	tfirm.c 798
                           1924 ; Peephole 182   used 16 bit load of dptr
   065E 90 FF 4A           1925 	mov  dptr,#(((0xFF)<<8) + 0x4A)
   0661 74 80              1926 	mov	a,#0x80
   0663 F0                 1927 	movx	@dptr,a
                           1928 ;	tfirm.c 802
   0664 E5 4C              1929 	mov	a,_bOEP1RecieveLength
                           1930 ; Peephole 162   removed sjmp by inverse jump logic
   0666 60 02              1931 	jz   00135$
   0668                    1932 00134$:
                           1933 ; Peephole 132   changed ljmp to sjmp
   0668 80 33              1934 	sjmp 00102$
   066A                    1935 00135$:
                           1936 ;	tfirm.c 803
   066A 90 FD 81           1937 	mov	dptr,#(_pbOEP1XBufferAddress + 0x0001)
   066D E0                 1938 	movx	a,@dptr
   066E F5 4C              1939 	mov	_bOEP1RecieveLength,a
                           1940 ;	tfirm.c 804
   0670 90 FF 0A           1941 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
   0673 E0                 1942 	movx	a,@dptr
   0674 FA                 1943 	mov	r2,a
   0675 53 02 7F           1944 	anl	ar2,#0x7F
                           1945 ;	tfirm.c 805
   0678 7B 00              1946 	mov	r3,#0x00
   067A                    1947 00116$:
   067A C3                 1948 	clr	c
   067B EB                 1949 	mov	a,r3
   067C 9A                 1950 	subb	a,r2
                           1951 ; Peephole 108   removed ljmp by inverse jump logic
   067D 50 17              1952 	jnc  00119$
   067F                    1953 00136$:
                           1954 ;	tfirm.c 806
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
                           1969 ;	tfirm.c 808
   0691 05 4D              1970 	inc	_bOEP1SaveBufferPosition
                           1971 ;	tfirm.c 805
   0693 0B                 1972 	inc	r3
                           1973 ; Peephole 132   changed ljmp to sjmp
   0694 80 E4              1974 	sjmp 00116$
   0696                    1975 00119$:
                           1976 ;	tfirm.c 810
   0696 90 FF 0A           1977 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
                           1978 ; Peephole 180   changed mov to clr
   0699 E4                 1979 	clr  a
   069A F0                 1980 	movx	@dptr,a
                           1981 ; Peephole 132   changed ljmp to sjmp
   069B 80 2C              1982 	sjmp 00103$
   069D                    1983 00102$:
                           1984 ;	tfirm.c 815
   069D 90 FF 0A           1985 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
   06A0 E0                 1986 	movx	a,@dptr
   06A1 FB                 1987 	mov	r3,a
   06A2 74 7F              1988 	mov	a,#0x7F
   06A4 5B                 1989 	anl	a,r3
   06A5 FA                 1990 	mov	r2,a
                           1991 ;	tfirm.c 816
   06A6 7B 00              1992 	mov	r3,#0x00
   06A8                    1993 00120$:
   06A8 C3                 1994 	clr	c
   06A9 EB                 1995 	mov	a,r3
   06AA 9A                 1996 	subb	a,r2
                           1997 ; Peephole 108   removed ljmp by inverse jump logic
   06AB 50 17              1998 	jnc  00123$
   06AD                    1999 00137$:
                           2000 ;	tfirm.c 817
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
                           2015 ;	tfirm.c 819
   06BF 05 4D              2016 	inc	_bOEP1SaveBufferPosition
                           2017 ;	tfirm.c 816
   06C1 0B                 2018 	inc	r3
                           2019 ; Peephole 132   changed ljmp to sjmp
   06C2 80 E4              2020 	sjmp 00120$
   06C4                    2021 00123$:
                           2022 ;	tfirm.c 821
   06C4 90 FF 0A           2023 	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
                           2024 ; Peephole 180   changed mov to clr
   06C7 E4                 2025 	clr  a
   06C8 F0                 2026 	movx	@dptr,a
   06C9                    2027 00103$:
                           2028 ;	tfirm.c 826
   06C9 C3                 2029 	clr	c
   06CA E5 4D              2030 	mov	a,_bOEP1SaveBufferPosition
   06CC 95 4C              2031 	subb	a,_bOEP1RecieveLength
                           2032 ; Peephole 108   removed ljmp by inverse jump logic
   06CE 50 02              2033 	jnc  00105$
   06D0                    2034 00138$:
                           2035 ;	tfirm.c 827
                           2036 ; Peephole 132   changed ljmp to sjmp
   06D0 80 5C              2037 	sjmp 00124$
   06D2                    2038 00105$:
                           2039 ;	tfirm.c 829
   06D2 75 4C 00           2040 	mov	_bOEP1RecieveLength,#0x00
                           2041 ;	tfirm.c 831
   06D5 75 4D 00           2042 	mov	_bOEP1SaveBufferPosition,#0x00
                           2043 ;	tfirm.c 833
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
                           2074 ;	tfirm.c 836
   0708                    2075 00106$:
   0708 12 09 E1           2076 	lcall	_fn_cmd_01
                           2077 ;	tfirm.c 837
                           2078 ;	tfirm.c 840
                           2079 ; Peephole 132   changed ljmp to sjmp
   070B 80 21              2080 	sjmp 00115$
   070D                    2081 00107$:
   070D 12 09 F4           2082 	lcall	_fn_cmd_02
                           2083 ;	tfirm.c 841
                           2084 ;	tfirm.c 844
                           2085 ; Peephole 132   changed ljmp to sjmp
   0710 80 1C              2086 	sjmp 00115$
   0712                    2087 00108$:
   0712 12 0A 07           2088 	lcall	_fn_cmd_03
                           2089 ;	tfirm.c 845
                           2090 ;	tfirm.c 848
                           2091 ; Peephole 132   changed ljmp to sjmp
   0715 80 17              2092 	sjmp 00115$
   0717                    2093 00109$:
   0717 12 0A 20           2094 	lcall	_fn_cmd_04
                           2095 ;	tfirm.c 849
                           2096 ;	tfirm.c 852
                           2097 ; Peephole 132   changed ljmp to sjmp
   071A 80 12              2098 	sjmp 00115$
   071C                    2099 00110$:
   071C 12 0A 33           2100 	lcall	_fn_cmd_05
                           2101 ;	tfirm.c 853
                           2102 ;	tfirm.c 856
                           2103 ; Peephole 132   changed ljmp to sjmp
   071F 80 0D              2104 	sjmp 00115$
   0721                    2105 00111$:
   0721 12 0A 46           2106 	lcall	_fn_cmd_06
                           2107 ;	tfirm.c 857
                           2108 ;	tfirm.c 860
                           2109 ; Peephole 132   changed ljmp to sjmp
   0724 80 08              2110 	sjmp 00115$
   0726                    2111 00112$:
   0726 12 0A 59           2112 	lcall	_fn_cmd_07
                           2113 ;	tfirm.c 861
                           2114 ;	tfirm.c 864
                           2115 ; Peephole 132   changed ljmp to sjmp
   0729 80 03              2116 	sjmp 00115$
   072B                    2117 00113$:
   072B 12 0A 5A           2118 	lcall	_fn_cmd_08
                           2119 ;	tfirm.c 869
   072E                    2120 00115$:
                           2121 ;	tfirm.c 871
   072E                    2122 00124$:
   072E 22                 2123 	ret
                           2124 ;------------------------------------------------------------
                           2125 ;Allocation info for local variables in function 'IEP1InterruptHandler'
                           2126 ;------------------------------------------------------------
                           2127 ;	tfirm.c 875
                           2128 ;	-----------------------------------------
                           2129 ;	 function IEP1InterruptHandler
                           2130 ;	-----------------------------------------
   072F                    2131 _IEP1InterruptHandler:
                           2132 ;	tfirm.c 876
   072F                    2133 00101$:
   072F 22                 2134 	ret
                           2135 ;------------------------------------------------------------
                           2136 ;Allocation info for local variables in function 'SetupPacketInterruptHandler'
                           2137 ;------------------------------------------------------------
                           2138 ;	tfirm.c 879
                           2139 ;	-----------------------------------------
                           2140 ;	 function SetupPacketInterruptHandler
                           2141 ;	-----------------------------------------
   0730                    2142 _SetupPacketInterruptHandler:
                           2143 ;	tfirm.c 882
   0730 90 FF 81           2144 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
   0733 74 80              2145 	mov	a,#0x80
   0735 F0                 2146 	movx	@dptr,a
                           2147 ;	tfirm.c 883
   0736 90 FF 83           2148 	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
   0739 74 80              2149 	mov	a,#0x80
   073B F0                 2150 	movx	@dptr,a
                           2151 ;	tfirm.c 885
                           2152 ; Peephole 182   used 16 bit load of dptr
   073C 90 FF FE           2153 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   073F 74 04              2154 	mov	a,#0x04
   0741 F0                 2155 	movx	@dptr,a
                           2156 ;	tfirm.c 889
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
                           2167 ;	tfirm.c 890
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
                           2182 ;	tfirm.c 892
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
                           2195 ;	tfirm.c 897
   0773 75 31 00           2196 	mov	_bStatusAction,#0x00
                           2197 ;	tfirm.c 901
   0776 12 05 87           2198 	lcall	_usbDecodeAndProcessUsbRequest
   0779                    2199 00104$:
   0779 22                 2200 	ret
                           2201 ;------------------------------------------------------------
                           2202 ;Allocation info for local variables in function 'usbISR'
                           2203 ;------------------------------------------------------------
                           2204 ;	tfirm.c 905
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
                           2223 ;	tfirm.c 906
   0797 C2 AF              2224 	clr	_EA
                           2225 ;	tfirm.c 908
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
                           2271 ;	tfirm.c 911
                           2272 ; Peephole 182   used 16 bit load of dptr
   07E2 90 FF 92           2273 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2274 ; Peephole 180   changed mov to clr
   07E5 E4                 2275 	clr  a
   07E6 F0                 2276 	movx	@dptr,a
                           2277 ;	tfirm.c 912
   07E7 12 06 24           2278 	lcall	_OEP0InterruptHandler
                           2279 ;	tfirm.c 913
   07EA 02 08 6D           2280 	ljmp	00111$
                           2281 ;	tfirm.c 916
   07ED                    2282 00102$:
                           2283 ; Peephole 182   used 16 bit load of dptr
   07ED 90 FF 92           2284 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2285 ; Peephole 180   changed mov to clr
   07F0 E4                 2286 	clr  a
   07F1 F0                 2287 	movx	@dptr,a
                           2288 ;	tfirm.c 917
   07F2 12 06 41           2289 	lcall	_IEP0InterruptHandler
                           2290 ;	tfirm.c 918
   07F5 02 08 6D           2291 	ljmp	00111$
                           2292 ;	tfirm.c 921
   07F8                    2293 00103$:
                           2294 ; Peephole 182   used 16 bit load of dptr
   07F8 90 FF 92           2295 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2296 ; Peephole 180   changed mov to clr
   07FB E4                 2297 	clr  a
   07FC F0                 2298 	movx	@dptr,a
                           2299 ;	tfirm.c 922
   07FD 12 06 5E           2300 	lcall	_OEP1InterruptHandler
                           2301 ;	tfirm.c 924
   0800 02 08 6D           2302 	ljmp	00111$
                           2303 ;	tfirm.c 927
   0803                    2304 00104$:
                           2305 ; Peephole 182   used 16 bit load of dptr
   0803 90 FF 92           2306 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2307 ; Peephole 180   changed mov to clr
   0806 E4                 2308 	clr  a
   0807 F0                 2309 	movx	@dptr,a
                           2310 ;	tfirm.c 930
   0808 02 08 6D           2311 	ljmp	00111$
                           2312 ;	tfirm.c 933
   080B                    2313 00105$:
                           2314 ; Peephole 182   used 16 bit load of dptr
   080B 90 FF 92           2315 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2316 ; Peephole 180   changed mov to clr
   080E E4                 2317 	clr  a
   080F F0                 2318 	movx	@dptr,a
                           2319 ;	tfirm.c 934
                           2320 ; Peephole 182   used 16 bit load of dptr
   0810 90 FF FE           2321 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   0813 74 01              2322 	mov	a,#0x01
   0815 F0                 2323 	movx	@dptr,a
                           2324 ;	tfirm.c 935
   0816 12 07 30           2325 	lcall	_SetupPacketInterruptHandler
                           2326 ;	tfirm.c 936
   0819 02 08 6D           2327 	ljmp	00111$
                           2328 ;	tfirm.c 939
   081C                    2329 00106$:
                           2330 ; Peephole 182   used 16 bit load of dptr
   081C 90 FF 92           2331 	mov  dptr,#(((0xFF)<<8) + 0x92)
                           2332 ; Peephole 180   changed mov to clr
   081F E4                 2333 	clr  a
   0820 F0                 2334 	movx	@dptr,a
                           2335 ;	tfirm.c 940
                           2336 ; Peephole 182   used 16 bit load of dptr
   0821 90 FF FE           2337 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   0824 74 04              2338 	mov	a,#0x04
   0826 F0                 2339 	movx	@dptr,a
                           2340 ;	tfirm.c 941
   0827 12 07 30           2341 	lcall	_SetupPacketInterruptHandler
                           2342 ;	tfirm.c 942
                           2343 ;	tfirm.c 945
                           2344 ; Peephole 132   changed ljmp to sjmp
   082A 80 41              2345 	sjmp 00111$
   082C                    2346 00107$:
   082C 75 82 92           2347 	mov	dpl,#0x92
   082F 75 83 FF           2348 	mov	dph,#0xFF
                           2349 ; Peephole 180   changed mov to clr
   0832 E4                 2350 	clr  a
   0833 F0                 2351 	movx	@dptr,a
                           2352 ;	tfirm.c 946
                           2353 ; Peephole 182   used 16 bit load of dptr
   0834 90 FF FE           2354 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   0837 74 80              2355 	mov	a,#0x80
   0839 F0                 2356 	movx	@dptr,a
                           2357 ;	tfirm.c 947
   083A 12 03 25           2358 	lcall	_usbReset
                           2359 ;	tfirm.c 949
                           2360 ;	tfirm.c 952
                           2361 ; Peephole 132   changed ljmp to sjmp
   083D 80 2E              2362 	sjmp 00111$
   083F                    2363 00108$:
   083F 75 82 92           2364 	mov	dpl,#0x92
   0842 75 83 FF           2365 	mov	dph,#0xFF
                           2366 ; Peephole 180   changed mov to clr
   0845 E4                 2367 	clr  a
   0846 F0                 2368 	movx	@dptr,a
                           2369 ;	tfirm.c 953
                           2370 ; Peephole 182   used 16 bit load of dptr
   0847 90 FF FE           2371 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   084A 74 20              2372 	mov	a,#0x20
   084C F0                 2373 	movx	@dptr,a
                           2374 ;	tfirm.c 954
   084D 75 41 00           2375 	mov	_bSuspended,#0x00
                           2376 ;	tfirm.c 955
                           2377 ;	tfirm.c 958
                           2378 ; Peephole 132   changed ljmp to sjmp
   0850 80 1B              2379 	sjmp 00111$
   0852                    2380 00109$:
   0852 75 82 92           2381 	mov	dpl,#0x92
   0855 75 83 FF           2382 	mov	dph,#0xFF
                           2383 ; Peephole 180   changed mov to clr
   0858 E4                 2384 	clr  a
   0859 F0                 2385 	movx	@dptr,a
                           2386 ;	tfirm.c 959
                           2387 ; Peephole 182   used 16 bit load of dptr
   085A 90 FF FE           2388 	mov  dptr,#(((0xFF)<<8) + 0xFE)
   085D 74 40              2389 	mov	a,#0x40
   085F F0                 2390 	movx	@dptr,a
                           2391 ;	tfirm.c 960
   0860 75 41 01           2392 	mov	_bSuspended,#0x01
                           2393 ;	tfirm.c 961
                           2394 ;	tfirm.c 964
                           2395 ; Peephole 132   changed ljmp to sjmp
   0863 80 08              2396 	sjmp 00111$
   0865                    2397 00110$:
   0865 75 82 92           2398 	mov	dpl,#0x92
   0868 75 83 FF           2399 	mov	dph,#0xFF
                           2400 ; Peephole 180   changed mov to clr
   086B E4                 2401 	clr  a
   086C F0                 2402 	movx	@dptr,a
                           2403 ;	tfirm.c 966
   086D                    2404 00111$:
                           2405 ;	tfirm.c 968
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
                           2425 ;	tfirm.c 972
                           2426 ;	-----------------------------------------
                           2427 ;	 function main
                           2428 ;	-----------------------------------------
   088A                    2429 _main:
                           2430 ;	tfirm.c 974
                           2431 ; Peephole 182   used 16 bit load of dptr
   088A 90 FF 94           2432 	mov  dptr,#(((0xFF)<<8) + 0x94)
                           2433 ; Peephole 180   changed mov to clr
   088D E4                 2434 	clr  a
   088E F0                 2435 	movx	@dptr,a
                           2436 ;	tfirm.c 975
                           2437 ; Peephole 182   used 16 bit load of dptr
   088F 90 FF 95           2438 	mov  dptr,#(((0xFF)<<8) + 0x95)
                           2439 ; Peephole 180   changed mov to clr
   0892 E4                 2440 	clr  a
   0893 F0                 2441 	movx	@dptr,a
                           2442 ;	tfirm.c 976
                           2443 ; Peephole 182   used 16 bit load of dptr
   0894 90 FF 96           2444 	mov  dptr,#(((0xFF)<<8) + 0x96)
   0897 74 FF              2445 	mov	a,#0xFF
   0899 F0                 2446 	movx	@dptr,a
                           2447 ;	tfirm.c 977
                           2448 ; Peephole 182   used 16 bit load of dptr
   089A 90 FF 97           2449 	mov  dptr,#(((0xFF)<<8) + 0x97)
   089D 74 80              2450 	mov	a,#0x80
   089F F0                 2451 	movx	@dptr,a
                           2452 ;	tfirm.c 979
   08A0 75 B0 FF           2453 	mov	_P3,#0xFF
                           2454 ;	tfirm.c 980
   08A3 75 A0 FF           2455 	mov	_P2,#0xFF
                           2456 ;	tfirm.c 981
   08A6 75 90 FF           2457 	mov	_P1,#0xFF
                           2458 ;	tfirm.c 983
   08A9 53 A8 F5           2459 	anl	_IE,#0xF5
                           2460 ;	tfirm.c 985
   08AC D2 B2              2461 	setb	_P3_2
                           2462 ;	tfirm.c 987
   08AE 12 03 E2           2463 	lcall	_SystemInitialization
   08B1                    2464 00101$:
   08B1 22                 2465 	ret
                           2466 	.area CSEG    (CODE)
   08B2                    2467 _abromConfigurationDescriptorGroup:
   08B2 09                 2468 	.db #0x09
   08B3 02                 2469 	.db #0x02
   08B4 20                 2470 	.db #0x20
   08B5 00                 2471 	.db #0x00
   08B6 01                 2472 	.db #0x01
   08B7 01                 2473 	.db #0x01
   08B8 00                 2474 	.db #0x00
   08B9 A0                 2475 	.db #0xA0
   08BA 32                 2476 	.db #0x32
   08BB 09                 2477 	.db #0x09
   08BC 04                 2478 	.db #0x04
   08BD 00                 2479 	.db #0x00
   08BE 00                 2480 	.db #0x00
   08BF 02                 2481 	.db #0x02
   08C0 FF                 2482 	.db #0xFF
   08C1 01                 2483 	.db #0x01
   08C2 01                 2484 	.db #0x01
   08C3 01                 2485 	.db #0x01
   08C4 07                 2486 	.db #0x07
   08C5 05                 2487 	.db #0x05
   08C6 81                 2488 	.db #0x81
   08C7 02                 2489 	.db #0x02
   08C8 40                 2490 	.db #0x40
   08C9 00                 2491 	.db #0x00
   08CA 00                 2492 	.db #0x00
   08CB 07                 2493 	.db #0x07
   08CC 05                 2494 	.db #0x05
   08CD 01                 2495 	.db #0x01
   08CE 02                 2496 	.db #0x02
   08CF 40                 2497 	.db #0x40
   08D0 00                 2498 	.db #0x00
   08D1 00                 2499 	.db #0x00
   08D2                    2500 _abromDeviceDescriptor:
   08D2 12                 2501 	.db #0x12
   08D3 01                 2502 	.db #0x01
   08D4 10                 2503 	.db #0x10
   08D5 01                 2504 	.db #0x01
   08D6 00                 2505 	.db #0x00
   08D7 00                 2506 	.db #0x00
   08D8 00                 2507 	.db #0x00
   08D9 08                 2508 	.db #0x08
   08DA FF                 2509 	.db #0xFF
   08DB FF                 2510 	.db #0xFF
   08DC FF                 2511 	.db #0xFF
   08DD FF                 2512 	.db #0xFF
   08DE 00                 2513 	.db #0x00
   08DF 01                 2514 	.db #0x01
   08E0 01                 2515 	.db #0x01
   08E1 02                 2516 	.db #0x02
   08E2 03                 2517 	.db #0x03
   08E3 01                 2518 	.db #0x01
   08E4                    2519 _tUsbRequestList:
   08E4 02                 2520 	.db #0x02
   08E5 03                 2521 	.db #0x03
   08E6 00                 2522 	.db #0x00
   08E7 00                 2523 	.db #0x00
   08E8 FF                 2524 	.db #0xFF
   08E9 00                 2525 	.db #0x00
   08EA 00                 2526 	.db #0x00
   08EB 00                 2527 	.db #0x00
   08EC F7                 2528 	.db #0xF7
   08ED 47 00              2529 	.byte _usbSetEndpointHalt,(_usbSetEndpointHalt >> 8)
   08EF 02                 2530 	.db #0x02
   08F0 01                 2531 	.db #0x01
   08F1 00                 2532 	.db #0x00
   08F2 00                 2533 	.db #0x00
   08F3 FF                 2534 	.db #0xFF
   08F4 00                 2535 	.db #0x00
   08F5 00                 2536 	.db #0x00
   08F6 00                 2537 	.db #0x00
   08F7 F7                 2538 	.db #0xF7
   08F8 58 00              2539 	.byte _usbClearEndpointHalt,(_usbClearEndpointHalt >> 8)
   08FA 80                 2540 	.db #0x80
   08FB 08                 2541 	.db #0x08
   08FC 00                 2542 	.db #0x00
   08FD 00                 2543 	.db #0x00
   08FE 00                 2544 	.db #0x00
   08FF 00                 2545 	.db #0x00
   0900 01                 2546 	.db #0x01
   0901 00                 2547 	.db #0x00
   0902 FF                 2548 	.db #0xFF
   0903 69 00              2549 	.byte _usbGetConfiguration,(_usbGetConfiguration >> 8)
   0905 00                 2550 	.db #0x00
   0906 09                 2551 	.db #0x09
   0907 FF                 2552 	.db #0xFF
   0908 00                 2553 	.db #0x00
   0909 00                 2554 	.db #0x00
   090A 00                 2555 	.db #0x00
   090B 00                 2556 	.db #0x00
   090C 00                 2557 	.db #0x00
   090D DF                 2558 	.db #0xDF
   090E 7F 00              2559 	.byte _usbSetConfiguration,(_usbSetConfiguration >> 8)
   0910 80                 2560 	.db #0x80
   0911 06                 2561 	.db #0x06
   0912 FF                 2562 	.db #0xFF
   0913 01                 2563 	.db #0x01
   0914 FF                 2564 	.db #0xFF
   0915 FF                 2565 	.db #0xFF
   0916 FF                 2566 	.db #0xFF
   0917 FF                 2567 	.db #0xFF
   0918 D0                 2568 	.db #0xD0
   0919 77 02              2569 	.byte _usbGetDeviceDescriptor,(_usbGetDeviceDescriptor >> 8)
   091B 80                 2570 	.db #0x80
   091C 06                 2571 	.db #0x06
   091D FF                 2572 	.db #0xFF
   091E 02                 2573 	.db #0x02
   091F FF                 2574 	.db #0xFF
   0920 FF                 2575 	.db #0xFF
   0921 FF                 2576 	.db #0xFF
   0922 FF                 2577 	.db #0xFF
   0923 D0                 2578 	.db #0xD0
   0924 FF 01              2579 	.byte _usbGetConfigurationDescriptor,(_usbGetConfigurationDescriptor >> 8)
   0926 81                 2580 	.db #0x81
   0927 06                 2581 	.db #0x06
   0928 FF                 2582 	.db #0xFF
   0929 21                 2583 	.db #0x21
   092A FF                 2584 	.db #0xFF
   092B FF                 2585 	.db #0xFF
   092C FF                 2586 	.db #0xFF
   092D FF                 2587 	.db #0xFF
   092E D0                 2588 	.db #0xD0
   092F 3D 02              2589 	.byte _usbGetHIDDescriptor,(_usbGetHIDDescriptor >> 8)
   0931 80                 2590 	.db #0x80
   0932 06                 2591 	.db #0x06
   0933 FF                 2592 	.db #0xFF
   0934 03                 2593 	.db #0x03
   0935 FF                 2594 	.db #0xFF
   0936 FF                 2595 	.db #0xFF
   0937 FF                 2596 	.db #0xFF
   0938 FF                 2597 	.db #0xFF
   0939 D0                 2598 	.db #0xD0
   093A EB 02              2599 	.byte _usbGetStringDescriptor,(_usbGetStringDescriptor >> 8)
   093C 81                 2600 	.db #0x81
   093D 06                 2601 	.db #0x06
   093E FF                 2602 	.db #0xFF
   093F 22                 2603 	.db #0x22
   0940 FF                 2604 	.db #0xFF
   0941 FF                 2605 	.db #0xFF
   0942 FF                 2606 	.db #0xFF
   0943 FF                 2607 	.db #0xFF
   0944 D0                 2608 	.db #0xD0
   0945 F3 01              2609 	.byte _usbGetReportDescriptor,(_usbGetReportDescriptor >> 8)
   0947 21                 2610 	.db #0x21
   0948 09                 2611 	.db #0x09
   0949 FF                 2612 	.db #0xFF
   094A FF                 2613 	.db #0xFF
   094B FF                 2614 	.db #0xFF
   094C FF                 2615 	.db #0xFF
   094D FF                 2616 	.db #0xFF
   094E FF                 2617 	.db #0xFF
   094F C0                 2618 	.db #0xC0
   0950 85 01              2619 	.byte _usbSetReport,(_usbSetReport >> 8)
   0952 21                 2620 	.db #0x21
   0953 0A                 2621 	.db #0x0A
   0954 FF                 2622 	.db #0xFF
   0955 FF                 2623 	.db #0xFF
   0956 FF                 2624 	.db #0xFF
   0957 FF                 2625 	.db #0xFF
   0958 00                 2626 	.db #0x00
   0959 00                 2627 	.db #0x00
   095A C3                 2628 	.db #0xC3
   095B 96 00              2629 	.byte _usbSetIdle,(_usbSetIdle >> 8)
   095D 21                 2630 	.db #0x21
   095E 0B                 2631 	.db #0x0B
   095F FF                 2632 	.db #0xFF
   0960 FF                 2633 	.db #0xFF
   0961 FF                 2634 	.db #0xFF
   0962 FF                 2635 	.db #0xFF
   0963 00                 2636 	.db #0x00
   0964 00                 2637 	.db #0x00
   0965 C3                 2638 	.db #0xC3
   0966 E9 00              2639 	.byte _usbSetProtocol,(_usbSetProtocol >> 8)
   0968 A1                 2640 	.db #0xA1
   0969 02                 2641 	.db #0x02
   096A FF                 2642 	.db #0xFF
   096B FF                 2643 	.db #0xFF
   096C FF                 2644 	.db #0xFF
   096D FF                 2645 	.db #0xFF
   096E 01                 2646 	.db #0x01
   096F 00                 2647 	.db #0x00
   0970 C3                 2648 	.db #0xC3
   0971 A6 00              2649 	.byte _usbGetIdle,(_usbGetIdle >> 8)
   0973 A1                 2650 	.db #0xA1
   0974 03                 2651 	.db #0x03
   0975 FF                 2652 	.db #0xFF
   0976 FF                 2653 	.db #0xFF
   0977 FF                 2654 	.db #0xFF
   0978 FF                 2655 	.db #0xFF
   0979 01                 2656 	.db #0x01
   097A 00                 2657 	.db #0x00
   097B C3                 2658 	.db #0xC3
   097C F3 00              2659 	.byte _usbGetProtocol,(_usbGetProtocol >> 8)
   097E 81                 2660 	.db #0x81
   097F 0A                 2661 	.db #0x0A
   0980 00                 2662 	.db #0x00
   0981 00                 2663 	.db #0x00
   0982 FF                 2664 	.db #0xFF
   0983 FF                 2665 	.db #0xFF
   0984 01                 2666 	.db #0x01
   0985 00                 2667 	.db #0x00
   0986 F3                 2668 	.db #0xF3
   0987 D3 00              2669 	.byte _usbGetInterface,(_usbGetInterface >> 8)
   0989 80                 2670 	.db #0x80
   098A 00                 2671 	.db #0x00
   098B 00                 2672 	.db #0x00
   098C 00                 2673 	.db #0x00
   098D 00                 2674 	.db #0x00
   098E 00                 2675 	.db #0x00
   098F 02                 2676 	.db #0x02
   0990 00                 2677 	.db #0x00
   0991 FF                 2678 	.db #0xFF
   0992 B5 01              2679 	.byte _usbGetDeviceStatus,(_usbGetDeviceStatus >> 8)
   0994 81                 2680 	.db #0x81
   0995 00                 2681 	.db #0x00
   0996 00                 2682 	.db #0x00
   0997 00                 2683 	.db #0x00
   0998 FF                 2684 	.db #0xFF
   0999 00                 2685 	.db #0x00
   099A 02                 2686 	.db #0x02
   099B 00                 2687 	.db #0x00
   099C F7                 2688 	.db #0xF7
   099D CB 01              2689 	.byte _usbGetInterfaceStatus,(_usbGetInterfaceStatus >> 8)
   099F 82                 2690 	.db #0x82
   09A0 00                 2691 	.db #0x00
   09A1 00                 2692 	.db #0x00
   09A2 00                 2693 	.db #0x00
   09A3 FF                 2694 	.db #0xFF
   09A4 00                 2695 	.db #0x00
   09A5 02                 2696 	.db #0x02
   09A6 00                 2697 	.db #0x00
   09A7 F7                 2698 	.db #0xF7
   09A8 8C 01              2699 	.byte _usbGetEndpointStatus,(_usbGetEndpointStatus >> 8)
   09AA 00                 2700 	.db #0x00
   09AB 05                 2701 	.db #0x05
   09AC FF                 2702 	.db #0xFF
   09AD 00                 2703 	.db #0x00
   09AE 00                 2704 	.db #0x00
   09AF 00                 2705 	.db #0x00
   09B0 00                 2706 	.db #0x00
   09B1 00                 2707 	.db #0x00
   09B2 DF                 2708 	.db #0xDF
   09B3 09 01              2709 	.byte _usbSetAddress,(_usbSetAddress >> 8)
   09B5 00                 2710 	.db #0x00
   09B6 03                 2711 	.db #0x03
   09B7 01                 2712 	.db #0x01
   09B8 00                 2713 	.db #0x00
   09B9 00                 2714 	.db #0x00
   09BA 00                 2715 	.db #0x00
   09BB 00                 2716 	.db #0x00
   09BC 00                 2717 	.db #0x00
   09BD FF                 2718 	.db #0xFF
   09BE 39 01              2719 	.byte _usbSetRemoteWakeup,(_usbSetRemoteWakeup >> 8)
   09C0 00                 2720 	.db #0x00
   09C1 01                 2721 	.db #0x01
   09C2 01                 2722 	.db #0x01
   09C3 00                 2723 	.db #0x00
   09C4 00                 2724 	.db #0x00
   09C5 00                 2725 	.db #0x00
   09C6 00                 2726 	.db #0x00
   09C7 00                 2727 	.db #0x00
   09C8 FF                 2728 	.db #0xFF
   09C9 5F 01              2729 	.byte _usbClearRemoteWakeup,(_usbClearRemoteWakeup >> 8)
   09CB 01                 2730 	.db #0x01
   09CC 0B                 2731 	.db #0x0B
   09CD FF                 2732 	.db #0xFF
   09CE 00                 2733 	.db #0x00
   09CF FF                 2734 	.db #0xFF
   09D0 00                 2735 	.db #0x00
   09D1 00                 2736 	.db #0x00
   09D2 00                 2737 	.db #0x00
   09D3 D7                 2738 	.db #0xD7
   09D4 BC 00              2739 	.byte _usbSetInterface,(_usbSetInterface >> 8)
   09D6 FF                 2740 	.db #0xFF
   09D7 FF                 2741 	.db #0xFF
   09D8 FF                 2742 	.db #0xFF
   09D9 FF                 2743 	.db #0xFF
   09DA FF                 2744 	.db #0xFF
   09DB FF                 2745 	.db #0xFF
   09DC FF                 2746 	.db #0xFF
   09DD FF                 2747 	.db #0xFF
   09DE 00                 2748 	.db #0x00
   09DF 06 03              2749 	.byte _usbNonStandardRequest,(_usbNonStandardRequest >> 8)
