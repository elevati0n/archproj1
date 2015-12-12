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

//normal operation
always @ (posedge clk) 
begin 
dataMemOut = dataMemIn;
ALUResultOut = ALUResultIn;
instrOut = instrIn;
end 

//hazard


endmodule