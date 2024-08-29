interface ahb_if(input bit clk);

  logic [2:0]hsize;
 bit hwrite;
logic [1:0]htrans;
logic [31:0]haddr;
logic [31:0]hwdata;
logic [2:0]hburst;
logic [31:0]hrdata;
logic [1:0]hresp;
bit hreadyout;
bit hreadyin;
bit rstn;



clocking ahb_drv_cb@(posedge clk);
 default input#1 output#0;

output htrans,hwrite,haddr,hwdata,hsize,hreadyin,rstn;
input  hreadyout,hrdata;

endclocking

clocking ahb_mon_cb@(posedge clk);
 default input#1 output#0;
 
   input   htrans,hwrite,haddr,hwdata,hsize,hreadyin,hrdata,hresp,hreadyout;

endclocking

modport AHB_DRV(clocking ahb_drv_cb);
modport AHB_MON(clocking ahb_mon_cb);

endinterface
