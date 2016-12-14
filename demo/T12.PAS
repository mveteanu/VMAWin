uses crt,appmcga,graph,vesadrv,bk,mouse,obj,events,clock,fileos;

type  PMicroPaint=^MicroPaint;
      MicroPaint=object
                   mx,my,mtip:integer;
                   Constructor Init(x,y,tip:integer);
                   Procedure   Run;
                   Destructor  Done;
                   private
                   fer1:pwindow;fra:pframe;
                   but1,but2,but3:pbutton;
                   evw:tevent;
                 end;

type  PDemo=^TDemo;
      TDemo=object
              dx,dy,dtip:integer;
              Constructor Init(x,y,tip:integer);
              Procedure Run;
              Destructor Done;
              private
              fer1:pwindow;fra:pframe;
              but1,but2,but3:pbutton;
              evw:tevent;
            end;

Constructor MicroPaint.Init;
begin
 mx:=x;my:=y;mtip:=tip;
 new(fer1);fer1^.init(mx,my,310,190,'Micro Paint',mtip,true);
 fer1^.LoadUnifImage('u5.bmp');
 fer1^.show;
 new(but1);but1^.init(fer1,15,155,80,20,'Demo');but1^.show;
 new(but2);but2^.init(fer1,115,155,80,20,'Clear');but2^.show;
 new(but3);but3^.init(fer1,215,155,80,20,'About');but3^.show;
 new(fra);fra^.init(fer1,15,30,280,115,4,white,'Desen');fra^.show;
end;

Procedure MicroPaint.Run;
function Apartine(x,y,x1,y1,x2,y2:integer):boolean;
begin
 if (x1<x) and (x<x2) and (y1<y) and (y<y2) then
     Apartine:=True
 else Apartine:=False
end;
var f,x1,y1,x,y,pasx,pasy,rax,ray,rx,ry:integer;
begin
 repeat
   fer1^.move;
   GetEvent(evw);
   if fra^.clicked(evw) then
     begin
      setwritemode(copyput);setfillstyle(solidfill,green);
      fra^.activate;hidemouse;
       setcolor(lightred);fillellipse(fra^.getx+6,fra^.gety,6,3);
       setcolor(yellow);fillellipse(fra^.getx,fra^.gety+6,3,6);
       setcolor(lightblue);fillellipse(fra^.getx-6,fra^.gety,6,3);
      showmouse;fra^.deactivate;
     end;
   if but2^.clicked(evw) then fra^.show;
   if but3^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;hidemouse;
      settextjustify(centertext,centertext);settextstyle(0,0,2);
      setcolor(blue);outtextxy(fra^.fralung div 2,fra^.fralat div 2,'æPaint by VMA');
      setcolor(lightblue);outtextxy(fra^.fralung div 2+2,fra^.fralat div 2+2,'æPaint by VMA');
      showmouse;fra^.deactivate;
     end;

   if but1^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;
      x:=0;y:=0;
      pasx:=2;pasy:=2;
      rax:=15;ray:=15;rx:=1;ry:=1;
      repeat
        setwritemode(copyput);
        setcolor(random(255));setfillstyle(solidfill,random(255));
        fillellipse(x,y,rax,ray);
        if (x>fra^.fralung)or(x<0) then pasx:=-pasx;
        if (y>fra^.fralat)or(y<0) then pasy:=-pasy;
        if (rax>25)or(rax<2)then rx:=-rx;
        if (ray>10)or(ray<2)then ry:=-ry;
        inc(x,pasx);inc(y,pasy);
        inc(rax,rx);inc(ray,ry);
        fra^.deactivate;fer1^.move;fra^.activate;
      until leftpressed1 and not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20);
      fra^.deactivate;
     end;
 until fer1^.clicked(evw);
end;

Destructor MicroPaint.Done;
begin
 dispose(fer1,done);
 dispose(fra ,done);
 dispose(but1,done);
 dispose(but2,done);
end;

Constructor TDemo.Init;
begin
 dx:=x;dy:=y;dtip:=tip;
 new(fer1);fer1^.init(dx,dy,310,190,'Demonstration',dtip,true);
 fer1^.loadunifimage('u12.bmp');
 fer1^.show;
 new(but1);but1^.init(fer1,15,155,80,20,'Demo1');but1^.show;
 new(but2);but2^.init(fer1,115,155,80,20,'Demo2');but2^.show;
 new(but3);but3^.init(fer1,215,155,80,20,'Demo3');but3^.show;
 new(fra);fra^.init(fer1,15,30,280,115,4,white,'Look here...');fra^.show;
end;

