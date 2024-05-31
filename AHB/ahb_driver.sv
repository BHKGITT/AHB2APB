class ahb_drv extends uvm_driver#(ahb_xtn);

`uvm_component_utils(ahb_drv)

virtual ahb_if.AHB_DRV vif;

 ahb_config ahb_cfg;
 
  


function new(string name="ahb_drv",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);

  if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
   `uvm_fatal("ahb_drv","get method failed")
endfunction

function void connect_phase(uvm_phase phase);
 vif=ahb_cfg.vif;
endfunction




task sendtodut(ahb_xtn req);

//req.print();
`uvm_info("ahb_driver",$sformatf("printing from ahb_driver \n %s",req.sprint()),UVM_LOW)

vif.ahb_drv_cb.haddr<=req.haddr;
vif.ahb_drv_cb.hsize<=req.hsize;
vif.ahb_drv_cb.htrans<=req.htrans;
vif.ahb_drv_cb.hwrite<=req.hwrite;
vif.ahb_drv_cb.hreadyin<=1'b1;

@(vif.ahb_drv_cb);

while(vif.ahb_drv_cb.hreadyout===0)
 @(vif.ahb_drv_cb);

if(req.hwrite)
  vif.ahb_drv_cb.hwdata<=req.hwdata;

 else
 req.hrdata<=vif.ahb_drv_cb.hrdata;
endtask


task run_phase(uvm_phase phase);
 vif.ahb_drv_cb.rstn<=1'b0;
 repeat(2)
  @(vif.ahb_drv_cb);
  vif.ahb_drv_cb.rstn<=1'b1;
  @(vif.ahb_drv_cb);

  forever 
begin
seq_item_port.get_next_item(req);
sendtodut(req);
seq_item_port.item_done();
end
endtask

endclass

