module reg_file2(
input [4:0] readReg1, readReg2, writeReg,
input [31:0] writeData,
input regWrite, clk, WBOut,
output reg [31:0] readData1, readData2
);

reg [31:0] regFile [0:31];
integer k;

//set all reg to 0
initial begin
  for (k = 0; k <=31; k = k +1)
	regFile[k] = 0;
	readData1 = 0;
	readData2 = 0;
end

//at posedge clock
always  @ (negedge clk)  
begin
  if (regWrite) 
      regFile[writeReg] = writeData;
      
end

always @(readReg1 or readReg2) 
begin
  readData1 = regFile[readReg1];
  readData2 = regFile[readReg2];
end

//WB LOGIC


endmodule