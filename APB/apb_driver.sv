class apb_drv extends uvm_driver#(apb_xtn);

`uvm_component_utils(apb_drv)

virtual apb_if.APB_DRV vif;

apb_config apb_cfg;

function new(string name="apb_drv",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
  `uvm_fatal("apb_drv","get method failed")
endfunction

function void connect_phase(uvm_phase phase);
 vif=apb_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
forever 
sendtodut();

endtask

task sendtodut();
 apb_xtn xtn;
 xtn=apb_xtn::type_id::create("xtn");
while(vif.apb_drv_cb.psel===0)
 @(vif.apb_drv_cb);

 if(vif.apb_drv_cb.pwrite==0)
  vif.apb_drv_cb.prdata<=$urandom;

// repeat(2)
 @(vif.apb_drv_cb);

`uvm_info("apb_driver",$sformatf("printing from apb_driver %s\n ",xtn.sprint()),UVM_LOW)

endtask

endclass

