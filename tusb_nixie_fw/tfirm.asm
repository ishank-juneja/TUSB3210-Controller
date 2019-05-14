;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.0 Mon May 13 20:34:34 2019

;--------------------------------------------------------
	.module tfirm
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tUsbRequestList
	.globl _abromDeviceDescriptor
	.globl _abromConfigurationDescriptorGroup
	.globl _main
	.globl _usbISR
	.globl _SetupPacketInterruptHandler
	.globl _IEP1InterruptHandler
	.globl _OEP1InterruptHandler
	.globl _IEP0InterruptHandler
	.globl _OEP0InterruptHandler
	.globl _usbDecodeAndProcessUsbRequest
	.globl _usbReceiveNextPacketOnOEP0
	.globl _SystemInitialization
	.globl _usbReset
	.globl _usbNonStandardRequest
	.globl _usbGetStringDescriptor
	.globl _usbGetDeviceDescriptor
	.globl _usbGetHIDDescriptor
	.globl _usbGetConfigurationDescriptor
	.globl _usbGetReportDescriptor
	.globl _usbGetInterfaceStatus
	.globl _usbGetDeviceStatus
	.globl _usbGetEndpointStatus
	.globl _usbSetReport
	.globl _usbClearRemoteWakeup
	.globl _usbSetRemoteWakeup
	.globl _usbSetAddress
	.globl _usbGetProtocol
	.globl _usbSetProtocol
	.globl _usbGetInterface
	.globl _usbSetInterface
	.globl _usbGetIdle
	.globl _usbSetIdle
	.globl _usbSetConfiguration
	.globl _usbGetConfiguration
	.globl _usbClearEndpointHalt
	.globl _usbSetEndpointHalt
	.globl _pbIEP1YBufferAddress
	.globl _pbIEP1XBufferAddress
	.globl _pbOEP1YBufferAddress
	.globl _pbOEP1XBufferAddress
	.globl _abDescriptor
	.globl _abIEP0Buffer
	.globl _abOEP0Buffer
	.globl _tOutputEndPointDescriptorBlock
	.globl _tInputEndPointDescriptorBlock
	.globl _tEndPoint0DescriptorBlock
	.globl _tSetupPacket
	.globl _abIEP1SaveBuffer
	.globl _abOEP1SaveBuffer
	.globl _total
	.globl _bOEP1SaveBufferPosition
	.globl _bOEP1RecieveLength
	.globl _FIRMWARE_VERSION
	.globl _ID2
	.globl _ID1
	.globl _bCurrentBuffer
	.globl _bHostAskMoreDataThanAvailable
	.globl _gbProtocol
	.globl _gbIdleRateH
	.globl _gbIdleRateL
	.globl _bSuspended
	.globl _bInterfaceNumber
	.globl _bConfigurationNumber
	.globl _pbOEP0Buffer
	.globl _pbIEP0Buffer
	.globl _wBytesRemainingOnOEP0
	.globl _wBytesRemainingOnIEP0
	.globl _wDeviceFeatures
	.globl _bUsbDeviceAddress
	.globl _bStatusAction
	.globl _deviceReady
	.globl _usbSendZeroLengthPacketOnIEP0
	.globl _usbStallEndpoint0
	.globl _usbReceiveDataPacketOnEP0
	.globl _usbSendNextPacketOnIEP0
	.globl _usbSendDataPacketOnEP0
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
_deviceReady::
	.ds 1
_bStatusAction::
	.ds 1
_bUsbDeviceAddress::
	.ds 1
_wDeviceFeatures::
	.ds 2
_wBytesRemainingOnIEP0::
	.ds 2
_wBytesRemainingOnOEP0::
	.ds 2
_pbIEP0Buffer::
	.ds 3
_pbOEP0Buffer::
	.ds 3
_bConfigurationNumber::
	.ds 1
_bInterfaceNumber::
	.ds 1
_bSuspended::
	.ds 1
_gbIdleRateL::
	.ds 1
_gbIdleRateH::
	.ds 1
_gbProtocol::
	.ds 1
_bHostAskMoreDataThanAvailable::
	.ds 2
_bCurrentBuffer::
	.ds 2
_ID1::
	.ds 1
_ID2::
	.ds 1
_FIRMWARE_VERSION::
	.ds 1
_bOEP1RecieveLength::
	.ds 1
_bOEP1SaveBufferPosition::
	.ds 1
_total::
	.ds 1
_usbGetEndpointStatus_wEndpointStatus_1_1::
	.ds 2
_usbGetInterfaceStatus_wStatusBuffer_1_1::
	.ds 2
_usbDecodeAndProcessUsbRequest_sloc0_1_0::
	.ds 1
_usbDecodeAndProcessUsbRequest_sloc1_1_0::
	.ds 1
_usbDecodeAndProcessUsbRequest_sloc2_1_0::
	.ds 1
_usbDecodeAndProcessUsbRequest_sloc3_1_0::
	.ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area _DUMMY
	.area	OSEG    (OVR,DATA)
	.area _DUMMY
	.area	OSEG    (OVR,DATA)
	.area _DUMMY
	.area	OSEG    (OVR,DATA)
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG	(DATA)
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
_abOEP1SaveBuffer::
	.ds 80
_abIEP1SaveBuffer::
	.ds 80
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_tSetupPacket	=	0xff00
_tEndPoint0DescriptorBlock	=	0xff80
_tInputEndPointDescriptorBlock	=	0xff48
_tOutputEndPointDescriptorBlock	=	0xff08
_abOEP0Buffer	=	0xfef0
_abIEP0Buffer	=	0xfef8
_abDescriptor	=	0xfe80
_pbOEP1XBufferAddress	=	0xfd80
_pbOEP1YBufferAddress	=	0xfdc0
_pbIEP1XBufferAddress	=	0xfe00
_pbIEP1YBufferAddress	=	0xfe40
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area CSEG    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
	ljmp	_usbISR
	.ds	5
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
__sdcc_gsinit_startup:
	mov	sp,#7
	lcall	__sdcc_external_startup
	mov	a,dpl
	jz	__sdcc_init_data
	ljmp	__sdcc_program_startup
__sdcc_init_data:
;	tfirm.c 27
	mov	_deviceReady,#0x00
;	tfirm.c 30
	clr	a
	mov	(_wDeviceFeatures + 1),a
	mov	_wDeviceFeatures,a
;	tfirm.c 35
	mov	_bConfigurationNumber,#0x00
;	tfirm.c 36
	mov	_bInterfaceNumber,#0x00
;	tfirm.c 38
	mov	_bSuspended,#0x00
;	tfirm.c 42
	mov	_gbProtocol,#0x01
