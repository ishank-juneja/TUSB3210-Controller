#include <8052.h>
#include "types.h"

#define bIEPDCTX_1              (* (char xdata *)0xFF4A)

//Digit and Tube Mappings
/*Digit Mappings*/
#define digA P0_0
#define digB P1_6
#define digC P1_5
#define digD P1_7

/*Tube Mappings*/
#define T0 P0_3
#define T1 P0_2
#define T2 P0_1
#define T3 P1_4
#define T4 P1_3
#define T5 P1_2

xdata at 0xfe00 BYTE iep1_buffer[0x40];
xdata at 0xfd80 BYTE oep1_buffer[0x40];

//Commands 1-3 are samples shared by prof Mukul
void fn_cmd_01(void) {
  // Function for CMD_01
  // Simply send back 0x1b, the ESC character
  iep1_buffer[0] = 0x1b;
  bIEPDCTX_1 = 1;
}


void fn_cmd_02(void) {
  iep1_buffer[0] = 0x4e; // N
  iep1_buffer[1] = 0x49; // I
  iep1_buffer[2] = 0x58; // X
  iep1_buffer[3] = 0x49; // I
  iep1_buffer[4] = 0x45; // E
  iep1_buffer[5] = '\0'; // String terminator
  bIEPDCTX_1 = 6;
}

void fn_cmd_03(void) {
  // Add 1 to the received 8 bytes and send them back to the host
  int i;
  for(i=0; i<8; i++) {
    iep1_buffer[i] = oep1_buffer[i]+1;
  }
  bIEPDCTX_1 = 8; 
}

//cmd to display the received digits on the correct
//tubes for the next one second

void fn_cmd_04(void) {  
	//Initiate the display of time using received information


	// Simply send back 0x1b,the ESC character
	//as confirmation that execution of 
	//displaying the time is initiated 
  iep1_buffer[0] = 0x1b;
  bIEPDCTX_1 = 1;
}

/*Not used
void fn_cmd_05(void) {}
void fn_cmd_06(void) {}
void fn_cmd_07(void) {}
void fn_cmd_08(void) {}
*/