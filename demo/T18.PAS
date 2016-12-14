uses crt,appmcga,graph,vesadrv,fonts,bk,mouse,obj,events,fileos;

type PApp=^TApp;
     TApp=object
           ev:tevent;
           main:pwindow;
           b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,i1,i2:pbutton;
           Constructor Init;
           Procedure   Run;
           Destructor  Done;
           private
           procedure fereastra2(stri:string);
          end;

Procedure tapp.fereastra2(stri:string);
var fer2:pwindow;
    tex:ptext;but:pbutton;
    evw:tevent;
begin
 new(fer2);
 fer2^.init(260,200,260,190,'Informatie',3,true);
 UseFile('..\win-img\textures.lib');
 fer2^.loadunifimage('u2.bmp');
 new(tex,init(fer2,30,40,200,100,1,stri));
 new(but,init(fer2,100,152,60,20,'O.K.'));
 fer2^.show;tex^.show;but^.show;
 repeat
  fer2^.move;
  getevent(evw);
 until but^.clicked(evw) or fer2^.clicked(evw);
 dispose(fer2,done);dispose(tex,done);dispose(but,done);
end;

Constructor TApp.Init;
begin
 new(main,init(0,0,getmaxx,getmaxy,'VMA soft',1,false));

 new(b1,init(main,050,150,200,50,'Basic'));
 new(b2,init(main,300,150,200,50,'Pascal'));
 new(b3,init(main,550,150,200,50,'C'));

 new(b4,init(main,050,250,200,50,'Fortran'));
 new(b5,init(main,300,250,200,50,'Ada'));
 new(b6,init(main,550,250,200,50,'Small Talk'));

 new(b7,init(main,050,350,200,50,'Java'));
 new(b8,init(main,300,350,200,50,'Logo'));
 new(b9,init(main,550,350,200,50,'Prolog'));

 new(b10,init(main,050,450,200,50,'Lisp'));
 new(b11,init(main,300,450,200,50,'Eiffel'));
 new(b12,init(main,550,450,200,50,'Oberon'));

 UseFile('..\win-img\icons.lib');
 new(i1,initico2(main,475,540,100,40,1,'exit.ICO'));
 new(i2,initico2(main,225,540,100,40,1,'question.ICO'));

 b1^.show;b2^.show;b3^.show;b4^.show;b5^.show;b6^.show;
 b7^.show;b8^.show;b9^.show;b10^.show;b11^.show;b12^.show;
 i1^.show;i2^.show;
end;

Procedure  TApp.Run;
begin
repeat
 getevent(ev);
 if b1^.clicked(ev) then fereastra2('Cel mai simplu limbaj pe care toata lumea trebuie sa-l cunoasca');
 if b2^.clicked(ev) then fereastra2('Pascal-ul este unul dintre cele mai bine structurate limbaje de programare');
 if b3^.clicked(ev) then fereastra2('C-ul este cel mai la moda limbaj la ora actuala');
 if b4^.clicked(ev) then fereastra2('Limbajul generatiei trecute');
 if b5^.clicked(ev) then fereastra2('Pe aproape de Pascal ?');
 if b6^.clicked(ev) then fereastra2('Pentru cei ce ce fac totul in O.O.P.');
 if b7^.clicked(ev) then fereastra2('Foarte interesant !');
 if b8^.clicked(ev) then fereastra2('Pentru cei care nu au reusit sa invete BASIC');
 if b9^.clicked(ev) then fereastra2('Limbaj al inteligentei artificiale');
 if b10^.clicked(ev) then fereastra2('Limbaj al inteligentei artificiale');
 if b11^.clicked(ev) then fereastra2('Orientat obiect');
 if b12^.clicked(ev) then fereastra2('Nimic de spus');
 if i2^.clicked(ev) then fereastra2('Program demonstrativ realizat de Veteanu Marian Adrian');
until i1^.clicked(ev);
end;

Destructor TApp.Done;
begin
 dispose(main,done);
 dispose(i1,done);
 dispose(i2,done);
 dispose(b1,done);
 dispose(b2,done);
 dispose(b3,done);
 dispose(b4,done);
 dispose(b5,done);
 dispose(b6,done);
 dispose(b7,done);
 dispose(b8,done);
 dispose(b9,done);
 dispose(b10,done);
 dispose(b11,done);
 dispose(b12,done);
end;

procedure Keret(xr1,yr1,xr2,yr2,tip:integer);
begin
   setwritemode(copyput);setlinestyle(0,0,0);
   if tip=0 then setcolor(darkgray)else
   setcolor(lightgray);
   graph.line(xr1+1,yr1+1,xr2-2,yr1+1);
   line(xr1+1,yr1+1,xr1+1,yr2-1);
   if tip=0 then setcolor(lightgray)else
   setcolor(darkgray);
   line(xr2-1,yr1+1,xr2-1,yr2-1);
   line(xr2-1,yr2-1,xr1+1,yr2-1);
end;

var pal:virtualpal;
    app:papp;

begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('u14.bmp');

 setfillstyle(solidfill,blue);bar(50,25,750,100);
 keret(50,25,750,100,0);keret(51,26,749,99,1);
 msettextstyle(4,horizdir,6);
 setcolor(darkgray);outtextxy(57,20,'Limbaje de programare');
 setcolor(lightgray);outtextxy(59,22,'Limbaje de programare');

 Initmouse;Showmouse;
 new(app,init);
 app^.run;
 dispose(app,done);

 CloseGraph;
end.


