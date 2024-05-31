class apb_agent_top extends uvm_env;

`uvm_component_utils(apb_agent_top)

apb_agent apb_agt;
env_config env_cfg;

function new(string name="apb_agent_top",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
apb_agt=apb_agent::type_id::create("apb_agt",this);

if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
  `uvm_fatal("apb_agent_top","get methoed failed")

uvm_config_db#(apb_config)::set(this,"apb_agt*","apb_config",env_cfg.apb_cfg);

super.build_phase(phase);
endfunction


endclass