;	tfirm.c 90
	mov	_total,#0x00
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME	 (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
__sdcc_program_startup:
	lcall	_main
;	return from main will lock up
	sjmp .
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSendZeroLengthPacketOnIEP0'
;------------------------------------------------------------
;	tfirm.c 92
;	-----------------------------------------
;	 function usbSendZeroLengthPacketOnIEP0
;	-----------------------------------------
_usbSendZeroLengthPacketOnIEP0:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	tfirm.c 93
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 94
	mov	_bStatusAction,#0x00
;	tfirm.c 95
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetEndpointHalt'
;------------------------------------------------------------
;	tfirm.c 98
;	-----------------------------------------
;	 function usbSetEndpointHalt
;	-----------------------------------------
_usbSetEndpointHalt:
;	tfirm.c 99
	mov	dptr,#_tInputEndPointDescriptorBlock
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x7F
	mov	dptr,#_tInputEndPointDescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 100
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbClearEndpointHalt'
;------------------------------------------------------------
;	tfirm.c 103
;	-----------------------------------------
;	 function usbClearEndpointHalt
;	-----------------------------------------
_usbClearEndpointHalt:
;	tfirm.c 104
	mov	dptr,#_tInputEndPointDescriptorBlock
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x80
	mov	dptr,#_tInputEndPointDescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 105
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetConfiguration'
;------------------------------------------------------------
;	tfirm.c 109
;	-----------------------------------------
;	 function usbGetConfiguration
;	-----------------------------------------
_usbGetConfiguration:
;	tfirm.c 110
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 111
	mov	r2,#_bConfigurationNumber
	mov	r3,#0x00
	mov	r4,#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetConfiguration'
;------------------------------------------------------------
;	tfirm.c 114
;	-----------------------------------------
;	 function usbSetConfiguration
;	-----------------------------------------
_usbSetConfiguration:
;	tfirm.c 115
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 116
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_bConfigurationNumber,a
;	tfirm.c 117
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetIdle'
;------------------------------------------------------------
;	tfirm.c 120
;	-----------------------------------------
;	 function usbSetIdle
;	-----------------------------------------
_usbSetIdle:
;	tfirm.c 121
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_gbIdleRateL,a
;	tfirm.c 122
	mov	dptr,#(_tSetupPacket + 0x0003)
	movx	a,@dptr
	mov	_gbIdleRateH,a
;	tfirm.c 123
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetIdle'
;------------------------------------------------------------
;	tfirm.c 126
;	-----------------------------------------
;	 function usbGetIdle
;	-----------------------------------------
_usbGetIdle:
;	tfirm.c 127
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 128
	mov	r2,#_gbIdleRateH
	mov	r3,#0x00
	mov	r4,#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetInterface'
;------------------------------------------------------------
;	tfirm.c 131
;	-----------------------------------------
;	 function usbSetInterface
;	-----------------------------------------
_usbSetInterface:
;	tfirm.c 132
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 133
	mov	dptr,#(_tSetupPacket + 0x0004)
	movx	a,@dptr
	mov	_bInterfaceNumber,a
;	tfirm.c 134
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetInterface'
;------------------------------------------------------------
;	tfirm.c 137
;	-----------------------------------------
;	 function usbGetInterface
;	-----------------------------------------
_usbGetInterface:
;	tfirm.c 138
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 139
	mov	r2,#_bInterfaceNumber
	mov	r3,#0x00
	mov	r4,#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetProtocol'
;------------------------------------------------------------
;	tfirm.c 143
;	-----------------------------------------
;	 function usbSetProtocol
;	-----------------------------------------
_usbSetProtocol:
;	tfirm.c 144
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_gbProtocol,a
;	tfirm.c 145
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetProtocol'
;------------------------------------------------------------
;	tfirm.c 148
;	-----------------------------------------
;	 function usbGetProtocol
;	-----------------------------------------
_usbGetProtocol:
;	tfirm.c 149
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 150
	mov	r2,#_gbProtocol
	mov	r3,#0x00
	mov	r4,#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetAddress'
;------------------------------------------------------------
;	tfirm.c 154
;	-----------------------------------------
;	 function usbSetAddress
;	-----------------------------------------
_usbSetAddress:
;	tfirm.c 155
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	r2,a
	mov	r3,#0x00
	clr	c
	mov	a,r2
	subb	a,#0x80
	mov	a,r3
	subb	a,#0x00
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00102$
00107$:
;	tfirm.c 157
	mov	r2,#0xFF
	mov	r3,#0xFF
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
; Peephole 136   removed redundant moves
	mov  r4,a
	mov  dpl,r2
	mov  dph,r3
	movx	@dptr,a
;	tfirm.c 158
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_bUsbDeviceAddress,a
;	tfirm.c 159
	mov	_bStatusAction,#0x03
;	tfirm.c 160
	lcall	_usbSendZeroLengthPacketOnIEP0
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00102$:
;	tfirm.c 163
	lcall	_usbStallEndpoint0
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetRemoteWakeup'
;------------------------------------------------------------
;	tfirm.c 167
;	-----------------------------------------
;	 function usbSetRemoteWakeup
;	-----------------------------------------
_usbSetRemoteWakeup:
;	tfirm.c 168
	mov	r2,#0xFC
	mov	r3,#0xFF
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
	movx	a,@dptr
	mov	r4,a
	orl	ar4,#0x08
	mov	dpl,r2
	mov	dph,r3
	mov	a,r4
	movx	@dptr,a
;	tfirm.c 169
	orl	(_wDeviceFeatures + 1),#0x02
;	tfirm.c 170
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 171
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbClearRemoteWakeup'
;------------------------------------------------------------
;	tfirm.c 174
;	-----------------------------------------
;	 function usbClearRemoteWakeup
;	-----------------------------------------
_usbClearRemoteWakeup:
;	tfirm.c 175
	mov	r2,#0xFC
	mov	r3,#0xFF
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
	movx	a,@dptr
	mov	r4,a
	anl	ar4,#0xF7
	mov	dpl,r2
	mov	dph,r3
	mov	a,r4
	movx	@dptr,a
;	tfirm.c 176
	anl	(_wDeviceFeatures + 1),#0xFD
;	tfirm.c 177
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 178
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetReport'
;------------------------------------------------------------
;	tfirm.c 181
;	-----------------------------------------
;	 function usbSetReport
;	-----------------------------------------
_usbSetReport:
;	tfirm.c 182
	clr	a
	mov	(_wBytesRemainingOnOEP0 + 1),a
	mov	_wBytesRemainingOnOEP0,#0x01
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetEndpointStatus'
;------------------------------------------------------------
;wEndpointStatus           Allocated to in memory with name '_usbGetEndpointStatus_wEndpointStatus_1_1'
;	tfirm.c 186
;	-----------------------------------------
;	 function usbGetEndpointStatus
;	-----------------------------------------
_usbGetEndpointStatus:
;	tfirm.c 187
	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,#0x00
	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),#0x01
;	tfirm.c 188
	mov	dptr,#_tInputEndPointDescriptorBlock
	movx	a,@dptr
; Peephole 105   removed redundant mov
	mov  r2,a
; Peephole 111   removed ljmp by inverse jump logic
	jnb  acc.7,00102$
00106$:
;	tfirm.c 189
	clr	a
	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),a
	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,a
00102$:
;	tfirm.c 191
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x02
;	tfirm.c 192
	mov	r2,#_usbGetEndpointStatus_wEndpointStatus_1_1
	mov	r3,#0x00
	mov	r4,#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00103$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetDeviceStatus'
;------------------------------------------------------------
;	tfirm.c 195
;	-----------------------------------------
;	 function usbGetDeviceStatus
;	-----------------------------------------
_usbGetDeviceStatus:
;	tfirm.c 196
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x02
;	tfirm.c 197
	mov	r2,#_wDeviceFeatures
	mov	r3,#0x00
	mov	r4,#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetInterfaceStatus'
;------------------------------------------------------------
;wStatusBuffer             Allocated to in memory with name '_usbGetInterfaceStatus_wStatusBuffer_1_1'
;	tfirm.c 200
;	-----------------------------------------
;	 function usbGetInterfaceStatus
;	-----------------------------------------
_usbGetInterfaceStatus:
;	tfirm.c 201
	clr	a
	mov	(_usbGetInterfaceStatus_wStatusBuffer_1_1 + 1),a
	mov	_usbGetInterfaceStatus_wStatusBuffer_1_1,a
;	tfirm.c 202
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 203
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x02
;	tfirm.c 204
	mov	r2,#_usbGetInterfaceStatus_wStatusBuffer_1_1
	mov	r3,#0x00
	mov	r4,#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetReportDescriptor'
;------------------------------------------------------------
;	tfirm.c 208
;	-----------------------------------------
;	 function usbGetReportDescriptor
;	-----------------------------------------
_usbGetReportDescriptor:
;	tfirm.c 209
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 210
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x3F
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetConfigurationDescriptor'
;------------------------------------------------------------
;bTemp                     Allocated to registers 
;	tfirm.c 214
;	-----------------------------------------
;	 function usbGetConfigurationDescriptor
;	-----------------------------------------
_usbGetConfigurationDescriptor:
;	tfirm.c 217
	mov	r2,#0x00
00101$:
	cjne	r2,#0x20,00109$
00109$:
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00110$:
;	tfirm.c 218
	mov	a,r2
	add	a,#_abDescriptor
	mov	r3,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,#(_abDescriptor >> 8)
	mov	r4,a
	mov	a,r2
; Peephole 180   changed mov to clr
; Peephole 186   optimized movc sequence
	mov  dptr,#_abromConfigurationDescriptorGroup
	movc a,@a+dptr
; Peephole 136   removed redundant moves
	mov  r5,a
	mov  dpl,r3
	mov  dph,r4
	movx	@dptr,a
;	tfirm.c 217
	inc	r2
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	tfirm.c 220
	mov	dptr,#(_abDescriptor + 0x0007)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 222
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 223
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x20
;	tfirm.c 224
	mov	r2,#_abDescriptor
	mov	r3,#(_abDescriptor >> 8)
	mov	r4,#0x01
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetHIDDescriptor'
;------------------------------------------------------------
;bTemp                     Allocated to registers 
;	tfirm.c 228
;	-----------------------------------------
;	 function usbGetHIDDescriptor
;	-----------------------------------------
_usbGetHIDDescriptor:
;	tfirm.c 231
	mov	r2,#0x00
00101$:
	cjne	r2,#0x12,00109$
00109$:
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00110$:
;	tfirm.c 232
	mov	a,r2
	add	a,#_abDescriptor
	mov	r3,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,#(_abDescriptor >> 8)
	mov	r4,a
	mov	a,#0x12
	add	a,r2
; Peephole 180   changed mov to clr
; Peephole 186   optimized movc sequence
	mov  dptr,#_abromConfigurationDescriptorGroup
	movc a,@a+dptr
; Peephole 136   removed redundant moves
	mov  r5,a
	mov  dpl,r3
	mov  dph,r4
	movx	@dptr,a
