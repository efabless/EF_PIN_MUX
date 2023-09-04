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


#define EF_PIN_MUX_BASE				0x00000000

#define	EF_PIN_MUX_FN_SEL_REG_ADDR		(EF_PIN_MUX_BASE+0x0)


volatile unsigned int * ef_pin_mux_fn_sel	= (volatile unsigned int *) EF_PIN_MUX_FN_SEL_REG_ADDR;
