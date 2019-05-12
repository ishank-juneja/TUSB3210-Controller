;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.0 Thu May  9 16:35:10 2019

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
;	tfirm.c 12
	mov	_deviceReady,#0x00
;	tfirm.c 15
	clr	a
	mov	(_wDeviceFeatures + 1),a
	mov	_wDeviceFeatures,a
;	tfirm.c 20
	mov	_bConfigurationNumber,#0x00
;	tfirm.c 21
	mov	_bInterfaceNumber,#0x00
;	tfirm.c 23
	mov	_bSuspended,#0x00
;	tfirm.c 27
	mov	_gbProtocol,#0x01
;	tfirm.c 75
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
;	tfirm.c 77
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
;	tfirm.c 78
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 79
	mov	_bStatusAction,#0x00
;	tfirm.c 80
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetEndpointHalt'
;------------------------------------------------------------
;	tfirm.c 83
;	-----------------------------------------
;	 function usbSetEndpointHalt
;	-----------------------------------------
_usbSetEndpointHalt:
;	tfirm.c 84
	mov	dptr,#_tInputEndPointDescriptorBlock
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x7F
	mov	dptr,#_tInputEndPointDescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 85
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbClearEndpointHalt'
;------------------------------------------------------------
;	tfirm.c 88
;	-----------------------------------------
;	 function usbClearEndpointHalt
;	-----------------------------------------
_usbClearEndpointHalt:
;	tfirm.c 89
	mov	dptr,#_tInputEndPointDescriptorBlock
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x80
	mov	dptr,#_tInputEndPointDescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 90
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetConfiguration'
;------------------------------------------------------------
;	tfirm.c 94
;	-----------------------------------------
;	 function usbGetConfiguration
;	-----------------------------------------
_usbGetConfiguration:
;	tfirm.c 95
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 96
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
;	tfirm.c 99
;	-----------------------------------------
;	 function usbSetConfiguration
;	-----------------------------------------
_usbSetConfiguration:
;	tfirm.c 100
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 101
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_bConfigurationNumber,a
;	tfirm.c 102
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetIdle'
;------------------------------------------------------------
;	tfirm.c 105
;	-----------------------------------------
;	 function usbSetIdle
;	-----------------------------------------
_usbSetIdle:
;	tfirm.c 106
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_gbIdleRateL,a
;	tfirm.c 107
	mov	dptr,#(_tSetupPacket + 0x0003)
	movx	a,@dptr
	mov	_gbIdleRateH,a
;	tfirm.c 108
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetIdle'
;------------------------------------------------------------
;	tfirm.c 111
;	-----------------------------------------
;	 function usbGetIdle
;	-----------------------------------------
_usbGetIdle:
;	tfirm.c 112
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 113
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
;	tfirm.c 116
;	-----------------------------------------
;	 function usbSetInterface
;	-----------------------------------------
_usbSetInterface:
;	tfirm.c 117
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 118
	mov	dptr,#(_tSetupPacket + 0x0004)
	movx	a,@dptr
	mov	_bInterfaceNumber,a
;	tfirm.c 119
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetInterface'
;------------------------------------------------------------
;	tfirm.c 122
;	-----------------------------------------
;	 function usbGetInterface
;	-----------------------------------------
_usbGetInterface:
;	tfirm.c 123
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 124
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
;	tfirm.c 128
;	-----------------------------------------
;	 function usbSetProtocol
;	-----------------------------------------
_usbSetProtocol:
;	tfirm.c 129
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_gbProtocol,a
;	tfirm.c 130
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetProtocol'
;------------------------------------------------------------
;	tfirm.c 133
;	-----------------------------------------
;	 function usbGetProtocol
;	-----------------------------------------
_usbGetProtocol:
;	tfirm.c 134
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x01
;	tfirm.c 135
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
;	tfirm.c 139
;	-----------------------------------------
;	 function usbSetAddress
;	-----------------------------------------
_usbSetAddress:
;	tfirm.c 140
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
;	tfirm.c 142
	mov	r2,#0xFF
	mov	r3,#0xFF
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
; Peephole 136   removed redundant moves
	mov  r4,a
	mov  dpl,r2
	mov  dph,r3
	movx	@dptr,a
