uses crt,appmcga,graph,vesadrv,bk,mouse,obj,events,fileos;

var pal:virtualpal;

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


Constructor TDemo.Init;
begin
 dx:=x;dy:=y;dtip:=tip;
 new(fer1);fer1^.init(dx,dy,310,190,'Demonstration',dtip,true);fer1^.show;
 new(but1);but1^.init(fer1,15,155,80,20,'Demo1');but1^.show;
 new(but2);but2^.init(fer1,115,155,80,20,'Demo2');but2^.show;
 new(but3);but3^.init(fer1,215,155,80,20,'Demo3');but3^.show;
 new(fra);fra^.init(fer1,15,30,280,115,0,white,'Look here...');fra^.show;
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
 dispose(fer1,done);dispose(fra,done);
 dispose(but1,done);dispose(but2,done);
end;

var Demo:PDemo;

begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('U1.BMP');
 initmouse;showmouse;

 New(Demo,Init(100,100,3));
 Demo^.Run;
 dispose(Demo,Done);

 CloseGraph;
end.


