uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events;
var pal:virtualpal;
    activ:boolean;
    evw:tevent;
    fer1:pwindow;inp:pinput;
    but1,but2:pbutton;

procedure fereastra2;
var fer2:pwindow;
    but3,but4,but5,but6,but7,but8:pbutton;
    tex:ptext;chk:pchkbox;
begin
 new(fer2);fer2^.init(300,200,320,190,'Message',1,true);fer2^.show;
 new(tex);tex^.init(fer2,90,40,205,100,1,inp^.inpmesage);tex^.show;
 new(chk);chk^.init(fer2,20,155,0,true,'Wrap');chk^.show;
 new(but3);but3^.init(fer2,20,40,55,20,'Top');but3^.show;
 new(but4);but4^.init(fer2,20,80,55,20,'Center');but4^.show;
 new(but5);but5^.init(fer2,20,120,55,20,'Bottom');but5^.show;
 new(but6);but6^.init(fer2,90,155,55,20,'Left');but6^.show;
 new(but7);but7^.init(fer2,165,155,55,20,'Center');but7^.show;
 new(but8);but8^.init(fer2,240,155,55,20,'Right');but8^.show;
 repeat
  fer2^.move;
  getevent(evw);
  if but3^.clicked(evw) then begin tex^.SetJustify(tex^.texhor,toptext,chk^.chkchecked);tex^.show;end;
  if but4^.clicked(evw) then begin tex^.SetJustify(tex^.texhor,centertext,chk^.chkchecked);tex^.show;end;
  if but5^.clicked(evw) then begin tex^.SetJustify(tex^.texhor,bottomtext,chk^.chkchecked);tex^.show;end;
  if but6^.clicked(evw) then begin tex^.SetJustify(lefttext,tex^.texver,chk^.chkchecked);tex^.show;end;
  if but7^.clicked(evw) then begin tex^.SetJustify(centertext,tex^.texver,chk^.chkchecked);tex^.show;end;
  if but8^.clicked(evw) then begin tex^.SetJustify(righttext,tex^.texver,chk^.chkchecked);tex^.show;end;
  if chk^.clicked(evw) then begin chk^.toggle;tex^.SetJustify(tex^.texhor,tex^.texver,chk^.chkchecked);tex^.show;end;
 until fer2^.clicked(evw);
 dispose(fer2,done);dispose(tex,done);dispose(chk,done);
 dispose(but3,done);dispose(but4,done);dispose(but5,done);
 dispose(but6,done);dispose(but7,done);dispose(but8,done);
end;


begin
 OpenGraph(VESA_800x600x256);
 loadpal('..\win-img\uniform.pal',pal);setallpal(pal);
 setcolor(green);
 MSetTextStyle(7,horizdir,20);outtextxy(120,200,'VMA soft');freefont;

 new(fer1);fer1^.init(100,100,260,200,'VMA soft',1,true);fer1^.show;
 new(but1);but1^.init(fer1,90,50,80,32,'Display');but1^.show;
 new(but2);but2^.init(fer1,90,100,80,32,'Disable');but2^.show;

 new(inp);inp^.init(fer1,40,160,180,1,0);
 inp^.settext('VMA software is the best in graphics and tools programming');
 inp^.show;

 initmouse;showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);
   if but2^.clicked(evw) then if inp^.inpenabled
                    then begin inp^.disable;but2^.retitle('Enable');end
                    else begin inp^.enable;but2^.retitle('Disable');end;
   if inp^.clicked(evw) then inp^.edit;
   if but1^.clicked(evw) then fereastra2;
 until fer1^.clicked(evw);
 dispose(fer1,done);dispose(but1,done);
 dispose(but2,done);dispose(inp,done);
 CloseGraph;
end.


