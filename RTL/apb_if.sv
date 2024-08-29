interface apb_if(input bit clk);

logic [31:0] paddr;
logic [31:0] pwdata;
logic [31:0] prdata;

bit pwrite;
bit penable;
bit [3:0] psel;

clocking apb_drv_cb@(posedge clk);
 default input #1 output #0;
 
 input paddr,pwdata,pwrite,penable,psel;
 output prdata;
endclocking 

 clocking apb_mon_cb@(posedge clk);
 default input #1 output #0;
 
 input prdata,paddr,pwdata,pwrite,penable,psel;
endclocking 

modport APB_DRV(clocking apb_drv_cb);
modport APB_MON(clocking apb_mon_cb);

endinterface
