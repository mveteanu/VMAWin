unit Bk;
interface
procedure TileUnifImage ( FileName : string );
procedure TileImage (FileName,PalName:string);
procedure TileImg(x1,y1,x2,y2:integer;poin:pointer);

implementation
uses appmcga,appbmp,graph,vesadrv;

procedure TileUnifImage ( FileName : string );
 var pal:virtualpal;scr:virtualscreen;
     mar:word;p:pointer;
     imlung,imlat,depasire:longint;
     x,y:integer;
begin
 setupvirtual(scr);
 loadbmpfile(0,0,FileName,scr,pal);setallpal(pal);
 imlung:=TestI.H.Width;imlat:=TestI.H.Height;
 depasire:=getmaxx mod imlung;
 mar:=imlung*imlat+16;
 if maxavail<mar then begin
                       closegraph;
                       writeln(' Eroare de executie !');
                       writeln(' Insuficienta memorie pentru a rula acest program !');
                       halt(2);
                      end
                    else getmem(p,mar);
 getframe(scr,0,0,imlung-1,imlat-1,p);
 y:=0;
 repeat
  x:=0;
  repeat
   putimage(x,y,p^,copyput);
   inc(x,imlung);
  until x>getmaxx;
  inc(y,imlat);
 until y>getmaxy;
 freemem(p,mar);
 mar:=(depasire+1)*imlat+16;
 if maxavail<mar then begin
                       closegraph;
                       writeln(' Eroare de executie !');
                       writeln(' Insuficienta memorie pentru a rula acest program !');
                       halt(2);
                      end
                    else getmem(p,mar);
 getframe(scr,0,0,depasire,imlat-1,p);
 y:=0;
 repeat
  putimage(getmaxx-depasire,y,p^,copyput);
  inc(y,imlat);
 until y>getmaxy;
 freemem(p,mar);
shutdownvirtual(scr);
end;

procedure TileImage;
 var pal1,pal2:virtualpal;
     scr1,scr2:virtualscreen;
     mar:word;p:pointer;
     imlung,imlat,depasire:longint;
     x,y:integer;
begin
 setupvirtual(scr2);
 setupvirtual(scr1);
 loadbmpfile(0,0,FileName,scr1,pal1);
 loadpal(palname,pal2);setallpal(pal2);
 changescreenpal(scr1,pal1,scr2,pal2);
 shutdownvirtual(scr1);
 imlung:=TestI.H.Width;imlat:=TestI.H.Height;
 depasire:=getmaxx mod imlung;
 mar:=imlung*imlat+16;
 if maxavail<mar then begin
                       closegraph;
                       writeln(' Eroare de executie !');
                       writeln(' Insuficienta memorie pentru a rula acest program !');
                       halt(2);
                      end
                    else getmem(p,mar);
 getframe(scr2,0,0,imlung-1,imlat-1,p);
 y:=0;
 repeat
  x:=0;
  repeat
   putimage(x,y,p^,copyput);
   inc(x,imlung);
  until x>getmaxx;
  inc(y,imlat);
 until y>getmaxy;
 freemem(p,mar);
 mar:=(depasire+1)*imlat+16;
 if maxavail<mar then begin
                       closegraph;
                       writeln(' Eroare de executie !');
                       writeln(' Insuficienta memorie pentru a rula acest program !');
                       halt(2);
                      end
                    else getmem(p,mar);
 getframe(scr2,0,0,depasire,imlat-1,p);
 y:=0;
 repeat
  putimage(getmaxx-depasire,y,p^,copyput);
  inc(y,imlat);
 until y>getmaxy;
 freemem(p,mar);
shutdownvirtual(scr2);
end;

procedure TileImg(x1,y1,x2,y2:integer;poin:pointer);
var x,y:integer;mar2:word;
    p2:pointer;wp:viewporttype;
    depasire,depasire2:word;
    imlung,imlat:word;
begin
 imlung:=linear(poin^)[0]+256*linear(poin^)[1];
 imlat :=linear(poin^)[2]+256*linear(poin^)[3];
 if (imlung>x2-x1)or(imlat>y2-y1) then exit;
 getviewsettings(wp);
 setviewport(x1,y1,x2,y2,true);
 depasire:=(x2-x1) mod imlung;depasire2:=(y2-y1) mod imlat;
 y:=0;
 repeat
  x:=0;
  repeat
   putimage(x,y,poin^,copyput);
   inc(x,imlung);
  until x>x2-x1-imlung;
  inc(y,imlat);
 until y>y2-y1-imlat;
 mar2:=imagesize(0,0,depasire+1,imlat);
 getmem(p2,mar2);
 getimage(0,0,depasire,imlat-1,p2^);
 y:=0;
 repeat
  putimage(x2-x1-depasire,y,p2^,copyput);
  inc(y,imlat);
 until y>y2-y1-imlat;
 freemem(p2,mar2);
 mar2:=imagesize(0,0,imlung,depasire2+1);
 getmem(p2,mar2);
 getimage(0,0,imlung-1,depasire2,p2^);
 x:=0;
 repeat
  putimage(x,y2-y1-depasire2,p2^,copyput);
  inc(x,imlung);
 until x>x2-x1-imlung;
 freemem(p2,mar2);
 mar2:=imagesize(0,0,depasire+1,depasire2+1);
 getmem(p2,mar2);
 getimage(0,0,depasire,depasire2,p2^);
 putimage(x2-x1-depasire,y2-y1-depasire2,p2^,copyput);
 freemem(p2,mar2);
 setviewport(wp.x1,wp.y1,wp.x2,wp.y2,true);
end;

end.

