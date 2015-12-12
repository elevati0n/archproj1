module andg(
output reg out,
input in0,
input in1);
always @ (in0 or in1)
if (in0 & in1) 
begin 
out = 1; 
end
else begin
out = 0;
end 
endmodule