uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events;
var pal:virtualpal;
    activ:boolean;
    evw:tevent;
    fer1,fer2:pwindow;
    but1,but2,but3,but4:pbutton;
    inp:pinput;


procedure bell;begin sound(300);delay(30);nosound;end;

begin
 OpenGraph(VESA_800x600x256);
 loadpal('..\win-img\uniform.pal',pal);setallpal(pal);
 setcolor(green);
 MSetTextStyle(7,horizdir,20);outtextxy(120,200,'VMA soft');freefont;

 new(fer1);
 fer1^.init(100,100,260,200,'VMA soft',1,true);
 fer1^.setarea(0,0,getmaxx div 2,getmaxy);
 fer1^.show;

 new(fer2);
 fer2^.init(400,300,160,180,'Exit panel',1,true);
 fer2^.setarea(getmaxx div 2+1,0,getmaxx,getmaxy);
 fer2^.show;activ:=true;

 new(but1);
 but1^.init(fer1,90,50,80,32,'Enable');
 but1^.show;

 new(but2);
 but2^.init(fer1,90,100,80,32,'Disable');
 but2^.show;

 new(but3);
 but3^.init(fer2,40,50,80,32,'Close');
 but3^.show;

 new(but4);
 but4^.init(fer2,40,100,80,32,'Exit');
 but4^.show;

 new(inp);
 inp^.init(fer1,40,160,180,1,0);
 inp^.settext('VMA software is the best in tools programming');
 inp^.show;

 initmouse;showmouse;
 repeat
   fer1^.move;
   if activ then fer2^.move;
   GetEvent(evw);
   if but1^.clicked(evw) then inp^.enable;
   if but2^.clicked(evw) then inp^.disable;
   if inp^.clicked(evw) then begin inp^.edit;if inp^.inpchanged then bell;end;
   if activ then
    begin
     if but4^.clicked(evw) then break;
     if but3^.clicked(evw)or fer2^.clicked(evw) then
               begin
                 activ:=false;
                 dispose(fer2,done);dispose(but3,done);dispose(but4,done);
                 fer1^.setarea(0,0,getmaxx,getmaxy);
               end;
    end;
 until fer1^.clicked(evw);
 dispose(fer1,done);dispose(but1,done);dispose(but2,done);dispose(inp,done);
 if activ then begin dispose(fer2,done);dispose(but3,done);dispose(but4,done);end;
 CloseGraph;
end.


