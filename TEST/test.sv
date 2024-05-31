class test extends uvm_test;

`uvm_component_utils(test)

env envh;
env_config env_cfg;


bit has_apb_agent=1;
bit has_ahb_agent=1;
bit has_scoreboard=1;

bit has_vsequencer=1;



ahb_config ahb_cfg;
apb_config apb_cfg;




function new(string name="test",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
envh=env::type_id::create("envh",this);
env_cfg=env_config::type_id::create("env_cfg");
 


if(has_ahb_agent)
 begin
   ahb_cfg=ahb_config::type_id::create("ahb_cfg");
if(!uvm_config_db#(virtual ahb_if)::get(this,"","ahb_if",ahb_cfg.vif))
 `uvm_fatal("test","get method failed")
  ahb_cfg.is_active=UVM_ACTIVE;
  env_cfg.ahb_cfg=ahb_cfg;
end


if(has_apb_agent)
 begin
    apb_cfg=apb_config::type_id::create("apb_cfg");
if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_cfg.vif))
  `uvm_fatal("apb_test","get method failed")
    apb_cfg.is_active=UVM_ACTIVE;
   env_cfg.apb_cfg=apb_cfg;
end




uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);


env_cfg.has_apb_agent=has_apb_agent;
env_cfg.has_ahb_agent=has_ahb_agent;
env_cfg.has_scoreboard=has_scoreboard;
env_cfg.has_vsequencer=has_vsequencer;


//super.build_phase(phase);
endfunction


function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction


endclass


class non_seqs_test extends test;

`uvm_component_utils(non_seqs_test)


non_seqs1 s1;

function new(string name="non_seqs_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=non_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#30;
phase.drop_objection(this);
endtask

endclass


class unspecified_test extends test;

`uvm_component_utils(unspecified_test)


unspecified_seqs1 s1;

function new(string name="unspecified_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=unspecified_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#30;
phase.drop_objection(this);
endtask

endclass





class wrap4_test extends test;

`uvm_component_utils(wrap4_test)


wrap4_seqs1 s1;

function new(string name="wrap4_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=wrap4_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#130;
phase.drop_objection(this);
endtask

endclass


class inc4_test extends test;

`uvm_component_utils(inc4_test)


inc4_seqs1 s1;

function new(string name="inc4_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=inc4_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#130;
phase.drop_objection(this);
endtask

endclass


class wrap8_test extends test;

`uvm_component_utils(wrap8_test)


wrap8_seqs1 s1;

function new(string name="wrap8_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=wrap8_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#130;
phase.drop_objection(this);
endtask

endclass


class inc8_test extends test;

`uvm_component_utils(inc8_test)


inc8_seqs1 s1;

function new(string name="inc8_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=inc8_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#130;
phase.drop_objection(this);
endtask

endclass



class wrap16_test extends test;

`uvm_component_utils(wrap16_test)


wrap16_seqs1 s1;

function new(string name="wrap16_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=wrap16_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#130;
phase.drop_objection(this);
endtask

endclass

class inc16_test extends test;

`uvm_component_utils(inc16_test)

inc16_seqs1 s1;

function new(string name="inc16_test",uvm_component parent);
super.new(name,parent);
endfunction


task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=inc16_seqs1::type_id::create("s1");
s1.start(envh.vseqrh);
#130;
phase.drop_objection(this);
endtask

endclass

