class ahb_agent extends uvm_agent;

`uvm_component_utils(ahb_agent)

ahb_seqr seqr;
ahb_drv drv;
ahb_mon mon;

ahb_config ahb_cfg;

function new(string name="ahb_agent",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);

mon=ahb_mon::type_id::create("mon",this);

if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
 `uvm_fatal("ahb_agent","get method failed")

if(ahb_cfg.is_active)
begin
drv=ahb_drv::type_id::create("drv",this);
seqr=ahb_seqr::type_id::create("seqr",this);
end

endfunction

function void connect_phase(uvm_phase phase);
drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass

