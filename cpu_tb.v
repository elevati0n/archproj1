`timescale 1 ns /100 ps 
module cpu_tb;

reg clk, reset; 

wire [4*8:1]  inst_addr;
wire  [31:0]  instr;
wire  [4*8:1]  data_addr;
wire  [31:0]  data_in;
wire          mem_read;
wire          mem_write;
wire [31:0]  data_out;

Memory memory(inst_addr,
        instr,
        data_addr,
        data_in,
        mem_read,
        mem_write,
        data_out);



/*

wire inst_addr,
        instr,
        data_addr,
        data_in,
        mem_read,
        mem_write,
        data_out
*/

proj1 finalProject(inst_addr,
	clk,
	reset,
        instr,
        data_addr,
        data_in,
        mem_read,
        mem_write,
        data_out);




initial begin
  clk = 0;  
  reset = 1;
  #5 reset = 1;
  #38 reset = 0;
end

always 
#10 clk = ~clk; //arbitrary clock 

endmodule