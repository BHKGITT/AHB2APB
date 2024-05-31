class apb_xtn extends uvm_sequence_item;

`uvm_object_utils(apb_xtn)


logic [31:0] paddr;
logic [31:0] pwdata;
logic [31:0] prdata;

bit pwrite;
bit penable;
bit[3:0] psel;
bit hresp;

function new(string name="apb_xtn");
super.new(name);
endfunction

 function void do_print(uvm_printer printer);
 printer.print_field("pwrite",pwrite,1,UVM_DEC);
 printer.print_field("paddr",paddr,32,UVM_DEC);
 printer.print_field("prdata",prdata,32,UVM_DEC);
 printer.print_field("pwdata",pwdata,32,UVM_DEC);
 printer.print_field("penable",penable,1,UVM_DEC);
 printer.print_field("psel",psel,4,UVM_DEC);
 printer.print_field("hresp",hresp,1,UVM_DEC);
endfunction

endclass