;	tfirm.c 143
	mov	dptr,#(_tSetupPacket + 0x0002)
	movx	a,@dptr
	mov	_bUsbDeviceAddress,a
;	tfirm.c 144
	mov	_bStatusAction,#0x03
;	tfirm.c 145
	lcall	_usbSendZeroLengthPacketOnIEP0
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00102$:
;	tfirm.c 148
	lcall	_usbStallEndpoint0
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetRemoteWakeup'
;------------------------------------------------------------
;	tfirm.c 152
;	-----------------------------------------
;	 function usbSetRemoteWakeup
;	-----------------------------------------
_usbSetRemoteWakeup:
;	tfirm.c 153
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
;	tfirm.c 154
	orl	(_wDeviceFeatures + 1),#0x02
;	tfirm.c 155
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 156
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbClearRemoteWakeup'
;------------------------------------------------------------
;	tfirm.c 159
;	-----------------------------------------
;	 function usbClearRemoteWakeup
;	-----------------------------------------
_usbClearRemoteWakeup:
;	tfirm.c 160
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
;	tfirm.c 161
	anl	(_wDeviceFeatures + 1),#0xFD
;	tfirm.c 162
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 163
	lcall	_usbSendZeroLengthPacketOnIEP0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSetReport'
;------------------------------------------------------------
;	tfirm.c 166
;	-----------------------------------------
;	 function usbSetReport
;	-----------------------------------------
_usbSetReport:
;	tfirm.c 167
	clr	a
	mov	(_wBytesRemainingOnOEP0 + 1),a
	mov	_wBytesRemainingOnOEP0,#0x01
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetEndpointStatus'
;------------------------------------------------------------
;wEndpointStatus           Allocated to in memory with name '_usbGetEndpointStatus_wEndpointStatus_1_1'
;	tfirm.c 171
;	-----------------------------------------
;	 function usbGetEndpointStatus
;	-----------------------------------------
_usbGetEndpointStatus:
;	tfirm.c 172
	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,#0x00
	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),#0x01
;	tfirm.c 173
	mov	dptr,#_tInputEndPointDescriptorBlock
	movx	a,@dptr
; Peephole 105   removed redundant mov
	mov  r2,a
; Peephole 111   removed ljmp by inverse jump logic
	jnb  acc.7,00102$
00106$:
;	tfirm.c 174
	clr	a
	mov	(_usbGetEndpointStatus_wEndpointStatus_1_1 + 1),a
	mov	_usbGetEndpointStatus_wEndpointStatus_1_1,a
00102$:
;	tfirm.c 176
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x02
;	tfirm.c 177
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
;	tfirm.c 180
;	-----------------------------------------
;	 function usbGetDeviceStatus
;	-----------------------------------------
_usbGetDeviceStatus:
;	tfirm.c 181
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x02
;	tfirm.c 182
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
;	tfirm.c 185
;	-----------------------------------------
;	 function usbGetInterfaceStatus
;	-----------------------------------------
_usbGetInterfaceStatus:
;	tfirm.c 186
	clr	a
	mov	(_usbGetInterfaceStatus_wStatusBuffer_1_1 + 1),a
	mov	_usbGetInterfaceStatus_wStatusBuffer_1_1,a
;	tfirm.c 187
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 188
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x02
;	tfirm.c 189
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
;	tfirm.c 193
;	-----------------------------------------
;	 function usbGetReportDescriptor
;	-----------------------------------------
_usbGetReportDescriptor:
;	tfirm.c 194
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 195
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x3F
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetConfigurationDescriptor'
;------------------------------------------------------------
;bTemp                     Allocated to registers 
;	tfirm.c 199
;	-----------------------------------------
;	 function usbGetConfigurationDescriptor
;	-----------------------------------------
_usbGetConfigurationDescriptor:
;	tfirm.c 202
	mov	r2,#0x00
