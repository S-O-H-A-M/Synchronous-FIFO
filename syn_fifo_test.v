`include "syn_fifo.v"
module syn_fifo_test;

//Inputs
reg clk,rst,we,re;
reg [3:0] data;

//Outputs
wire [3:0] read_data;
//Instatntiate the Unit Under Test(UUT)
syn_fifo uut(
    .clk(clk),
    .rst(rst),
    .we(we),
    .re(re),
    .data(data),
    .read_data(read_data)
);
always #30 clk=~clk;

initial begin
    $dumpfile("syn_fifo_test.vcd");
    $dumpvars(0,syn_fifo_test);
    //Initialize Inputs
    clk=1;rst=1;we=0;re=0;data=0;
    //Wait for 100ns for global reset to finish
    #60;we=1;data='d7;rst=0;
    //#20;we=0;re=1;rst=0;
    
    //Add stimulus here
    #60;we=1;data='d1;re=0;
    #60;we=1;data='d2;
    #60;we=1;data='d3;
    #60;we=1;data='d6;
    #60;we=1;data='d5;
    #60;we=1;data='d4;
    #60;we=1;data='d7;

    #60;re=1;we=0;
    #60;
    $finish;
end
endmodule