;	tfirm.c 231
	inc	r2
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	tfirm.c 234
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 235
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x09
;	tfirm.c 236
	mov	r2,#_abDescriptor
	mov	r3,#(_abDescriptor >> 8)
	mov	r4,#0x01
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetDeviceDescriptor'
;------------------------------------------------------------
;bTemp                     Allocated to registers 
;	tfirm.c 239
;	-----------------------------------------
;	 function usbGetDeviceDescriptor
;	-----------------------------------------
_usbGetDeviceDescriptor:
;	tfirm.c 242
	mov	r2,#0x00
00101$:
	cjne	r2,#0x12,00109$
00109$:
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00110$:
;	tfirm.c 243
	mov	a,r2
	add	a,#_abDescriptor
	mov	r3,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,#(_abDescriptor >> 8)
	mov	r4,a
	mov	a,r2
; Peephole 180   changed mov to clr
; Peephole 186   optimized movc sequence
	mov  dptr,#_abromDeviceDescriptor
	movc a,@a+dptr
; Peephole 136   removed redundant moves
	mov  r5,a
	mov  dpl,r3
	mov  dph,r4
	movx	@dptr,a
;	tfirm.c 242
	inc	r2
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	tfirm.c 245
	mov	dptr,#(_abDescriptor + 0x0004)
	mov	a,#0xFF
	movx	@dptr,a
;	tfirm.c 246
	mov	dptr,#(_abDescriptor + 0x0008)
	mov	a,#0x51
	movx	@dptr,a
;	tfirm.c 247
	mov	dptr,#(_abDescriptor + 0x0009)
	mov	a,#0x04
	movx	@dptr,a
;	tfirm.c 248
	mov	dptr,#(_abDescriptor + 0x000a)
	mov	a,#0x10
	movx	@dptr,a
;	tfirm.c 249
	mov	dptr,#(_abDescriptor + 0x000b)
	mov	a,#0x32
	movx	@dptr,a
;	tfirm.c 250
	mov	dptr,#(_abDescriptor + 0x000c)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 251
	mov	dptr,#(_abDescriptor + 0x000d)
	mov	a,#0x01
	movx	@dptr,a
;	tfirm.c 253
	mov	dptr,#(_abDescriptor + 0x000e)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 254
	mov	dptr,#(_abDescriptor + 0x000f)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 255
	mov	dptr,#(_abDescriptor + 0x0010)
	mov	a,#0x01
	movx	@dptr,a
;	tfirm.c 257
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 258
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x12
;	tfirm.c 259
	mov	r2,#_abDescriptor
	mov	r3,#(_abDescriptor >> 8)
	mov	r4,#0x01
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
;	tfirm.c 263
	mov	_deviceReady,#0x01
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetStringDescriptor'
;------------------------------------------------------------
;	tfirm.c 267
;	-----------------------------------------
;	 function usbGetStringDescriptor
;	-----------------------------------------
_usbGetStringDescriptor:
;	tfirm.c 269
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 270
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x12
;	tfirm.c 271
	mov	r2,#_abDescriptor
	mov	r3,#(_abDescriptor >> 8)
	mov	r4,#0x01
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbNonStandardRequest'
;------------------------------------------------------------
;	tfirm.c 275
;	-----------------------------------------
;	 function usbNonStandardRequest
;	-----------------------------------------
_usbNonStandardRequest:
;	tfirm.c 276
	lcall	_usbStallEndpoint0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbStallEndpoint0'
;------------------------------------------------------------
;	tfirm.c 279
;	-----------------------------------------
;	 function usbStallEndpoint0
;	-----------------------------------------
_usbStallEndpoint0:
;	tfirm.c 280
	mov	dptr,#_tEndPoint0DescriptorBlock
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#_tEndPoint0DescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 281
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbReset'
;------------------------------------------------------------
;	tfirm.c 494
;	-----------------------------------------
;	 function usbReset
;	-----------------------------------------
_usbReset:
;	tfirm.c 495
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFF)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 497
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 498
	mov	_wBytesRemainingOnOEP0,#0xFF
	mov	(_wBytesRemainingOnOEP0 + 1),#0xFF
;	tfirm.c 499
;	tfirm.c 501
; Peephole 3.b   changed mov to clr
	clr  a
	mov  _bStatusAction,a
	mov	(_pbIEP0Buffer + 2),a
	mov	(_pbIEP0Buffer + 1),a
	mov	_pbIEP0Buffer,a
;	tfirm.c 502
	clr	a
	mov	(_pbOEP0Buffer + 2),a
	mov	(_pbOEP0Buffer + 1),a
	mov	_pbOEP0Buffer,a
;	tfirm.c 504
	mov	_bConfigurationNumber,#0x00
;	tfirm.c 505
	mov	_bInterfaceNumber,#0x00
;	tfirm.c 507
	mov	dptr,#_tEndPoint0DescriptorBlock
	mov	a,#0x84
	movx	@dptr,a
;	tfirm.c 508
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,#0x84
	movx	@dptr,a
;	tfirm.c 510
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 511
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 514
	mov	dptr,#_tInputEndPointDescriptorBlock
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 515
	mov	dptr,#_tInputEndPointDescriptorBlock
	mov	a,#0x84
	movx	@dptr,a
;	tfirm.c 516
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0001)
	mov	a,#0xC0
	movx	@dptr,a
;	tfirm.c 517
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 518
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0007)
	mov	a,#0x40
	movx	@dptr,a
;	tfirm.c 519
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 522
	mov	dptr,#_tOutputEndPointDescriptorBlock
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 524
	mov	dptr,#_tOutputEndPointDescriptorBlock
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x84
	mov	dptr,#_tOutputEndPointDescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 525
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0001)
	mov	a,#0xB0
	movx	@dptr,a
;	tfirm.c 526
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 527
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0005)
	mov	a,#0xB8
	movx	@dptr,a
;	tfirm.c 528
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0006)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 529
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0007)
	mov	a,#0x40
	movx	@dptr,a
;	tfirm.c 531
	clr	a
	mov	(_bCurrentBuffer + 1),a
	mov	_bCurrentBuffer,a
;	tfirm.c 532
	mov	_bOEP1RecieveLength,#0x00
;	tfirm.c 533
	mov	_bOEP1SaveBufferPosition,#0x00
;	tfirm.c 535
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFD)
	mov	a,#0xE5
	movx	@dptr,a
;	tfirm.c 536
	mov	r2,#0xF7
	mov	r3,#0xFF
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xF7)
	movx	a,@dptr
	mov	r4,a
	orl	ar4,#0x95
	mov	dpl,r2
	mov	dph,r3
	mov	a,r4
	movx	@dptr,a
;	tfirm.c 538
	mov	_ID1,#0x43
;	tfirm.c 539
	mov	_ID2,#0x4D
;	tfirm.c 540
	mov	_FIRMWARE_VERSION,#0x00
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SystemInitialization'
;------------------------------------------------------------
;	tfirm.c 544
;	-----------------------------------------
;	 function SystemInitialization
;	-----------------------------------------
_SystemInitialization:
;	tfirm.c 546
	clr	_EA
;	tfirm.c 548
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 550
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x90)
	mov	a,#0xE0
	movx	@dptr,a
;	tfirm.c 555
	setb	_EA
;	tfirm.c 556
	setb	_EX0
;	tfirm.c 558
	lcall	_usbReset
;	tfirm.c 560
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
	mov	a,#0x80
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbReceiveDataPacketOnEP0'
;------------------------------------------------------------
;	tfirm.c 565
;	-----------------------------------------
;	 function usbReceiveDataPacketOnEP0
;	-----------------------------------------
_usbReceiveDataPacketOnEP0:
;	tfirm.c 576
	mov	_pbOEP0Buffer,dpl
	mov	(_pbOEP0Buffer + 1),dph
	mov	(_pbOEP0Buffer + 2),b
;	tfirm.c 570
	mov	dptr,#(_tSetupPacket + 0x0007)
	movx	a,@dptr
	mov	r2,a
	mov	r3,#0x00
;	tfirm.c 571
	mov	ar3,r2
	mov	r2,#0x00
;	tfirm.c 572
	mov	dptr,#(_tSetupPacket + 0x0006)
	movx	a,@dptr
	mov	r4,a
	mov	r5,#0x00
;	tfirm.c 574
	mov	a,r4
	orl	a,r2
	mov	_wBytesRemainingOnOEP0,a
	mov	a,r5
	orl	a,r3
	mov	(_wBytesRemainingOnOEP0 + 1),a
;	tfirm.c 575
	mov	_bStatusAction,#0x02
;	tfirm.c 576
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbReceiveNextPacketOnOEP0'
;------------------------------------------------------------
;	tfirm.c 579
;	-----------------------------------------
;	 function usbReceiveNextPacketOnOEP0
;	-----------------------------------------
_usbReceiveNextPacketOnOEP0:
;	tfirm.c 585
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x7F
;	tfirm.c 592
	mov	ar3,r2
	mov	r4,#0x00
	clr	c
	mov	a,_wBytesRemainingOnOEP0
	subb	a,r3
	mov	a,(_wBytesRemainingOnOEP0 + 1)
	subb	a,r4
	jnc	00117$
	ljmp	00105$
