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

initial begin
    Hsync = 1'b1;
    Vsync = 1'b1;
    Hcount = 10'b0000000000;
    Vcount = 10'b0000000000;
    vgaRed = 4'h0;
    vgaBlue = 4'h0;
    vgaGreen = 4'h0;
end

//always@(posedge clk_25MHz)
always@(posedge clk)
begin

    if((Hcount < 640) && (Vcount < 480)) begin
        case(sw)
            0: begin
                //black
                vgaRed=4'h0;
                vgaGreen = 4'h0;
                vgaBlue = 4'h0;
            end
            1:begin
                //blue
                vgaRed = 4'h0;
                vgaGreen = 4'h0;
                vgaBlue = 4'hF;
            end
            2:begin
                //brown
                vgaRed = 4'h3;
                vgaGreen = 4'h3;
                vgaBlue = 4'h3;
            end
            4:begin
                //cyan
                vgaRed = 4'h7;
                vgaGreen = 4'hF;
                vgaBlue = 4'hF;
            end
            8:begin
                //red
                vgaRed = 4'hF;
                vgaGreen = 4'h0;
                vgaBlue = 4'h0;
            end
            16:begin
                //magenta
                vgaRed = 4'hF;
                vgaGreen = 4'h0;
                vgaBlue = 4'hF;
            end
            32:begin
                //yellow
                vgaRed = 4'hF;
                vgaGreen = 4'hF;
                vgaBlue = 4'hF;
            end
            64:begin
                //white
                vgaRed = 4'hF;
                vgaGreen = 4'hF;
                vgaBlue = 4'hF;
            end
            default:begin
                //black
                vgaRed = 4'h0;
                vgaGreen = 4'h0;
                vgaBlue = 4'h0;
            end
        endcase
    end else begin
        vgaRed = 0;
        vgaGreen = 0;
        vgaBlue = 0;
    end

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
