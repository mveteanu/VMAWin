uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events;
var pal:virtualpal;
    activ:boolean;
    evw:tevent;
    fer1,fer2:pwindow;
    but1,but2,but3,but4:pbutton;
    inp:pinput;tex:ptext;


procedure bell;begin sound(300);delay(30);nosound;end;

procedure fereastra2;
begin
 new(fer2);
 fer2^.init(300,200,260,190,'Mesajul',1,true);
 fer2^.show;
 new(tex);
 tex^.init(fer2,30,40,200,120,1,inp^.inpmesage);
 tex^.show;
 repeat
  fer2^.move;
  getevent(evw);
 until fer2^.clicked(evw);
 dispose(fer2,done);dispose(tex,done);
end;


begin
 OpenGraph(VESA_800x600x256);
 loadpal('..\win-img\uniform.pal',pal);setallpal(pal);
 setcolor(green);
 MSetTextStyle(7,horizdir,20);outtextxy(120,200,'VMA soft');freefont;

 new(fer1);
 fer1^.init(100,100,260,200,'VMA soft',1,true);
 fer1^.show;


 new(but1);
 but1^.init(fer1,90,50,80,32,'Afiseaza');
 but1^.show;

 new(but2);
 but2^.init(fer1,90,100,80,32,'Disable');
 but2^.show;


 new(inp);
 inp^.init(fer1,40,160,180,1,0);
 inp^.settext('VMA software is the best in graphics and tools programming');
 inp^.show;

 initmouse;showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);
   if but2^.clicked(evw) then if inp^.inpenabled
                    then begin inp^.disable;but2^.retitle('Enable');end
                    else begin inp^.enable;but2^.retitle('Disable');end;
   if inp^.clicked(evw) then begin inp^.edit;if inp^.inpchanged then bell;end;
   if but1^.clicked(evw) then fereastra2;
 until fer1^.clicked(evw);
 dispose(fer1,done);
 dispose(but1,done);
 dispose(but2,done);
 dispose(inp, done);
 CloseGraph;
end.