00101$:
	cjne	r2,#0x20,00109$
00109$:
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00110$:
;	tfirm.c 203
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
;	tfirm.c 202
	inc	r2
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	tfirm.c 205
	mov	dptr,#(_abDescriptor + 0x0007)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 207
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 208
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x20
;	tfirm.c 209
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
;	tfirm.c 213
;	-----------------------------------------
;	 function usbGetHIDDescriptor
;	-----------------------------------------
_usbGetHIDDescriptor:
;	tfirm.c 216
	mov	r2,#0x00
00101$:
	cjne	r2,#0x12,00109$
00109$:
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00110$:
;	tfirm.c 217
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
;	tfirm.c 216
	inc	r2
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	tfirm.c 219
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 220
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x09
;	tfirm.c 221
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
;	tfirm.c 224
;	-----------------------------------------
;	 function usbGetDeviceDescriptor
;	-----------------------------------------
_usbGetDeviceDescriptor:
;	tfirm.c 227
	mov	r2,#0x00
00101$:
	cjne	r2,#0x12,00109$
00109$:
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00104$
00110$:
;	tfirm.c 228
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
;	tfirm.c 227
	inc	r2
; Peephole 132   changed ljmp to sjmp
	sjmp 00101$
00104$:
;	tfirm.c 230
	mov	dptr,#(_abDescriptor + 0x0004)
	mov	a,#0xFF
	movx	@dptr,a
;	tfirm.c 231
	mov	dptr,#(_abDescriptor + 0x0008)
	mov	a,#0x51
	movx	@dptr,a
;	tfirm.c 232
	mov	dptr,#(_abDescriptor + 0x0009)
	mov	a,#0x04
	movx	@dptr,a
;	tfirm.c 233
	mov	dptr,#(_abDescriptor + 0x000a)
	mov	a,#0x10
	movx	@dptr,a
;	tfirm.c 234
	mov	dptr,#(_abDescriptor + 0x000b)
	mov	a,#0x32
	movx	@dptr,a
;	tfirm.c 235
	mov	dptr,#(_abDescriptor + 0x000c)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 236
	mov	dptr,#(_abDescriptor + 0x000d)
	mov	a,#0x01
	movx	@dptr,a
;	tfirm.c 238
	mov	dptr,#(_abDescriptor + 0x000e)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 239
	mov	dptr,#(_abDescriptor + 0x000f)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 240
	mov	dptr,#(_abDescriptor + 0x0010)
	mov	a,#0x01
	movx	@dptr,a
;	tfirm.c 242
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 243
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x12
;	tfirm.c 244
	mov	r2,#_abDescriptor
	mov	r3,#(_abDescriptor >> 8)
	mov	r4,#0x01
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_usbSendDataPacketOnEP0
;	tfirm.c 248
	mov	_deviceReady,#0x01
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbGetStringDescriptor'
;------------------------------------------------------------
;	tfirm.c 252
;	-----------------------------------------
;	 function usbGetStringDescriptor
;	-----------------------------------------
_usbGetStringDescriptor:
;	tfirm.c 254
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 255
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,#0x12
;	tfirm.c 256
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
;	tfirm.c 260
;	-----------------------------------------
;	 function usbNonStandardRequest
;	-----------------------------------------
_usbNonStandardRequest:
;	tfirm.c 261
	lcall	_usbStallEndpoint0
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbStallEndpoint0'
;------------------------------------------------------------
;	tfirm.c 264
;	-----------------------------------------
;	 function usbStallEndpoint0
;	-----------------------------------------
_usbStallEndpoint0:
;	tfirm.c 265
	mov	dptr,#_tEndPoint0DescriptorBlock
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#_tEndPoint0DescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 266
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
;	tfirm.c 479
;	-----------------------------------------
;	 function usbReset
;	-----------------------------------------
_usbReset:
;	tfirm.c 480
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFF)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 482
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 483
	mov	_wBytesRemainingOnOEP0,#0xFF
	mov	(_wBytesRemainingOnOEP0 + 1),#0xFF
