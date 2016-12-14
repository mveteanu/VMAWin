
uses appbmp,appmcga,graph,vesadrv,bk,mouse,obj,events,clock,xms,fileos;

var pal:virtualpal;han1:word;
    Ceas:PClock;

begin
 writeln('Please wait ...');
 if not xmsinstalled then begin writeln('Eroare XMS');exit;end;
 allocextmem(512,han1);
   if xmserror>0 then begin writeln('Insuficienta memorie extinsa sau sunteti in modul protejat');exit;end;
 LoadBMPinXMS('..\win-img\tigru2.bmp',han1,0,pal);

 OpenGraph(VESA_800x600x256);
 LoadVisualPal('..\win-img\uniform.pal');
 VideoScreenOff;RestoreImage2(0,0,han1,0,pal);VideoScreenOn;
 FreeExtMem(han1);

 Initmouse;Showmouse;
 UseFile('..\win-img\textures.lib');
 new(Ceas,Init(100,100,250,220,3,lightblue,'u5.bmp','Clock'));
 Ceas^.SetClock(blue);
 Ceas^.Run;
 dispose(Ceas,Done);

 CloseGraph;
end.


