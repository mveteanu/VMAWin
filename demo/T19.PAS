uses crt,bk,appmcga,graph,vesadrv,mouse,obj,events,fileos;
Const Limbaje:array[1..12] of string=
      ('Basic','Logo','Pascal','C','Fortran','Prolog',
      'Lisp','Eiffel','Oberon','Java','Ada','Small Talk');

Const Mesaj:array[1..12] of string=(
'Cel mai simplu limbaj pe care toata lumea trebuie sa-l cunoasca',
'Pentru cei care nu au reusit sa invete BASIC',
'Pascal-ul este unul dintre cele mai bine structurate limbaje de programare',
'C-ul este cel mai la moda limbaj la ora actuala',
'Limbajul generatiei trecute',
'Limbaj al inteligentei artificiale',
'Limbaj al inteligentei artificiale',
'Orientat obiect',
'Nimic de spus',
'Foarte interesant !',
'Pe aproape de Pascal ?',
'Pentru cei ce ce fac totul in O.O.P.');


Type PApp = ^TApp;
     TApp = object
             fer1:pwindow;
             buts:array[1..12] of pbutton;
             Constructor Init;
             Procedure   Run;
             Destructor  Done;
            private
             evw:tevent;
             Procedure Message(stri:string);
            end;

Constructor TApp.Init;
var f:word;
begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('u12.bmp');
 InitMouse;
 ShowMouse;
 SetSenzitivity(trunc(120*0.75),120,2);

 New(fer1,init(0,0,150,300,'Limbaje',2,true));fer1^.show;
 for f:=1 to 12 do
  begin new(buts[f],init(fer1,8,6+(f*22),133,20,Limbaje[f]));buts[f]^.show;end;

end;

Procedure TApp.Message(stri:string);
var fer2:pwindow;
    tex:ptext;but:pbutton;
begin
 new(fer2,init(fer1^.winx+fer1^.winlung,fer1^.winy,260,190,'Informatie',1,true));
 new(tex,init(fer2,30,40,200,100,1,stri));
 new(but,init(fer2,100,152,60,20,'O.K.'));
 fer2^.show;tex^.show;but^.show;
 repeat
  fer2^.move;
  getevent(evw);
 until but^.clicked(evw) or fer2^.clicked(evw);
 dispose(fer2,done);
 dispose(tex,done);
 dispose(but,done);
end;

Procedure TApp.Run;
var f:word;
begin
 repeat
  fer1^.move;
  GetEvent(evw);
  for f:=1 to 12 do
   if buts[f]^.clicked(evw) then
     Message(Mesaj[f]);
 until fer1^.clicked(evw);
end;

Destructor TApp.Done;
var f:word;
begin
dispose(fer1,done);
for f:=1 to 12 do dispose(buts[f],done);
CloseGraph;
end;

var App:PApp;
begin
 New(App,Init);
 App^.Run;
 Dispose(App,Done);
end.