;	tfirm.c 484
;	tfirm.c 486
; Peephole 3.b   changed mov to clr
	clr  a
	mov  _bStatusAction,a
	mov	(_pbIEP0Buffer + 2),a
	mov	(_pbIEP0Buffer + 1),a
	mov	_pbIEP0Buffer,a
;	tfirm.c 487
	clr	a
	mov	(_pbOEP0Buffer + 2),a
	mov	(_pbOEP0Buffer + 1),a
	mov	_pbOEP0Buffer,a
;	tfirm.c 489
	mov	_bConfigurationNumber,#0x00
;	tfirm.c 490
	mov	_bInterfaceNumber,#0x00
;	tfirm.c 492
	mov	dptr,#_tEndPoint0DescriptorBlock
	mov	a,#0x84
	movx	@dptr,a
;	tfirm.c 493
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,#0x84
	movx	@dptr,a
;	tfirm.c 495
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 496
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 499
	mov	dptr,#_tInputEndPointDescriptorBlock
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 500
	mov	dptr,#_tInputEndPointDescriptorBlock
	mov	a,#0x84
	movx	@dptr,a
;	tfirm.c 501
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0001)
	mov	a,#0xC0
	movx	@dptr,a
;	tfirm.c 502
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 503
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0007)
	mov	a,#0x40
	movx	@dptr,a
;	tfirm.c 504
	mov	dptr,#(_tInputEndPointDescriptorBlock + 0x0002)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 507
	mov	dptr,#_tOutputEndPointDescriptorBlock
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 509
	mov	dptr,#_tOutputEndPointDescriptorBlock
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x84
	mov	dptr,#_tOutputEndPointDescriptorBlock
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 510
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0001)
	mov	a,#0xB0
	movx	@dptr,a
;	tfirm.c 511
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 512
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0005)
	mov	a,#0xB8
	movx	@dptr,a
;	tfirm.c 513
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0006)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 514
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0007)
	mov	a,#0x40
	movx	@dptr,a
;	tfirm.c 516
	clr	a
	mov	(_bCurrentBuffer + 1),a
	mov	_bCurrentBuffer,a
;	tfirm.c 517
	mov	_bOEP1RecieveLength,#0x00
;	tfirm.c 518
	mov	_bOEP1SaveBufferPosition,#0x00
;	tfirm.c 520
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFD)
	mov	a,#0xE5
	movx	@dptr,a
;	tfirm.c 521
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
;	tfirm.c 523
	mov	_ID1,#0x43
;	tfirm.c 524
	mov	_ID2,#0x4D
;	tfirm.c 525
	mov	_FIRMWARE_VERSION,#0x00
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SystemInitialization'
;------------------------------------------------------------
;	tfirm.c 529
;	-----------------------------------------
;	 function SystemInitialization
;	-----------------------------------------
_SystemInitialization:
;	tfirm.c 531
	clr	_EA
;	tfirm.c 533
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 535
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x90)
	mov	a,#0xE0
	movx	@dptr,a
;	tfirm.c 540
	setb	_EA
;	tfirm.c 541
	setb	_EX0
;	tfirm.c 543
	lcall	_usbReset
;	tfirm.c 545
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFC)
	mov	a,#0x80
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbReceiveDataPacketOnEP0'
;------------------------------------------------------------
;	tfirm.c 550
;	-----------------------------------------
;	 function usbReceiveDataPacketOnEP0
;	-----------------------------------------
_usbReceiveDataPacketOnEP0:
;	tfirm.c 561
	mov	_pbOEP0Buffer,dpl
	mov	(_pbOEP0Buffer + 1),dph
	mov	(_pbOEP0Buffer + 2),b
;	tfirm.c 555
	mov	dptr,#(_tSetupPacket + 0x0007)
	movx	a,@dptr
	mov	r2,a
	mov	r3,#0x00
;	tfirm.c 556
	mov	ar3,r2
	mov	r2,#0x00
;	tfirm.c 557
	mov	dptr,#(_tSetupPacket + 0x0006)
	movx	a,@dptr
	mov	r4,a
	mov	r5,#0x00
