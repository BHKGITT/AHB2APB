class env_config extends uvm_object;
`uvm_object_utils(env_config)

bit has_ahb_agent=1;
bit has_apb_agent=1;
bit has_scoreboard=1;

bit has_vsequencer=1;



ahb_config ahb_cfg;
apb_config apb_cfg;


function new (string name="env_config");
super.new(name);
endfunction

endclass

