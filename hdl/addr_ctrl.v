`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2022 07:43:05 PM
// Design Name: 
// Module Name: addr_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module addr_ctrl(
    input  clk,
    input  we,
    input  [31:0] max_addr,
    output reg ce_addr,
    output reg rst_addr
    );
    
    localparam RDY = 2'b00, START = 2'b01, ENDLOOP = 2'b10;
    
    reg [31:0] counter = 0;
    reg [31:0] max_count;
    reg [1:0] state = RDY;
        
    always @ (posedge clk)
    begin
        if (we)
        begin
            rst_addr <= 0;
            ce_addr <= 0;
            state <= RDY;
        end
        else 
        begin
            case (state)
                RDY:
                begin
                    rst_addr <= 1;
                    ce_addr <= 0;
                    counter <= 0;
                    max_count <= max_addr;
                    state <= START;
                end
                START:
                begin
                    rst_addr <= 0;           
                    ce_addr <= 1;
                    counter <= counter + 1;
                    if (counter >= max_count + 1)
                    begin
                        counter <= 0;
                        state <= ENDLOOP;
                    end
                end         
                ENDLOOP:
                begin
                    rst_addr <= 1;
                    ce_addr <= 0;
                    state <= RDY;
                end
            endcase
        end
    end
    
endmodule