;	tfirm.c 559
	mov	a,r4
	orl	a,r2
	mov	_wBytesRemainingOnOEP0,a
	mov	a,r5
	orl	a,r3
	mov	(_wBytesRemainingOnOEP0 + 1),a
;	tfirm.c 560
	mov	_bStatusAction,#0x02
;	tfirm.c 561
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbReceiveNextPacketOnOEP0'
;------------------------------------------------------------
;	tfirm.c 564
;	-----------------------------------------
;	 function usbReceiveNextPacketOnOEP0
;	-----------------------------------------
_usbReceiveNextPacketOnOEP0:
;	tfirm.c 570
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x7F
;	tfirm.c 577
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
;	tfirm.c 581
	mov	r5,#0x00
00107$:
	clr	c
	mov	a,r5
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00110$
00118$:
;	tfirm.c 582
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
;	tfirm.c 581
	inc	r5
; Peephole 132   changed ljmp to sjmp
	sjmp 00107$
00110$:
;	tfirm.c 586
	clr	c
	mov	a,_wBytesRemainingOnOEP0
	subb	a,r3
	mov	_wBytesRemainingOnOEP0,a
	mov	a,(_wBytesRemainingOnOEP0 + 1)
	subb	a,r4
	mov	(_wBytesRemainingOnOEP0 + 1),a
;	tfirm.c 592
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
;	tfirm.c 594
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 595
	mov	_bStatusAction,#0x02
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00102$:
;	tfirm.c 607
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 608
	mov	_bStatusAction,#0x00
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00105$:
;	tfirm.c 619
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	orl	ar2,#0x08
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0002)
	mov	a,r2
	movx	@dptr,a
;	tfirm.c 620
	mov	_bStatusAction,#0x00
00111$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbSendNextPacketOnIEP0'
;------------------------------------------------------------
;	tfirm.c 624
;	-----------------------------------------
;	 function usbSendNextPacketOnIEP0
;	-----------------------------------------
_usbSendNextPacketOnIEP0:
;	tfirm.c 628
	mov	a,_wBytesRemainingOnIEP0
	cjne	a,#0xFF,00125$
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	cjne	a,#0xFF,00125$
	ljmp	00111$
00125$:
;	tfirm.c 630
	clr	c
	mov	a,#0x08
	subb	a,_wBytesRemainingOnIEP0
; Peephole 180   changed mov to clr
	clr  a
	subb	a,(_wBytesRemainingOnIEP0 + 1)
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00108$
00126$:
;	tfirm.c 634
	mov	r2,#0x08
;	tfirm.c 635
	mov	a,_wBytesRemainingOnIEP0
	add	a,#0xf8
	mov	_wBytesRemainingOnIEP0,a
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	addc	a,#0xff
	mov	(_wBytesRemainingOnIEP0 + 1),a
;	tfirm.c 636
	mov	_bStatusAction,#0x01
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00108$:
;	tfirm.c 638
	clr	c
	mov	a,_wBytesRemainingOnIEP0
	subb	a,#0x08
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	subb	a,#0x00
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00105$
00127$:
;	tfirm.c 642
	mov	r2,_wBytesRemainingOnIEP0
;	tfirm.c 643
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 644
	mov	_bStatusAction,#0x00
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00105$:
;	tfirm.c 649
	mov	r2,#0x08
;	tfirm.c 650
	mov	a,_bHostAskMoreDataThanAvailable
	cjne	a,#0x01,00128$
	mov	a,(_bHostAskMoreDataThanAvailable + 1)
; Peephole 162   removed sjmp by inverse jump logic
	jz   00129$
00128$:
; Peephole 132   changed ljmp to sjmp
	sjmp 00102$
00129$:
;	tfirm.c 652
	clr	a
	mov	(_wBytesRemainingOnIEP0 + 1),a
	mov	_wBytesRemainingOnIEP0,a