00117$:
;	tfirm.c 596
	mov	r5,#0x00
00107$:
	clr	c
	mov	a,r5
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00110$
00118$:
;	tfirm.c 597
	mov	r6,_pbOEP0Buffer
	mov	r7,(_pbOEP0Buffer + 1)
	mov	r0,(_pbOEP0Buffer + 2)
	inc	_pbOEP0Buffer
	clr	a
	cjne	a,_pbOEP0Buffer,00119$
	inc	(_pbOEP0Buffer + 1)
00119$:
	mov	a,r5
	add	a,#_abOEP0Buffer
	mov	dpl,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,#(_abOEP0Buffer >> 8)
	mov	dph,a
	movx	a,@dptr
; Peephole 191   removed redundant mov
	mov  r1,a
	mov  dpl,r6
	mov  dph,r7
	mov  b,r0
	lcall	__gptrput
;	tfirm.c 596
	inc	r5
; Peephole 132   changed ljmp to sjmp
	sjmp 00107$
00110$:
;	tfirm.c 601
	clr	c
	mov	a,_wBytesRemainingOnOEP0
	subb	a,r3
	mov	_wBytesRemainingOnOEP0,a
	mov	a,(_wBytesRemainingOnOEP0 + 1)
	subb	a,r4
	mov	(_wBytesRemainingOnOEP0 + 1),a
;	tfirm.c 607
	clr	c
; Peephole 180   changed mov to clr
	clr  a
	subb	a,_wBytesRemainingOnOEP0
; Peephole 180   changed mov to clr
	clr  a
	subb	a,(_wBytesRemainingOnOEP0 + 1)
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00102$
00120$:
;	tfirm.c 609
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 610
	mov	_bStatusAction,#0x02
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00102$:
;	tfirm.c 622
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 623
	mov	_bStatusAction,#0x00
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00105$:
;	tfirm.c 634
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 635
	mov	_bStatusAction,#0x00
00111$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSendNextPacketOnIEP0'
;------------------------------------------------------------
;	tfirm.c 639
;	-----------------------------------------
;	 function usbSendNextPacketOnIEP0
;	-----------------------------------------
_usbSendNextPacketOnIEP0:
;	tfirm.c 643
	mov	a,_wBytesRemainingOnIEP0
	cjne	a,#0xFF,00125$
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	cjne	a,#0xFF,00125$
	ljmp	00111$
00125$:
;	tfirm.c 645
	clr	c
	mov	a,#0x08
	subb	a,_wBytesRemainingOnIEP0
; Peephole 180   changed mov to clr
	clr  a
	subb	a,(_wBytesRemainingOnIEP0 + 1)
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00108$
00126$:
;	tfirm.c 649
	mov	r2,#0x08
;	tfirm.c 650
	mov	a,_wBytesRemainingOnIEP0
	add	a,#0xf8
	mov	_wBytesRemainingOnIEP0,a
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	addc	a,#0xff
	mov	(_wBytesRemainingOnIEP0 + 1),a
;	tfirm.c 651
	mov	_bStatusAction,#0x01
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00108$:
;	tfirm.c 653
	clr	c
	mov	a,_wBytesRemainingOnIEP0
	subb	a,#0x08
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	subb	a,#0x00
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00105$
00127$:
;	tfirm.c 657
	mov	r2,_wBytesRemainingOnIEP0
;	tfirm.c 658
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 659
	mov	_bStatusAction,#0x00
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00105$:
;	tfirm.c 664
	mov	r2,#0x08
;	tfirm.c 665
	mov	a,_bHostAskMoreDataThanAvailable
	cjne	a,#0x01,00128$
	mov	a,(_bHostAskMoreDataThanAvailable + 1)
; Peephole 162   removed sjmp by inverse jump logic
	jz   00129$
00128$:
; Peephole 132   changed ljmp to sjmp
	sjmp 00102$
00129$:
;	tfirm.c 667
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,a
;	tfirm.c 668
	mov	_bStatusAction,#0x01
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00102$:
;	tfirm.c 672
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 673
	mov	_bStatusAction,#0x00
;	tfirm.c 676
00124$:
	mov	r3,#0x00
00113$:
	clr	c
	mov	a,r3
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00116$
00130$:
;	tfirm.c 677
	mov	a,r3
	add	a,#_abIEP0Buffer
	mov	r4,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,#(_abIEP0Buffer >> 8)
	mov	r5,a
	mov	dpl,_pbIEP0Buffer
	mov	dph,(_pbIEP0Buffer + 1)
	mov	b,(_pbIEP0Buffer + 2)
	inc	_pbIEP0Buffer
	clr	a
	cjne	a,_pbIEP0Buffer,00131$
	inc	(_pbIEP0Buffer + 1)
00131$:
	lcall	__gptrget
; Peephole 136   removed redundant moves
	mov  r6,a
	mov  dpl,r4
	mov  dph,r5
	movx	@dptr,a
;	tfirm.c 676
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00113$
00116$:
;	tfirm.c 679
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
	mov	a,r2
	movx	@dptr,a
; Peephole 132   changed ljmp to sjmp
	sjmp 00117$
00111$:
;	tfirm.c 683
	mov	_bStatusAction,#0x00
00117$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSendDataPacketOnEP0'
;------------------------------------------------------------
;pbBuffer                  Allocated to registers 
;wh                        Allocated to registers r2 r3 
;wl                        Allocated to registers r4 r5 
;wTemp                     Allocated to registers r2 r3 
;	tfirm.c 687
;	-----------------------------------------
;	 function usbSendDataPacketOnEP0
;	-----------------------------------------
_usbSendDataPacketOnEP0:
;	tfirm.c 712
	mov	_pbIEP0Buffer,dpl
	mov	(_pbIEP0Buffer + 1),dph
	mov	(_pbIEP0Buffer + 2),b
;	tfirm.c 694
	mov	dptr,#(_tSetupPacket + 0x0007)
	movx	a,@dptr
	mov	r2,a
	mov	r3,#0x00
;	tfirm.c 695
	mov	ar3,r2
	mov	r2,#0x00
;	tfirm.c 696
	mov	dptr,#(_tSetupPacket + 0x0006)
	movx	a,@dptr
	mov	r4,a
	mov	r5,#0x00
;	tfirm.c 698
	mov	a,r4
	orl	ar2,a
	mov	a,r5
	orl	ar3,a
;	tfirm.c 702
	clr	c
	mov	a,_wBytesRemainingOnIEP0
	subb	a,r2
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	subb	a,r3
; Peephole 132   changed ljmp to sjmp
; Peephole 160   removed sjmp by inverse jump logic
	jc   00102$
00107$:
;	tfirm.c 704
	mov	_wBytesRemainingOnIEP0,r2
	mov	(_wBytesRemainingOnIEP0 + 1),r3
;	tfirm.c 705
	clr	a
	mov	(_bHostAskMoreDataThanAvailable + 1),a
	mov	_bHostAskMoreDataThanAvailable,a
; Peephole 132   changed ljmp to sjmp
	sjmp 00103$
00102$:
;	tfirm.c 709
	clr	a
	mov	(_bHostAskMoreDataThanAvailable + 1),a
	mov	_bHostAskMoreDataThanAvailable,#0x01
00103$:
;	tfirm.c 712
	lcall	_usbSendNextPacketOnIEP0
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbDecodeAndProcessUsbRequest'
;------------------------------------------------------------
;bMask                     Allocated to registers r6 
;bResult                   Allocated to registers r5 
;bTemp                     Allocated to registers 
;pbUsbRequestList          Allocated to registers r2 r3 r4 
;sloc0                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc0_1_0'
;sloc1                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc1_1_0'
;sloc2                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc2_1_0'
;sloc3                     Allocated to in memory with name '_usbDecodeAndProcessUsbRequest_sloc3_1_0'
;	tfirm.c 715
;	-----------------------------------------
;	 function usbDecodeAndProcessUsbRequest
;	-----------------------------------------
_usbDecodeAndProcessUsbRequest:
;	tfirm.c 723
	mov	r2,#_tUsbRequestList
	mov	r3,#(_tUsbRequestList >> 8)
	mov	r4,#0x02
;	tfirm.c 728
00106$:
;	tfirm.c 730
	mov	r5,#0x00
;	tfirm.c 731
	mov	r6,#0x80
;	tfirm.c 738
	mov	r7,#0x00
00110$:
	cjne	r7,#0x08,00122$
00122$:
	clr	a
	rlc	a
; Peephole 105   removed redundant mov
	mov  r0,a
; Peephole 110   removed ljmp by inverse jump logic
	jz  00113$
