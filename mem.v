`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2024 12:13:03
// Design Name: 
// Module Name: mem_c
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
module mem (
    input Clk,                
    input rst,              
    input wr,         
    input rd,            
    input [3:0] addr,       
    input [7:0] Data_in,    
    output reg [7:0] Data_out   
);
    reg [7:0] A [0:10]; 
    always @(posedge Clk or posedge rst) begin
        if (rst) begin
            Data_out <= 8'b0;  
        end 
        else begin
            case ({wr, rd}) 
                2'b10: begin
                   
                    A[addr] <= Data_in;
                end
                2'b01: begin
                   
                    Data_out <= A[addr];
                end
                default: begin
                
                    Data_out=8'bz;
                end
            endcase
        end
    end
endmodule