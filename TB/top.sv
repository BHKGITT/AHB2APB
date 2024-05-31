module top;
import pkg::*;
import uvm_pkg::*;

bit clk;
always #10 clk=~clk;

ahb_if in0(clk);
apb_if in1(clk);

//instiation of rtl

 rtl_top A1(.Hclk(clk),.Hresetn(in0.rstn),.Hsize(in0.hsize),.Hreadyin(in0.hreadyin),.Hwdata(in0.hwdata),.Haddr(in0.haddr),.Hwrite(in0.hwrite),.Hrdata(in0.hrdata),.Hresp(in0.hresp),.Hreadyout(in0.hreadyout),.Htrans(in0.htrans),.Prdata(in1.prdata),.Pselx(in1.psel),.Pwrite(in1.pwrite),.Penable(in1.penable),.Paddr(in1.paddr),.Pwdata(in1.pwdata));

initial
begin
 `ifdef VCS
   $fsdbDumpvars(0,top);
  `endif;
    uvm_config_db#(virtual ahb_if)::set(null,"*","ahb_if",in0);
    uvm_config_db#(virtual apb_if)::set(null,"*","apb_if",in1);
	run_test("");

end

endmodule

