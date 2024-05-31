class vseqr extends uvm_sequencer#(uvm_sequence_item);

`uvm_component_utils(vseqr)

ahb_seqr h_seqr;
apb_seqr p_seqr;

function new(string name="vseqr",uvm_component parent);
super.new(name,parent);
endfunction

endclass

