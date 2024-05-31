class vseqs extends uvm_sequence#(uvm_sequence_item);

`uvm_object_utils(vseqs)

ahb_seqr h_seqr;
apb_seqr p_seqr;

vseqr vseqrh;

env_config env_cfg;

function new(string name="vseqs");
super.new(name);
endfunction 


task body();

 if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",env_cfg))
   `uvm_fatal("vseqs","get method failed")
  assert($cast(vseqrh,m_sequencer))
    
  if(env_cfg.has_ahb_agent)
   h_seqr=vseqrh.h_seqr;

  if(env_cfg.has_apb_agent)
   p_seqr=vseqrh.p_seqr;
endtask

endclass


class non_seqs1 extends vseqs;

`uvm_object_utils(non_seqs1)

non_seqs s1;

function new(string name="non_seqs1");
super.new(name);
endfunction 



task body();
super.body();
 s1=non_seqs::type_id::create("s1");

//fork
s1.start(h_seqr);
//join

endtask

endclass

class unspecified_seqs1 extends vseqs;

`uvm_object_utils(unspecified_seqs1)

unspecified_seqs s1;

function new(string name="unspecified_seqs1");
super.new(name);
endfunction 


task body();

super.body();

 s1=unspecified_seqs::type_id::create("s1");

fork
s1.start(h_seqr);
join

endtask

endclass


class wrap4_seqs1 extends vseqs;

`uvm_object_utils(wrap4_seqs1)

wrap4_seqs s1;

function new(string name="wrap4_seqs1");
super.new(name);
endfunction 



task body();

super.body();

 s1=wrap4_seqs::type_id::create("s1");

//fork
s1.start(h_seqr);
//join

endtask

endclass


class inc4_seqs1 extends vseqs;

`uvm_object_utils(inc4_seqs1)

inc4_seqs s1;

function new(string name="inc4_seqs1");
super.new(name);
endfunction 



task body();
super.body();

 s1=inc4_seqs::type_id::create("s1");

fork
s1.start(h_seqr);
join

endtask

endclass


class wrap8_seqs1 extends vseqs;

`uvm_object_utils(wrap8_seqs1)

wrap8_seqs s1;

function new(string name="wrap8_seqs1");
super.new(name);
endfunction 



task body();
super.body();

 s1=wrap8_seqs::type_id::create("s1");

fork
s1.start(h_seqr);
join

endtask

endclass



class inc8_seqs1 extends vseqs;

`uvm_object_utils(inc8_seqs1)

inc8_seqs s1;

function new(string name="inc8_seqs1");
super.new(name);
endfunction 


task body();
super.body();

 s1=inc8_seqs::type_id::create("s1");

fork
s1.start(h_seqr);
join

endtask

endclass



class wrap16_seqs1 extends vseqs;

`uvm_object_utils(wrap16_seqs1)

wrap16_seqs s1;

function new(string name="wrap16_seqs1");
super.new(name);
endfunction 



task body();
super.body();

 s1=wrap16_seqs::type_id::create("s1");

//fork

s1.start(h_seqr);
//join

endtask

endclass


class inc16_seqs1 extends vseqs;

`uvm_object_utils(inc16_seqs1)

inc16_seqs s1;

function new(string name="inc16_seqs1");
super.new(name);
endfunction 



task body();
super.body();

 s1=inc16_seqs::type_id::create("s1");

fork
s1.start(h_seqr);
join

endtask

endclass







              




