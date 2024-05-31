class env extends uvm_env;
`uvm_component_utils(env)

sb sbh;

apb_agent_top apb_agt_top;
ahb_agent_top ahb_agt_top;

env_config env_cfg;

vseqr vseqrh;


function new(string name="env",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);

if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
  `uvm_fatal("env ","get methoed failed")


if(env_cfg.has_scoreboard)
sbh=sb::type_id::create("sbh",this);

if(env_cfg.has_apb_agent)
apb_agt_top= apb_agent_top::type_id::create("apb_agt_top",this);


if(env_cfg.has_ahb_agent)
ahb_agt_top= ahb_agent_top::type_id::create("ahb_agt_top",this);

if(env_cfg.has_vsequencer)
vseqrh=vseqr::type_id::create("vseqrh",this);
endfunction

function void connect_phase(uvm_phase phase);
  if(env_cfg.has_ahb_agent)
   vseqrh.h_seqr=ahb_agt_top.ahb_agt.seqr;

   if(env_cfg.has_apb_agent)
   vseqrh.p_seqr=apb_agt_top.apb_agt.seqr;
 
 if(env_cfg.has_scoreboard)
begin
  ahb_agt_top.ahb_agt.mon.mon_port.connect(sbh.ahb_fifo.analysis_export);
  apb_agt_top.apb_agt.mon.mon_port.connect(sbh.apb_fifo.analysis_export);
end
  endfunction 

endclass

