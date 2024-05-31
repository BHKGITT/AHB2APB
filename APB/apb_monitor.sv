class apb_mon extends uvm_monitor;

`uvm_component_utils(apb_mon)

virtual apb_if.APB_MON vif;

uvm_analysis_port#(apb_xtn) mon_port;

apb_config apb_cfg;


function new(string name="apb_mon",uvm_component parent);
super.new(name,parent);
mon_port=new("mon_port",this);
endfunction

function void build_phase(uvm_phase phase);
 if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
  `uvm_fatal("apb_mon","get method failed")
 endfunction

function void connect_phase(uvm_phase phase);
 vif=apb_cfg.vif;
endfunction


task run_phase(uvm_phase phase);
 forever
collectdata();
 endtask

task collectdata();

 apb_xtn xtn=apb_xtn::type_id::create("xtn");
  
 while(vif.apb_mon_cb.penable===0) 
 @(vif.apb_mon_cb);

  xtn.paddr=vif.apb_mon_cb.paddr;
 xtn.pwrite=vif.apb_mon_cb.pwrite;
 xtn.psel=vif.apb_mon_cb.psel;
 
 if(xtn.pwrite)
  xtn.pwdata=vif.apb_mon_cb.pwdata;
else
 xtn.prdata=vif.apb_mon_cb.prdata;

repeat(2)
 @(vif.apb_mon_cb);

mon_port.write(xtn);

`uvm_info("apb_monitor",$sformatf("printing from apb_monitor--------------------------- \n %s",xtn.sprint()),UVM_LOW)

endtask

endclass


