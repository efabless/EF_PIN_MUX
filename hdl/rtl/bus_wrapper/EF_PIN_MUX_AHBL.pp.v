/*
	Copyright 2024 Efabless Corp.

	Author: Mohamed Shalan (mshalan@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale			1ns/1ps
`default_nettype	none

module EF_PIN_MUX_AHBL (
	input wire          HCLK,
                                        input wire          HRESETn,
                                        input wire          HWRITE,
                                        input wire [31:0]   HWDATA,
                                        input wire [31:0]   HADDR,
                                        input wire [1:0]    HTRANS,
                                        input wire          HSEL,
                                        input wire          HREADY,
                                        output wire         HREADYOUT,
                                        output wire [31:0]  HRDATA,
                                        output wire         IRQ
,
	input	wire	[48-1:0]	io_in,
	output	wire	[48-1:0]	io_out,
	output	wire	[48-1:0]	io_oeb,
	output	wire	[192-1:0]	p_in,
	input	wire	[192-1:0]	p_out,
	input	wire	[192-1:0]	p_oeb
);

	localparam	fn_sel0_REG_OFFSET = 16'h0000;
	localparam	fn_sel1_REG_OFFSET = 16'h0004;
	localparam	fn_sel2_REG_OFFSET = 16'h0008;
	wire		clk = HCLK;
	wire		rst_n = HRESETn;


	reg  last_HSEL, last_HWRITE; reg [31:0] last_HADDR; reg [1:0] last_HTRANS;
                                        always@ (posedge HCLK or negedge HRESETn) begin
					   if(~HRESETn) begin
					       last_HSEL       <= 1'b0;
					       last_HADDR      <= 1'b0;
					       last_HWRITE     <= 1'b0;
					       last_HTRANS     <= 1'b0;
				            end else if(HREADY) begin
                                                last_HSEL       <= HSEL;
                                                last_HADDR      <= HADDR;
                                                last_HWRITE     <= HWRITE;
                                                last_HTRANS     <= HTRANS;
                                            end
                                        end
                                        wire    ahbl_valid	= last_HSEL & last_HTRANS[1];
	                                    wire	ahbl_we	= last_HWRITE & ahbl_valid;
	                                    wire	ahbl_re	= ~last_HWRITE & ahbl_valid;

	wire [96-1:0]	sel;

	// Register Definitions
	reg [31:0]	fn_sel0_REG;
	assign	sel[31:0] = fn_sel0_REG;
	always @(posedge HCLK or negedge HRESETn) if(~HRESETn) fn_sel0_REG <= 0;
                                        else if(ahbl_we & (last_HADDR[16-1:0]==fn_sel0_REG_OFFSET))
                                            fn_sel0_REG <= HWDATA[32-1:0];

	reg [31:0]	fn_sel1_REG;
	assign	sel[63:32] = fn_sel1_REG;
	always @(posedge HCLK or negedge HRESETn) if(~HRESETn) fn_sel1_REG <= 0;
                                        else if(ahbl_we & (last_HADDR[16-1:0]==fn_sel1_REG_OFFSET))
                                            fn_sel1_REG <= HWDATA[32-1:0];

	reg [31:0]	fn_sel2_REG;
	assign	sel[95:64] = fn_sel2_REG;
	always @(posedge HCLK or negedge HRESETn) if(~HRESETn) fn_sel2_REG <= 0;
                                        else if(ahbl_we & (last_HADDR[16-1:0]==fn_sel2_REG_OFFSET))
                                            fn_sel2_REG <= HWDATA[32-1:0];

	EF_PIN_MUX #(.COUNT(48)) instance_to_wrap (
		.sel(sel),
		.io_in(io_in),
		.io_out(io_out),
		.io_oeb(io_oeb),
		.p_in(p_in),
		.p_out(p_out),
		.p_oeb(p_oeb)
	);

	assign	HRDATA = 
			(last_HADDR[16-1:0] == fn_sel0_REG_OFFSET)	? fn_sel0_REG :
			(last_HADDR[16-1:0] == fn_sel1_REG_OFFSET)	? fn_sel1_REG :
			(last_HADDR[16-1:0] == fn_sel2_REG_OFFSET)	? fn_sel2_REG :
			32'hDEADBEEF;

	assign	HREADYOUT = 1'b1;

endmodule
