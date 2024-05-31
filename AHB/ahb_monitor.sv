class ahb_mon extends uvm_monitor;

`uvm_component_utils(ahb_mon)

virtual ahb_if.AHB_MON vif;

ahb_config ahb_cfg;

uvm_analysis_port#(ahb_xtn) mon_port;



function new(string name="ahb_mon",uvm_component parent);
super.new(name,parent);
mon_port=new("mon_port",this);
endfunction


function void build_phase(uvm_phase phase);
 if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
  `uvm_fatal("ahb_mon","get method failed")
 endfunction

function void connect_phase(uvm_phase phase);
 vif=ahb_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
  while(vif.ahb_mon_cb.hreadyout!==1)
    @(vif.ahb_mon_cb);
 forever
   collectdata();
 endtask

task collectdata();
  ahb_xtn xtn;
 xtn=ahb_xtn::type_id::create("xtn");
  
 while(vif.ahb_mon_cb.htrans!==2'b10 && vif.ahb_mon_cb.htrans!==2'b11)
 @(vif.ahb_mon_cb);
  xtn.haddr=vif.ahb_mon_cb.haddr;
  xtn.hsize=vif.ahb_mon_cb.hsize;
  xtn.htrans=vif.ahb_mon_cb.htrans;
  
xtn.hwrite=vif.ahb_mon_cb.hwrite;
 @(vif.ahb_mon_cb);

 while(vif.ahb_mon_cb.hreadyout!==1)
  @(vif.ahb_mon_cb);

if(vif.ahb_mon_cb.hwrite)
  xtn.hwdata=vif.ahb_mon_cb.hwdata;
else
  xtn.hrdata=vif.ahb_mon_cb.hrdata;

mon_port.write(xtn);

`uvm_info("ahb_monitor",$sformatf("printing from ahb_monitor \n %s",xtn.sprint()),UVM_LOW) 

endtask




endclass


