module pipelineIDEX(
input [31:0] readData1In,
input [31:0] readData2In,
output reg [31:0] readData1Out,
output reg [31:0] readData2Out,
//output reg [31:0] readData1, readData2
input [31:0] signExtendIn,
output reg [31:0] signExtendOut,
input [31:0] instrIn,
output reg [31:0] instrOut,
//wbmex
input wbIn,
input mIn,
input exIn,
output reg wbOut,
output reg mOut,
//hazard
output reg hazard,
//clk
input clk
); 

//normal operation
always @ (posedge clk) 
begin 
readData1Out = readData1In;
readData2Out = readData2In;
signExtendOut = signExtendIn;
instrOut = instrIn;
wbOut = wbOut;
mOut = mIn;
end 

//hazard


endmodule