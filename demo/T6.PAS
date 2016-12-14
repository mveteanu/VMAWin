             {                                  }
	     {   Micro Paint - by VMA software  }
             {                                  }

uses crt,appmcga,graph,vesadrv,bk,mouse,obj,events,fileos;

var pal:virtualpal;

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


Constructor MicroPaint.Init;
begin
 mx:=x;my:=y;mtip:=tip;
 new(fer1);fer1^.init(mx,my,310,190,'Micro Paint',mtip,true);
 fer1^.show;
 new(but1);but1^.init(fer1,15,155,80,20,'Demo');but1^.show;
 new(but2);but2^.init(fer1,115,155,80,20,'Sterge');but2^.show;
 new(but3);but3^.init(fer1,215,155,80,20,'Despre');but3^.show;
 new(fra);fra^.init(fer1,15,30,280,115,4,white,'Desen');fra^.show;
end;

Procedure MicroPaint.Run;
function Apartine(x,y,x1,y1,x2,y2:integer):boolean;
begin
 if (x1<x) and (x<x2) and (y1<y) and (y<y2) then
     Apartine:=True
 else Apartine:=False
end;
var x1,y1,pasx,pasy:integer;
begin
 repeat
   fer1^.move;
   GetEvent(evw);
   if fra^.clicked(evw) then
     begin
      setwritemode(copyput);setfillstyle(solidfill,red);setcolor(yellow);
      fra^.activate;hidemouse;
      fillellipse(fra^.getx,fra^.gety,5,5);
      showmouse;fra^.deactivate;
     end;
   if but2^.clicked(evw) then fra^.show;
   if but3^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;hidemouse;
      settextjustify(centertext,centertext);settextstyle(0,0,2);
      setcolor(red);outtextxy(fra^.fralung div 2,fra^.fralat div 2,'æPaint by VMA');
      setcolor(lightblue);outtextxy(fra^.fralung div 2+2,fra^.fralat div 2+2,'æPaint by VMA');
      showmouse;fra^.deactivate;
     end;
   if but1^.clicked(evw) then
     begin
      setwritemode(copyput);
      fra^.activate;
      setfillstyle(solidfill,blue);
      x1:=0;y1:=0;
      pasx:=3;pasy:=3;
      repeat
        setcolor(random(255));setwritemode(copyput);
        fillellipse(x1,y1,25,25);
        if (x1>fra^.fralung)or(x1<0) then pasx:=-pasx;
	if (y1>fra^.fralat)or(y1<0) then pasy:=-pasy;
        inc(x1,pasx);inc(y1,pasy);
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


var Paint:PMicroPaint;

begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('u1.bmp');
 Initmouse;Showmouse;

 new(Paint,Init(100,100,1));
 Paint^.Run;
 dispose(Paint,Done);

 CloseGraph;
end.


