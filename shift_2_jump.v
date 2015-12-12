module shift2jump(
  input [29:0] instr,
  output reg [31:0] shifted_instr
  );
  
  always @ (instr)
  begin 
    shifted_instr = {instr[29:0],2'b00};
  end
  
endmodule