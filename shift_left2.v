module shiftleft2(
        input [31:0] shiftIn,
        output reg [31:0] shiftOut);
        
        always @ (shiftIn)
        begin 
                shiftOut = {shiftIn[29:0],2'b00};
        end 
        
endmodule         
