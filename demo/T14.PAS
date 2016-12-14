uses crt,appmcga,graph,vesadrv,bk,mouse,obj,events,fileos;
const fisiere:array[1..42]of string=(
  'zip','australi','backup','bcpp','check','clock','close','disk35','disk525','dos',
 'exit','file','fileman','flight','globe','guide','l123','mickey','music','new','newpage','norton','note',
 'open','playroom','printer','printshp','prodigy','quattro','question','quicken',
 'remote','save','schedule','setup','shell','sol','tools','virus','win','wordperf','works');


type PButonase=^Butonase;
     Butonase=object
               fer1:pwindow;tex:ptext;
               ico:array[1..42] of pbutton;
               Constructor Init(tip:integer);
               Procedure   Run;
               Destructor  Done;
               private     evw:tevent;
              end;


Constructor Butonase.Init;
var f,g:integer;
begin
 new(fer1);fer1^.init(100,80,600,440,'VMA soft',tip,false);
 fer1^.show;
 new(tex);tex^.init(fer1,20,360,560,60,1,'Acestea sunt butoane cu forma libera. '+
  +'Toate aceste butoane exista in VMA Win. Utilizatorul are posibilitatea sa le foloseasca '+
  +'pe acestea sau sa creeze altele. Exista 4 moduri diferite de apasare a butoanelor definite. Acesta este modul 1.');
 tex^.show;
 for g:=1 to 6 do for f:=1 to 7 do
    begin
      new(ico[(g-1)*7+f],initico2(fer1,f*70,g*50,0,0,1,fisiere[(g-1)*7+f]+'.ICO'));
      ico[(g-1)*7+f]^.show;
    end;
end;

Procedure Butonase.Run;
var f,g,contor:integer;
begin
 contor:=0;
 repeat
   fer1^.move;
   GetEvent(evw);
   for g:=1 to 6 do for f:=1 to 7 do
    if ico[(g-1)*7+f]^.clicked(evw) then
     tex^.Redefine('Acest buton este continut in fisierul '+fisiere[(g-1)*7+f]+'.ico');
 until fer1^.clicked(evw)or (contor=2);
end;

Destructor Butonase.Done;
var f,g:integer;
begin
 dispose(fer1,done);
 dispose(tex,done);
 for g:=1 to 6 do for f:=1 to 7 do dispose(ico[(g-1)*7+f],done);
end;


var Butoane:PButonase;
    pal:virtualpal;


begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('u1.bmp');
 UseFile('..\win-img\icons.lib');
 initmouse;showmouse;

 new(Butoane,Init(1));
 Butoane^.Run;
 dispose(Butoane,Done);

 CloseGraph;
end.