;	tfirm.c 653
	mov	_bStatusAction,#0x01
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00102$:
;	tfirm.c 657
	mov	_wBytesRemainingOnIEP0,#0xFF
	mov	(_wBytesRemainingOnIEP0 + 1),#0xFF
;	tfirm.c 658
	mov	_bStatusAction,#0x00
;	tfirm.c 661
00124$:
	mov	r3,#0x00
00113$:
	clr	c
	mov	a,r3
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00116$
00130$:
;	tfirm.c 662
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
;	tfirm.c 661
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00113$
00116$:
;	tfirm.c 664
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
	mov	a,r2
	movx	@dptr,a
; Peephole 132   changed ljmp to sjmp
	sjmp 00117$
00111$:
;	tfirm.c 668
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
;	tfirm.c 672
;	-----------------------------------------
;	 function usbSendDataPacketOnEP0
;	-----------------------------------------
_usbSendDataPacketOnEP0:
;	tfirm.c 697
	mov	_pbIEP0Buffer,dpl
	mov	(_pbIEP0Buffer + 1),dph
	mov	(_pbIEP0Buffer + 2),b
;	tfirm.c 679
	mov	dptr,#(_tSetupPacket + 0x0007)
	movx	a,@dptr
	mov	r2,a
	mov	r3,#0x00
;	tfirm.c 680
	mov	ar3,r2
	mov	r2,#0x00
;	tfirm.c 681
	mov	dptr,#(_tSetupPacket + 0x0006)
	movx	a,@dptr
	mov	r4,a
	mov	r5,#0x00
;	tfirm.c 683
	mov	a,r4
	orl	ar2,a
	mov	a,r5
	orl	ar3,a
;	tfirm.c 687
	clr	c
	mov	a,_wBytesRemainingOnIEP0
	subb	a,r2
	mov	a,(_wBytesRemainingOnIEP0 + 1)
	subb	a,r3
; Peephole 132   changed ljmp to sjmp
; Peephole 160   removed sjmp by inverse jump logic
	jc   00102$
00107$:
;	tfirm.c 689
	mov	_wBytesRemainingOnIEP0,r2
	mov	(_wBytesRemainingOnIEP0 + 1),r3
;	tfirm.c 690
	clr	a
	mov	(_bHostAskMoreDataThanAvailable + 1),a
	mov	_bHostAskMoreDataThanAvailable,a
; Peephole 132   changed ljmp to sjmp
	sjmp 00103$
00102$:
;	tfirm.c 694
	clr	a
	mov	(_bHostAskMoreDataThanAvailable + 1),a
	mov	_bHostAskMoreDataThanAvailable,#0x01
00103$:
;	tfirm.c 697
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
;	tfirm.c 700
;	-----------------------------------------
;	 function usbDecodeAndProcessUsbRequest
;	-----------------------------------------
_usbDecodeAndProcessUsbRequest:
;	tfirm.c 708
	mov	r2,#_tUsbRequestList
	mov	r3,#(_tUsbRequestList >> 8)
	mov	r4,#0x02
;	tfirm.c 713
00106$:
;	tfirm.c 715
	mov	r5,#0x00
;	tfirm.c 716
	mov	r6,#0x80
;	tfirm.c 723
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
;	tfirm.c 725
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
;	tfirm.c 726
	mov	a,r6
	orl	a,r5
	mov	r5,a
00102$:
;	tfirm.c 727
	mov	a,r6
	clr	c
	rrc	a
	mov	_usbDecodeAndProcessUsbRequest_sloc3_1_0,a
	mov	r6,_usbDecodeAndProcessUsbRequest_sloc3_1_0
;	tfirm.c 723
	inc	r7
; Peephole 132   changed ljmp to sjmp
	sjmp 00110$
00113$:
;	tfirm.c 738
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
;	tfirm.c 742
	mov	a,#0x0B
	add	a,r2
	mov	r2,a
; Peephole 180   changed mov to clr
	clr  a
	addc	a,r3
	mov	r3,a
	ljmp	00106$
00107$:
;	tfirm.c 747
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
;	tfirm.c 748
; Peephole 132   changed ljmp to sjmp
	sjmp 00114$
