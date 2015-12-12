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

//normal operation
always @ (posedge clk) 
begin 
ALUResultOut = ALUResultIn;
ALUInput2Out = ALUInput2In;
readRegOut = readRegIn;
WBOut = WBIn;
instrOut = instr;
end 

//hazard


endmodule