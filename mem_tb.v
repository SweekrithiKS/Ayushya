`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2024 12:30:22
// Design Name: 
// Module Name: mem_tb
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
module mem_tb();

    reg Clk;              
    reg rst;            
    reg wr;          
    reg rd;          
    reg [3:0] addr;     
    reg [7:0] Data_in;      


    wire [7:0] Data_out;   
    mem uut (
        .Clk(Clk), 
        .rst(rst), 
        .wr(wr), 
        .rd(rd), 
        .addr(addr), 
        .Data_in(Data_in), 
        .Data_out(Data_out)
    );

  
    always #5 Clk = ~Clk;

    initial begin
     
        Clk = 0;
        rst = 0;
        wr = 0;
        rd = 0;
        addr = 0;
        Data_in = 0;
        
        $display("Applying reset...");
        rst = 1;
        #10 rst = 0;  

        $display("Test 1: Writing 8'hAA to address 0");
        addr = 4'b0000;   
        Data_in = 8'hAA;  
        wr = 1;           
        rd = 0;           
        #10 wr = 0;       

        $display("Reading from address 0");
        rd = 1;           
        #10 $display("Data at address 0: %h", Data_out); 
        rd = 0;           

        
        $display("Test 2: Writing 8'hBB to address 1");
        addr = 4'b0001;   
        Data_in = 8'hBB;  
        wr = 1;          
        rd = 0;           
        #10 wr = 0;       

        $display("Reading from address 1");
        rd = 1;           
        #10 $display("Data at address 1: %h", Data_out); 
        rd = 0;           

        $display("Test 3: Writing 8'hCC to address 2 (write priority test)");
        addr = 4'b0010;   
        Data_in = 8'hCC;  
        wr = 1;           
        rd = 1;           
        #10 wr = 0;       
        
        rd = 0;          
        $display("Reading from address 2");
        rd = 1;           
        #10 $display("Data at address 2: %h", Data_out);
        rd = 0;          

        $display("Test completed.");
        $stop;
    end

endmodule

