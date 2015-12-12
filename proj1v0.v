module proj3(
output reg  [4*8:1]  inst_addr,
input  [31:0]  instr,
output reg  [4*8:1]  data_addr,
output reg  [31:0]  data_in,
output reg          mem_read,
output reg          mem_write,
input  [31:0]  data_out
);
//process has input and output from memoryfile  

/*  from memory file : 
module Memory(
    inst_addr,
    instr,
	data_addr,
	data_in,
	mem_read,
	mem_write,
	data_out
);

// Interface
input   [4*8:1]  inst_addr;
output  [31:0]  instr;
input   [4*8:1]  data_addr;
input   [31:0]  data_in;
input           mem_read;
input           mem_write;
output  [31:0]  data_out;

*/

//the inverse of the memories IO
// Interface 
/*
output   [4*8:1]  inst_addr;
input  [31:0]  instr;
output   [4*8:1]  data_addr;
output   [31:0]  data_in;
output           mem_read;
output           mem_write;
input  [31:0]  data_out;
*/
//FETCH STAGE 1. 

//the output of the jumpMux into the PC
//wire [7:0] jumpMuxToPC; 

//program counter and InsMem input and output
//intrastage 
/*
input wire   [4*8:1]  inst_addr;
output wire  [31:0]  instr;
*/
//output of adderPlus4tojumpMux
wire [31:0] adder4ToJumpMux;
//for pipeline: adder4ToPipeIFID
//wire [31:0] adder4ToJumpMuxToPipeIFID;

//for pipeline: inst_addrToPipeIFID 
//wire [31:0] inst_addrToPipeIFID;

//jumpMuxtoPC
wire [31:0] jumpMuxToPC;

//control signal for jumpMuxPC; 


//COMPONETS in step 1 Fetch

//pc counter
pcCounter pc_counter(jumpMuxToPC, instr); 

//instruction memory

Memory memory(inst_addr,
    instr,
	data_addr,
	data_in,
	mem_read,
	mem_write,
	data_out); 




//Hazard Detection Unit
//wire to top of PipeIFID

//HazardDetectionToPC
//wire hazardDetectToPC

//HazardDectectionToPipeIFID
//wire HazardDectectionToPipeIFID

//











/*


always@(posedge clk, posedge rst)
begin
	if(rst)
		out <= 0;
	else if(en)
		out <= in;
end
*/
		
endmodule
