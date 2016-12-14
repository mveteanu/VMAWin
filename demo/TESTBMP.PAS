uses appbmp,vesadrv,graph,appmcga,xms;
var han1:word;ofs,ofs2:longint;
    pal:virtualpal;

begin
  if not xmsinstalled then begin writeln('Eroare XMS');exit;end;
  allocextmem(512,han1);
   if xmserror>0 then begin writeln('Insuficienta memorie extinsa sau sunteti in modul protejat');exit;end;
  appmcga.setcolor(4);print(10,14,'Image is loading in extended memory');
  LoadBMPinXMS('..\win-img\tigru.bmp',han1,0,pal);

 opengraph(vesa_800x600x256);setallpal(pal);
 RestoreImage(0,0,han1,0);
 FreeExtMem(han1);

 readln;
 closegraph;
end.

