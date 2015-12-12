`timescale 1ns/100ps

module projPipe(
output  [31:0]  inst_addr,
input clk,
input reset,
input  [31:0]  instr,
output  [31:0]  data_addr,
output  [31:0]  data_in,
output  mem_read,
output  mem_write,
input  [31:0]  data_out
);

//stage 1 FETCH

wire [31:0] aluAdd4ToJumpMux;

add4PC pc_add4(inst_addr, aluAdd4ToJumpMux);

wire [31:0] jumpMuxToPC;

wire hazardtoPC;

pcCounter2 pc_counter2(clk, hazardtoPC, reset, jumpMuxToPC, inst_addr); 

wire [31:0] IFIDInstrOut;

wire [31:0] jumpAddressSL; 


wire [31:0] ALUInput1;

shiftleft2 sl2top(
ALUInput1, 
jumpAddressSL
); 

wire [31:0] jumpMuxPC1;
wire [31:0] shiftLeftToALU;

mux32bit2_1 jumpMux2(
Jump,
aluAdd4ToJumpMux,
shiftLeftToALU, 
jumpMuxToPC
);

/*
module pipelineIFID(
input [31:0] addrPlus4,
input [31:0] instrIn,
output reg [31:0] addrPlus4Out,
output reg [31:0] instrOut,
input IFFlush,
input hazard,
input clk
)
*/

wire [31:0] IFIDaddrPlus4Out; 
wire IFFlush;
wire IFIDhazard;

pipelineIFID p1(aluAdd4ToJumpMux, instr, IFIDaddrPlus4Out, IFIDInstrOut, IFFlush, IFIDhazard, clk);

//STAGE 2 

/*
module reg_file(
input [4:0] readReg1, readReg2, writeReg,
input [31:0] writeData,
input regWrite, clk, WBOut,
output reg [31:0] readData1, readData2
);
*/

wire [4:0] writeRegIn; 
wire [31:0] writeDataIn; 
wire [31:0] readData1;
wire [31:0] readData2;

//register 
reg_file2 regfile2(
        IFIDInstrOut[25:21],
        IFIDInstrOut[20:16],
        writeRegIn, 
        writeDataIn,
        RegWrite, clk, WBOut,
        readData1, readData2);

//ctrl unit 

//wire RegDst, Jump, Branch, RegWrite, MemRead, MemtoReg, MemWrite, ALUSrc;
wire [1:0] ALUOp; 

controlunit ctrl_unit(RegDst, Jump, Branch, mem_read, MemtoReg, 
mem_write, ALUSrc, RegWrite,  ALUOp, IFIDInstrOut[31:26]);

wire [31:0] signExtendToShiftLeft; 

//signextend
signextend signExtend(IFIDInstrOut[15:0], signExtendToShiftLeft);  //

//wire [31:0] shiftLeftToALU;

//shift left
shiftleft2 SL2(
        signExtendToShiftLeft,
        shiftLeftToALU);  

wire [3:0] aluctrlout; 
/*
alu_control aluCtrler(
  ALUOp[1:0],
  instr[5:0],
  IFIDInstrOut[3:0]
);
*/

wire zeroAluTop; 


//calculate branch address ALU
alu aluTop(
        jumpMuxPC1[31:0],
        zeroAluTop,
        4'b0010, 
        //data_a 
        IFIDaddrPlus4Out[31:0],  //check this
        //data_b 
        shiftLeftToALU[31:0]
);


//need to add comparator 
// mux for WB M EX
// is the control unit the same?


//done with stage 2??? 
/*
module pipelineIDEX(
input [31:0] readData1In, input [31:0] readData2In,
output reg [31:0] readData1Out, output reg [31:0] readData2Out,
//output reg [31:0] readData1, readData2
input [31:0] signExtendIn, 
output reg [31:0] signExtendOut,
input [31:0] instrIn,
output reg [31:0] instrOut,
input wbIn, input mIn, input exIn,
output reg wbOut, output reg mOut,
//hazard pipelineIDEX
*/

//outputs for pipeline
wire [31:0] IDEXReadData1, IDEXReadData2; 
//wire [31:0] readData1Out, readData2Out;
wire [31:0] signExtendOut; 
wire [31:0] IDEXInstrOut; 

wire IDEXmIn, IDEXexIn, IDEXwbOut, IDEXmOut, IDEXwbIn;

wire IDEXhazard;

pipelineIDEX p2(readData1, readData2, IDEXReadData1, IDEXReadData2, 
signExtendToShiftLeft, signExtendOut, IFIDInstrOut, IDEXInstrOut,
IDEXwbIn, IDEXmIn, IDEXexIn, IDEXwbOut, IDEXmOut, IDEXhazard, clk);

//stage 3

//mux's for ALU EXEC

/*
module mux4to1(
input [31:0] IDEX,
input [31:0] EXMEM, 
input [31:0] MEMWB,
input [31:0] notused,
input [1:0] s,
output reg [31:0] dataOut);
*/
wire [1:0] ForwardA, ForwardB;


mux4to1 top4to1mux(IDEXReadData1, writeDataIn, data_addr, , ForwardA, ALUInput1);

wire [31:0] ALUMuxtoMux; 

mux4to1 bottom4to1mux(IDEXReadData2, writeDataIn, data_addr, , ForwardB, ALUMuxtoMux);

wire [31:0] ALUInput2;

mux32bit2_1 aluReadDataMux(
ALUSrc,
ALUMuxtoMux,
signExtendOut,
ALUInput1
);

//the exec alu

// ALU Execturor
/*
module alu( output reg[31:0] aluresult, output zero,
            input[3:0] operation, input[31:0] data_a, input [31:0] data_b );
*/

wire [31:0] EXMEMdata_addr;

//wire [1:0] ALUOp;
//wire [3:0] aluctrlout; 

//module alu_control(input[1:0] aluop, input[5:0] funct, output reg[3:0] operation );
alu_control aluCtrler(
  ALUOp,
  IDEXInstrOut[5:0],
  aluctrlout
);

alu aluExec(
        EXMEMdata_addr[31:0],
        , //no longer needed comparator instead
        aluctrlout[3:0], 
        //data_a
        ALUInput1,
        //data_b 
        ALUInput2
);

//mux for registers
/*
module mux5bit2_1(
//ctrl`
input s,
//in0 [correct]
input [4:0] in0,
input [4:0] in1,
output reg [4:0] out
);
*/
wire regCtrl;   ///who am i hooked up to???? '
wire [4:0] EXMEMRegIn;

