# Program a TUSB3210 Microcontroller
***
The now discontinued TUSB3210 microcontroller by Texas Instrumnets was used in our project on a USB powered and controlled nixie tube clock display.

Details of our project can be found on [Ishank's Blog](https://ishank-juneja.github.io/blog/)
***
**Usage**

The directory `nixie_usb_original` was shared by our project advisor [Mukul Chandorkar](https://www.ee.iitb.ac.in/~mukul/). It contains the following file structure, 
```
.
├── sdcc-2.3.0-i386-unknown-linux2.2.tar.gz
├── tusb_nixie_fw
│   ├── bootloader
│   │   ├── Makefile
│   │   ├── sboot
│   │   └── sboot.c
│   ├── commands.h
│   ├── descrip.h
│   ├── Makefile
│   ├── sboot
│   ├── tfirm.bin
│   ├── tfirm.c
│   ├── tusb2136.h
│   ├── types.h
│   ├── usbdefs.h
│   ├── usbiofun.c
│   └── usbiofun.h
└── usbc
    ├── commands.h
    ├── Makefile
    ├── usbc
    └── usbc.c
```
