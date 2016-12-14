uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events;
var pal:virtualpal;
    activ:boolean;
    evw:tevent;
    fer1:pwindow;fra:pframe;
    but1,but2,but3,but4:pbutton;
    f,x,y,pasx,pasy,rax,ray,rx,ry:integer;

    WholePal : virtualpal;
    CurX,CurY,CurCol : integer;
    right,down:Boolean;Xloop,Yloop : Integer;
    block:array[1..40,1..40] of byte;

    af:boolean;

function Apartine(x,y,x1,y1,x2,y2:integer):boolean;
begin
 if (x1<x) and (x<x2) and (y1<y) and (y<y2) then
     Apartine:=True
 else Apartine:=False
end;

procedure PaintMandelbrot;
var
        u,v : integer;
        rl,rh,il,ih : real;
        x,y,xx,yy,dx,dy : real;
        r,i,s : real;
        n,nmax : word;
begin
 for u:=16 to 31 do begin Pal[u,1]:=30;pal[u,2]:=(40+u*3)mod 63;pal[u,3]:=0;end;
        SetAllPal(pal);
        clearviewport;
        rl:=-2;
        rh:=0.5;
        il:=-1.5;
        ih:=1.5;
        nmax:=12;

        dx:=(rh-rl) / 160;
        dy:=(ih-il) / 100;
        yy:=il-dy;

        for u:=0 to fra^.fralat do begin
                yy:=yy+dy;
                xx:=rl-dx;
                for v:=0 to fra^.fralung do begin
                        xx:=xx+dx;
                        n:=0; r:=0.0; i:=0.0; s:=0.0;
                        repeat
                                x:=r;
                                y:=i;
                                r:=sqr(x) - sqr(y) + xx;
                                i:=2.0*x*y + yy;
                                s:=sqr(r) + sqr(i);
                                inc(n);
                        until (n=nmax) OR (s>4.0);
                        if (n=nmax) then PutPixel(v,u,16) else PutPixel(v,u,16+n);
                end;
        end;
end;

Procedure LiniiJucause;
const
  nrpasi=198;
  lungime=40;
var
  pxc,pyc,i,j:integer;
  x1,x2,y1,y2,culori,xcentru,ycentru,unghiuri:array[1..4] of integer;
function rad(unghi:integer):real;
  begin
    rad:=unghi*pi/180;
  end;
procedure calculpunct(xc,yc:integer;unghi:integer);
  begin
    pxc:=xc+trunc(cos(rad(unghi))*lungime);
    pyc:=yc+trunc(sin(rad(unghi))*lungime);
  end;
