module mux32bit2_1(
input s,
input [31:0] in0,
input [31:0] in1,
output reg [31:0] out
);

always@(s or in0 or in1)
	if (s == 1) begin
	out = in1;
	end
	else begin
	out = in0;	
	end
endmodule