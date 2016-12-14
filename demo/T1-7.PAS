uses crt,appmcga,graph,vesadrv,mouse,obj,obj3,events,kerets;
const iesire:boolean=false;
var pal:virtualpal;
    evw:tevent;
    fer1:pwindow;
    but1,but2,but3,but4,but5:pos2button;


Function  TestIesire:boolean;
var fer1:PBorWindow2B;
    rasp:byte;
begin
 new(fer1,init(180,120,1,'Da','Nu','Mesaj','Dori€i s† p†r†si€i acest program ?'));
 fer1^.setattr(10,1,blue);
 rasp:=fer1^.run;
 dispose(fer1,done);
 TestIesire:=false;
 If rasp=1 then TestIesire:=true;
end;

Procedure But_Run;
var fe1:PBor2Window1B;
begin
 new(fe1,init(180,120,2,1,'Mesaj 1','Nu ave€i ce rula !'));
 fe1^.setattr(10,1,blue);
 fe1^.run;
 dispose(fe1,done);
end;

begin
 {OpenGraph(VGA_640x480x16);}
 OpenGraph(VESA_640x480x256);
 Setuniformpal;
 new(fer1,init(0,0,getmaxx,getmaxy,'VMA soft',2,false));
 setfillstyle(solidfill,lightgray);
 Panou3D(0,0,getmaxx,21);
 new(but1,init(fer1,15,2,50,16,'File',4));
 new(but2,init(fer1,85,2,50,16,'Edit',3));
 new(but3,init(fer1,155,2,60,16,'Search',3));
 new(but4,init(fer1,225,2,50,16,'Run',3));
 new(but5,init(fer1,295,2,50,16,'Exit',3));
 but1^.show;but2^.show;but3^.show;but4^.show;but5^.show;
 initmouse;showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);
   but1^.clicked(evw);
   but2^.clicked(evw);
   but3^.clicked(evw);
   if but4^.clicked(evw) then But_Run;
   if but5^.clicked(evw) then iesire:=testiesire;
 until iesire;
 dispose(fer1,done);
 dispose(but1,done);
 dispose(but2,done);
 dispose(but3,done);
 dispose(but4,done);
 dispose(but5,done);
 CloseGraph;
end.


