module pipelineIFID(
input [31:0] addrPlus4,
input [31:0] instrIn,
output reg [31:0] addrPlus4Out,
output reg [31:0] instrOut,
input IFFlush,
input hazard,
input clk
); 

//normal operation
always @ (posedge clk) 
begin 
addrPlus4Out = addrPlus4;
instrOut = instrIn;
end 

//hazard

//flush

endmodule
