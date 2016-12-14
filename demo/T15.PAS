uses crt,appmcga,graph,vesadrv,bk,mouse,obj,events,clock,fileos;
const fisiere:array[1..42]of string=(
  'zip','australi','backup','bcpp','check','clock','close','disk35','disk525','dos',
 'exit','file','fileman','flight','globe','guide','l123','mickey','music','new','newpage','norton','note',
 'open','playroom','printer','printshp','prodigy','quattro','question','quicken',
 'remote','save','schedule','setup','shell','sol','tools','virus','win','wordperf','works');
const mesaje:array[1..4] of string=
      ('Program realizat de Veteanu Marian Adrian in "BP 7.0 with Objects"',
      'Aceste butoane sunt incluse in VMA Win',
      'Exista 5 tipuri diferite de butoane',
      'Pentru crearea de butoane folositi utilitarele incluse in VMA Win');

     MainMenu:array[1..6]of menuitem=(
        (item:'Demo Animation '#16;enabled:true;checked:false),
        (item:'Micro Paint    '#16;enabled:true;checked:false),
        (item:'Clock          '#16;enabled:true;checked:false),
        (item:'Butonase       '#16;enabled:true;checked:false),
        (item:'Teeths         '#16;enabled:true;checked:false),
        (item:'More buttons'      ;enabled:true;checked:false));
      MenuTexture:array[1..20]of menuitem=(
        (item:'None';         enabled:true;checked:false),
      	(item:'Tiger';	      enabled:true;checked:false),
      	(item:'Acid';         enabled:true;checked:false),
      	(item:'Zebra';        enabled:true;checked:false),
      	(item:'Rain';         enabled:true;checked:false),
      	(item:'Brown wood';   enabled:true;checked:false),
      	(item:'Stones';       enabled:true;checked:false),
      	(item:'Red wood';     enabled:true;checked:false),
      	(item:'White marble ';enabled:true;checked:false),
      	(item:'Cartoons';     enabled:true;checked:false),
      	(item:'Program logo'; enabled:true;checked:false),
      	(item:'Hatch';        enabled:true;checked:false),
      	(item:'Caviar';       enabled:true;checked:false),
      	(item:'Fibres';       enabled:true;checked:false),
      	(item:'Globes';       enabled:true;checked:false),
      	(item:'Long Fibres';  enabled:true;checked:false),
      	(item:'Maze';         enabled:true;checked:false),
      	(item:'Circles';      enabled:true;checked:false),
        (item:'Sponge';       enabled:true;checked:false),
        (item:'Wall';         enabled:true;checked:false));



type  PMicroPaint=^MicroPaint;
      MicroPaint=object
                   mx,my,mtip:integer;
                   Constructor Init(x,y,tip:integer;ima:string);
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
              Constructor Init(x,y,tip:integer;ima:string);
              Procedure Run;
              Destructor Done;
              private
              fer1:pwindow;fra:pframe;
              but1,but2,but3:pbutton;
              evw:tevent;
            end;

type PButonase=^Butonase;
     Butonase=object
               fer1:pwindow;tex:ptext;
               ico1,ico2,ico3,ico4,ico5,ico6,ico7:pbutton;
               Constructor Init(x,y,tip:integer;ima:string);
               Procedure   Run;
               Destructor  Done;
               private evw:tevent;
              end;

type Pteeth=^teeth;
     teeth=object
               fer1:pwindow;tex:ptext;
               ico1:pbutton;
               ic:array[1..8] of pbutton;
               Constructor Init(x,y,tip:integer;ima:string);
               Procedure   Run;
               Destructor  Done;
               private     mesaj:integer;evw:tevent;
               function stri(x:integer):string;
              end;

type PButoane2=^Butoane2;
     Butoane2=object
               fer1:pwindow;tex:ptext;
               ico:array[1..42] of pbutton;
               Constructor Init(tip:integer);
               Procedure   Run;
               Destructor  Done;
               private     evw:tevent;
              end;


Constructor MicroPaint.Init;
begin
 UseFile('..\win-img\textures.lib');
 mx:=x;my:=y;mtip:=tip;
 new(fer1,initxms(mx,my,310,190,'Micro Paint',mtip,true));
 fer1^.LoadUnifImage(ima);fer1^.makezoom(1);
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
 fer1^.done;fra^.done;
 but1^.done;but2^.done;
end;

Constructor TDemo.Init;
begin
 UseFile('..\win-img\textures.lib');
 dx:=x;dy:=y;dtip:=tip;
 new(fer1,initxms(dx,dy,310,190,'Demonstration',dtip,true));
 fer1^.loadunifimage(ima);fer1^.makezoom(1);
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
 fer1^.done;fra^.done;
 but1^.done;but2^.done;
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
 UseFile('..\win-img\textures.lib');
 new(fer1,initxms(x,y,310,200,'Butoane utilizator',tip,true));
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
 fer1^.done;tex^.done;
 ico1^.done;ico2^.done;ico3^.done;ico4^.done;
 ico5^.done;ico6^.done;ico7^.done;
end;

Constructor teeth.Init;
var f:integer;
begin
 mesaj:=1;
 new(fer1,initxms(x,y,320,170,'VMA soft',tip,true));
 UseFile('..\win-img\textures.lib');
 fer1^.loadunifimage(ima);fer1^.show;
 new(tex);tex^.init(fer1,100,35,210-50,64,1,'Apasati pe imaginea din stanga');tex^.show;
 UseFile('..\win-img\icons.lib');
 new(ico1,initico2(fer1,20,35,0,0,2,'teeth.ico'));ico1^.show;
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
 fer1^.done;tex^.done;
 ico1^.done;
 for f:=1 to 8 do ic[f]^.done;
end;

Constructor Butoane2.Init;
var f,g:integer;
begin
 new(fer1);fer1^.initxms(100,80,600,440,'VMA soft',tip,true);
 UseFile('..\win-img\textures.lib');
 fer1^.loadunifimage('u2.bmp');fer1^.show;
 new(tex);tex^.init(fer1,20,360,560,60,1,'Acestea sunt butoane cu forma libera. '+
  +'Toate aceste butoane exista in VMA Win. Utilizatorul are posibilitatea sa le foloseasca '+
  +'pe acestea sau sa creeze altele. Exista 4 moduri diferite de apasare a butoanelor definite. Acesta este modul 1.');
 tex^.show;
 UseFile('..\win-img\icons.lib');
 for g:=1 to 6 do for f:=1 to 7 do
    begin
      new(ico[(g-1)*7+f],initico2(fer1,f*70,g*50,0,0,1,fisiere[(g-1)*7+f]+'.ICO'));
      ico[(g-1)*7+f]^.show;
    end;
end;

Procedure Butoane2.Run;
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

Destructor Butoane2.Done;
var f,g:integer;
begin
 fer1^.done;tex^.done;
 for g:=1 to 6 do for f:=1 to 7 do ico[(g-1)*7+f]^.done;
end;

var pal:virtualpal;
    cl:byte;
    evw:tevent;
    fer1:PWindow;
    but1:pbutton;menu1:PMenu;
    fundal:string;fereastra:integer;
    PrevineFragmentareaHeapului:pointer;
    paint:PMicroPaint;Demo:PDemo;teet:pteeth;
    ceas:PClock;Butoane:PButonase;Buton:PButoane2;

Function AlegeFundal:string;
var menu2:PMenu;
begin
      new(menu2);
      menu2^.init(fer1^.winx+fer1^.winlung+60,fer1^.winy+70,'Texture');
      menu2^.setitems(20,@MenuTexture);
      menu2^.show(2);
      repeat
       GetEvent(evw);
       case menu2^.run(evw) of
       1:begin menu2^.done;AlegeFundal:='NuExista.bmp';break;end;
       2:begin menu2^.done;AlegeFundal:='u1.bmp';break;end;
       3:begin menu2^.done;AlegeFundal:='u10.bmp';break;end;
       4:begin menu2^.done;AlegeFundal:='u11.bmp';break;end;
       5:begin menu2^.done;AlegeFundal:='u12.bmp';break;end;
       6:begin menu2^.done;AlegeFundal:='u2.bmp';break;end;
       7:begin menu2^.done;AlegeFundal:='u3.bmp';break;end;
       8:begin menu2^.done;AlegeFundal:='u4.bmp';break;end;
       9:begin menu2^.done;AlegeFundal:='u5.bmp';break;end;
      10:begin menu2^.done;AlegeFundal:='u6.bmp';break;end;
      11:begin menu2^.done;AlegeFundal:='u7.bmp';break;end;
      12:begin menu2^.done;AlegeFundal:='u8.bmp';break;end;
      13:begin menu2^.done;AlegeFundal:='u9.bmp';break;end;
      14:begin menu2^.done;AlegeFundal:='u13.bmp';break;end;
      15:begin menu2^.done;AlegeFundal:='u14.bmp';break;end;
      16:begin menu2^.done;AlegeFundal:='u15.bmp';break;end;
      17:begin menu2^.done;AlegeFundal:='u16.bmp';break;end;
      18:begin menu2^.done;AlegeFundal:='u17.bmp';break;end;
      19:begin menu2^.done;AlegeFundal:='u18.bmp';break;end;
      20:begin menu2^.done;AlegeFundal:='u19.bmp';break;end;
       end;
      until false;
end;

Function AlegeFereastra:integer;
var menu2:PMenu;
begin
      new(menu2);
      menu2^.init(fer1^.winx+fer1^.winlung+20,fer1^.winy+40,'Win Shape');
      menu2^.NewItem('2D Window   '#16,true,false);
      menu2^.NewItem('2.5D Window '#16,true,false);
      menu2^.NewItem('3D Window   '#16,true,false);
      menu2^.NewItem('3D2 Window  '#16,true,false);
      menu2^.show(2);
      repeat
       GetEvent(evw);
       case menu2^.run(evw) of
       1:begin fundal:=alegefundal;menu2^.done;AlegeFereastra:=1;break;end;
       2:begin fundal:=alegefundal;menu2^.done;AlegeFereastra:=2;break;end;
       3:begin fundal:=alegefundal;menu2^.done;AlegeFereastra:=3;break;end;
       4:begin fundal:=alegefundal;menu2^.done;AlegeFereastra:=4;break;end;
       end;
      until false;
end;



begin
 OpenGraph(VESA_800x600x256);
 UseFile('..\win-img\textures.lib');
 TileUnifImage('u1.bmp');

 new(fer1,initxms(100,120,250,150,'Only for kids',1,true));
 fer1^.LoadUnifImage('u7.bmp');fer1^.makezoom(2);
 fer1^.show;
 new(but1);but1^.init(fer1,30,125,190,10,'Click here to start');but1^.show;

 initmouse;SetSenzitivity(trunc(120*0.75),120,2);
 showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);
   mark(PrevineFragmentareaHeapului);
   if but1^.clicked(evw) then
     begin
      new(menu1,init(fer1^.winx+fer1^.winlung-20,fer1^.winy+20,'Application'));
      menu1^.setitems(6,@MainMenu);
      menu1^.show(2);
      repeat
       GetEvent(evw);
       case menu1^.run(evw) of
        -1 :begin menu1^.done;break;end;
         1 :begin fereastra:=alegefereastra;menu1^.done;
           New(Demo,Init(300,160,fereastra,fundal));Demo^.Run;Demo^.Done;break;end;
         2 :begin fereastra:=alegefereastra;menu1^.done;
           new(Paint,Init(280,180,fereastra,fundal));Paint^.Run;Paint^.Done;break;end;
         3 :begin fereastra:=alegefereastra;menu1^.done;
           UseFile('..\win-img\textures.lib');
           new(Ceas,Init(300,200,250,220,fereastra,lightgray,fundal,'Clock'));
           Ceas^.SetClock(blue);Ceas^.Run;Ceas^.Done;break;end;
         4 :begin fereastra:=alegefereastra;menu1^.done;
	   new(Butoane);Butoane^.Init(300,200,fereastra,fundal);Butoane^.Run;
	   Butoane^.Done;break;end;
         5 :begin fereastra:=alegefereastra;menu1^.done;
           new(teet);teet^.Init(300,200,fereastra,fundal);teet^.Run;
           teet^.done;break;end;
         6 :begin menu1^.done;new(Buton);Buton^.Init(3);Buton^.Run;
	    Buton^.Done;break;end;
       end;
      until false;
     end;
 release(PrevineFragmentareaHeapului);
 until fer1^.clicked(evw);
 fer1^.done;but1^.done;
 CloseGraph;
end.


