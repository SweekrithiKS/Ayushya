`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2024 12:10:59
// Design Name: 
// Module Name: mem32_tb
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

module tb_mem32;

    reg Clk;
    reg rst;
    reg wr;
    reg rd;
    reg [3:0] in_add;
    reg [31:0] Data_in_32;

    wire [31:0] Data_out_32;
    wire valid;  

    
    mem32 uut (
        .Clk(Clk), 
        .rst(rst), 
        .wr(wr), 
        .rd(rd), 
        .in_add(in_add), 
        .Data_in_32(Data_in_32), 
        .Data_out_32(Data_out_32),
        .valid(valid)  
    );

 
    always #5 Clk = ~Clk;  

    initial begin

        Clk = 0;
        rst = 1;        
        wr = 0;
        rd = 0;
        in_add = 4'b0;
        Data_in_32 = 32'b0;

        #10;
        rst = 0;        
       
        wr = 1;
        rd = 0;
        in_add = 4'b0000;
        Data_in_32 = 32'hDEADBEEF;  
        #10;

       
        in_add = 4'b0100;
        Data_in_32 = 32'hCAFEBABE;  

       
        in_add = 4'b1100;
        Data_in_32 = 32'h12345678;
        #10;

      
        wr = 0;
        rd = 1;
        in_add = 4'b0000;
        #10;
        $display("Read Data at Address 0: %h (Expected: DEADBEEF), Valid: %b", Data_out_32, valid);

     
        in_add = 4'b0100;
        #10;
        $display("Read Data at Address 4: %h (Expected: CAFEBABE), Valid: %b", Data_out_32, valid);

       
        in_add = 4'b1100;
        #10;
        $display("Read Data at Address 12: %h (Expected: 12345678), Valid: %b", Data_out_32, valid);

       
        in_add = 4'b1110;
        #10;
        $display("Read Data at Address 14: %h (Expected: high impedance), Valid: %b", Data_out_32, valid);

     
        $finish;
    end

endmodule