begin

  culori[1]:=red;
  culori[2]:=blue;
  culori[3]:=green;
  culori[4]:=brown;

  setfillstyle(solidfill,0);bar(0,0,fra^.fralung,fra^.fralat);
  repeat
    for i:=1 to 4 do
      begin
        unghiuri[i]:=(i mod 4 )*45;
      end;

    xcentru[1]:=30;
    ycentru[1]:=30;
    xcentru[2]:=fra^.fralung-30;
    ycentru[2]:=30;
    xcentru[3]:=30;
    ycentru[3]:=fra^.fralat-30;
    xcentru[4]:=fra^.fralung-30;
    ycentru[4]:=fra^.fralat-30;


    for i:=1 to nrpasi do
      begin
        for j:=1 to 4 do
          begin
            calculpunct(xcentru[j],ycentru[j],unghiuri[j]);
            x1[j]:=pxc;
            y1[j]:=pyc;
            calculpunct(xcentru[j],ycentru[j],unghiuri[j]+180);
            x2[j]:=pxc;
            y2[j]:=pyc;
          end;

        for j:=1 to 4 do
          begin
            setcolor(culori[j]);setwritemode(copyput);setlinestyle(0,0,3);
            if apartine(mousex,mousey,fer1^.winx+fra^.frax,
            fer1^.winy+fra^.fray,fer1^.winx+fra^.frax+fra^.fralung,fer1^.winy+fra^.fray+fra^.fralat)
            then begin hidemouse;af:=true;end;
             rectangle(x1[j],y1[j],x2[j],y2[j]);
             line(x1[j],y1[j],x2[j],y2[j]);
             line(x2[j],y1[j],x1[j],y2[j]);
            if af then showmouse;
          end;
            fra^.deactivate;fer1^.move;fra^.activate;
            if leftpressed1 and
             not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20)
              then exit;
        delay(15);
        {stergerea liniilor}
        for j:=1 to 4 do
          begin
            setcolor(black);setwritemode(copyput);setlinestyle(0,0,3);
            if apartine(mousex,mousey,fer1^.winx+fra^.frax,
            fer1^.winy+fra^.fray-10,fer1^.winx+fra^.frax+fra^.fralung,fer1^.winy+fra^.fray+fra^.fralat)
            then begin hidemouse;af:=true;end;
             rectangle(x1[j],y1[j],x2[j],y2[j]);
             line(x1[j],y1[j],x2[j],y2[j]);
             line(x2[j],y1[j],x1[j],y2[j]);
            if af then showmouse;
            end;

        {modificarea coordonatelor}
        xcentru[1]:=xcentru[1]+trunc(fra^.fralung/nrpasi);
        ycentru[1]:=ycentru[1]+trunc(fra^.fralat/nrpasi);
        xcentru[2]:=xcentru[2]-trunc(fra^.fralung/nrpasi);
        ycentru[2]:=ycentru[2]+trunc(fra^.fralat/nrpasi);
        xcentru[3]:=xcentru[3]+trunc(fra^.fralung/nrpasi);
        ycentru[3]:=ycentru[3]-trunc(fra^.fralat/nrpasi);
        xcentru[4]:=xcentru[4]-trunc(fra^.fralung/nrpasi);
        ycentru[4]:=ycentru[4]-trunc(fra^.fralat/nrpasi);
        for j:=1 to 4 do
          begin
            unghiuri[j]:=unghiuri[j]+5;
            unghiuri[j]:=unghiuri[j] mod 360;
          end;
      end;
    {interschimabarea culorilor}
    i:=culori[1];
    culori[1]:=culori[4];
    culori[4]:=i;

    i:=culori[2];
    culori[2]:=culori[3];
    culori[3]:=i;

  until false;
end;

procedure CreazaFractal;
var bruit,s:word;
function creerbruit(x1,y1,x2,y2,x,y:word):byte;
var moy,val:word;
begin
moy:=(getpixel(x1,y1)+getpixel(x2,y2)) shr 1;
val:=(16+random(256) and bruit)-bruit shr 1+moy;
putpixel(x,y,val);
creerbruit:=val;
end;
procedure divise(x1,y1,x2,y2:word);
var x,y,num,tmp:word;
begin
  x:=(x1+x2) shr 1;
  y:=(y1+y2) shr 1;
  if (x<>x1) or (y<>y1) then begin
  num:=0;
  if getpixel(x,y1)=0 then num:=creerbruit(x1,y1,x2,y1,x,y1)
                   else num:=getpixel(x,y1);
  if getpixel(x,y2)=0 then num:=num+creerbruit(x1,y2,x2,y2,x,y2)
                   else num:=num+getpixel(x,y2);
  if getpixel(x2,y)=0 then num:=num+creerbruit(x2,y1,x2,y2,x2,y)
                   else num:=num+getpixel(x2,y);
  if getpixel(x1,y)=0 then num:=num+creerbruit(x1,y1,x1,y2,x1,y)
                   else num:=num+getpixel(x1,y);
  putpixel(x,y,num shr 2);
  tmp:=bruit;
  bruit:=bruit shr 1;
  divise(x1,y1,x,y);
  divise(x,y1,x2,y);
  divise(x,y,x2,y2);
  divise(x1,y,x,y2);
  bruit:=tmp;
end;
end;
procedure creazapaleta;
var t:word;
begin
 for t:=0 to 63 do
   begin
     pal[t+16,3]:=63-t;pal[t+64,2]:=t;
     pal[t+128,1]:=t;pal[t+128,2]:=t shr 1;
     pal[t+192,1]:=t;pal[t+192,2]:=t;
   end;
 end;
Procedure Flou(x1,y1,x2,y2:integer);
var s,t:integer;
begin
for s:=x1+1 to x2-1 do for t:=y1+1 to y2-1 do
putpixel(s,t ,(getpixel(s-1,t-1)+getpixel(s-1,t)+getpixel(s-1,t+1)+getpixel(s,t-1 )+
             getpixel(s,t )+getpixel(s,t+1 )+getpixel(s+1,t-1)+getpixel(s+1,t)+
             getpixel(s+1,t+1)) div 9 );
