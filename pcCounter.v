module pcCounter(
//input clk, HazardUnitControl ;
input clk,
input reset,
input [31:0] in,
 output reg [31:0] out
);

reg [31:0] holdState;

always @(posedge clk)
if (reset == 1)
  begin        
    out[31:0] = 32'h00003000;
end 

else begin 
out = in; 
end
endmodule

/*


begin 
holdState = jumpMuxToPC;
//instr = holdState; 
//end

//always @(clk)
//begin 
instr = holdState;
end

endmodule
*/
