class apb_agent extends uvm_agent;

`uvm_component_utils(apb_agent)

apb_seqr seqr;
apb_drv drv;
apb_mon mon;

apb_config apb_cfg;

function new(string name="apb_agent",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);

mon=apb_mon::type_id::create("mon",this);

if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
 `uvm_fatal("apb_agent","get method failed")

if(apb_cfg.is_active)
begin
drv=apb_drv::type_id::create("drv",this);
seqr=apb_seqr::type_id::create("seqr",this);
end
endfunction

function void connect_phase(uvm_phase phase);
drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass

