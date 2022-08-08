`timescale 1ns / 1ps

module clock_divider (
    input [20:0] max_count,
    input clk,
    input rst,
    output reg clk_div
    );

    reg [31:0] address;
     
    always @ (posedge(clk), posedge(rst))
    begin
        if (rst == 1'b1)
            address <= 32'b0;
        else if (address >= max_count - 1)
            address <= 32'b0;
        else
            address <= address + 1;
                  
    end

    always @ (posedge(clk), posedge(rst))
    begin
        if (rst == 1'b1)
            clk_div <= 1'b0;
        else if (address >= max_count - 1)
            clk_div <= ~clk_div;
        else
            clk_div <= clk_div;
    end

endmodule
