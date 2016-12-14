uses appmcga,appbmp,xms,events,obj,vesadrv,graph,mouse;

var w1:pwindow;
    ev:tevent;
    si:PScollImage;
    pal:VirtualPal;
    han:word;
    f:integer;

begin
  if not xmsinstalled then begin writeln('Eroare XMS');exit;end;
  allocextmem(512,han);
  if xmserror>0 then begin writeln('Insuficienta memorie extinsa sau sunteti in modul protejat');exit;end;
  WriteLn('Se incarca imaginea si se aproximeaza culorile......');

  LoadPal('..\win-img\uniform.pal',pal);
  LoadBMPinXMS2('..\win-img\tigru.bmp',han,0,pal);

  OpenGraph(VESA_800x600x256);SetUniformPal;
  SetFillStyle(SolidFill,DarkGray);Bar(0,0,getmaxx,getmaxy);
  setcolor(lightgray);
  for f:=0 to getmaxx do line(f*20,0,f*20,getmaxy);
  for f:=0 to getmaxy do line(0,f*20,getmaxx,f*20);
  setcolor(black);
  for f:=0 to getmaxx do line(f*20+2,0,f*20+2,getmaxy);
  for f:=0 to getmaxy do line(0,f*20+2,getmaxx,f*20+2);

  InitMouse;ShowMouse;

  new(w1,initxms(100,100,520,400,'VMA soft',3,true));w1^.show;
  new(si,Init(w1,20,30,480,340,0,0,han));
  si^.Show;

  repeat
   getevent(ev);
   w1^.move;
   si^.run(ev);
  until w1^.clicked(ev);

  Dispose(w1,Done);
  Dispose(si,Done);

  CloseGraph;
  FreeExtMem(han);
end.

