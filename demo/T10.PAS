uses crt,appmcga,graph,vesadrv,bk,mouse,obj,events,fileos;
var pal:virtualpal;
    cl:byte;
    evw:tevent;
    fer1,fer2,fer3:pwindow;
    but1,but2,but3:pbutton;
    fer1dead,fer2dead,fer3dead:boolean;

procedure bell;begin sound(300);delay(30);nosound;end;

begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('u1.bmp');

 fer1dead:=false;fer2dead:=false;fer3dead:=false;
 new(fer1);fer1^.init(10,0,150,100,'Win 1',1,true);
 fer1^.setarea(0,0,getmaxx div 3,getmaxy);fer1^.show;

 new(fer2);fer2^.init(276,0,150,100,'Win 2',2,true);
 fer2^.setarea(getmaxx div 3+1,0,2*(getmaxx div 3),getmaxy);fer2^.show;

 new(fer3);fer3^.init(600,0,150,100,'Win 3',3,true);
 fer3^.setarea(2*(getmaxx div 3)+1,0,getmaxx,getmaxy);fer3^.show;

 new(but1);but1^.init(fer1,25,60,100,20,'O.K.');but1^.show;
 new(but2);but2^.init(fer2,25,60,100,20,'O.K.');but2^.show;
 new(but3);but3^.init(fer3,25,60,100,20,'O.K.');but3^.show;

 initmouse;showmouse;cl:=0;
 repeat
   fer1^.move;fer2^.move;fer3^.move;
   if (not fer1dead) and (but1^.clicked(evw)or fer1^.clicked(evw)) then
      begin
       fer1dead:=true;dispose(fer1,done);dispose(but1,done);inc(cl);
      end;
   if (not fer2dead) and (but2^.clicked(evw)or fer2^.clicked(evw)) then
      begin
       fer2dead:=true;dispose(fer2,done);dispose(but2,done);inc(cl);
      end;
   if (not fer3dead) and (but3^.clicked(evw)or fer3^.clicked(evw)) then
      begin
       fer3dead:=true;dispose(fer3,done);dispose(but3,done);inc(cl);
      end;
   GetEvent(evw);
 until cl=3;
 CloseGraph;
end.