00123$:
;	tfirm.c 740
; Peephole 180   changed mov to clr
	clr  a
	add	a,r7
	mov	dpl,a
	mov	a,#0xFF
	addc	a,#0x00
	mov	dph,a
	movx	a,@dptr
	mov	r1,a
	mov	a,r7
	add	a,r2
	mov	dpl,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,r3
	mov	dph,a
	mov	b,r4
	lcall	__gptrget
	mov	_usbDecodeAndProcessUsbRequest_sloc0_1_0,a
	mov	_usbDecodeAndProcessUsbRequest_sloc1_1_0,r1
	mov	a,_usbDecodeAndProcessUsbRequest_sloc1_1_0
	cjne	a,_usbDecodeAndProcessUsbRequest_sloc0_1_0,00124$
	mov	a,#0x01
	sjmp	00125$
00124$:
	clr	a
00125$:
; Peephole 105   removed redundant mov
	mov  _usbDecodeAndProcessUsbRequest_sloc2_1_0,a
; Peephole 110   removed ljmp by inverse jump logic
	jz  00102$
00126$:
;	tfirm.c 741
	mov	a,r6
	orl	a,r5
	mov	r5,a
00102$:
;	tfirm.c 742
	mov	a,r6
	clr	c
	rrc	a
	mov	_usbDecodeAndProcessUsbRequest_sloc3_1_0,a
	mov	r6,_usbDecodeAndProcessUsbRequest_sloc3_1_0
;	tfirm.c 738
	inc	r7
; Peephole 132   changed ljmp to sjmp
	sjmp 00110$
00113$:
;	tfirm.c 753
	mov	a,r7
	add	a,r2
	mov	dpl,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,r3
	mov	dph,a
	mov	b,r4
	lcall	__gptrget
; Peephole 105   removed redundant mov
	mov  r7,a
	anl	ar5,a
	mov	a,r5
	cjne	a,ar7,00127$
; Peephole 132   changed ljmp to sjmp
	sjmp 00107$
00127$:
;	tfirm.c 757
	mov	a,#0x0B
	add	a,r2
	mov	r2,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,r3
	mov	r3,a
	ljmp	00106$
00107$:
;	tfirm.c 762
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	movx	a,@dptr
; Peephole 105   removed redundant mov
	mov  r5,a
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	a,r5
; Peephole 111   removed ljmp by inverse jump logic
	jnb  acc.0,00109$
00128$:
;	tfirm.c 763
; Peephole 132   changed ljmp to sjmp
	sjmp 00114$
00109$:
;	tfirm.c 767
	mov	a,#0x09
	add	a,r2
	mov	dpl,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,r3
	mov	dph,a
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
	mov	a,#00129$
	push	acc
	mov	a,#(00129$ >> 8)
	push	acc
	push	ar2
	push	ar3
	ret
00129$:
00114$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'OEP0InterruptHandler'
;------------------------------------------------------------
;	tfirm.c 770
;	-----------------------------------------
;	 function OEP0InterruptHandler
;	-----------------------------------------
_OEP0InterruptHandler:
;	tfirm.c 772
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 780
	mov	a,_bStatusAction
; Peephole 132   changed ljmp to sjmp
; Peephole 199   optimized misc jump sequence
	cjne a,#0x02,00102$
;00107$:
; Peephole 200   removed redundant sjmp
00108$:
;	tfirm.c 781
	lcall	_usbReceiveNextPacketOnOEP0
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00102$:
;	tfirm.c 783
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'IEP0InterruptHandler'
;------------------------------------------------------------
;	tfirm.c 786
;	-----------------------------------------
;	 function IEP0InterruptHandler
;	-----------------------------------------
_IEP0InterruptHandler:
;	tfirm.c 788
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 796
	mov	a,_bStatusAction
; Peephole 132   changed ljmp to sjmp
; Peephole 199   optimized misc jump sequence
	cjne a,#0x01,00102$
;00107$:
; Peephole 200   removed redundant sjmp
00108$:
;	tfirm.c 797
	lcall	_usbSendNextPacketOnIEP0
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00102$:
;	tfirm.c 803
	mov	dptr,#_tEndPoint0DescriptorBlock
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#_tEndPoint0DescriptorBlock
	mov	a,r2
	movx	@dptr,a
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'OEP1InterruptHandler'
;------------------------------------------------------------
;bSize                     Allocated to registers r2 
;bTemp                     Allocated to registers 
;xmt_size                  Allocated to in memory with name '_OEP1InterruptHandler_xmt_size_1_1'
;rcv_size                  Allocated to in memory with name '_OEP1InterruptHandler_rcv_size_1_1'
;	tfirm.c 807
;	-----------------------------------------
;	 function OEP1InterruptHandler
;	-----------------------------------------
_OEP1InterruptHandler:
;	tfirm.c 813
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x4A)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 817
	mov	a,_bOEP1RecieveLength
; Peephole 162   removed sjmp by inverse jump logic
	jz   00135$
00134$:
; Peephole 132   changed ljmp to sjmp
	sjmp 00102$
00135$:
;	tfirm.c 818
	mov	dptr,#(_pbOEP1XBufferAddress + 0x0001)
	movx	a,@dptr
	mov	_bOEP1RecieveLength,a
;	tfirm.c 819
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x7F
;	tfirm.c 820
	mov	r3,#0x00
00116$:
	clr	c
	mov	a,r3
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00119$
00136$:
;	tfirm.c 821
	mov	a,_bOEP1SaveBufferPosition
	add	a,#_abOEP1SaveBuffer
	mov	r0,a
	mov	a,r3
	add	a,#_pbOEP1XBufferAddress
	mov	dpl,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,#(_pbOEP1XBufferAddress >> 8)
	mov	dph,a
	movx	a,@dptr
; Peephole 192   used a instead of ar4 as source
	mov  r4,a
	mov  @r0,a
;	tfirm.c 823
	inc	_bOEP1SaveBufferPosition
;	tfirm.c 820
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00116$
00119$:
;	tfirm.c 825
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
; Peephole 132   changed ljmp to sjmp
	sjmp 00103$
00102$:
;	tfirm.c 830
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r3,a
	mov	a,#0x7F
	anl	a,r3
	mov	r2,a
;	tfirm.c 831
	mov	r3,#0x00
00120$:
	clr	c
	mov	a,r3
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00123$
00137$:
;	tfirm.c 832
	mov	a,_bOEP1SaveBufferPosition
	add	a,#_abOEP1SaveBuffer
	mov	r0,a
	mov	a,r3
	add	a,#_pbOEP1XBufferAddress
	mov	dpl,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,#(_pbOEP1XBufferAddress >> 8)
	mov	dph,a
	movx	a,@dptr
; Peephole 192   used a instead of ar4 as source
	mov  r4,a
	mov  @r0,a
;	tfirm.c 834
	inc	_bOEP1SaveBufferPosition
;	tfirm.c 831
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00120$
00123$:
;	tfirm.c 836
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
00103$:
;	tfirm.c 841
	clr	c
	mov	a,_bOEP1SaveBufferPosition
	subb	a,_bOEP1RecieveLength
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00105$
00138$:
;	tfirm.c 842
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00105$:
;	tfirm.c 844
	mov	_bOEP1RecieveLength,#0x00
;	tfirm.c 846
	mov	_bOEP1SaveBufferPosition,#0x00
;	tfirm.c 848
	mov	r0,#_abOEP1SaveBuffer
	mov	ar2,@r0
	cjne	r2,#0x01,00139$
00139$:
; Peephole 132   changed ljmp to sjmp
; Peephole 160   removed sjmp by inverse jump logic
	jc   00115$
00140$:
	clr	c
	mov	a,#0x08
	subb	a,r2
; Peephole 132   changed ljmp to sjmp
; Peephole 160   removed sjmp by inverse jump logic
	jc   00115$
00141$:
	dec	r2
	mov	a,r2
	add	a,acc
	add	a,r2
	mov	dptr,#00142$
	jmp	@a+dptr
00142$:
	ljmp	00106$
	ljmp	00107$
	ljmp	00108$
	ljmp	00109$
	ljmp	00110$
	ljmp	00111$
	ljmp	00112$
	ljmp	00113$
;	tfirm.c 851
00106$:
	lcall	_fn_cmd_01
;	tfirm.c 852
;	tfirm.c 855
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00107$:
	lcall	_fn_cmd_02
;	tfirm.c 856
;	tfirm.c 859
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00108$:
	lcall	_fn_cmd_03
;	tfirm.c 860
;	tfirm.c 863
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00109$:
	lcall	_fn_cmd_04
;	tfirm.c 864
;	tfirm.c 867
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00110$:
	lcall	_fn_cmd_05
;	tfirm.c 868
;	tfirm.c 871
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00111$:
	lcall	_fn_cmd_06
;	tfirm.c 872
;	tfirm.c 875
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00112$:
	lcall	_fn_cmd_07
;	tfirm.c 876
;	tfirm.c 879
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00113$:
	lcall	_fn_cmd_08
