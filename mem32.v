`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2024 11:38:34
// Design Name: 
// Module Name: mem32
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


module mem32 (
    input Clk,                
    input rst,              
    input wr,         
    input rd,            
    input [3:0] in_add,      
    input [31:0] Data_in_32,  
    output reg [31:0] Data_out_32,  
    output reg valid
);
    reg [7:0] A [0:15];  

    always @(posedge Clk or posedge rst) begin
        if (rst) begin
      
            Data_out_32 <= 32'b0;
            valid <= 0;
        end else begin
            case ({wr, rd}) 
                2'b10: begin
                    
                    if (in_add <= 12) begin  
                        A[in_add]     <= Data_in_32[7:0];    
                        A[in_add + 1] <= Data_in_32[15:8];   
                        A[in_add + 2] <= Data_in_32[23:16];  
                        A[in_add + 3] <= Data_in_32[31:24];  
                        valid <= 0;
                    end
                end
                2'b01: begin
                    
                    if (in_add <= 12) begin  
                        Data_out_32[7:0]    <= A[in_add];      
                        Data_out_32[15:8]   <= A[in_add + 1];  
                        Data_out_32[23:16]  <= A[in_add + 2];  
                        Data_out_32[31:24]  <= A[in_add + 3]; 
                        valid <= 1; 
                    end else begin
                        Data_out_32 <= 32'bz; 
                        valid <= 0; 
                    end
                end
                default: begin
                    Data_out_32 <= 32'bz;  
                    valid <= 0;
                end
            endcase
        end
    end
endmodule


