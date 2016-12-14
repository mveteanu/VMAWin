uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events,fileos;

var  pal:virtualpal;
     evw:tevent;
type PButonase=^Butonase;
     Butonase=object
               fer1:pwindow;tex:ptext;
               ico1,ico2,ico3,ico4,ico5,ico6,ico7:pbutton;
               Constructor Init(x,y,tip:integer;ima:string);
               Procedure   Run;
               Destructor  Done;
              end;

{$F+}
procedure filebutton;external;{$l file.obj}
procedure newbutton;external;{$l new.obj}
procedure openbutton;external;{$l open.obj}
procedure savebutton;external;{$l save.obj}
procedure closebutton;external;{$l close.obj}
procedure setupbutton;external;{$l setup.obj}
procedure exitbutton;external;{$l exit.obj}
{$F-}


Constructor Butonase.Init;
begin
 new(fer1);fer1^.init(x,y,310,200,'VMA soft',tip,true);
 fer1^.loadunifimage(ima);fer1^.show;
 new(tex);tex^.init(fer1,200,30,90,100,1,'Acestea sunt butoane definite de utilizator');tex^.show;

 new(ico1);ico1^.initico(fer1,20,30,0,0,1,@filebutton);ico1^.show;
 new(ico2);ico2^.initico(fer1,80,30,0,0,1,@newbutton);ico2^.show;
 new(ico3);ico3^.initico(fer1,140,30,0,0,1,@openbutton);ico3^.show;
 new(ico4);ico4^.initico(fer1,20,90,0,0,1,@savebutton);ico4^.show;
 new(ico5);ico5^.initico(fer1,80,90,0,0,1,@closebutton);ico5^.show;
 new(ico6);ico6^.initico(fer1,140,90,0,0,1,@setupbutton);ico6^.show;
 new(ico7);ico7^.initico(fer1,120,140,80,45,1,@exitbutton);ico7^.show;
end;

Procedure Butonase.Run;
var contor:integer;
begin
 contor:=0;
 repeat
   fer1^.move;
   GetEvent(evw);
   if ico1^.clicked(evw) then tex^.redefine('Ati apasat butonul "File"');
   if ico2^.clicked(evw) then tex^.redefine('Ati apasat butonul "New"');
   if ico3^.clicked(evw) then tex^.redefine('Ati apasat butonul "Open"');
   if ico4^.clicked(evw) then tex^.redefine('Ati apasat butonul "Save"');
   if ico5^.clicked(evw) then tex^.redefine('Ati apasat butonul "Close"');
   if ico6^.clicked(evw) then tex^.redefine('Ati apasat butonul "Setup"');
   if ico7^.clicked(evw) then begin tex^.redefine('Mai apasati odata "Exit"');inc(contor);end;
 until fer1^.clicked(evw)or (contor=2);
end;

Destructor Butonase.Done;
begin
 dispose(fer1,done);
 dispose(tex,done);
 dispose(ico1,done);
 dispose(ico2,done);
 dispose(ico3,done);
 dispose(ico4,done);
 dispose(ico5,done);
 dispose(ico6,done);
 dispose(ico7,done);
end;


var Butoane:PButonase;

begin
 OpenGraph(VESA_800x600x256);
 loadpal('..\win-img\uniform.pal',pal);setallpal(pal);
 MSetTextStyle(7,horizdir,20);outtextxy(120,200,'VMA soft');freefont;
 initmouse;showmouse;

 UseFile('..\win-img\textures.lib');
 new(Butoane,Init(100,100,1,'u5.bmp'));
 Butoane^.Run;
 dispose(Butoane,Done);

 CloseGraph;
end.


