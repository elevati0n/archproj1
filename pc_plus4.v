module add4PC(
  input [31:0] in,
  output reg [31:0] out
  );

	always @ (in)
	begin
	  out = in+4;
	end

endmodule