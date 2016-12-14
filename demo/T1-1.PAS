uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events,Ukbd;
const cont:integer=1;
      mesaj:array[0..3] of string=
      ('Veteanu Marian Adrian',
      'VMA software is the best in tools programming',
      'If you want to be a winner then buy our products',
      'Demonstration');


var pal:virtualpal;
    evw:tevent;
    fer1,fer2:pwindow;
    but1,but2,but3,but4:pbutton;
    inp:pinput;upd:pupdown;
    chk1,chk2:pchkbox;
    rul:pruler;

procedure bell;begin sound(300);delay(30);nosound;end;

begin
 OpenGraph(VESA_800x600x256);
 loadpal('..\win-img\uniform.pal',pal);setallpal(pal);
 setfillstyle(solidfill,darkgray);bar(0,0,getmaxx,getmaxy);

 new(fer1);
 fer1^.init(100,100,310,200,'VMA soft',3,true);
 fer1^.show;

 new(but1);
 but1^.init(fer1,30,50,80,32,'Enable');
 but1^.show;

 new(but2);
 but2^.init(fer1,30,100,80,32,'Disable');
 but2^.show;

 new(inp);
 inp^.init(fer1,30,160,180,1,0);
 inp^.settext(mesaj[1]);
 inp^.show;

 new(chk1);
 chk1^.init(fer1,120,56,0,true,'Enable button');
 chk1^.show;

 new(chk2);
 chk2^.init(fer1,120,106,0,true,'Enable button');
 chk2^.show;

 new(upd);
 upd^.init(fer1,220,150,3);
 upd^.show;

 new(rul);
 rul^.init(fer1,270,55,130,20,1,0,1000,10,100);
 rul^.show;

 initmouse;showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);
   if but1^.clicked(evw) then inp^.enable;
   if but2^.clicked(evw) then inp^.disable;
   if inp^.clicked(evw) then begin inp^.edit;if inp^.inpchanged then bell;end;
   if chk1^.clicked(evw) then begin chk1^.toggle;if chk1^.chkchecked then but1^.enable else but1^.disable;end;
   if chk2^.clicked(evw) then begin chk2^.toggle;if chk2^.chkchecked then but2^.enable else but2^.disable;end;
   if upd^.clicked(evw)=1 then begin inc(cont);if cont=4 then cont:=3;inp^.settext(mesaj[cont]);inp^.show;end;
   if upd^.clicked(evw)=2 then begin dec(cont);if cont=-1 then cont:=0;inp^.settext(mesaj[cont]);inp^.show;end;
   if rul^.clicked(evw) then begin sound(100+rul^.getpos*5);delay(10);nosound;end;
 until (fer1^.clicked(evw)) or (evw.scankey=kbesc);
 dispose(fer1,done);
 dispose(but1,done);
 dispose(but2,done);
 dispose(inp,done);
 dispose(upd,done);
 dispose(chk1,done);
 dispose(chk2,done);
 dispose(rul,done);
 CloseGraph;
end.


