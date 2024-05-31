class ahb_agent_top extends uvm_env;

`uvm_component_utils(ahb_agent_top)

ahb_agent ahb_agt;
env_config env_cfg;

function new(string name="ahb_agent_top",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
ahb_agt=ahb_agent::type_id::create("ahb_agt",this);

if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
  `uvm_fatal("ahb_agent_top","get methoed failed")

uvm_config_db#(ahb_config)::set(this,"ahb_agt*","ahb_config",env_cfg.ahb_cfg);

super.build_phase(phase);
endfunction


endclass

