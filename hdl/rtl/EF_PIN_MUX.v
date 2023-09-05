/*
	Copyright 2020 Efabless Corp.

	Author: Mohamed Shalan (mshalan@efabless.com)
	
	Licensed under the Apache License, Version 2.0 (the "License"); 
	you may not use this file except in compliance with the License. 
	You may obtain a copy of the License at:
	http://www.apache.org/licenses/LICENSE-2.0
	Unless required by applicable law or agreed to in writing, software 
	distributed under the License is distributed on an "AS IS" BASIS, 
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
	See the License for the specific language governing permissions and 
	limitations under the License.
*/


/*
	Pin Multiplexing Fabric

 	Four functions per pin

	Example usage:
	wire [COUNT-1:0] NC[3:0];	// Array of wires of unconnected inputs
	pin_mux pmux (
	.p_in({
		//	3			2			1			0
			UART0_RX, 	UART1_RX, 	NC[29][1], 	PORTA_IN[7],		// Peripherals on I/O 29
			NC[28][3], 	NC[28][2], 	NC[28][1], 	PORTA_IN[6],		// Peripherals on I/O 28
			.
			.
			}),
	.p_out({
		//	3			2			1			0
			1'b0, 		1'b0, 		UART0_TX, 	PORTA_OUT[7],
			UART1_TX, 	PWM0_A, 	PWM1_A, 	PORTA_OUT[6],
			.
			.
			}),
	p_oe({
		//	3			2			1			0
			1'b0, 		1'b0, 		1'b1, 		PORTA_OE[7],
			1'b1, 		1'b1, 		1'b0, 		PORTA_OE[6],
				.
				.
			})
	
	)
*/

`timescale          1ns/1ns
`default_nettype    none

module EF_PIN_MUX #(parameter COUNT=16) (
	// I/O Pads facing ports
	input  wire [COUNT-1:0] io_in,
	output wire [COUNT-1:0] io_out,
	output wire [COUNT-1:0] io_oeb,

	// Peripherals facing ports
	output wire [COUNT*4-1:0]	p_in,
	input  wire [COUNT*4-1:0]	p_out,
	input  wire [COUNT*4-1:0]	p_oeb,
	
	// Peripheral Selection (2 selection bits per pin)
	input wire [COUNT*2-1:0]    sel
);

    // count cannot be more than 16

	// Decode the selection to enable the input of the selected function only
	wire [3:0] dec[COUNT-1:0];
	generate
		genvar j;
		for(j=0; j<COUNT;j=j+1) begin : DECODER
			assign dec[j] = 1 << sel[j*2+1:j*2];
		end
	endgenerate

	generate
		genvar i;
		for(i=0; i<COUNT;i=i+1) begin : IN_ASSIGN
			assign p_in[(i*4+3):(i*4)] = {4{io_in[i]}} & dec[i];
		end

		for(i=0; i<COUNT;i=i+1) begin : O_ASSIGN
			assign io_out[i] = p_out[i*4 + (sel[i*2+1:i*2])];
		end
		
		for(i=0; i<COUNT;i=i+1) begin : OE_ASSIGN
			assign io_oeb[i] = p_oeb[i*4 + (sel[i*2+1:i*2])];
		end
		
	endgenerate

endmodule