;	tfirm.c 884
00115$:
;	tfirm.c 886
00124$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'IEP1InterruptHandler'
;------------------------------------------------------------
;	tfirm.c 890
;	-----------------------------------------
;	 function IEP1InterruptHandler
;	-----------------------------------------
_IEP1InterruptHandler:
;	tfirm.c 891
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SetupPacketInterruptHandler'
;------------------------------------------------------------
;	tfirm.c 894
;	-----------------------------------------
;	 function SetupPacketInterruptHandler
;	-----------------------------------------
_SetupPacketInterruptHandler:
;	tfirm.c 897
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 898
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 900
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x04
	movx	@dptr,a
;	tfirm.c 904
	mov	dptr,#_tSetupPacket
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x80
; Peephole 132   changed ljmp to sjmp
; Peephole 199   optimized misc jump sequence
	cjne r2,#0x80,00102$
;00107$:
; Peephole 200   removed redundant sjmp
00108$:
;	tfirm.c 905
	mov	r2,#0xFC
	mov	r3,#0xFF
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
	movx	a,@dptr
	mov	r4,a
	orl	ar4,#0x01
	mov	dpl,r2
	mov	dph,r3
	mov	a,r4
	movx	@dptr,a
; Peephole 132   changed ljmp to sjmp
	sjmp 00103$
00102$:
;	tfirm.c 907
	mov	r2,#0xFC
	mov	r3,#0xFF
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
	movx	a,@dptr
	mov	r4,a
	anl	ar4,#0xFE
	mov	dpl,r2
	mov	dph,r3
	mov	a,r4
	movx	@dptr,a
00103$:
;	tfirm.c 912
	mov	_bStatusAction,#0x00
;	tfirm.c 916
	lcall	_usbDecodeAndProcessUsbRequest
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbISR'
;------------------------------------------------------------
;	tfirm.c 920
;	-----------------------------------------
;	 function usbISR
;	-----------------------------------------
_usbISR:
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	tfirm.c 921
	clr	_EA
;	tfirm.c 923
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
	movx	a,@dptr
	mov	r2,a
	mov	ar3,r2
	cjne	r3,#0x12,00123$
; Peephole 132   changed ljmp to sjmp
	sjmp 00103$
00123$:
	mov	ar3,r2
	cjne	r3,#0x22,00124$
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00124$:
	mov	ar3,r2
	cjne	r3,#0x30,00125$
; Peephole 132   changed ljmp to sjmp
	sjmp 00105$
00125$:
	mov	ar3,r2
	cjne	r3,#0x32,00126$
	ljmp	00106$
00126$:
	mov	ar3,r2
	cjne	r3,#0x38,00127$
	ljmp	00108$
00127$:
	mov	ar3,r2
	cjne	r3,#0x3A,00128$
	ljmp	00109$
00128$:
	mov	ar3,r2
	cjne	r3,#0x3C,00129$
	ljmp	00107$
00129$:
	mov	ar3,r2
	cjne	r3,#0x44,00130$
; Peephole 132   changed ljmp to sjmp
	sjmp 00102$
00130$:
	cjne	r2,#0x46,00131$
	sjmp	00132$
00131$:
	ljmp	00110$
00132$:
;	tfirm.c 926
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 927
	lcall	_OEP0InterruptHandler
;	tfirm.c 928
	ljmp	00111$
;	tfirm.c 931
00102$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 932
	lcall	_IEP0InterruptHandler
;	tfirm.c 933
	ljmp	00111$
;	tfirm.c 936
00103$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 937
	lcall	_OEP1InterruptHandler
;	tfirm.c 939
	ljmp	00111$
;	tfirm.c 942
00104$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 945
	ljmp	00111$
;	tfirm.c 948
00105$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 949
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x01
	movx	@dptr,a
;	tfirm.c 950
	lcall	_SetupPacketInterruptHandler
;	tfirm.c 951
	ljmp	00111$
;	tfirm.c 954
00106$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 955
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x04
	movx	@dptr,a
;	tfirm.c 956
	lcall	_SetupPacketInterruptHandler
;	tfirm.c 957
;	tfirm.c 960
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00107$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 961
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 962
	lcall	_usbReset
;	tfirm.c 964
;	tfirm.c 967
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00108$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 968
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x20
	movx	@dptr,a
;	tfirm.c 969
	mov	_bSuspended,#0x00
;	tfirm.c 970
;	tfirm.c 973
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00109$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 974
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x40
	movx	@dptr,a
;	tfirm.c 975
	mov	_bSuspended,#0x01
;	tfirm.c 976
;	tfirm.c 979
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00110$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 981
00111$:
;	tfirm.c 983
	setb	_EA
00112$:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;i                         Allocated to registers 
;temp_dig                  Allocated to registers r2 
;	tfirm.c 987
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	tfirm.c 992
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x94)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 993
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x95)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 994
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x96)
	mov	a,#0xFF
	movx	@dptr,a
;	tfirm.c 995
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x97)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 997
	mov	_P3,#0xFF
;	tfirm.c 998
	mov	_P2,#0xFF
;	tfirm.c 999
	mov	_P1,#0xFF
;	tfirm.c 1001
	anl	_IE,#0xF5
;	tfirm.c 1003
	setb	_P3_2
;	tfirm.c 1005
	lcall	_SystemInitialization
;	tfirm.c 1007
	mov	_P0,#0xFF
;	tfirm.c 1008
	mov	_P1,#0xFF
;	tfirm.c 1010
00102$:
;	tfirm.c 1013
	clr	_P0_3
;	tfirm.c 1014
	setb	_P0_2
;	tfirm.c 1015
	setb	_P0_1
;	tfirm.c 1016
	setb	_P1_4
;	tfirm.c 1017
	setb	_P1_3
;	tfirm.c 1018
	setb	_P1_2
;	tfirm.c 1022
	mov	a,_nixie_digits
	cpl	a
; Peephole 105   removed redundant mov
	mov  r2,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00143$
	cpl	a
	inc	a
00143$:
	mov	b,a
	mov	a,r2
	jnb	acc.7,00144$
	cpl	a
	inc	a
00144$:
	div	ab
	pop	acc
	jb	ov,00145$
	jnb	acc.7,00145$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00145$:
	mov	a,b
	clr	c; oops
	jz	00146$
	cpl	c
00146$:
	mov	_P0_0,c
;	tfirm.c 1023
	mov	a,_nixie_digits
	mov	c,acc.7
	rrc	a
;	tfirm.c 1024
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00147$
	cpl	a
	inc	a
00147$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00148$
	cpl	a
	inc	a
00148$:
	div	ab
	pop	acc
	jb	ov,00149$
	jnb	acc.7,00149$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00149$:
	mov	a,b
	clr	c; oops
	jz	00150$
	cpl	c
00150$:
	mov	_P1_6,c
;	tfirm.c 1025
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1026
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00151$
	cpl	a
	inc	a
00151$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00152$
	cpl	a
	inc	a
00152$:
	div	ab
	pop	acc
	jb	ov,00153$
	jnb	acc.7,00153$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00153$:
	mov	a,b
	clr	c; oops
	jz	00154$
	cpl	c
00154$:
	mov	_P1_5,c
;	tfirm.c 1027
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1028
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00155$
	cpl	a
	inc	a
00155$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00156$
	cpl	a
	inc	a
00156$:
	div	ab
	pop	acc
	jb	ov,00157$
	jnb	acc.7,00157$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00157$:
	mov	a,b
	clr	c; oops
	jz	00158$
	cpl	c
00158$:
	mov	_P1_7,c
;	tfirm.c 1032
	mov	r3,#0x00
	mov	r4,#0x00
00104$:
	clr	c
	mov	a,r3
	subb	a,#0xE8
	mov	a,r4
	xrl	a,#0x80
	subb	a,#0x83
	clr	a
	rlc	a
; Peephole 105   removed redundant mov
	mov  r5,a
; Peephole 110   removed ljmp by inverse jump logic
	jz  00107$
00159$:
;	tail increment optimized
	inc	r3
	cjne	r3,#0x00,00104$
	inc	r4
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00107$:
;	tfirm.c 1036
	setb	_P0_3
;	tfirm.c 1037
	clr	_P0_2
;	tfirm.c 1038
	setb	_P0_1
;	tfirm.c 1039
	setb	_P1_4
;	tfirm.c 1040
	setb	_P1_3
;	tfirm.c 1041
	setb	_P1_2
;	tfirm.c 1044
; Peephole 221a remove redundant move
	mov	a,0x0001 + _nixie_digits
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00160$
	cpl	a
	inc	a
00160$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00161$
	cpl	a
	inc	a
00161$:
	div	ab
	pop	acc
	jb	ov,00162$
	jnb	acc.7,00162$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00162$:
	mov	a,b
	clr	c; oops
	jz	00163$
	cpl	c
00163$:
	mov	_P0_0,c
