module clk_generator_25MHz(
input clk,
input reset,
output reg clk_25MHz
    );
    reg [29:0] count;
    
    always @(posedge clk)begin
        if(reset)
            count=0;
        else
            if(count>=2)
            begin
                count=0;
                clk_25MHz=~clk_25MHz;
            end
            else
                count=count+1;
    end
endmodule
