class ahb_xtn extends uvm_sequence_item;

`uvm_object_utils(ahb_xtn)

rand logic [2:0]hsize;
rand bit hwrite;
rand logic [1:0]htrans;
rand logic [31:0]haddr;
rand logic [31:0]hwdata;
rand logic [2:0]hburst;

 logic [31:0]hrdata;

rand logic [9:0]length;
 bit hreadyin;
 bit hreadyout;

constraint hsiz {hsize inside{[0:2]};}

constraint hadd{ if(hsize==1)
      		   haddr%2==0;
		if(hsize==2)
		  haddr%4==0;}

constraint hadd1{soft haddr inside {[32'h 8000_0000 : 32'h 0000_03FF],
			       	[32'h 8400_0000 : 32'h 0000_03FF],
				[32'h 8800_0000 : 32'h 0000_03FF],
				[32'h 8C00_0000 : 32'h 0000_03FF]};}


function new(string name="ahb_xtn");
super.new(name);
endfunction


function void do_print(uvm_printer printer);
 printer.print_field("haddr",haddr,32,UVM_DEC);
 printer.print_field("hwdata",hwdata,32,UVM_DEC);
 printer.print_field("hburst",hburst,3,UVM_DEC);
 printer.print_field("htrans",htrans,2,UVM_DEC);
 printer.print_field("hwrite",hwrite,1,UVM_DEC);
 printer.print_field("hsize",hsize,3,UVM_DEC);
  printer.print_field("hrdata",hrdata,32,UVM_DEC);
 endfunction
endclass