;	tfirm.c 1045
	mov	a,0x0001 + _nixie_digits
	mov	c,acc.7
	rrc	a
;	tfirm.c 1046
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00164$
	cpl	a
	inc	a
00164$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00165$
	cpl	a
	inc	a
00165$:
	div	ab
	pop	acc
	jb	ov,00166$
	jnb	acc.7,00166$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00166$:
	mov	a,b
	clr	c; oops
	jz	00167$
	cpl	c
00167$:
	mov	_P1_6,c
;	tfirm.c 1047
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1048
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00168$
	cpl	a
	inc	a
00168$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00169$
	cpl	a
	inc	a
00169$:
	div	ab
	pop	acc
	jb	ov,00170$
	jnb	acc.7,00170$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00170$:
	mov	a,b
	clr	c; oops
	jz	00171$
	cpl	c
00171$:
	mov	_P1_5,c
;	tfirm.c 1049
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1050
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00172$
	cpl	a
	inc	a
00172$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00173$
	cpl	a
	inc	a
00173$:
	div	ab
	pop	acc
	jb	ov,00174$
	jnb	acc.7,00174$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00174$:
	mov	a,b
	clr	c; oops
	jz	00175$
	cpl	c
00175$:
	mov	_P1_7,c
;	tfirm.c 1052
	mov	r3,#0x00
	mov	r4,#0x00
00108$:
	clr	c
	mov	a,r3
	subb	a,#0xE8
	mov	a,r4
	xrl	a,#0x80
	subb	a,#0x83
	clr	a
	rlc	a
; Peephole 105   removed redundant mov
	mov  r5,a
; Peephole 110   removed ljmp by inverse jump logic
	jz  00111$
00176$:
;	tail increment optimized
	inc	r3
	cjne	r3,#0x00,00108$
	inc	r4
; Peephole 132   changed ljmp to sjmp
	sjmp 00108$
00111$:
;	tfirm.c 1056
	setb	_P0_3
;	tfirm.c 1057
	setb	_P0_2
;	tfirm.c 1058
	clr	_P0_1
;	tfirm.c 1059
	setb	_P1_4
;	tfirm.c 1060
	setb	_P1_3
;	tfirm.c 1061
	setb	_P1_2
;	tfirm.c 1065
; Peephole 221a remove redundant move
	mov	a,0x0002 + _nixie_digits
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00177$
	cpl	a
	inc	a
00177$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00178$
	cpl	a
	inc	a
00178$:
	div	ab
	pop	acc
	jb	ov,00179$
	jnb	acc.7,00179$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00179$:
	mov	a,b
	clr	c; oops
	jz	00180$
	cpl	c
00180$:
	mov	_P0_0,c
;	tfirm.c 1066
	mov	a,0x0002 + _nixie_digits
	mov	c,acc.7
	rrc	a
;	tfirm.c 1067
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00181$
	cpl	a
	inc	a
00181$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00182$
	cpl	a
	inc	a
00182$:
	div	ab
	pop	acc
	jb	ov,00183$
	jnb	acc.7,00183$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00183$:
	mov	a,b
	clr	c; oops
	jz	00184$
	cpl	c
00184$:
	mov	_P1_6,c
;	tfirm.c 1068
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1069
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00185$
	cpl	a
	inc	a
00185$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00186$
	cpl	a
	inc	a
00186$:
	div	ab
	pop	acc
	jb	ov,00187$
	jnb	acc.7,00187$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00187$:
	mov	a,b
	clr	c; oops
	jz	00188$
	cpl	c
00188$:
	mov	_P1_5,c
;	tfirm.c 1070
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1071
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00189$
	cpl	a
	inc	a
00189$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00190$
	cpl	a
	inc	a
00190$:
	div	ab
	pop	acc
	jb	ov,00191$
	jnb	acc.7,00191$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00191$:
	mov	a,b
	clr	c; oops
	jz	00192$
	cpl	c
00192$:
	mov	_P1_7,c
;	tfirm.c 1075
	mov	r3,#0x00
	mov	r4,#0x00
00112$:
	clr	c
	mov	a,r3
	subb	a,#0xE8
	mov	a,r4
	xrl	a,#0x80
	subb	a,#0x83
	clr	a
	rlc	a
; Peephole 105   removed redundant mov
	mov  r5,a
; Peephole 110   removed ljmp by inverse jump logic
	jz  00115$
00193$:
;	tail increment optimized
	inc	r3
	cjne	r3,#0x00,00112$
	inc	r4
; Peephole 132   changed ljmp to sjmp
	sjmp 00112$
00115$:
;	tfirm.c 1079
	setb	_P0_3
;	tfirm.c 1080
	setb	_P0_2
;	tfirm.c 1081
	setb	_P0_1
;	tfirm.c 1082
	clr	_P1_4
;	tfirm.c 1083
	setb	_P1_3
;	tfirm.c 1084
	setb	_P1_2
;	tfirm.c 1087
; Peephole 221a remove redundant move
	mov	a,0x0003 + _nixie_digits
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00194$
	cpl	a
	inc	a
00194$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00195$
	cpl	a
	inc	a
00195$:
	div	ab
	pop	acc
	jb	ov,00196$
	jnb	acc.7,00196$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00196$:
	mov	a,b
	clr	c; oops
	jz	00197$
	cpl	c
00197$:
	mov	_P0_0,c
;	tfirm.c 1088
	mov	a,0x0003 + _nixie_digits
	mov	c,acc.7
	rrc	a
;	tfirm.c 1089
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00198$
	cpl	a
	inc	a
00198$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00199$
	cpl	a
	inc	a
00199$:
	div	ab
	pop	acc
	jb	ov,00200$
	jnb	acc.7,00200$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00200$:
	mov	a,b
	clr	c; oops
	jz	00201$
	cpl	c
00201$:
	mov	_P1_6,c
;	tfirm.c 1090
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1091
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00202$
	cpl	a
	inc	a
00202$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00203$
	cpl	a
	inc	a
00203$:
	div	ab
	pop	acc
	jb	ov,00204$
	jnb	acc.7,00204$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00204$:
	mov	a,b
	clr	c; oops
	jz	00205$
	cpl	c
00205$:
	mov	_P1_5,c
;	tfirm.c 1092
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1093
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00206$
	cpl	a
	inc	a
00206$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00207$
	cpl	a
	inc	a
00207$:
	div	ab
	pop	acc
	jb	ov,00208$
	jnb	acc.7,00208$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00208$:
	mov	a,b
	clr	c; oops
	jz	00209$
	cpl	c
00209$:
	mov	_P1_7,c
;	tfirm.c 1095
	mov	r3,#0x00
	mov	r4,#0x00
00116$:
	clr	c
	mov	a,r3
	subb	a,#0xE8
	mov	a,r4
	xrl	a,#0x80
	subb	a,#0x83
	clr	a
	rlc	a
; Peephole 105   removed redundant mov
	mov  r5,a
; Peephole 110   removed ljmp by inverse jump logic
	jz  00119$
00210$:
;	tail increment optimized
	inc	r3
	cjne	r3,#0x00,00116$
	inc	r4
; Peephole 132   changed ljmp to sjmp
	sjmp 00116$
00119$:
;	tfirm.c 1099
	setb	_P0_3
;	tfirm.c 1100
	setb	_P0_2
;	tfirm.c 1101
	setb	_P0_1
;	tfirm.c 1102
	setb	_P1_4
;	tfirm.c 1103
	clr	_P1_3
;	tfirm.c 1104
	setb	_P1_2
;	tfirm.c 1108
; Peephole 221a remove redundant move
	mov	a,0x0004 + _nixie_digits
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00211$
	cpl	a
	inc	a
00211$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00212$
	cpl	a
	inc	a
00212$:
	div	ab
	pop	acc
	jb	ov,00213$
	jnb	acc.7,00213$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00213$:
	mov	a,b
	clr	c; oops
	jz	00214$
	cpl	c
00214$:
	mov	_P0_0,c
;	tfirm.c 1109
	mov	a,0x0004 + _nixie_digits
	mov	c,acc.7
	rrc	a
;	tfirm.c 1110
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00215$
	cpl	a
	inc	a
00215$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00216$
	cpl	a
	inc	a
00216$:
	div	ab
	pop	acc
	jb	ov,00217$
	jnb	acc.7,00217$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00217$:
	mov	a,b
	clr	c; oops
	jz	00218$
	cpl	c
00218$:
	mov	_P1_6,c
;	tfirm.c 1111
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1112
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00219$
	cpl	a
	inc	a
00219$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00220$
	cpl	a
	inc	a
00220$:
	div	ab
	pop	acc
	jb	ov,00221$
	jnb	acc.7,00221$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00221$:
	mov	a,b
	clr	c; oops
	jz	00222$
	cpl	c
00222$:
	mov	_P1_5,c
;	tfirm.c 1113
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1114
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00223$
	cpl	a
	inc	a
