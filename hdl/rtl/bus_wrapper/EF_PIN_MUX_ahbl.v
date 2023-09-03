/*
	Copyright 2023 Efabless Corp.

	Author: Mohamed Shalan (mshalan@efabless.com)

	This file is auto-generated by wrapper_gen.py

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

`define		AHB_BLOCK(name, init)	always @(posedge HCLK or negedge HRESETn) if(~HRESETn) name <= init;
`define		AHB_REG(name, init)		`AHB_BLOCK(name, init) else if(ahbl_we & (last_HADDR==``name``_ADDR)) name <= HWDATA;
`define		AHB_ICR(sz)				`AHB_BLOCK(ICR_REG, sz'b0) else if(ahbl_we & (last_HADDR==ICR_REG_ADDR)) ICR_REG <= HWDATA; else ICR_REG <= sz'd0;

module EF_PIN_MUX_ahbl (
	input	wire [31:0]	io_in,
	output	wire [31:0]	io_out,
	output	wire [31:0]	io_oeb,
	output	wire [127:0]	p_in,
	input	wire [127:0]	p_out,
	input	wire [127:0]	p_oeb,
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
	localparam[15:0] FN_SEL0_REG_ADDR = 16'h0000;
	localparam[15:0] FN_SEL1_REG_ADDR = 16'h0004;

	reg             last_HSEL;
	reg [31:0]      last_HADDR;
	reg             last_HWRITE;
	reg [1:0]       last_HTRANS;

	always@ (posedge HCLK) begin
		if(HREADY) begin
			last_HSEL       <= HSEL;
			last_HADDR      <= HADDR;
			last_HWRITE     <= HWRITE;
			last_HTRANS     <= HTRANS;
		end
	end

	reg	[31:0]	FN_SEL0_REG;
	reg	[31:0]	FN_SEL1_REG;

	wire[31:0]	sel0	= FN_SEL0_REG[31:0];
	wire[31:0]	sel1	= FN_SEL1_REG[31:0];
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
		.sel0(sel0),
		.sel1(sel1)
	);

	`AHB_REG(FN_SEL0_REG, 0)
	`AHB_REG(FN_SEL1_REG, 0)
	assign	HRDATA = 
			(last_HADDR == FN_SEL0_REG_ADDR) ? FN_SEL0_REG :
			(last_HADDR == FN_SEL1_REG_ADDR) ? FN_SEL1_REG :
			32'hDEADBEEF;


	assign HREADYOUT = 1'b1;

endmodule