mux5bit2_1 m1(regCtrl, IDEXInstrOut[4:0], IDEXInstrOut[4:0], EXMEMRegIn);

//end stage 3 
/*
module pipelineEXMEM(
input [31:0] ALUResultIn,
input [31:0] ALUInput2In,
//input [4:0] readReg1
input [4:0] readRegIn,
output reg [31:0] ALUResultOut,
output reg [31:0] ALUInput2Out,
output reg [4:0] readRegOut,
input [31:0] instr,
output reg [31:0] instrOut, 
input WBIn,
input MIn,
output reg WBOut,
input clk
); 
*/
wire [31:0] EXMEMALUInput2Out; 
wire [31:0] EXMEMAluResultOut; //, data_in;
wire [4:0] EXMEMReadRegOut;
wire EXMEMWBout; 
wire [31:0] EXMEMInstrOut;

//i doubt this is right
pipelineEXMEM p3(
EXMEMdata_addr, ALUInput2, EXMEMRegIn, 
data_addr, data_in,
EXMEMReadRegOut,  IDEXInstrOut, EXMEMInstrOut, IDEXWBout, IDEXMout, EXMEMWBout, clk);

//Data Memory

 //stage 4

/*
module pipelineMEMWB(
input [31:0] dataMemIn,
input [31:0] ALUResultIn,
//input [4:0] readReg1
input [31:0] instrIn,
output reg [31:0] dataMemOut,
output reg [31:0] ALUResultOut,
output reg [31:0] instrOut,
input WBIn,
output reg WBOut,
input clk
); 
*/
wire [31:0] MEMWBinstrOut;
wire MEMWBWBIn, MEMWBWBOut;
wire [31:0] MEMWBdataMemOut;
//check EXMEMALUInput2Out

pipelineMEMWB p4(data_out, data_in, data_in, EXMEMALUInput2Out, MEMWBdataMemOut, MEMWBinstrOut, MEMWBWBIn, MEMWBWBOut, clk);

//stage 5 write back

mux5bit2_1 writeRegMux(
//ctrl`
RegDst,
//in0 [correct]
MEMWBinstrOut[20:16],
//in1 [correct]
MEMWBinstrOut[15:11],
// output 
writeRegIn
);



endmodule