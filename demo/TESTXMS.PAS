uses appmcga,bk,graph,vesadrv,crt,xms,fileos;
var han1:word;ofs:longint;
    maxfree,memfree,HLength,FreeHandles:word;
    locked:boolean;
    pal:virtualpal;
    f:integer;


begin
 clrscr;
 if not xmsinstalled then begin writeln('Eroare XMS');exit;end;
 opengraph(vesa_800x600x256);
 UseFile('..\win-img\textures.lib');
 tileunifimage('u1.bmp');getallpal(pal);

  allocextmem(GetImageSize(0,0,799,599),han1);
   if xmserror>0 then begin closegraph;writeln('Eroare XMS');exit;end;
  rectangle(0,0,799,599);
  storeimage(0,0,799,599,han1,0);

  closegraph;
  freeextmeminfo(maxfree,memfree);
  GetHandleInfo(han1,locked,HLength,FreeHandles);
  writeln('Memorie libera         : ',memfree,' KBytes');
  writeln('Blocul maxim           : ',maxfree,' KBytes');
  writeln('Handlerul XMS folosit  : ',han1);
  writeln('Marimea handlerului    : ',HLength,' KBytes');
  writeln('Handlere libere        : ',FreeHandles);
  writeln;
  writeln('Apasati orice tasta pentru a reveni in modul grafic');readkey;
  opengraph(vesa_800x600x256);setallpal(pal);

  restoreimage(0,0,han1,0);
  freeextmem(han1);

  readln;
  CloseGraph;
end.

