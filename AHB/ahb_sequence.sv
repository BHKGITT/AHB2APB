class ahb_seqs extends uvm_sequence#(ahb_xtn);

`uvm_object_utils(ahb_seqs)


 logic [2:0]hsize1;
 bit hwrite1;
 logic [1:0]htrans1;
 logic [31:0]haddr1;
 logic [31:0]hwdata1;
 logic [2:0]hburst1;




function new(string name="ahb_seqs");
super.new(name);
endfunction

endclass


class non_seqs extends ahb_seqs;

  `uvm_object_utils(non_seqs)


function new(string name="non_seqs");
super.new(name);
endfunction

task body();
 req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {hburst==3'b000; htrans==2'b10; hwrite==1'b1;});
    //req.print();
 finish_item(req);
endtask

endclass


class unspecified_seqs extends ahb_seqs;

  `uvm_object_utils(unspecified_seqs)



function new(string name="unspecified_seqs");
super.new(name);
endfunction

task body();
 req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {haddr==haddr%1024+(length*3'b001 <<hsize<=1024);
				hburst==3'b001; htrans==2'b10; hwrite==1;});
 finish_item(req);
endtask
endclass


class wrap4_seqs extends ahb_seqs;

`uvm_object_utils(wrap4_seqs) 

function new(string name="wrap4_seqs");
super.new(name);
endfunction



task body();
begin
 req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {hburst==3'b010; htrans==2'b10; hwrite==1;});
 finish_item(req);
end

hsize1=req.hsize;
haddr1=req.haddr;

for(int i=0;i<3;i++)
begin
 start_item(req);
 if(req.hsize==0)
   assert(req.randomize() with {htrans==2'b11;hburst==3'b010;hwrite==1;hsize==hsize1;haddr=={haddr1[31:2],haddr1[1:0]+1'b1};});

 if(req.hsize==1)
   assert(req.randomize() with {htrans==2'b11;hburst==3'b010;hwrite==1;hsize==hsize1;haddr=={haddr1[31:4],haddr1[2:1]+1'b1,haddr1[0]};});

 if(req.hsize==2)
   assert(req.randomize() with {htrans==2'b11;hburst==3'b010;hwrite==1;hsize==hsize1;haddr=={haddr1[31:4],haddr1[3:2]+1'b1,haddr1[1:0]};});
  finish_item(req);
 haddr1=req.haddr;
end

endtask

endclass



class inc4_seqs extends ahb_seqs;

`uvm_object_utils(inc4_seqs) 

function new(string name="inc4_seqs");
super.new(name);
endfunction


task body();
begin
 req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {hburst==3'b011; htrans==2'b10; hwrite==1;});
 finish_item(req);
end

hsize1=req.hsize;
haddr1=req.haddr;


for(int i=0;i<3;i++)
begin
 start_item(req);
   assert(req.randomize() with {hburst==3'b011;htrans==2'b11;hwrite==1;hsize==hsize1;haddr==haddr1+(3'b001<<hsize);});
   finish_item(req);

   haddr1=req.haddr;
end
endtask

endclass


class wrap8_seqs extends ahb_seqs;

`uvm_object_utils(wrap8_seqs) 

function new(string name="wrap8_seqs");
super.new(name);
endfunction


task body();
begin
 req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {hburst==3'b100; htrans==2'b10; hwrite==1;});
 finish_item(req);
end

hsize1 =req.hsize;
haddr1=req.haddr;


for(int i=0;i<7;i++)
begin
 start_item(req);
  if(req.hsize==0)
    assert(req.randomize() with {htrans==2'b11;hburst==3'b010;hwrite==1;hsize==hsize1;haddr=={haddr1[31:3],haddr1[2:0]+1'b1};});

  if(req.hsize==1)
   assert(req.randomize() with {htrans==2'b11;hburst==3'b010;hwrite==1;hsize==hsize1;haddr=={haddr1[31:4],haddr1[3:1]+1'b1,haddr1[0]};});


  if(req.hsize==2)
    assert(req.randomize() with {htrans==2'b11;hburst==3'b100;hwrite==1;hsize==hsize1;haddr=={haddr1[31:5],haddr1[4:2]+1'b1,haddr[1:0]};});
  finish_item(req);
 haddr1=req.haddr;
end

endtask

endclass


class inc8_seqs extends ahb_seqs;

`uvm_object_utils(inc8_seqs) 

function new(string name="inc8_seqs");
super.new(name);
endfunction

task body();
begin
 req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {hburst==3'b101; htrans==2'b10; hwrite==1;});
 finish_item(req);
end

hsize1 =req.hsize;
haddr1=req.haddr;



for(int i=0;i<7;i++)
begin
 start_item(req);
  assert(req.randomize() with {hburst==3'b101;htrans==2'b11;hwrite==1;hsize==hsize1;haddr==haddr1+(3'b001<<hsize);});
   finish_item(req);
   haddr1=req.haddr;
end

endtask

endclass



class wrap16_seqs extends ahb_seqs;

`uvm_object_utils(wrap16_seqs) 

function new(string name="wrap16_seqs");
super.new(name);
endfunction


task body();
begin
 req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {hburst==3'b110; htrans==2'b10; hwrite==1;});
 finish_item(req);
end

hsize1 =req.hsize;
haddr1=req.haddr;

for(int i=0;i<15;i++)
begin
 start_item(req);
 if(req.hsize==0)
  assert(req.randomize() with {htrans==2'b11;hburst==3'b010;hwrite==1;hsize==hsize1;haddr=={haddr1[31:4],haddr1[3:0]+1'b1};});

 if(req.hsize==1)
   assert(req.randomize() with {htrans==2'b11;hburst==3'b010;hwrite==1;hsize==hsize1;haddr=={haddr1[31:5],haddr1[4:1]+1'b1,haddr1[0]};});

 if(req.hsize==2)
  assert(req.randomize() with {htrans==2'b11;hburst==3'b110;hwrite==1;hsize==hsize1;haddr=={haddr1[31:6],haddr1[5:2]+1'b1,haddr[1:0]};});

  finish_item(req);
 haddr1=req.haddr;
end

endtask

endclass


class inc16_seqs extends ahb_seqs;

`uvm_object_utils(inc16_seqs) 

function new(string name="inc16_seqs");
super.new(name);
endfunction


task body();
 begin
req=ahb_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {hburst==3'b111; htrans==2'b10; hwrite==1;hsize==2;});
 finish_item(req);
end
hsize1 =req.hsize;
haddr1=req.haddr;


for(int i=0;i<15;i++)
begin
 start_item(req);
  assert(req.randomize() with {hburst==3'b111;htrans==2'b11;hwrite==1;hsize==hsize1;haddr==haddr1+(3'b001<<hsize);});
   finish_item(req);
   haddr1=req.haddr;
end
endtask

endclass






