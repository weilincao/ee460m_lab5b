module VGA_Output(
input clk,
input [7:0] sw,
output reg[3:0] vgaRed,
output reg[3:0] vgaBlue,
output reg[3:0] vgaGreen,
output reg Hsync,
output reg Vsync
);

wire clk_25MHz;

clk_generator_25MHz cg25MHz(
.clk(clk),
.reset(1'b0),
.clk_25MHz(clk_25MHz)
);

reg [9:0] Hcount;
reg [9:0] Vcount;

always@(posedge clk)
begin

 case(sw)
       0: begin
       //black
        vgaRed=0;
        
       end
       1:begin
       //blue
       end
       2:begin
       //brown
       end
       4:begin
       //cyan
       end
       8:begin
       //red
       end
       16:begin
       //magenta
       end
       32:begin
       //yellow
       end
       64:begin
       //white
       end
       default:begin
       //black
       end
   endcase

    case(Hcount)
        0: begin
            Hcount = Hcount + 1;
            case(Vcount)
                493: begin
                    Vsync = 1'b0;
                    Vcount = Vcount + 1;
                end
                495: begin
                    Vsync = 1'b1;
                    Vcount = Vcount + 1;
                end
                524: begin
                    Vcount = 0;
                end
                default: begin
                    Vcount = Vcount + 1;
                end
            endcase
        end
        640:begin
            Hcount = Hcount + 1;
            vgaRed=0;
            vgaBlue=0;
            vgaGreen=0;
        end
        659: begin
            Hsync = 1'b0;
            Hcount = Hcount + 1;
        end
        756: begin
            Hsync = 1'b1;
            Hcount = Hcount + 1;
        end
        799: begin
            Hcount = 0;
        end
        default: begin
            Hcount = Hcount + 1;
        end
    endcase



end
endmodule