Procedure TDemo.Run;
var f,x,y,pasx,pasy,rax,ray,rx,ry:integer;

function Apartine(x,y,x1,y1,x2,y2:integer):boolean;
begin
 if (x1<x) and (x<x2) and (y1<y) and (y<y2) then
     Apartine:=True
 else Apartine:=False
end;

begin
 setwritemode(copyput);
 fra^.activate;hidemouse;
 settextjustify(centertext,centertext);settextstyle(0,0,2);
 setcolor(blue);outtextxy(fra^.fralung div 2,fra^.fralat div 2,'Demo by VMA');
 setcolor(lightblue);outtextxy(fra^.fralung div 2+2,fra^.fralat div 2+2,'Demo by VMA');
 showmouse;fra^.deactivate;
 repeat
   fer1^.move;
   GetEvent(evw);

   if but1^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;
      x:=0;y:=0;
      pasx:=2;pasy:=2;
      rax:=25;ray:=25;rx:=1;ry:=1;
      repeat
        setwritemode(copyput);
        setcolor(random(255));setfillstyle(solidfill,random(255));
        fillellipse(x,y,rax,ray);
        if (x>fra^.fralung)or(x<0) then pasx:=-pasx;
        if (y>fra^.fralat)or(y<0) then pasy:=-pasy;
        if (rax>45)or(rax<10)then rx:=-rx;
        if (ray>25)or(ray<10)then ry:=-ry;
        inc(x,pasx);inc(y,pasy);
        inc(rax,rx);inc(ray,ry);
        fra^.deactivate;fer1^.move;fra^.activate;
      until leftpressed1 and not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20);
      fra^.deactivate;
     end;

 if but2^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;
      setfillstyle(9,blue);
      x:=0;y:=0;
      pasx:=3;pasy:=3;
      repeat
        setcolor(random(255));setwritemode(copyput);
        fillellipse(x,y,25,25);
        if (x>fra^.fralung)or(x<0) then pasx:=-pasx;
        if (y>fra^.fralat)or(y<0) then pasy:=-pasy;
        inc(x,pasx);inc(y,pasy);
        fra^.deactivate;fer1^.move;fra^.activate;
      until leftpressed1 and not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20);
      fra^.deactivate;
     end;

   if but3^.clicked(evw) then
     begin
      fra^.activate;
     repeat
       x:=round(random(fra^.fralung));y:=round(random(fra^.fralat));
       setfillstyle(solidfill,magenta);fillellipse(x,y,30,30);
       for f:=0 to round(20+random(20)) do begin
       setwritemode(copyput);
       setcolor(1+random(256));circle(x,y,f);end;
       fra^.deactivate;fer1^.move;fra^.activate;
     until leftpressed1 and not apartine(mousex,mousey,fer1^.winx+20,fer1^.winy+5,fer1^.winx+fer1^.winlung-5,fer1^.winy+20);;
      fra^.deactivate;
     end;
 until fer1^.clicked(evw);
end;

Destructor TDemo.Done;
begin
 dispose(fer1,done);
 dispose(fra, done);
 dispose(but1,done);
 dispose(but2,done);
end;

var pal:virtualpal;
    cl:byte;p:pointer;
    evw:tevent;
    fer1:PWindow;
    but1,but2,but3:pbutton;
    paint:PMicroPaint;Demo:PDemo;ceas:PClock;

begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('u1.bmp');

 new(fer1);fer1^.init(100,120,250,150,'Only for kids',1,true);
 fer1^.LoadUnifImage('u7.bmp');fer1^.show;
 new(but1);but1^.init(fer1,30,120,50,15,'Demo');but1^.show;
 new(but2);but2^.init(fer1,100,120,50,15,'æPaint');but2^.show;
 new(but3);but3^.init(fer1,170,120,50,15,'Clock');but3^.show;

 initmouse;showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);

   if but1^.clicked(evw) then
     begin
      mark(P);
      New(Demo,Init(300,160,3));
      Demo^.Run;
      dispose(Demo,Done);
      release(P);
     end;

   if but2^.clicked(evw) then
     begin
      mark(P);
      new(Paint,Init(280,180,2));
      Paint^.Run;
      dispose(Paint,Done);
      release(P);
     end;

   if but3^.clicked(evw) then
     begin
      mark(P);
      new(Ceas,Init(300,200,250,220,3,lightgray,'u2.bmp','Clock'));
      Ceas^.SetClock(blue);
      Ceas^.Run;
      dispose(Ceas,Done);
      release(p);
     end;
 until fer1^.clicked(evw);
 CloseGraph;
end.


