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

#ifndef EF_PIN_MUXREGS_H
#define EF_PIN_MUXREGS_H

#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const unsigned int
#define   __W     volatile       unsigned int
#define   __RW    volatile       unsigned int
#endif



typedef struct _EF_PIN_MUX_TYPE_ {
	__W 	fn_sel0;
	__W 	fn_sel1;
	__W 	fn_sel2;
	__R 	reserved_0[16317];
	__RW	IM;
	__R 	MIS;
	__R 	RIS;
	__W 	IC;
} EF_PIN_MUX_TYPE;

#endif