00109$:
;	tfirm.c 752
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
;	tfirm.c 755
;	-----------------------------------------
;	 function OEP0InterruptHandler
;	-----------------------------------------
_OEP0InterruptHandler:
;	tfirm.c 757
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 765
	mov	a,_bStatusAction
; Peephole 132   changed ljmp to sjmp
; Peephole 199   optimized misc jump sequence
	cjne a,#0x02,00102$
;00107$:
; Peephole 200   removed redundant sjmp
00108$:
;	tfirm.c 766
	lcall	_usbReceiveNextPacketOnOEP0
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00102$:
;	tfirm.c 768
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
;	tfirm.c 771
;	-----------------------------------------
;	 function IEP0InterruptHandler
;	-----------------------------------------
_IEP0InterruptHandler:
;	tfirm.c 773
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 781
	mov	a,_bStatusAction
; Peephole 132   changed ljmp to sjmp
; Peephole 199   optimized misc jump sequence
	cjne a,#0x01,00102$
;00107$:
; Peephole 200   removed redundant sjmp
00108$:
;	tfirm.c 782
	lcall	_usbSendNextPacketOnIEP0
; Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00102$:
;	tfirm.c 788
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
;	tfirm.c 792
;	-----------------------------------------
;	 function OEP1InterruptHandler
;	-----------------------------------------
_OEP1InterruptHandler:
;	tfirm.c 798
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x4A)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 802
	mov	a,_bOEP1RecieveLength
; Peephole 162   removed sjmp by inverse jump logic
	jz   00135$
00134$:
; Peephole 132   changed ljmp to sjmp
	sjmp 00102$
00135$:
;	tfirm.c 803
	mov	dptr,#(_pbOEP1XBufferAddress + 0x0001)
	movx	a,@dptr
	mov	_bOEP1RecieveLength,a
;	tfirm.c 804
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x7F
;	tfirm.c 805
	mov	r3,#0x00
00116$:
	clr	c
	mov	a,r3
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00119$
00136$:
;	tfirm.c 806
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
;	tfirm.c 808
	inc	_bOEP1SaveBufferPosition
;	tfirm.c 805
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00116$
00119$:
;	tfirm.c 810
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
; Peephole 132   changed ljmp to sjmp
	sjmp 00103$
00102$:
;	tfirm.c 815
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
	movx	a,@dptr
	mov	r3,a
	mov	a,#0x7F
	anl	a,r3
	mov	r2,a
;	tfirm.c 816
	mov	r3,#0x00
00120$:
	clr	c
	mov	a,r3
	subb	a,r2
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00123$
00137$:
;	tfirm.c 817
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
;	tfirm.c 819
	inc	_bOEP1SaveBufferPosition
;	tfirm.c 816
	inc	r3
; Peephole 132   changed ljmp to sjmp
	sjmp 00120$
00123$:
;	tfirm.c 821
	mov	dptr,#(_tOutputEndPointDescriptorBlock + 0x0002)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
00103$:
;	tfirm.c 826
	clr	c
	mov	a,_bOEP1SaveBufferPosition
	subb	a,_bOEP1RecieveLength
; Peephole 108   removed ljmp by inverse jump logic
	jnc  00105$
00138$:
;	tfirm.c 827
; Peephole 132   changed ljmp to sjmp
	sjmp 00124$
00105$:
;	tfirm.c 829
	mov	_bOEP1RecieveLength,#0x00
;	tfirm.c 831
	mov	_bOEP1SaveBufferPosition,#0x00
;	tfirm.c 833
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
;	tfirm.c 836
00106$:
	lcall	_fn_cmd_01
;	tfirm.c 837
;	tfirm.c 840
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00107$:
	lcall	_fn_cmd_02
;	tfirm.c 841
;	tfirm.c 844
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00108$:
	lcall	_fn_cmd_03
;	tfirm.c 845
;	tfirm.c 848
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00109$:
	lcall	_fn_cmd_04
;	tfirm.c 849
;	tfirm.c 852
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00110$:
	lcall	_fn_cmd_05
