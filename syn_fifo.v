module syn_fifo(clk,rst,we,re,data,read_data);

parameter pointer_size='d3,depth='d8,width='d4;

reg [pointer_size-1:0] wp,rp; 
input clk,rst,we,re;
reg[width-1:0] fifo[depth-1:0];
input[width-1:0] data;
integer i;
output reg [width-1:0] read_data;

always @(posedge clk)
begin
    
    if(rst) 
    begin
        for(i=0;i<=depth-1;i=i+1)
        fifo[i]='d0;
        wp='d0;
        rp='d0;
    end
    else if(we)
    begin
        if(wp==depth-1 && rp=='d0)
        begin
            fifo[wp]=data;
            wp=0; 
            $display("fifo is full");
        end
        else
        begin
            fifo[wp]=data;
            wp=wp+1;
        end
    end
    else if(re)
    begin
        if(rp==depth-1)
        begin
            $display("fifo is empty");
            read_data=fifo[rp];
            fifo[rp]='d0;
            rp=0;
        end
        else
        begin
            read_data=fifo[rp];
            fifo[rp]='d0; 
            rp=rp+1;
        end
    end
    else
    begin
        wp=wp;
        rp=rp;
        $display("No Operation");
    end
end

endmodule
