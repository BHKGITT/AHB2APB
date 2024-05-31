class sb extends uvm_scoreboard;

`uvm_component_utils(sb)

ahb_xtn xtn;
apb_xtn xtn1;

uvm_tlm_analysis_fifo#(ahb_xtn)ahb_fifo;
uvm_tlm_analysis_fifo#(apb_xtn)apb_fifo;

covergroup cpg;
  hsize1: coverpoint xtn.hsize{ bins b1={0,1,2};}
  
  htrans1:coverpoint xtn.htrans{ bins b2={2,3};}
 
  hadd1: coverpoint xtn.haddr{ bins b1={[32'h 8000_0000 : 32'h 0000_03FF]};
			      bins b2={[32'h 8400_0000 : 32'h 0000_03FF]};
			      bins b3={[32'h 8800_0000 : 32'h 0000_03FF]};
                              bins b4={[32'h 8C00_0000 : 32'h 0000_03FF]};}
 

  hwrite:coverpoint xtn.hwrite{ bins b1={1,0};}

 // crossAB: cross hsize1,htrans1,hadd1,hwrite;


 endgroup

function new(string name="sb",uvm_component parent);
super.new(name,parent);

cpg=new();

apb_fifo=new("apb_fifo",this);
ahb_fifo=new("ahb_fifo",this);
endfunction
  
task run_phase(uvm_phase phase);
 forever
  begin
 fork
   ahb_fifo.get(xtn);
   apb_fifo.get(xtn1);
join
  check1(xtn,xtn1);
  cpg.sample;

  end
endtask






task check1(ahb_xtn xtn,apb_xtn xtn1);
 if(xtn.hwrite)
   begin
     if(xtn.hsize==0)
      begin
     if(xtn.haddr[1:0]==2'b00)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata[7:0],xtn1.pwdata);
    else if(xtn.haddr[1:0]==2'b01)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata[15:8],xtn1.pwdata);
    else if(xtn.haddr[1:0]==2'b10)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata[23:16],xtn1.pwdata);
    else if(xtn.haddr[1:0]==2'b11)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata[31:24],xtn1.pwdata);
    end


 else if(xtn.hsize==1)
      begin
     if(xtn.haddr[1:0]==2'b00)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata[15:0],xtn1.pwdata);
     else if(xtn.haddr[1:0]==2'b10)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata[31:16],xtn1.pwdata);
     end


else if(xtn.hsize==2)
   begin
    if(xtn.haddr[1:0]==0)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata,xtn1.pwdata);
    end
  end

else 
begin
if(xtn.hsize==0)
      begin
     if(xtn.haddr[1:0]==2'b00)
      compare1(xtn.haddr,xtn1.paddr,xtn.hrdata[7:0],xtn1.prdata);
     else if(xtn.haddr[1:0]==2'b01)
      compare1(xtn.haddr,xtn1.paddr,xtn.hrdata[15:8],xtn1.prdata);
      else if(xtn.haddr[1:0]==2'b10)
      compare1(xtn.haddr,xtn1.paddr,xtn.hrdata[23:16],xtn1.prdata);
      else if(xtn.haddr[1:0]==2'b11)
      compare1(xtn.haddr,xtn1.paddr,xtn.hrdata[31:24],xtn1.prdata);
      end

 else if(xtn.hsize==1)
      begin
     if(xtn.haddr[1:0]==2'b00)
      compare1(xtn.haddr,xtn1.paddr,xtn.hrdata[15:0],xtn1.prdata);
     else if(xtn.haddr[1:0]==2'b10)
      compare1(xtn.haddr,xtn1.paddr,xtn.hrdata[31:16],xtn1.prdata);
    end

else if(xtn.hsize==2)
   begin
    if(xtn.haddr[1:0]==0)
      compare1(xtn.haddr,xtn1.paddr,xtn.hwdata,xtn1.prdata);
   end
 end
endtask


task compare1(input int haddr,paddr,hdata,pdata);
 
if(haddr==paddr)
 `uvm_info(get_full_name(),"address matched",UVM_LOW)
else 
 `uvm_info(get_full_name(),"address mis matched",UVM_LOW)

  if(hdata==pdata)
  `uvm_info(get_full_name(),"data matched",UVM_LOW)

else 
 `uvm_info(get_full_name(),"data mismatched",UVM_LOW)
endtask
endclass

