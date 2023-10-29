/*
	Copyright 2023 Efabless Corp.

	Author: Mohamed Shalan (mshalan@efabless.com)

	This file is auto-generated by wrapper_gen.py on 2023-10-29

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


`timescale			1ns/1ns
`default_nettype	none

`define		AHB_BLOCK(name, init)		always @(posedge HCLK or negedge HRESETn) if(~HRESETn) name <= init;
`define		AHB_REG(name, init, size)	`AHB_BLOCK(name, init) else if(ahbl_we & (last_HADDR[15:0]==``name``_ADDR)) name <= HWDATA[``size``-1:0];
`define		AHB_ICR(size)				`AHB_BLOCK(ICR_REG, sz'b0) else if(ahbl_we & (last_HADDR[15:0]==ICR_REG_ADDR)) ICR_REG <= HWDATA[``size``-1:0]; else ICR_REG <= ``size``'d0;

module EF_PIN_MUX_ahbl (
	input	wire [15:0]	io_in,
	output	wire [15:0]	io_out,
	output	wire [15:0]	io_oeb,
	output	wire [63:0]	p_in,
	input	wire [63:0]	p_out,
	input	wire [63:0]	p_oeb,
	input	wire 		HCLK,
	input	wire 		HRESETn,
	input	wire [31:0]	HADDR,
	input	wire 		HWRITE,
	input	wire [1:0]	HTRANS,
	input	wire 		HREADY,
	input	wire 		HSEL,
	input	wire [2:0]	HSIZE,
	input	wire [31:0]	HWDATA,
	output	wire [31:0]	HRDATA,
	output	wire 		HREADYOUT
);
	localparam[15:0] FN_SEL_REG_ADDR = 16'h0000;

	reg             last_HSEL;
	reg [31:0]      last_HADDR;
	reg             last_HWRITE;
	reg [1:0]       last_HTRANS;

	always@ (posedge HCLK or negedge HRESETn) begin
		if (!HRESETn) begin
			last_HSEL       <= 0;
			last_HADDR      <= 0;
			last_HWRITE     <= 0;
			last_HTRANS     <= 0;
		end else if (HREADY) begin
			last_HSEL       <= HSEL;
			last_HADDR      <= HADDR;
			last_HWRITE     <= HWRITE;
			last_HTRANS     <= HTRANS;
		end
	end

	reg	[31:0]	FN_SEL_REG;

	wire[31:0]	sel	= FN_SEL_REG[31:0];
	wire		ahbl_valid	= last_HSEL & last_HTRANS[1];
	wire		ahbl_we	= last_HWRITE & ahbl_valid;
	wire		ahbl_re	= ~last_HWRITE & ahbl_valid;
	wire		_clk_	= HCLK;
	wire		_rst_	= ~HRESETn;

	EF_PIN_MUX inst_to_wrap (
		.io_in(io_in),
		.io_out(io_out),
		.io_oeb(io_oeb),
		.p_in(p_in),
		.p_out(p_out),
		.p_oeb(p_oeb),
		.sel(sel)
	);

	`AHB_REG(FN_SEL_REG, 0, 32)
	assign	HRDATA = 
			(last_HADDR[15:0] == FN_SEL_REG_ADDR) ? FN_SEL_REG :
			32'hDEADBEEF;


	assign HREADYOUT = 1'b1;

endmodule
