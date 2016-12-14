uses crt,appmcga,graph,vesadrv,fonts,mouse,obj,events,fileos;
const
      mesaje:array[1..4] of string=
      ('Program realizat de Veteanu Marian Adrian in "BP 7.0 with Objects"',
      'Aceste butoane sunt incluse in VMA Win',
      'Exista 5 tipuri diferite de butoane',
      'Pentru crearea de butoane folositi utilitarele incluse in VMA Win');

var  pal:virtualpal;
     evw:tevent;
type Pteeth=^teeth;
     teeth=object
               fer1:pwindow;tex:ptext;
               ico1:pbutton;
               ic:array[1..8] of pbutton;
               Constructor Init(x,y,tip:integer;ima:string);
               Procedure   Run;
               Destructor  Done;
               private     mesaj:integer;
               function stri(x:integer):string;
              end;


Constructor teeth.Init;
var f:integer;
begin
 mesaj:=1;
 new(fer1,init(x,y,320,170,'VMA soft',tip,true));
 UseFile('..\win-img\textures.lib');
 fer1^.loadunifimage(ima);fer1^.show;
 new(tex);tex^.init(fer1,100,35,210-50,64,1,'Apasati pe imaginea din stanga');tex^.show;
 UseFile('..\win-img\icons.lib');
 new(ico1);ico1^.initico2(fer1,20,35,0,0,2,'teeth.ico');ico1^.show;
 for f:=1 to 6 do
   begin
    new(ic[f],initico2(fer1,f*50-30,115,0,0,1,'tb-'+stri(f)+'.ico'));
    ic[f]^.show;
   end;
    new(ic[7],initico2(fer1,270,30,0,0,1,'tb-7.ico'));ic[7]^.show;
    new(ic[8],initico2(fer1,270,70,0,0,1,'tb-8.ico'));ic[8]^.show;
end;

function teeth.stri(x:integer):string;
var strt:string;Begin str(x,strt);stri:=strt;End;

Procedure teeth.Run;
var f:integer;
begin
 repeat
   fer1^.move;
   GetEvent(evw);
   if ico1^.clicked(evw) then tex^.redefine('Acesta este un buton cu forma grafica definita de utilizator');
   for f:=1 to 6 do if ic[f]^.clicked(evw) then tex^.redefine('Acesta buton este continut de fisierul TB-'+stri(f)+'.ICO');
   if ic[7]^.clicked(evw) then begin if mesaj<4 then inc(mesaj);tex^.redefine(mesaje[mesaj]);end;
   if ic[8]^.clicked(evw) then begin if mesaj>1 then dec(mesaj);tex^.redefine(mesaje[mesaj]);end;
 until fer1^.clicked(evw);
end;

Destructor teeth.Done;
var f:integer;
begin
 dispose(fer1,done);dispose(tex,done);
 dispose(ico1,done);
 for f:=1 to 8 do dispose(ic[f],done);
end;


var Butoane:Pteeth;

begin
 OpenGraph(VESA_800x600x256);
 loadpal('..\win-img\uniform.pal',pal);setallpal(pal);
 initmouse;showmouse;

 new(Butoane,Init(100,100,3,'u2.bmp'));
 Butoane^.Run;
 dispose(Butoane,done);

 CloseGraph;
end.


