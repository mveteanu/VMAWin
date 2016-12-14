uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events;

var  pal:virtualpal;
     evw:tevent;

type Pteeth=^teeth;
     teeth=object
               fer1:pwindow;
               ico1,ico2,ico3,ico4,ico5,ico6,ico7,ico8:pusrbutton;
               Constructor Init(x,y,tip:integer);
               Procedure   Run;
               Destructor  Done;
              end;

{$F+}
procedure butok;external;{$l b1.obj}
procedure butcancel;external;{$l b2.obj}
procedure butabort;external;{$l b3.obj}
procedure butretry;external;{$l b4.obj}
procedure butignore;external;{$l b5.obj}
procedure butyes;external;{$l b6.obj}
procedure butno;external;{$l b7.obj}
procedure buthelp;external;{$l b8.obj}
{$F-}

Constructor teeth.Init;
var f:integer;
begin
 new(fer1,init(x,y,106,440,'VMA soft',tip,true));fer1^.show;
 new(ico1,init(fer1,20,30,@butok));ico1^.show;
 new(ico2,init(fer1,20,80,@butcancel));ico2^.show;
 new(ico3,init(fer1,20,130,@butabort));ico3^.show;
 new(ico4,init(fer1,20,180,@butretry));ico4^.show;
 new(ico5,init(fer1,20,230,@butignore));ico5^.show;
 new(ico6,init(fer1,20,280,@butyes));ico6^.show;
 new(ico7,init(fer1,20,330,@butno));ico7^.show;
 new(ico8,init(fer1,20,380,@buthelp));ico8^.show;
end;


Procedure teeth.Run;
var f:integer;
begin
 repeat
   fer1^.move;
   GetEvent(evw);
   ico1^.clicked(evw);
   ico2^.clicked(evw);
   ico3^.clicked(evw);
   ico4^.clicked(evw);
   ico5^.clicked(evw);
   ico6^.clicked(evw);
   ico7^.clicked(evw);
   ico8^.clicked(evw);
 until fer1^.clicked(evw);
end;

Destructor teeth.Done;
var f:integer;
begin
 dispose(fer1,done);
 dispose(ico1,done);
 dispose(ico2,done);
 dispose(ico3,done);
 dispose(ico4,done);
 dispose(ico5,done);
 dispose(ico6,done);
 dispose(ico7,done);
 dispose(ico8,done);
end;


var Butoane:Pteeth;

begin
 OpenGraph(VESA_800x600x256);
 setuniformpal;
 initmouse;showmouse;

 new(Butoane,Init(100,100,3));
 Butoane^.Run;
 dispose(Butoane,Done);

 CloseGraph;
end.