00223$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00224$
	cpl	a
	inc	a
00224$:
	div	ab
	pop	acc
	jb	ov,00225$
	jnb	acc.7,00225$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00225$:
	mov	a,b
	clr	c; oops
	jz	00226$
	cpl	c
00226$:
	mov	_P1_7,c
;	tfirm.c 1118
	mov	r3,#0x00
	mov	r4,#0x00
00120$:
	clr	c
	mov	a,r3
	subb	a,#0xE8
	mov	a,r4
	xrl	a,#0x80
	subb	a,#0x83
	clr	a
	rlc	a
; Peephole 105   removed redundant mov
	mov  r5,a
; Peephole 110   removed ljmp by inverse jump logic
	jz  00123$
00227$:
;	tail increment optimized
	inc	r3
	cjne	r3,#0x00,00120$
	inc	r4
; Peephole 132   changed ljmp to sjmp
	sjmp 00120$
00123$:
;	tfirm.c 1122
	setb	_P0_3
;	tfirm.c 1123
	setb	_P0_2
;	tfirm.c 1124
	setb	_P0_1
;	tfirm.c 1125
	setb	_P1_4
;	tfirm.c 1126
	setb	_P1_3
;	tfirm.c 1127
	clr	_P1_2
;	tfirm.c 1130
; Peephole 221a remove redundant move
	mov	a,0x0005 + _nixie_digits
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00228$
	cpl	a
	inc	a
00228$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00229$
	cpl	a
	inc	a
00229$:
	div	ab
	pop	acc
	jb	ov,00230$
	jnb	acc.7,00230$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00230$:
	mov	a,b
	clr	c; oops
	jz	00231$
	cpl	c
00231$:
	mov	_P0_0,c
;	tfirm.c 1131
	mov	a,0x0005 + _nixie_digits
	mov	c,acc.7
	rrc	a
;	tfirm.c 1132
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00232$
	cpl	a
	inc	a
00232$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00233$
	cpl	a
	inc	a
00233$:
	div	ab
	pop	acc
	jb	ov,00234$
	jnb	acc.7,00234$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00234$:
	mov	a,b
	clr	c; oops
	jz	00235$
	cpl	c
00235$:
	mov	_P1_6,c
;	tfirm.c 1133
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1134
; Peephole 105   removed redundant mov
	mov  r2,a
	cpl	a
; Peephole 105   removed redundant mov
	mov  r3,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00236$
	cpl	a
	inc	a
00236$:
	mov	b,a
	mov	a,r3
	jnb	acc.7,00237$
	cpl	a
	inc	a
00237$:
	div	ab
	pop	acc
	jb	ov,00238$
	jnb	acc.7,00238$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00238$:
	mov	a,b
	clr	c; oops
	jz	00239$
	cpl	c
00239$:
	mov	_P1_5,c
;	tfirm.c 1135
	mov	a,r2
	mov	c,acc.7
	rrc	a
;	tfirm.c 1136
; Peephole 105   removed redundant mov
; Peephole 105   removed redundant mov
; Peephole 184   removed redundant mov
	cpl  a
	mov  r2,a
	xrl	a,#0x02
	push	acc
	mov	a,#0x02
	jnb	acc.7,00240$
	cpl	a
	inc	a
00240$:
	mov	b,a
	mov	a,r2
	jnb	acc.7,00241$
	cpl	a
	inc	a
00241$:
	div	ab
	pop	acc
	jb	ov,00242$
	jnb	acc.7,00242$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00242$:
	mov	a,b
	clr	c; oops
	jz	00243$
	cpl	c
00243$:
	mov	_P1_7,c
;	tfirm.c 1138
	mov	r2,#0x00
	mov	r3,#0x00
00124$:
	clr	c
	mov	a,r2
	subb	a,#0xE8
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x83
	jc	00244$
	ljmp	00102$
00244$:
;	tail increment optimized
	inc	r2
	cjne	r2,#0x00,00124$
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00128$:
	ret
	.area CSEG    (CODE)
_abromConfigurationDescriptorGroup:
	.db #0x09
	.db #0x02
	.db #0x20
	.db #0x00
	.db #0x01
	.db #0x01
	.db #0x00
	.db #0xA0
	.db #0x32
	.db #0x09
	.db #0x04
	.db #0x00
	.db #0x00
	.db #0x02
	.db #0xFF
	.db #0x01
	.db #0x01
	.db #0x01
	.db #0x07
	.db #0x05
	.db #0x81
	.db #0x02
	.db #0x40
	.db #0x00
	.db #0x00
	.db #0x07
	.db #0x05
	.db #0x01
	.db #0x02
	.db #0x40
	.db #0x00
	.db #0x00
_abromDeviceDescriptor:
	.db #0x12
	.db #0x01
	.db #0x10
	.db #0x01
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x08
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0x00
	.db #0x01
	.db #0x01
	.db #0x02
	.db #0x03
	.db #0x01
_tUsbRequestList:
	.db #0x02
	.db #0x03
	.db #0x00
	.db #0x00
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xF7
	.byte _usbSetEndpointHalt,(_usbSetEndpointHalt >> 8)
	.db #0x02
	.db #0x01
	.db #0x00
	.db #0x00
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xF7
	.byte _usbClearEndpointHalt,(_usbClearEndpointHalt >> 8)
	.db #0x80
	.db #0x08
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x01
	.db #0x00
	.db #0xFF
	.byte _usbGetConfiguration,(_usbGetConfiguration >> 8)
	.db #0x00
	.db #0x09
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xDF
	.byte _usbSetConfiguration,(_usbSetConfiguration >> 8)
	.db #0x80
	.db #0x06
	.db #0xFF
	.db #0x01
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xD0
	.byte _usbGetDeviceDescriptor,(_usbGetDeviceDescriptor >> 8)
	.db #0x80
	.db #0x06
	.db #0xFF
	.db #0x02
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xD0
	.byte _usbGetConfigurationDescriptor,(_usbGetConfigurationDescriptor >> 8)
	.db #0x81
	.db #0x06
	.db #0xFF
	.db #0x21
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xD0
	.byte _usbGetHIDDescriptor,(_usbGetHIDDescriptor >> 8)
	.db #0x80
	.db #0x06
	.db #0xFF
	.db #0x03
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xD0
	.byte _usbGetStringDescriptor,(_usbGetStringDescriptor >> 8)
	.db #0x81
	.db #0x06
	.db #0xFF
	.db #0x22
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xD0
	.byte _usbGetReportDescriptor,(_usbGetReportDescriptor >> 8)
	.db #0x21
	.db #0x09
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xC0
	.byte _usbSetReport,(_usbSetReport >> 8)
	.db #0x21
	.db #0x0A
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0xC3
	.byte _usbSetIdle,(_usbSetIdle >> 8)
	.db #0x21
	.db #0x0B
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0xC3
	.byte _usbSetProtocol,(_usbSetProtocol >> 8)
	.db #0xA1
	.db #0x02
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0x01
	.db #0x00
	.db #0xC3
	.byte _usbGetIdle,(_usbGetIdle >> 8)
	.db #0xA1
	.db #0x03
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0x01
	.db #0x00
	.db #0xC3
	.byte _usbGetProtocol,(_usbGetProtocol >> 8)
	.db #0x81
	.db #0x0A
	.db #0x00
	.db #0x00
	.db #0xFF
	.db #0xFF
	.db #0x01
	.db #0x00
	.db #0xF3
	.byte _usbGetInterface,(_usbGetInterface >> 8)
	.db #0x80
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x02
	.db #0x00
	.db #0xFF
	.byte _usbGetDeviceStatus,(_usbGetDeviceStatus >> 8)
	.db #0x81
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xFF
	.db #0x00
	.db #0x02
	.db #0x00
	.db #0xF7
	.byte _usbGetInterfaceStatus,(_usbGetInterfaceStatus >> 8)
	.db #0x82
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xFF
	.db #0x00
	.db #0x02
	.db #0x00
	.db #0xF7
	.byte _usbGetEndpointStatus,(_usbGetEndpointStatus >> 8)
	.db #0x00
	.db #0x05
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xDF
	.byte _usbSetAddress,(_usbSetAddress >> 8)
	.db #0x00
	.db #0x03
	.db #0x01
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xFF
	.byte _usbSetRemoteWakeup,(_usbSetRemoteWakeup >> 8)
	.db #0x00
	.db #0x01
	.db #0x01
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xFF
	.byte _usbClearRemoteWakeup,(_usbClearRemoteWakeup >> 8)
	.db #0x01
	.db #0x0B
	.db #0xFF
	.db #0x00
	.db #0xFF
	.db #0x00
	.db #0x00
	.db #0x00
	.db #0xD7
	.byte _usbSetInterface,(_usbSetInterface >> 8)
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.db #0x00
	.byte _usbNonStandardRequest,(_usbNonStandardRequest >> 8)