end;
begin
  hidemouse;
  setfillstyle(solidfill,0);bar(0,0,fra^.fralung,fra^.fralat);
  creazapaleta;setallpal(pal);
  bruit:=round(exp((random(4)+7)*ln(2)))-1;
  putpixel(0,0,random(255)+16);
  divise(0,0,fra^.fralung,fra^.fralat);
  Flou(0,0,fra^.fralung,fra^.fralat);;
  showmouse;
end;

Procedure PregatesteBloc;
begin
  CurX := 100;CurY := 100;CurCol := 1;
  LoadIcon('..\win-img\worm.blc',addr(block));
  for f:=17 to 80 do begin pal[f,1]:=f-17;pal[f,2]:=0;pal[f,3]:=0;end;
  for f:=81 to 143 do begin pal[f,1]:=f-80;pal[f,2]:=f-80;pal[f,3]:=0;end;
  for f:=144 to 207 do begin pal[f,1]:=0;pal[f,2]:=0;pal[f,3]:=f-143;end;
  for f:=207 to 255 do begin pal[f,1]:=f-207;pal[f,2]:=0;pal[f,3]:=0;end;
  hidemouse;
  setfillstyle(solidfill,0);bar(0,0,fra^.fralung,fra^.fralat);
  showmouse;
end;

Procedure MutaBloc;
begin
  setwritemode(copyput);
  For XLoop := 1 to 40 do For Yloop := 1 to 40 do
  If block[Yloop,Xloop] = 1 then PutPixel(CurX+Xloop,CurY+Yloop,CurCol);
  RotatePal(pal,17,210);SetallPal(pal);
  CurCol := (CurCol) mod 210 + 17;
  if right then inc(curx,4) else dec(curx,3);
  if down then inc(cury,3) else dec(cury,2);
  If CurX > fra^.fralung then right:= FALSE;
  If CurY > fra^.fralat then down := FALSE;
  If CurX < 0 then right := TRUE;
  If CurY < 0 then down  := TRUE;
end;


begin
 OpenGraph(VESA_800x600x256);
 loadpal('..\win-img\uniform.pal',pal);setallpal(pal);
 setcolor(green);
 MSetTextStyle(7,horizdir,20);outtextxy(120,200,'VMA soft');freefont;

 new(fer1);fer1^.init(100,100,310,190,'Demonstration',3,true);fer1^.show;
 new(but1);but1^.init(fer1,15,155,60,20,'Demo1');but1^.show;
 new(but2);but2^.init(fer1,88,155,60,20,'Demo2');but2^.show;
 new(but3);but3^.init(fer1,162,155,60,20,'Demo3');but3^.show;
 new(but4);but4^.init(fer1,235,155,60,20,'Demo4');but4^.show;
 new(fra);fra^.init(fer1,15,30,280,115,0,white,'Look again here...');fra^.show;

 initmouse;showmouse;
 setwritemode(copyput);
 fra^.activate;hidemouse;
 settextjustify(centertext,centertext);settextstyle(0,0,2);
 setcolor(blue);outtextxy(fra^.fralung div 2,fra^.fralat div 2,'Demo2 by VMA');
 setcolor(lightblue);outtextxy(fra^.fralung div 2+2,fra^.fralat div 2+2,'Demo2 by VMA');
 showmouse;fra^.deactivate;

 repeat
   fer1^.move;
   GetEvent(evw);

   if but1^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;
      LiniiJucause;
      fra^.deactivate;
     end;

   if but2^.clicked(evw) then
     begin
      fra^.activate;
      PregatesteBloc;
     repeat
      MutaBloc;
      fra^.deactivate;fer1^.move;fra^.activate;
     until leftpressed1 and not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20);
      fra^.deactivate;
     end;

  if but3^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;
      CreazaFractal;
      repeat
        rotatepal(pal,16,255);waitretrace;setallpal(pal);
        fra^.deactivate;fer1^.move;fra^.activate;
      until leftpressed1 and not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20);
      fra^.deactivate;
     end;

 if but4^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;
      hidemouse;PaintMandelbrot;showmouse;
      repeat
        rotatepalback(pal,16,31);waitretrace;setallpal(pal);
        fra^.deactivate;fer1^.move;fra^.activate;
      until leftpressed1 and not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20);
      fra^.deactivate;
     end;

 until fer1^.clicked(evw);
 dispose(fer1,done);dispose(fra,done);
 dispose(but1,done);dispose(but2,done);
 CloseGraph;
end.


