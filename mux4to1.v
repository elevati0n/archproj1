module mux4to1(
input [31:0] IDEX,
input [31:0] EXMEM, 
input [31:0] MEMWB,
input [31:0] notused,
input [1:0] s,
output reg [31:0] dataOut);

always @(IDEX or MEMWB or EXMEM or notused or s) begin

if (s == 2'b00)  
dataOut = IDEX;


else if (s == 2'b01)  
dataOut = MEMWB;

else if (s == 2'b10) 
dataOut = EXMEM;

else   
dataOut = IDEX;
end

endmodule 