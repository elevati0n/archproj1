module mux5bit2_1(
//ctrl`
input s,
//in0 [correct]
input [4:0] in0,
input [4:0] in1,
output reg [4:0] out
);

always@(s or in0 or in1)
	if (s == 1) begin
	out = in1;
	end
	else begin
	out = in0;	
	end
endmodule