;	tfirm.c 853
;	tfirm.c 856
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00111$:
	lcall	_fn_cmd_06
;	tfirm.c 857
;	tfirm.c 860
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00112$:
	lcall	_fn_cmd_07
;	tfirm.c 861
;	tfirm.c 864
; Peephole 132   changed ljmp to sjmp
	sjmp 00115$
00113$:
	lcall	_fn_cmd_08
;	tfirm.c 869
00115$:
;	tfirm.c 871
00124$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'IEP1InterruptHandler'
;------------------------------------------------------------
;	tfirm.c 875
;	-----------------------------------------
;	 function IEP1InterruptHandler
;	-----------------------------------------
_IEP1InterruptHandler:
;	tfirm.c 876
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SetupPacketInterruptHandler'
;------------------------------------------------------------
;	tfirm.c 879
;	-----------------------------------------
;	 function SetupPacketInterruptHandler
;	-----------------------------------------
_SetupPacketInterruptHandler:
;	tfirm.c 882
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0001)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 883
	mov	dptr,#(_tEndPoint0DescriptorBlock + 0x0003)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 885
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x04
	movx	@dptr,a
;	tfirm.c 889
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
;	tfirm.c 890
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
;	tfirm.c 892
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
;	tfirm.c 897
	mov	_bStatusAction,#0x00
;	tfirm.c 901
	lcall	_usbDecodeAndProcessUsbRequest
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'usbISR'
;------------------------------------------------------------
;	tfirm.c 905
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
;	tfirm.c 906
	clr	_EA
;	tfirm.c 908
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
;	tfirm.c 911
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 912
	lcall	_OEP0InterruptHandler
;	tfirm.c 913
	ljmp	00111$
;	tfirm.c 916
00102$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 917
	lcall	_IEP0InterruptHandler
;	tfirm.c 918
	ljmp	00111$
;	tfirm.c 921
00103$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 922
	lcall	_OEP1InterruptHandler
;	tfirm.c 924
	ljmp	00111$
;	tfirm.c 927
00104$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 930
	ljmp	00111$
;	tfirm.c 933
00105$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 934
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x01
	movx	@dptr,a
;	tfirm.c 935
	lcall	_SetupPacketInterruptHandler
;	tfirm.c 936
	ljmp	00111$
;	tfirm.c 939
00106$:
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x92)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 940
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x04
	movx	@dptr,a
;	tfirm.c 941
	lcall	_SetupPacketInterruptHandler
;	tfirm.c 942
;	tfirm.c 945
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00107$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 946
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 947
	lcall	_usbReset
;	tfirm.c 949
;	tfirm.c 952
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00108$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 953
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x20
	movx	@dptr,a
;	tfirm.c 954
	mov	_bSuspended,#0x00
;	tfirm.c 955
;	tfirm.c 958
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00109$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 959
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0xFE)
	mov	a,#0x40
	movx	@dptr,a
;	tfirm.c 960
	mov	_bSuspended,#0x01
;	tfirm.c 961
;	tfirm.c 964
; Peephole 132   changed ljmp to sjmp
	sjmp 00111$
00110$:
	mov	dpl,#0x92
	mov	dph,#0xFF
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 966
00111$:
;	tfirm.c 968
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
;	tfirm.c 972
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	tfirm.c 974
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x94)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 975
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x95)
; Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;	tfirm.c 976
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x96)
	mov	a,#0xFF
	movx	@dptr,a
;	tfirm.c 977
; Peephole 182   used 16 bit load of dptr
	mov  dptr,#(((0xFF)<<8) + 0x97)
	mov	a,#0x80
	movx	@dptr,a
;	tfirm.c 979
	mov	_P3,#0xFF
;	tfirm.c 980
	mov	_P2,#0xFF
;	tfirm.c 981
	mov	_P1,#0xFF
;	tfirm.c 983
	anl	_IE,#0xF5
;	tfirm.c 985
	setb	_P3_2
;	tfirm.c 987
	lcall	_SystemInitialization
00101$:
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
