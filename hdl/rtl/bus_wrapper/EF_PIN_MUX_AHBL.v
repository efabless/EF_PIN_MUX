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

`define				AHBL_AW		16

`include			"ahbl_wrapper.vh"

module EF_PIN_MUX_AHBL (
	`AHBL_SLAVE_PORTS,
	input	wire	[48-1:0]	io_in,
	output	wire	[48-1:0]	io_out,
	output	wire	[48-1:0]	io_oeb,
	output	wire	[192-1:0]	p_in,
	input	wire	[192-1:0]	p_out,
	input	wire	[192-1:0]	p_oeb
);

	localparam	fn_sel0_REG_OFFSET = `AHBL_AW'h0000;
	localparam	fn_sel1_REG_OFFSET = `AHBL_AW'h0004;
	localparam	fn_sel2_REG_OFFSET = `AHBL_AW'h0008;
	wire		clk = HCLK;
	wire		rst_n = HRESETn;


	`AHBL_CTRL_SIGNALS

	wire [96-1:0]	sel;

	// Register Definitions
	reg [31:0]	fn_sel0_REG;
	assign	sel[31:0] = fn_sel0_REG;
	`AHBL_REG(fn_sel0_REG, 0, 32)

	reg [31:0]	fn_sel1_REG;
	assign	sel[63:32] = fn_sel1_REG;
	`AHBL_REG(fn_sel1_REG, 0, 32)

	reg [31:0]	fn_sel2_REG;
	assign	sel[95:64] = fn_sel2_REG;
	`AHBL_REG(fn_sel2_REG, 0, 32)

	EF_PIN_MUX instance_to_wrap (
		.sel(sel),
		.io_in(io_in),
		.io_out(io_out),
		.io_oeb(io_oeb),
		.p_in(p_in),
		.p_out(p_out),
		.p_oeb(p_oeb)
	);

	assign	HRDATA = 
			(last_HADDR[`AHBL_AW-1:0] == fn_sel0_REG_OFFSET)	? fn_sel0_REG :
			(last_HADDR[`AHBL_AW-1:0] == fn_sel1_REG_OFFSET)	? fn_sel1_REG :
			(last_HADDR[`AHBL_AW-1:0] == fn_sel2_REG_OFFSET)	? fn_sel2_REG :
			32'hDEADBEEF;

	assign	HREADYOUT = 1'b1;

endmodule
