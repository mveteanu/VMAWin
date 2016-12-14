{     In acest unit sunt implementate principalele obiecte necesare    }
{     creeri de interfete grafice asemanatoare cu Windows - GUI        }
{     Aproape toate obiectele au mai multe forme grafice               }


unit obj;
interface

uses vesadrv,appmcga,graph,xms,appbmp,events,collect,bk,fonts;
type PWindow   =^TWindow;
     TWindow   =object
                  winxms:boolean;
                  winx,winy,winlung,winlat:integer;
                  winx1,winy1,winx2,winy2:integer;wintip:integer;winzoom:word;
                  wintitle:string;winmoveable:boolean;winsaved:boolean;
                  constructor Init(x,y,lung,lat:integer;title:string;tip:integer;saved:boolean);
                  constructor InitXMS(x,y,lung,lat:integer;title:string;tip:integer;saved:boolean);
                  procedure   Show;virtual;
                  procedure   Move;virtual;
                  procedure   Save;virtual;
                  procedure   Restore;virtual;
                  procedure   MakeZoom(zoom:word);
                  procedure   SetArea(x1,y1,x2,y2:integer);
                  procedure   LoadUnifImage(FileName:string);virtual;
                  procedure   LoadImage(FileName:string;PalName:VirtualPal);virtual;
                  function    Clicked(ev:TEvent):boolean;virtual;
                  function    OutClicked(ev:TEvent):boolean;virtual;
                  destructor  Done;
                  private     winbg:pointer;winbgsize:word;
                  winpal:virtualpal;winpo:pointer;winmarpo:word;
                  winloaded:boolean;winshowed:boolean;wintiled:boolean;
                  winhan2:word;
                end;


type PButton   =^TButton;
     TButton   =object
                  butx,buty,butlung,butlat,buttip:integer;
                  buttitle:string;butwin:pwindow;butenabled:boolean;
                  icoimalung,icoimalat:integer;icoadr:pointer;
                  CulTitle:word;
                  Constructor Init(w:pwindow;x,y,lung,lat:integer;title:string);
                  Constructor InitIco(w:pwindow;x,y,lung,lat,tip:integer;adr:pointer);
                  Constructor InitIco2(w:pwindow;x,y,lung,lat,tip:integer;filename:string);
                  procedure   Show;virtual;
                  procedure   Showpressed;virtual;
                  procedure   Enable;
                  procedure   Disable;
                  procedure   Select(cul:word);virtual;
                  procedure   DeSelect;
                  procedure   Retitle(ttitle:string);
                  function    Clicked(ev:TEvent):boolean;virtual;
                  destructor  Done;
                  private     icofile:boolean;icofadr:pointer;icofmar:word;
                end;

type PMSButton =^TMSButton;
     TMSButton =object(TButton)
                  procedure   Show;virtual;
                  procedure   ShowPressed;virtual;
                end;


type POS2Button =^TOS2Button;
     TOS2Button =object(TButton)
                  os2buttip:byte;
                  Constructor Init(w:pwindow;x,y,lung,lat:integer;title:string;tip:byte);
                  procedure   Show;virtual;
                  procedure   ShowPressed;virtual;
                end;


type PUsrButton   =^TUsrButton;
     TUsrButton   =object(TButton)
                     Constructor Init(w:pwindow;x,y:integer;adr:pointer);
                     procedure   Show;virtual;
                     procedure   Showpressed;virtual;
                   end;

type PDefButton   =^TDefButton;
     TDefButton   =object
                  butx,buty,butlung,butlat:integer;
                  butwin:pwindow;butenabled:boolean;
                  Constructor Init(w:pwindow;x,y,lung,lat:integer);
                  procedure   Enable;
                  procedure   Disable;
                  function    Clicked(ev:TEvent):boolean;virtual;
                  destructor  Done;
                end;


type PInput    =^TInput;
     TInput    =object
                  inpx,inpy,inplung,inplat,inptip,inpnrcar:integer;
                  inpenabled,inpchanged:boolean;
                  inpmesage:string;inpwin:pwindow;
                  bkgray:boolean;
                  Constructor Init(w:pwindow;x,y,lung,tip,nrcar:integer);
                  procedure   SetText(mesage:string);virtual;
                  procedure   Show;virtual;
                  function    Edit:string;virtual;
                  procedure   Disable;virtual;
                  procedure   Enable;virtual;
                  function    Clicked(ev:TEvent):boolean;virtual;
                  Destructor  Done;virtual;
                  procedure   draw;virtual;
                end;

type PChkBox   =^TChkBox;
     TChkBox   =object
                  chkx,chky,chklung,chklat,chktip:integer;
                  chkmesage:string;chkwin:pwindow;
                  chkchecked,chkenabled:boolean;
                  Constructor Init(w:pwindow;x,y,tip:integer;checked:boolean;mesage:string);
                  procedure   Show;
                  procedure   Enable;
                  procedure   Disable;
                  procedure   Toggle;
                  function    Clicked(ev:TEvent):boolean;virtual;
                  destructor  Done;
                end;

type PUpDown   =^TUpDown;
     TUpDown   =object
                  updx,updy,updlung,updlat,updtip:integer;
                  updenabled:boolean;updWin:pwindow;
                  Constructor Init(w:pwindow;x,y,tip:integer);
                  procedure   Show;
                  procedure   ShowPressed(ypoz:integer);
                  procedure   Enable;
                  procedure   Disable;
                  function    Clicked(ev:TEvent):integer;virtual;
                  destructor  Done;
                end;

type PRuler    =^TRuler;
     TRuler    =object
                  rulx,ruly,rullung,rullat,rultip:integer;
                  rulmin,rulmax,rulstep,rulpos:longint;
                  rulenabled:boolean;rulwin:pwindow;
                  Constructor Init(w:pwindow;x,y,lung,lat,tip:integer;min,max,step,pos:longint);
                  procedure   Show;
                  procedure   Enable;
                  procedure   Disable;
                  procedure   SetPos(pos:longint);
                  function    GetPos:longint;
                  function    Clicked(ev:TEvent):boolean;virtual;
                  destructor  Done;
                  private     d,p:integer;
                        procedure   delmark;
                        procedure   drawmark(pr:integer);
                        procedure   rule(x,y:integer);
                end;

type PText     =^TText;
     TText     =object
                  texx,texy,texlung,texlat,textip:integer;
                  texbcol,texfcol,texfont,texsize:integer;
                  texwrap:boolean;texhor,texver:byte;
                  texmesage:string;texwin:pwindow;
                  Constructor Init(w:pwindow;x,y,lung,lat,tip:integer;mesage:string);
                  procedure   SetAttr(font,size,fcol,bcol:integer);
                  procedure   SetJustify(hor,ver:byte;wrap:boolean);
                  procedure   Show;
                  procedure   Redefine(mesage:string);
                  function    Clicked(ev:TEvent):boolean;virtual;
                  destructor  Done;
                end;

type PFrame    =^TFrame;
     TFrame    =object
                  frax,fray,fralung,fralat,fratip:integer;
                  fracol:word;fratitle:string;frawin:pwindow;
                  fraclickx,fraclicky:integer;
                  Constructor Init(w:pwindow;x,y,lung,lat,tip:integer;col:word;title:string);
                  procedure   Show;
                  procedure   Activate;
                  procedure   Deactivate;
                  function    Clicked(ev:TEvent):boolean;virtual;
                  function    GetX:integer;
                  function    GetY:integer;
                  destructor  Done;
                  private     wp:viewporttype;
                end;

type PMenu=^TMenu;
     MenuItem=record item:string;enabled,checked:boolean;end;
     TMenu=object
            menx,meny,menlung,menlat:integer;mentitle:string;nritem:byte;
            line:array[1..100] of menuitem;
            Constructor Init(x,y:integer;title:string);
            Procedure   Show(zoom:word); {0=fara zoom}
            Procedure   ResetItems;
            Procedure   SetItems(NrIt:byte;ItP:pointer);
            Procedure   NewItem(item:string;enabled,checked:boolean);
            Procedure   ChangeItem(nrit:byte;item:string;enabled,checked:boolean);
            Function    IsEnabled(nrit:byte):boolean;
            Function    IsChecked(nrit:byte):boolean;
            Function    Run(ev:TEvent):integer;
            Destructor  Done;
               private xx,yy,but,selected,maxl,last:integer;
               vp:viewporttype;out:boolean;
               marpoint:word;point:pointer;
               procedure writeitem(i:integer;act:boolean);
           end;

type PMenuXMS=^TMenuXMS;
     MenuItemXMS=record item:string;enabled,checked:boolean;end;
     TMenuXMS=object
            menx,meny,menlung,menlat:integer;mentitle:string;nritem:byte;
            line:array[1..100] of menuitemXMS;
            Constructor Init(x,y:integer;title:string);
            Procedure   Show(zoom:word); {0=fara zoom}
            Procedure   ResetItems;
            Procedure   SetItems(NrIt:byte;ItP:pointer);
            Procedure   NewItem(item:string;enabled,checked:boolean);
            Procedure   ChangeItem(nrit:byte;item:string;enabled,checked:boolean);
            Function    IsEnabled(nrit:byte):boolean;
            Function    IsChecked(nrit:byte):boolean;
            Function    Run(ev:TEvent):integer;
            Destructor  Done;
               private xx,yy,but,selected,maxl,last:integer;
               vp:viewporttype;out:boolean;
               marpoint:word;pointhan:word;pointoff:longint;
               procedure writeitem(i:integer;act:boolean);
           end;

type PList=^TList;
     TList=object
             lisx,lisy,lislung,lislat,liscul:integer;
             lislungcar,lislatcar:integer;
             liswin:pwindow;lisenabled:boolean;
             liscol:PCollection;printbeg,akt:ColItPo;
             Constructor Init(w:pwindow;x,y,lung,lat,cul:integer;col:PCollection);
             procedure   show;
             procedure   enable;
             procedure   disable;
             procedure   view(po:pointer;a,b,c,d:integer);virtual;
             function    Clicked(ev:tevent):string;
             procedure   Reinit;
             Destructor  done;
             private  wp:viewporttype;lisindex,lissize:integer;
             clickcont:integer;
             procedure drawselect;
             procedure delselect;
             procedure viewlist;
     end;


type PScollImage=^TScollImage;
     TScollImage=object
                  px,py,pdx,pdy,plung,plat,prlung,prlat:integer;
                  pluima,plaima:longint;
                  pcolor:word;
                  pfilehandle:word;
                  win:pwindow;
                  r1,r2:pruler;b1:pbutton;
                  Constructor Init(w:pwindow;x,y,lung,lat,dx,dy:integer;filehandle:word);
                  Procedure   Show;
                  Procedure   Run(ev:TEvent);
                  Destructor  Done;
                 end;


implementation
uses mouse,Ukbd,crt,kerets,fileos;
var winhan1:word;


function Apartine(x,y,x1,y1,x2,y2:integer):boolean;
begin
 if (x1<x) and (x<x2) and (y1<y) and (y<y2) then
     Apartine:=True
 else Apartine:=False
end;

Constructor TWindow.Init;
begin
 winx:=x;winy:=y;winxms:=false;
 winlung:=lung;winlat:=lat;winzoom:=0;
 if winx+winlung>getmaxx then winx:=getmaxx-winlung-1;
 if winy+winlat>getmaxy then winy:=getmaxy-winlat-1;
 if winx<0 then winx:=0;if winy<0 then winy:=0;
 winx1:=0;winy1:=0;
 winx2:=getmaxx;winy2:=getmaxy;
 wintitle:=title;
 wintip:=tip;
 winsaved:=saved;
 winmoveable:=winsaved;
 if winsaved then save;
 winloaded:=false;winshowed:=false;
 wintiled:=false;
end;

Constructor TWindow.InitXMS;
begin
 winx:=x;winy:=y;winxms:=true;
 winlung:=lung;winlat:=lat;winzoom:=0;
 if winx+winlung>getmaxx then winx:=getmaxx-winlung-1;
 if winy+winlat>getmaxy then winy:=getmaxy-winlat-1;
 if winx<0 then winx:=0;if winy<0 then winy:=0;
 winx1:=0;winy1:=0;
 winx2:=getmaxx;winy2:=getmaxy;
 wintitle:=title;
 wintip:=tip;
 winsaved:=saved;
 winmoveable:=winsaved;
 if winsaved then save;
 winloaded:=false;winshowed:=false;
end;


Procedure TWindow.MakeZoom;
begin
 winzoom:=zoom;
end;

Procedure TWindow.LoadUnifImage;
var imlung,imlat,imlung1,imlat1:integer;
    scr1,scr2:virtualscreen;
begin
 if (not fileexist(filename))and(not Lib_FileExist(filename)) then exit;
 if winshowed then exit;
 if (winlung>320) and (winlat>200) then
 begin
  wintiled:=true;
  setupvirtual(scr1);
  loadbmpfile(0,0,filename,scr1,winpal);
  imlung:=TestI.H.Width;imlat:=TestI.H.Height;
  winmarpo:=imlung*imlat+16;
  if winmarpo>maxavail then
    begin
      closegraph;
      writeln(' Eroare de executie !');
      writeln(' Insuficienta memorie pentru a rula acest program !');
      halt(2);
    end else getmem(winpo,winmarpo);
  getframe(scr1,0,0,imlung-1,imlat-1,winpo);
  shutdownvirtual(scr1);
 end
 else
 begin
  wintiled:=false;
  setupvirtual(scr2);
  setupvirtual(scr1);
  imlung:=winlung-10;imlat:=winlat-27;
  loadbmpfile(0,0,filename,scr1,winpal);
  imlung1:=TestI.H.Width;imlat1:=TestI.H.Height;
  rescale(scr1,0,0,imlung1-1,imlat1-1,scr2,0,0,imlung,imlat);
  shutdownvirtual(scr1);
  winmarpo:=imlung*imlat+16;
  if winmarpo>maxavail then
    begin
      closegraph;
      writeln(' Eroare de executie !');
      writeln(' Insuficienta memorie pentru a rula acest program !');
      halt(2);
    end else getmem(winpo,winmarpo);
  getframe(scr2,0,0,imlung-1,imlat-1,winpo);
  shutdownvirtual(scr2);
 end;
 winloaded:=true;
end;

Procedure TWindow.LoadImage;
var imlung,imlat,imlung1,imlat1:integer;
    scr1,scr2:virtualscreen;
begin
 if (not fileexist(filename))and(not Lib_FileExist(filename)) then exit;
 if winshowed then exit;
 if (winlung>320) and (winlat>200) then
 begin
  wintiled:=true;
  setupvirtual(scr1);setupvirtual(scr2);
  loadbmpfile(0,0,filename,scr1,winpal);
  changescreenpal(scr1,winpal,scr2,palname);
  shutdownvirtual(scr1);
  imlung:=TestI.H.Width;imlat:=TestI.H.Height;
  winmarpo:=imlung*imlat+16;
  if winmarpo>maxavail then
    begin
      closegraph;
      writeln(' Eroare de executie !');
      writeln(' Insuficienta memorie pentru a rula acest program !');
      halt(2);
    end else getmem(winpo,winmarpo);
  getframe(scr2,0,0,imlung-1,imlat-1,winpo);
  shutdownvirtual(scr2);
 end
 else
 begin
  wintiled:=false;
  setupvirtual(scr1);
  setupvirtual(scr2);
  imlung:=winlung-10;imlat:=winlat-27;
  loadbmpfile(0,0,filename,scr1,winpal);
  imlung1:=TestI.H.Width;imlat1:=TestI.H.Height;
  changescreenpal(scr1,winpal,scr2,palname);
  rescale(scr2,0,0,imlung1-1,imlat1-1,scr1,0,0,imlung,imlat);
  shutdownvirtual(scr2);
  winmarpo:=imlung*imlat+16;
  if winmarpo>maxavail then
    begin
      closegraph;
      writeln(' Eroare de executie !');
      writeln(' Insuficienta memorie pentru a rula acest program !');
      halt(2);
    end else getmem(winpo,winmarpo);
  getframe(scr1,0,0,imlung-1,imlat-1,winpo);
  shutdownvirtual(scr1);
 end;
 winloaded:=true;
end;

procedure TWindow.Show;
var f:integer;
begin
 hidemouse;
 setlinestyle(0,0,0);setwritemode(copyput);
case wintip of
 1:begin
 if winzoom>0 then panoucuzoom(winx,winy,winx+winlung,winy+winlat,lightgray,winzoom);
 panou(winx,winy,winx+winlung,winy+winlat);
 setfillstyle(solidfill,lightblue);bar(winx,winy,winx+winlung,winy+20);

 setcolor(lightblue); { Albastru S3 Trio }
 for f:=1 to 5 do rectangle(winx+f,winy+f,winx+winlung-f,winy+winlat-f);

 setcolor(darkgray);line(winx+winlung-5,winy+21,winx+winlung-5,winy+winlat-5);
 line(winx+5,winy+winlat-5,winx+winlung-5,winy+winlat-5);
 setcolor(white);line(winx+5,winy+21,winx+5,winy+winlat-5);
 rectangle(winx+5,winy+5,winx+winlung-5,winy+21);

 setcolor(black);
 rectangle(winx,winy,winx+winlung,winy+winlat);
 line(winx+5,winy+20,winx+winlung-5,winy+20);
 line(winx+20,winy+20,winx+20,winy+6);
 settextjustify(centertext,centertext);
 settextstyle(defaultfont,horizdir,1);
 outtextxy((2*winx+winlung)div 2,winy+14,wintitle);
 setfillstyle(solidfill,black);fillellipse((2*winx+24)div 2,(2*winy+24)div 2,2,2);
   end;
 2:begin
 setfillstyle(solidfill,lightgray);
 if winzoom>0 then panoucuzoom(winx,winy,winx+winlung,winy+winlat,lightgray,winzoom)
 else bar(winx,winy,winx+winlung,winy+winlat);
 setfillstyle(solidfill,lightblue);bar(winx+4,winy+4,winx+winlung-5,winy+20);
 setcolor(darkgray);rectangle(winx,winy,winx+winlung-1,winy+winlat-1);
 line(winx+4,winy+4,winx+winlung-5,winy+4);line(winx+4,winy+4,winx+4,winy+20);
 setcolor(white);line(winx+1,winy+1,winx+winlung-2,winy+1);
 line(winx+1,winy+1,winx+1,winy+winlat-2);
 line(winx+4,winy+20,winx+winlung-4,winy+20);
 line(winx+winlung-4,winy+20,winx+winlung-4,winy+4);
 setcolor(black);
 line(winx,winy+winlat,winx+winlung,winy+winlat);
 line(winx+winlung,winy+winlat,winx+winlung,winy);
 line(winx+20,winy+19,winx+20,winy+4);
 line(winx+8,winy+12,winx+16,winy+12);line(winx+8,winy+13,winx+16,winy+13);
 settextjustify(centertext,centertext);
 settextstyle(defaultfont,horizdir,1);
 outtextxy((2*winx+winlung)div 2,winy+13,wintitle);
   end;
 3:begin
   setfillstyle(solidfill,lightgray);
   if winzoom>0 then panoucuzoom(winx,winy,winx+winlung,winy+winlat,lightgray,winzoom)
   else bar(winx,winy,winx+winlung,winy+winlat);
   setcolor(black);rectangle(winx,winy,winx+winlung,winy+winlat);

   setcolor(DARKGRAY);moveto(winx+1, winy+winlat-1);lineto(winx+winlung-1, winy+winlat-1);
   lineto(winx+winlung-1, winy);moveto(winx+2, winy+winlat-2);lineto(winx+winlung-2, winy+winlat-2);
   lineto(winx+winlung-2, winy+1);moveto(winx+winlung-5, winy+5);
   lineto(winx+5, winy+5);lineto(winx+5, winy+winlat-5);
   setcolor(WHITE);lineto(winx+winlung-5, winy+winlat-5);lineto(winx+winlung-5, winy+5);
   moveto(winx+winlung-1, winy+1);lineto(winx+1, winy+1);lineto(winx+1, winy+winlat);
   moveto(winx+winlung-2, winy+2);lineto(winx+2, winy+2);lineto(winx+2, winy+winlat-1);
   keret(winx+20,winy+6,winx+winlung-6,winy+21,1);
   keret(winx+6,winy+6,winx+20,winy+21,1);
   setcolor(black);
   line(winx+9,winy+12,winx+16,winy+12);line(winx+9,winy+13,winx+16,winy+13);
   settextjustify(centertext,centertext);
   settextstyle(defaultfont,horizdir,1);
   outtextxy((2*winx+winlung)div 2,winy+15,wintitle);
   end;
 4:begin
   setfillstyle(solidfill,lightgray);
   if winzoom>0 then panoucuzoom(winx,winy,winx+winlung,winy+winlat,lightgray,winzoom)
   else bar(winx,winy,winx+winlung,winy+winlat);

   keret(winx+20,winy+5,winx+winlung-5,winy+21,0);
   keret(winx+5,winy+5,winx+18,winy+21,0);
   keret(winx+6,winy+6,winx+17,winy+20,1);
   keret(winx+5,winy+24,winx+winlung-5,winy+winlat-5,0);

   setcolor(darkgray);rectangle(winx+1,winy+1,winx+winlung,winy+winlat);
   setcolor(white);line(winx+1,winy+1,winx+winlung-1,winy+1);
   line(winx+1,winy+1,winx+1,winy+winlat-1);

   setcolor(black);
   line(winx+10,winy+12,winx+13,winy+12);
   line(winx+10,winy+13,winx+13,winy+13);
   settextjustify(centertext,centertext);
   settextstyle(defaultfont,horizdir,1);
   outtextxy((2*winx+winlung)div 2,winy+13,wintitle);
   end;
 5:begin
 setfillstyle(solidfill,lightgray);
 if winzoom>0 then panoucuzoom(winx,winy,winx+winlung,winy+winlat,lightgray,winzoom)
 else bar(winx,winy,winx+winlung,winy+winlat);
 setfillstyle(solidfill,lightblue);bar(winx,winy,winx+winlung,winy+20);

 setcolor(lightblue); { Albastru S3 Trio }
 for f:=1 to 5 do rectangle(winx+f,winy+f,winx+winlung-f,winy+winlat-f);

 setcolor(darkgray);line(winx+winlung-5,winy+21,winx+winlung-5,winy+winlat-5);
 line(winx+5,winy+winlat-5,winx+winlung-5,winy+winlat-5);
 setcolor(white);line(winx+5,winy+21,winx+5,winy+winlat-5);
 rectangle(winx+5,winy+5,winx+winlung-5,winy+21);

 setcolor(black);
 rectangle(winx,winy,winx+winlung,winy+winlat);
 line(winx+5,winy+20,winx+winlung-5,winy+20);
 line(winx+20,winy+20,winx+20,winy+6);
 settextjustify(centertext,centertext);
 settextstyle(defaultfont,horizdir,1);
 outtextxy((2*winx+winlung)div 2,winy+14,wintitle);
 setfillstyle(solidfill,black);fillellipse((2*winx+24)div 2,(2*winy+24)div 2,2,2);
   end;
end;
if winloaded then
 begin
  if wintiled then tileimg(winx+5,winy+22,winx+winlung-5,winy+winlat-5,winpo)
  else putimage(winx+5,winy+22,winpo^,copyput);
  freemem(winpo,winmarpo);
  winloaded:=false;
 end;
 showmouse;winshowed:=true;
end;

Procedure TWindow.Move;
var x1p,y1p,xa,ya:integer;
    po:pointer;mar:word;
begin
 if not winmoveable then exit;
 If leftpressed then if
     apartine(mousex,mousey,winx+20,winy+5,winx+winlung-5,winy+20) then
     begin
      setwritemode(xorput);setLinestyle(3,0,0);SetColor(white);
      xa:=mousex-winx;ya:=mousey-winy;
      x1p:=winx;y1p:=winy;
      hidemouse;Rectangle(x1p,y1p,x1p+winlung,y1p+winlat);showmouse;
      repeat
        If ((mousex<>x1p+xa) or (mousey<>y1p+ya)) then
          Begin
             if x1p<winx1 then begin x1p:=winx1;movemouse(x1p+xa,y1p+ya);end;
             if x1p+winlung>winx2 then begin x1p:=winx2-winlung;movemouse(x1p+xa,y1p+ya);end;
             if y1p<winy1 then begin y1p:=winy1;movemouse(x1p+xa,y1p+ya);end;
             if y1p+winlat>winy2 then begin y1p:=winy2-winlat;movemouse(x1p+xa,y1p+ya);end;
            HideMouse;
            Rectangle(x1p,y1p,x1p+winlung,y1p+winlat);
            x1p:=mousex-xa;y1p:=mousey-ya;
             if x1p<winx1 then begin x1p:=winx1;movemouse(x1p+xa,y1p+ya);end;
             if x1p+winlung>winx2 then begin x1p:=winx2-winlung;movemouse(x1p+xa,y1p+ya);end;
             if y1p<winy1 then begin y1p:=winy1;movemouse(x1p+xa,y1p+ya);end;
             if y1p+winlat>winy2 then begin y1p:=winy2-winlat;movemouse(x1p+xa,y1p+ya);end;
            Rectangle(x1p,y1p,x1p+winlung,y1p+winlat);ShowMouse;
          End;
      until not LeftPressed;
      hidemouse;Rectangle(x1p,y1p,x1p+winlung,y1p+winlat);showmouse;
if (x1p<>winx)or(y1p<>winy) then begin

      if not winxms then
       begin
       mar:=imagesize(winx,winy,winx+winlung,winy+winlat);
       if mar>maxavail then
         begin
          closegraph;
          writeln(' Eroare de executie !');
          writeln(' Insuficienta memorie pentru a rula acest program !');
          halt(2);
         end;
         getmem(po,mar);
         hidemouse;getimage(winx,winy,winx+winlung,winy+winlat,po^);showmouse;
       end
       else
       begin
         if not xmsinstalled then
            begin
               closegraph;
               writeln('Eroare XMS');
               writeln('Nu a fost detectat HiMem.Sys sau alt driver echivalent');
               halt;
            end;
         allocextmem(GetImageSize(winx,winy,winx+winlung,winy+winlat),winhan1);
         if xmserror>0 then begin
                             closegraph;
                             writeln('Eroare XMS. Alocare de memorie nereusita');
                             writeln('Probabil sunteti deja in modul protejat');
                             halt;
                            end;
         hidemouse;
         storeimage(winx,winy,winx+winlung,winy+winlat,winhan1,0);
         showmouse;
       end;


      if winsaved then restore;
      winx:=x1p;winy:=y1p;
      if winsaved then save;

      if not winxms then
       begin
         hidemouse;putimage(winx,winy,po^,copyput);freemem(po,mar);showmouse;
       end
       else
       begin
         hidemouse;
         restoreimage(winx,winy,winhan1,0);
         freeextmem(winhan1);
         showmouse;
       end;
     end;

 end;

end;

procedure TWindow.SetArea;
begin
 winx1:=x1;winy1:=y1;
 winx2:=x2;winy2:=y2;
end;

function TWindow.OutClicked;
begin
 OutClicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx<winx)or(ev.mx>winx+winlung)or
        (ev.my<winy)or(ev.my>winy+winlat)
 then
   begin
     while leftpressed and
        ((mousex<winx)or(mousex>winx+winlung)or
        (mousey<winy)or(mousey>winy+winlat))do;
     if (mousex<winx)or(mousex>winx+winlung)or
        (mousey<winy)or(mousey>winy+winlat)then OutClicked:=true;
   end;
end;

function TWindow.Clicked;
begin
 Clicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx>winx+5)and(ev.mx<winx+20)and
        (ev.my>winy+5)and(ev.my<winy+20)
 then begin
        hidemouse;
        setlinestyle(0,0,0);setwritemode(copyput);
        case wintip of
        1:begin
        setcolor(white);line(winx+20,winy+20,winx+20,winy+6);
                        line(winx+20,winy+20,winx+6,winy+20);
        setcolor(black);line(winx+5,winy+5,winx+20,winy+5);
                       line(winx+5,winy+5,winx+5,winy+20);
        setfillstyle(solidfill,lightblue);bar(winx+6,winy+6,winx+19,winy+19);
        setfillstyle(solidfill,black);
        fillellipse((2*winx+24)div 2+2,(2*winy+24)div 2+2,2,2);
          end;
        2:begin
        setcolor(white);line(winx+4,winy+4,winx+20,winy+4);
                        line(winx+4,winy+4,winx+4,winy+20);
        setcolor(darkgray);line(winx+20,winy+4,winx+20,winy+20);
                       line(winx+20,winy+20,winx+4,winy+20);
        setfillstyle(solidfill,lightblue);bar(winx+5,winy+5,winx+19,winy+19);
        setfillstyle(solidfill,black);
        fillellipse((2*winx+24)div 2,(2*winy+24)div 2,2,2);
          end;
        3:begin
        setfillstyle(solidfill,lightgray);bar(winx+7,winy+7,winx+19,winy+20);
        keret(winx+6,winy+6,winx+20,winy+21,0);
        setcolor(black);
        line(winx+9,winy+10,winx+16,winy+10);line(winx+9,winy+11,winx+16,winy+11);
        line(winx+9,winy+10,winx+16,winy+10);line(winx+9,winy+11,winx+16,winy+11);
        line(winx+9,winy+16,winx+16,winy+16);line(winx+9,winy+17,winx+16,winy+17);
        line(winx+9,winy+16,winx+16,winy+16);line(winx+9,winy+17,winx+16,winy+17);
          end;
        4:begin
        keret(winx+6,winy+6,winx+17,winy+20,0);
          end;
        end;
        showmouse;
        while leftpressed and
         (mousex>winx+5)and(mousex<winx+20)and
         (mousey>winy+5)and(mousey<winy+20) do;
        hidemouse;
        case wintip of
        1:begin
        setcolor(black);line(winx+20,winy+20,winx+20,winy+6);
                        line(winx+20,winy+20,winx+6,winy+20);
        setcolor(white);line(winx+5,winy+5,winx+20,winy+5);
                       line(winx+5,winy+5,winx+5,winy+20);
        setfillstyle(solidfill,lightblue);bar(winx+6,winy+6,winx+19,winy+19);
        setfillstyle(solidfill,black);setcolor(black);
        fillellipse((2*winx+24)div 2,(2*winy+24)div 2,2,2);
          end;
        2:begin
        setcolor(darkgray);line(winx+4,winy+4,winx+20,winy+4);
                        line(winx+4,winy+4,winx+4,winy+20);
        setcolor(white);line(winx+20,winy+5,winx+20,winy+20);
                       line(winx+20,winy+20,winx+4,winy+20);
        setfillstyle(solidfill,lightblue);bar(winx+5,winy+5,winx+19,winy+19);
        setcolor(black);
        line(winx+20,winy+19,winx+20,winy+4);
        line(winx+8,winy+12,winx+16,winy+12);line(winx+8,winy+13,winx+16,winy+13);
          end;
        3:begin
        setfillstyle(solidfill,lightgray);bar(winx+7,winy+7,winx+19,winy+20);
        keret(winx+6,winy+6,winx+20,winy+21,1);
        setcolor(black);
        line(winx+9,winy+12,winx+16,winy+12);line(winx+9,winy+13,winx+16,winy+13);
          end;
        4:begin
        keret(winx+6,winy+6,winx+17,winy+20,1);
          end;
        end;
        showmouse;
        if (mousex>winx+5)and(mousex<winx+20)and
         (mousey>winy+5)and(mousey<winy+20) then Clicked:=true;
      end;
end;

Procedure TWindow.Save;
begin

 if not winxms then
   begin
     if imagesize(winx,winy,winx+winlung,winy+winlat)>maxavail then
         begin
          closegraph;
          writeln(' Eroare de executie !');
          writeln(' Insuficienta memorie pentru a rula acest program !');
          halt(2);
         end;
     winbgsize:=imagesize(winx,winy,winx+winlung,winy+winlat);
     getmem(winbg,winbgsize);
     hidemouse;
     getimage(winx,winy,winx+winlung,winy+winlat,winbg^);
     showmouse;
   end
   else
   begin
     if not xmsinstalled then
        begin
         closegraph;
         writeln('Eroare XMS');
         writeln('Nu a fost detectat HiMem.Sys sau alt driver echivalent');
         halt(2);
        end;
     allocextmem(GetImageSize(winx,winy,winx+winlung,winy+winlat),winhan2);
     if xmserror>0 then begin
                          closegraph;
                          writeln('Eroare XMS. Alocare de memorie nereusita');
                          writeln('Probabil sunteti deja in modul protejat');
                          halt;
                        end;
     hidemouse;
     storeimage(winx,winy,winx+winlung,winy+winlat,winhan2,0);
     showmouse;
   end;
end;

procedure TWindow.Restore;
begin
 if not winxms then
   begin
     hidemouse;
     putimage(winx,winy,winbg^,normalput);
     showmouse;
     freemem(winbg,winbgsize);
     winbg:=nil;
   end
   else
   begin
     hidemouse;
     restoreimage(winx,winy,winhan2,0);
     freeextmem(winhan2);
     showmouse;
   end
end;

Destructor TWindow.Done;
begin
 if winsaved then restore;
end;

Constructor TButton.Init;
begin
 butx:=x;buty:=y;buttip:=0;
 butlung:=lung;butlat:=lat;
 buttitle:=title;
 butwin:=w;
 butenabled:=true;
 CulTitle:=black;
 icofile:=false;
end;


Constructor TButton.InitIco;
type IconType=record lung,lat:integer;front:array[1..50000]of byte;end;
begin
 ButX:=x;ButY:=y;butlung:=lung;butlat:=lat;
 buttip:=tip;if buttip=0 then buttip:=1;
 butenabled:=true;
 icoadr:=adr;butwin:=w;
 icoimalung:=Icontype(icoadr^).lung;
 icoimalat:=Icontype(icoadr^).lat;
 icofile:=false;
case buttip of
 1,4:begin
   if ButLung+8<icoimalung then ButLung:=icoimalung+8;
   if ButLat+8<icoimalat then ButLat:=icoimalat+8;
   end;
 2:begin
   if ButLung+3<icoimalung then ButLung:=icoimalung+3;
   if ButLat+3<icoimalat then ButLat:=icoimalat+3;
   end;
 3:begin
   if ButLung<icoimalung then ButLung:=icoimalung;
   if ButLat<icoimalat then ButLat:=icoimalat;
   end;
end;
end;

Constructor TButton.InitIco2;
var f:file;
    undeexista:byte;
begin
 undeexista:=0;
 if Lib_FileExist(filename)
  then undeexista:=1
  else if FileExist(filename)then undeexista:=2;

 if undeexista=0 then
 begin
    icofile:=false;
    if lung<20 then lung:=20;
    if lat<10 then lat:=20;
    init(w,x,y,lung,lat,'?');
 end;

 if undeexista=1 then
 begin
   icofile:=true;
   lib_reset(f,filename);
   icofmar:=lib_filesize;
   getmem(icofadr,icofmar+16);
   blockread(f,icofadr^,icofmar);
   close(f);
   InitIco(w,x,y,lung,lat,tip,icofadr);
 end;

 if undeexista=2 then
 begin
   assign(f,filename);
   {$I-}reset(f,1){$I+};
   icofile:=true;
   icofmar:=filesize(f);close(f);
   getmem(icofadr,icofmar+16);
   reset(f,icofmar);
   blockread(f,icofadr^,1);
   close(f);
   InitIco(w,x,y,lung,lat,tip,icofadr);
 end;

end;


procedure TButton.Show;
var i,j,x1,y1,x2,y2:integer;
    delta1,delta2:integer;
type IconType  =record lung,lat:integer;front:array[1..50000]of byte;end;
begin
  hidemouse;
case Buttip of
  0:begin
     setlinestyle(0,0,0);setwritemode(copyput);
     setfillstyle(solidfill,lightgray);
     Bar(butwin^.winx+butx,butwin^.winy+buty,
               butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);
     setcolor(white);
     line(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty);
     line(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx,butwin^.winy+buty+butlat);

     setcolor(darkgray);
     line(butwin^.winx+butx+butlung,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);
     line(butwin^.winx+butx,butwin^.winy+buty+butlat,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

     settextjustify(centertext,centertext);
     settextstyle(defaultfont,horizdir,1);
     if butenabled then
     setcolor(CulTitle) else
     setcolor(darkgray);
     outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2,
           (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2,buttitle);

     setcolor(black);
     Rectangle(butwin^.winx+butx-1,butwin^.winy+buty-1,
               butwin^.winx+butx+butlung+1,butwin^.winy+buty+butlat+1);
    end;
  1,2,3,4:begin
       x1:=ButWin^.winx+ButX;y1:=ButWin^.winy+ButY;
       delta1:=(ButLung-icoimalung)div 2;delta2:=(ButLat-icoimalat)div 2;
       setwritemode(copyput);setlinestyle(0,0,0);
       case buttip of
         1:begin
            setfillstyle(solidfill,lightgray);bar(x1,y1,x1+ButLung,y1+ButLat);
            keret(x1,y1,x1+ButLung,y1+ButLat,1);
            if butenabled then for i:=1 to icoimalung do for j:=1 to icoimalat do
             putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[j+(i-1)*icoimalung])
            else for i:=1 to icoimalung do for j:=1 to ButLat do
             putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[icoimalung*icoimalat+j+(i-1)*icoimalung]);
           end;
         2:begin
            setfillstyle(solidfill,lightgray);bar(x1,y1,x1+ButLung,y1+ButLat);
            keret(x1,y1,x1+ButLung,y1+ButLat,1);
            for i:=1 to icoimalung do for j:=1 to icoimalat do
             putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[j+(i-1)*icoimalung])
           end;
         3:begin
            for i:=1 to icoimalung do for j:=1 to icoimalat do
             putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[j+(i-1)*icoimalung])
           end;
         4:begin
            setfillstyle(solidfill,lightgray);bar(x1,y1,x1+ButLung,y1+ButLat);
            keret(x1,y1,x1+ButLung,y1+ButLat,1);
            for i:=1 to icoimalung do for j:=1 to icoimalat do
             putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[j+(i-1)*icoimalung])
           end;
       end;
  end;
 end;
 Showmouse;
end;

procedure TButton.DeSelect;
begin
 CulTitle:=Black;
 Show;
end;

procedure TButton.Select;
begin
 CulTitle:=Cul;
 Show;
end;


procedure TButton.ShowPressed;
var delta1,delta2,i,j,x1,y1:integer;
type IconType  =record lung,lat:integer;front:array[1..50000]of byte;end;
begin
     hidemouse;
case Buttip of
  0:begin
     setlinestyle(0,0,0);setwritemode(copyput);
     setfillstyle(solidfill,lightgray);
     Bar(butwin^.winx+butx,butwin^.winy+buty,
               butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);
     setcolor(darkgray);
     line(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty);
     line(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx,butwin^.winy+buty+butlat);

     setcolor(white);
     line(butwin^.winx+butx+butlung,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);
     line(butwin^.winx+butx,butwin^.winy+buty+butlat,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

     settextjustify(centertext,centertext);
     settextstyle(defaultfont,horizdir,1);
     if butenabled then
     setcolor(CulTitle) else
     setcolor(darkgray);
     outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2+2,
           (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+2,buttitle);

     setcolor(black);
     Rectangle(butwin^.winx+butx-1,butwin^.winy+buty-1,
               butwin^.winx+butx+butlung+1,butwin^.winy+buty+butlat+1);
  end;
 1,2,3,4:begin
      x1:=ButWin^.winx+ButX;y1:=ButWin^.winy+ButY;
      delta1:=(ButLung-icoimalung)div 2;delta2:=(ButLat-icoimalat)div 2;
      setwritemode(copyput);setlinestyle(0,0,0);
      case buttip of
       1:begin
         if butenabled then
         begin
          for i:=1 to icoimalung do for j:=1 to icoimalat do
           putpixel(x1+i+delta1+3,y1+j+delta2+3,Icontype(icoadr^).front[icoimalung*icoimalat+j+(i-1)*icoimalung]);
          for i:=1 to icoimalung do for j:=1 to icoimalat do
           if Icontype(icoadr^).front[j+(i-1)*icoimalung]<>lightgray then
           putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[j+(i-1)*icoimalung]);
         end;
         keret(x1,y1,x1+ButLung,y1+ButLat,0);
       end;
       2:begin
          for i:=1 to icoimalung do for j:=1 to icoimalat do
          putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[icoimalung*icoimalat+j+(i-1)*icoimalung]);
          keret(x1,y1,x1+ButLung,y1+ButLat,0);
       end;
       3:begin
          for i:=1 to icoimalung do for j:=1 to icoimalat do
          putpixel(x1+i+delta1,y1+j+delta2,Icontype(icoadr^).front[icoimalung*icoimalat+j+(i-1)*icoimalung]);
       end;
       4:begin
         setfillstyle(solidfill,lightgray);bar(x1,y1,x1+ButLung,y1+ButLat);
         for i:=1 to icoimalung do for j:=1 to icoimalat do
            putpixel(x1+i+delta1+2,y1+j+delta2+2,Icontype(icoadr^).front[j+(i-1)*icoimalung]);
         keret(x1,y1,x1+ButLung,y1+ButLat,0);
        end;
     end;

  end;
  end;
  Showmouse;
end;


Procedure TButton.Enable;
begin
 if not butenabled then begin butenabled:=true;show;end;
end;

Procedure TButton.Disable;
begin
 if butenabled then begin butenabled:=false;show;end;
end;

Procedure TButton.Retitle;
begin
 buttitle:=ttitle;
 show;
end;

Function  TButton.Clicked;
begin
 Clicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx>butwin^.winx+butx)and(ev.mx<butwin^.winx+butx+butlung)and
        (ev.my>butwin^.winy+buty)and(ev.my<butwin^.winy+buty+butlat)
        and butenabled
 then begin
        ShowPressed;
        while leftpressed and
         (mousex>butwin^.winx+butx)and(mousex<butwin^.winx+butx+butlung)and
         (mousey>butwin^.winy+buty)and(mousey<butwin^.winy+buty+butlat) do;
        Show;
     if (mousex>butwin^.winx+butx)and(mousex<butwin^.winx+butx+butlung)and
        (mousey>butwin^.winy+buty)and(mousey<butwin^.winy+buty+butlat) then
        Clicked:=true;
      end;
end;

Destructor TButton.Done;
begin
 if icofile then freemem(icofadr,icofmar);
end;

Procedure TMSButton.Show;
begin
   hidemouse;
   setlinestyle(0,0,0);setwritemode(copyput);
   setfillstyle(solidfill,lightgray);
   Bar(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

   setcolor(white);
   line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+butlung-1,butwin^.winy+buty+1);
   line(butwin^.winx+butx+1,butwin^.winy+buty+2,butwin^.winx+butx+butlung-2,butwin^.winy+buty+2);
   line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+1,butwin^.winy+buty+butlat-2);
   line(butwin^.winx+butx+2,butwin^.winy+buty+1,butwin^.winx+butx+2,butwin^.winy+buty+butlat-3);

   setcolor(darkgray);
   line(butwin^.winx+butx+1,butwin^.winy+buty+butlat-1,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat-1);
   line(butwin^.winx+butx+2,butwin^.winy+buty+butlat-2,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat-2);
   line(butwin^.winx+butx+butlung-1,butwin^.winy+buty+2,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat-1);
   line(butwin^.winx+butx+butlung-2,butwin^.winy+buty+3,butwin^.winx+butx+butlung-2,butwin^.winy+buty+butlat-1);

   setcolor(black);
   line(butwin^.winx+butx+1,butwin^.winy+buty,butwin^.winx+butx+butlung-1,butwin^.winy+buty);
   line(butwin^.winx+butx+1,butwin^.winy+buty+butlat,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat);
   line(butwin^.winx+butx,butwin^.winy+buty+1,butwin^.winx+butx,butwin^.winy+buty+butlat-1);
   line(butwin^.winx+butx+butlung,butwin^.winy+buty+1,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat-1);

   settextjustify(centertext,centertext);
   settextstyle(defaultfont,horizdir,1);
   if butenabled then
   setcolor(CulTitle) else
   setcolor(darkgray);
   outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2,
         (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2,buttitle);

   showmouse;
end;

Procedure TMSButton.ShowPressed;
begin
   hidemouse;
   setlinestyle(0,0,0);setwritemode(copyput);
   setfillstyle(solidfill,lightgray);
   Bar(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

   setcolor(darkgray);
   line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+butlung-1,butwin^.winy+buty+1);
   line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+1,butwin^.winy+buty+butlat-2);

   setcolor(black);
   line(butwin^.winx+butx+1,butwin^.winy+buty,butwin^.winx+butx+butlung-1,butwin^.winy+buty);
   line(butwin^.winx+butx+1,butwin^.winy+buty+butlat,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat);
   line(butwin^.winx+butx,butwin^.winy+buty+1,butwin^.winx+butx,butwin^.winy+buty+butlat-1);
   line(butwin^.winx+butx+butlung,butwin^.winy+buty+1,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat-1);

   settextjustify(centertext,centertext);
   settextstyle(defaultfont,horizdir,1);
   if butenabled then
   setcolor(CulTitle) else
   setcolor(darkgray);
   outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2+2,
        (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+2,buttitle);

   showmouse;
end;


Constructor TOS2Button.Init;
begin
 butx:=x;buty:=y;buttip:=0;
 os2buttip:=tip;
 butlung:=lung;butlat:=lat;
 buttitle:=title;
 butwin:=w;
 butenabled:=true;
 icofile:=false;
 CulTitle:=Black;
end;


Procedure TOS2Button.Show;
var x1,y1,x2,y2:integer;
begin
 hidemouse;
 setlinestyle(0,0,0);setwritemode(copyput);
 case os2buttip of
  1: begin
       setfillstyle(solidfill,lightgray);
       Bar(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

       settextjustify(centertext,centertext);
       settextstyle(defaultfont,horizdir,1);
       if butenabled then
       setcolor(CulTitle) else
       setcolor(darkgray);
       outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2,
         (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+1,buttitle);
     end;
  2: begin
       setfillstyle(solidfill,lightgray);
       Bar(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

       setcolor(white);
       line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+butlung-1,butwin^.winy+buty+1);
       line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+1,butwin^.winy+buty+butlat-2);

       setcolor(darkgray);
       line(butwin^.winx+butx+1,butwin^.winy+buty+butlat-1,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat-1);
       line(butwin^.winx+butx+butlung-1,butwin^.winy+buty+2,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat-1);

       settextjustify(centertext,centertext);
       settextstyle(defaultfont,horizdir,1);
       if butenabled then
       setcolor(CulTitle) else
       setcolor(darkgray);
       outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2,
         (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+1,buttitle);
     end;
  3: begin
      if GetMaxColor>15 then
       begin
         x1:=butwin^.winx+butx;
         y1:=butwin^.winy+buty;
         x2:=butwin^.winx+butx+butlung;
         y2:=butwin^.winy+buty+butlat;
         setfillstyle(solidfill,lightgray);
         Bar(x1+6,y1+6,x2-6,y2-6);

         SetColor(Gray1);
         Line(x1+4,y1+4,x2-5,y1+4);
         Line(x1+4,y1+5,x2-6,y1+5);
         Line(x1+4,y1+6,x1+4,y2-5);
         Line(x1+5,y1+6,x1+5,y2-6);

         SetColor(Gray3);
         Line(x1+5,y2-5,x2-6,y2-5);
         Line(x2-5,y2-5,x2-5,y1+5);

         SetColor(Gray4);
         Line(x1+4,y2-4,x2-4,y2-4);
         Line(x2-4,y2-5,x2-4,y1+4);

         SetColor(White2);
         Line(x1+3,y1+3,x1+3,y2-4);
         Line(x1+4,y1+3,x2-4,y1+3);

         SetColor(Gray5);
         Line(x1+3,y2-3,x2-3,y2-3);
         Line(x2-3,y2-4,x2-3,y1+3);

         SetColor(White);
         Line(x1+2,y1+2,x1+2,y2-3);
         Line(x1+3,y1+2,x2-3,y1+2);

         SetColor(Gray6);
         Line(x1+2,y2-2,x2-2,y2-2);
         Line(x2-2,y2-3,x2-2,y1+2);

         SetColor(Black);
         Rectangle(x1+1,y1+1,x2-1,y2-1);

         SetColor(Gray4);
         Line(x1,y2-1,x1,y1);
         Line(x1+1,y1,x2-1,y1);

         SetColor(White2);
         Line(x1,y2,x2,y2);
         Line(x2,y2-1,x2,y1);

         settextjustify(centertext,centertext);
         settextstyle(defaultfont,horizdir,1);
         if butenabled then
         setcolor(CulTitle) else
         setcolor(darkgray);
         outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2,
            (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+1,buttitle);
      end
      else inherited Show;
     end;
     4:begin
      if GetMaxColor>15 then
       begin
         x1:=butwin^.winx+butx;
         y1:=butwin^.winy+buty;
         x2:=butwin^.winx+butx+butlung;
         y2:=butwin^.winy+buty+butlat;
         setfillstyle(solidfill,lightgray);
         Bar(x1+2,y1+6,x2-2,y2-6);

         SetColor(Gray3);Line(x1+2,y2-5,x2-2,y2-5);
         SetColor(Gray4);Line(x1+2,y2-4,x2-2,y2-4);
         SetColor(Gray5);Line(x1+2,y2-3,x2-2,y2-3);
         SetColor(Gray6);Line(x1+2,y2-2,x2-2,y2-2);
         SetColor(Gray1);Line(x1+2,y1+5,x2-2,y1+5);
                         Line(x1+2,y1+4,x2-2,y1+4);
         SetColor(White2);Line(x1+2,y1+3,x2-2,y1+3);
         SetColor(White);Line(x1+2,y1+2,x2-2,y1+2);

         SetColor(Black);Rectangle(x1+1,y1+1,x2-1,y2-1);

         SetColor(Gray4);
         Line(x1,y2-1,x1,y1);
         Line(x1+1,y1,x2-1,y1);

         SetColor(White2);
         Line(x1,y2,x2,y2);
         Line(x2,y2-1,x2,y1);

         settextjustify(centertext,centertext);
         settextstyle(defaultfont,horizdir,1);
         if butenabled then
         setcolor(CulTitle) else
         setcolor(darkgray);
         outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2,
            (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+1,buttitle);
       end
       else inherited Show;

     end;
 end;
 showmouse;
end;


Procedure TOS2Button.ShowPressed;
var x1,y1,x2,y2:integer;
begin
 hidemouse;
 setlinestyle(0,0,0);setwritemode(copyput);
 case os2buttip of
  1: begin
       if GetMaxColor>15
         then setfillstyle(solidfill,Gray3)
         else setfillstyle(solidfill,lightgray);
       Bar(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

       if GetMaxColor>15
         then setcolor(Gray5)
         else setcolor(darkgray);
       line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+butlung-1,butwin^.winy+buty+1);
       line(butwin^.winx+butx+1,butwin^.winy+buty+1,butwin^.winx+butx+1,butwin^.winy+buty+butlat-2);

       setcolor(white);
       line(butwin^.winx+butx+1,butwin^.winy+buty+butlat-1,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat-1);
       line(butwin^.winx+butx+butlung-1,butwin^.winy+buty+2,butwin^.winx+butx+butlung-1,butwin^.winy+buty+butlat-1);

       settextjustify(centertext,centertext);
       settextstyle(defaultfont,horizdir,1);
       if butenabled then
       setcolor(CulTitle) else
       setcolor(darkgray);
       outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2+2,
         (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+2,buttitle);
     end;
  2: begin
       setfillstyle(solidfill,lightgray);
       Bar(butwin^.winx+butx,butwin^.winy+buty,butwin^.winx+butx+butlung,butwin^.winy+buty+butlat);

       settextjustify(centertext,centertext);
       settextstyle(defaultfont,horizdir,1);
       if butenabled then
       setcolor(CulTitle) else
       setcolor(darkgray);
       outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2+2,
         (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+2,buttitle);
     end;
  3: begin
      if GetMaxColor>15 then
       begin
         x1:=butwin^.winx+butx;
         y1:=butwin^.winy+buty;
         x2:=butwin^.winx+butx+butlung;
         y2:=butwin^.winy+buty+butlat;
         setfillstyle(solidfill,lightgray);
         Bar(x1+7,y1+7,x2-5,y2-5);

         SetColor(Gray1);
         Line(x1+5,y1+5,x2-5,y1+5);
         Line(x1+5,y1+6,x2-5,y1+6);
         Line(x1+5,y1+7,x1+5,y2-4);
         Line(x1+6,y1+7,x1+6,y2-5);

         SetColor(Gray3);
         Line(x1+6,y2-4,x2-4,y2-4);
         Line(x2-4,y2-5,x2-4,y1+5);

         SetColor(Gray4);
         Line(x1+5,y2-3,x2-3,y2-3);
         Line(x2-3,y2-4,x2-3,y1+4);

         SetColor(Gray5);
         Line(x1+4,y2-2,x2-2,y2-2);
         Line(x2-2,y2-3,x2-2,y1+3);

         SetColor(Gray6);
         Line(x1+3,y2-1,x2-1,y2-1);
         Line(x2-1,y2-2,x2-1,y1+2);

         SetColor(White2);
         Line(x1+4,y2-3,x1+4,y1+5);
         Line(x1+4,y1+4,x2-4,y1+4);

         SetColor(White);
         Line(x1+3,y2-2,x1+3,y1+4);
         Line(x1+3,y1+3,x2-3,y1+3);

         SetColor(Black);
         Line(x1+2,y2-1,x1+2,y1+3);
         Line(x1+1,y2-1,x1+1,y1+3);
         Line(x1+1,y1+2,x2-2,y1+2);
         Line(x1+1,y1+1,x2-1,y1+1);

         SetColor(Gray4);
         Line(x1,y2-1,x1,y1);
         Line(x1+1,y1,x2-1,y1);

         SetColor(White2);
         Line(x1,y2,x2,y2);
         Line(x2,y2-1,x2,y1);

         settextjustify(centertext,centertext);
         settextstyle(defaultfont,horizdir,1);
         if butenabled then
         setcolor(CulTitle) else
         setcolor(darkgray);
         outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2+2,
           (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+2,buttitle);
       end
      else inherited ShowPressed;
     end;
     4:begin
      if GetMaxColor>15 then
       begin
         x1:=butwin^.winx+butx;
         y1:=butwin^.winy+buty;
         x2:=butwin^.winx+butx+butlung;
         y2:=butwin^.winy+buty+butlat;
         setfillstyle(solidfill,lightgray);
         Bar(x1+2,y1+7,x2-2,y2-5);

         SetColor(Gray3);Line(x1+2,y2-4,x2-2,y2-4);
                         Line(x1+2,y2-3,x2-2,y2-3);
         SetColor(Gray4);Line(x1+2,y2-2,x2-2,y2-2);
         SetColor(Gray5);Line(x1+2,y2-1,x2-2,y2-1);
         SetColor(Gray1);Line(x1+2,y1+6,x2-2,y1+6);
                         Line(x1+2,y1+5,x2-2,y1+5);
         SetColor(White2);Line(x1+2,y1+4,x2-2,y1+4);
         SetColor(White);Line(x1+2,y1+3,x2-2,y1+3);

         SetColor(Black);
         Line(x1+2,y1+2,x2-2,y1+2);Line(x1+2,y1+1,x2-2,y1+1);
         Line(x1+1,y1+1,x1+1,y2-1);Line(x2-1,y1+1,x2-1,y2-1);

         SetColor(Gray4);
         Line(x1,y2-1,x1,y1);
         Line(x1+1,y1,x2-1,y1);

         SetColor(White2);
         Line(x1,y2,x2,y2);
         Line(x2,y2-1,x2,y1);

         settextjustify(centertext,centertext);
         settextstyle(defaultfont,horizdir,1);
         if butenabled then
         setcolor(CulTitle) else
         setcolor(darkgray);
         outtextxy((butwin^.winx+butx+butwin^.winx+butx+butlung)div 2+2,
           (butwin^.winy+buty+butwin^.winy+buty+butlat)div 2+2,buttitle);
       end
       else inherited ShowPressed;
     end;
 end;
 showmouse;
end;


Constructor TUsrButton.Init;
type IconType  =record lung,lat:word;end;
type Linear    =array[1..50000]of byte;
begin
 ButX:=x;ButY:=y;
 butenabled:=true;
 icoadr:=adr;butwin:=w;
 ButLung:=1+IconType(icoadr^).lung;
 ButLat:=1+IconType(icoadr^).lat;
 icofile:=false;
end;

var paltemp:virtualpal;
    lookuptable:array[0..255]of byte;
function findclosest16(pal:virtualpal;chkcol:byte):byte;
var i:byte;
    savecol:byte;
    dist,savedist,dx,dy,dz:longint;
begin
  savedist:=200000;
  for i:=0 to 15 do begin
   		dx:=pal[i,1]-pal[chkcol,1];
                dy:=pal[i,2]-pal[chkcol,2];
                dz:=pal[i,3]-pal[chkcol,3];
		dist:=dx*dx+dy*dy+dz*dz;
		if dist < savedist then
			begin
			  savedist:=dist;
			  savecol:=i;
			end;
                    end;
  findclosest16:=savecol;
end;

procedure TUsrButton.Show;
var i,j,x1,y1,x2,y2:integer;
    lu,la:integer;
type Linear =array[1..50000]of byte;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
  hidemouse;
  x1:=ButWin^.winx+ButX;y1:=ButWin^.winy+ButY;
 lu:=Icontype(icoadr^).lung+1;
 la:=Icontype(icoadr^).lat+1;
 if (GetMaxColor<>15) then putimage(x1,y1,Icontype(icoadr^).lung,copyput)
  else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(x1+j,y1+i,lookuptable[Icontype(icoadr^).front[1+i*lu+j]]);
    end;
  Showmouse;
end;


procedure TUsrButton.ShowPressed;
var i,j,x1,y1:integer;
    lu,la:integer;
type Linear =array[1..50000]of byte;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
  hidemouse;
  x1:=ButWin^.winx+ButX;y1:=ButWin^.winy+ButY;
 lu:=Icontype(icoadr^).lung+1;
 la:=Icontype(icoadr^).lat+1;
 if (GetMaxColor<>15) then putimage(x1,y1,Linear(icoadr^)[5+butlung*butlat],copyput)
  else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(x1+j,y1+i,lookuptable[Linear(icoadr^)[9+butlung*butlat+i*lu+j]]);
    end;
  Showmouse;
end;


Constructor TDefButton.Init;
begin
 butx:=x;buty:=y;
 butlung:=lung;butlat:=lat;
 butwin:=w;
 butenabled:=true;
end;


Procedure TDefButton.Enable;
begin
 if not butenabled then butenabled:=true;
end;

Procedure TDefButton.Disable;
begin
 if butenabled then butenabled:=false;
end;

Function  TDefButton.Clicked;
begin
 Clicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx>butwin^.winx+butx)and(ev.mx<butwin^.winx+butx+butlung)and
        (ev.my>butwin^.winy+buty)and(ev.my<butwin^.winy+buty+butlat)
        and butenabled
 then begin
        while leftpressed and
         (mousex>butwin^.winx+butx)and(mousex<butwin^.winx+butx+butlung)and
         (mousey>butwin^.winy+buty)and(mousey<butwin^.winy+buty+butlat) do;
     if (mousex>butwin^.winx+butx)and(mousex<butwin^.winx+butx+butlung)and
        (mousey>butwin^.winy+buty)and(mousey<butwin^.winy+buty+butlat) then
        Clicked:=true;
      end;
end;

Destructor TDefButton.Done;
begin
end;


Constructor TInput.Init;
begin
 inpx:=x;inpy:=y;
 inptip:=tip;
 inpenabled:=true;
 inpnrcar:=nrcar;
 inplung:=lung;if nrcar<>0 then inplung:=nrcar*8+6;
 inpchanged:=false;
 inplat:=22;
 inpmesage:='';
 inpwin:=w;
end;

procedure TInput.settext;
begin
 inpmesage:=mesage;
 if inpnrcar<>0 then inpmesage:=copy(mesage,1,inpnrcar);
end;

procedure TInput.Draw;
var x1,y1:integer;
begin
x1:=inpwin^.winx+inpx;
y1:=inpwin^.winy+inpy;
hidemouse;
setlinestyle(0,0,0);setwritemode(copyput);
case inptip of
0:begin
   setfillstyle(solidfill,lightgray);
   bar(x1,y1,x1+inplung,y1+20);
   keret(x1-1,y1-1,x1+inplung+1,y1+21,0);
   keret(x1,y1,x1+inplung,y1+20,1);
   bkgray:=true;
  end;
1:begin
   setfillstyle(solidfill,lightgray);
   bar(x1,y1,x1+inplung,y1+20);
   keret(x1-2,y1-2,x1+inplung+2,y1+22,1);
   keret(x1,y1,x1+inplung,y1+20,0);
   bkgray:=true;
  end;
2:begin
   setfillstyle(solidfill,white);
   bar(x1,y1,x1+inplung,y1+20);
   setcolor(black);
   rectangle(x1-1,y1-1,x1+inplung+1,y1+21);
   rectangle(x1,y1,x1+inplung,y1+20);
   bkgray:=false;
  end;
3:begin
   setfillstyle(solidfill,white);
   bar(x1,y1,x1+inplung,y1+20);
   setcolor(black);
   rectangle(x1-1,y1-1,x1+inplung+1,y1+21);
   bkgray:=false;
  end;
else
  begin
   setcolor(black);
   setfillstyle(solidfill,lightgray);
   bar(x1,y1,x1+inplung,y1+20);
   rectangle(x1-1,y1-1,x1+inplung+1,y1+21);
   bkgray:=true;
  end;
end;
  showmouse;
end;

procedure TInput.show;
var i:byte;
    x1,y1:integer;
begin
   x1:=inpwin^.winx+inpx;
   y1:=inpwin^.winy+inpy;
   Draw;
  hidemouse;
  settextstyle(0,horizdir,1);
  if not inpenabled then
               if bkgray then setcolor(darkgray)
                         else setcolor(lightgray)
               else setcolor(black);
  if inpmesage<>''then
    begin
    i:=0;
    repeat
    inc(i);
    until ((textwidth(copy(inpmesage,1,i))+3)>inplung)or(i>length(inpmesage));
    settextjustify(LeftText,CenterText);
    outtextxy(x1+3,(2*y1+20)div 2,copy(inpmesage,1,i-1));
    end;
 ShowMouse;
end;

function TInput.Clicked;
begin
 Clicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx>inpwin^.winx+inpx)and(ev.mx<inpwin^.winx+inpx+inplung)and
        (ev.my>inpwin^.winy+inpy)and(ev.my<inpwin^.winy+inpy+inplat)
 then Clicked:=true;
end;

function TInput.edit;
var m,n,n1,p,b,l,i,px,px2:integer;
    ch:char;
    ex,move:boolean;
    ins:byte;
    temp:string;
    x1,y1:integer;
 procedure print;
  begin
  x1:=inpwin^.winx+inpx;
  y1:=inpwin^.winy+inpy;
  hidemouse;
  if move then draw;
  settextjustify(LeftText,CenterText);
  settextstyle(0,0,1);
  setcolor(black);
  if move then outtextxy(x1+3,(2*y1+20)div 2,copy(inpmesage,b,i-b+1));
  setwritemode(XORPut);
  setcolor(lightgray);
  setlinestyle(0,0,1+2*ins);
  if not move then line(x1+(px2-b+1)*8+2,y1+3,x1+(px2-b+1)*8+2,y1+16);
  line(x1+(px-b+1)*8+2,y1+3,x1+(px-b+1)*8+2,y1+16);
  setlinestyle(0,0,1);
  setwritemode(NormalPut);
  px2:=px;
  showmouse;
  move:=false;
  if i>b+l-1 then
     i:=b+l-1;
  end;
  procedure fd;
  begin
  x1:=inpwin^.winx+inpx;
  y1:=inpwin^.winy+inpy;
  if inpnrcar=0 then
     begin
          if px<length(inpmesage)then
          begin
               if px=i then
               if i<length(inpmesage) then
                  begin
                  inc(px);
                  inc(i);
                  inc(b);
                  move:=true;
                  end;
               if px<i then inc(px);
          end;
     end
     else if (px<l)and(px<length(inpmesage)) then inc(px);
  end;
  procedure bk;
  begin
  x1:=inpwin^.winx+inpx;
  y1:=inpwin^.winy+inpy;
  if inpnrcar=0 then
  begin
       if px=1 then px:=0;
       if px=b then
          if b>1 then
             begin
             dec(px);
             dec(b);
             dec(i);
             move:=true;
             end;
       if px>b then dec(px);
  end
  else if px>0 then dec(px);
  end;
begin
     if inpenabled then
            begin
            temp:=inpmesage;
            repeat
            getmousestatus(n1,p,m);
            until m=0;
            move:=true;
            ins:=1;
            i:=length(inpmesage);
            l:=(inplung-3) div textwidth('A');
            b:=i-l+1;
            if l>i then b:=1;
            px:=i;
            hidemouse;
            print;
            repeat
            if keypressed then begin
            ch:=getextcode(ex);
            if ex then
               case ch of
               #77:{ -> }
                   fd;
               #75:{ <- }
                   bk;
               #82:{Insert}
                   begin
                   setwritemode(xorput);
                   setlinestyle(0,0,1+2*ins);
                   line(x1+(px-b+1)*8+2,y1+3,x1+(px-b+1)*8+2,y1+16);
                   ins:=1-ins;
                   setlinestyle(0,0,1+2*ins);
                   line(x1+(px-b+1)*8+2,y1+3,x1+(px-b+1)*8+2,y1+16);
                   setlinestyle(0,0,1);
                   setwritemode(normalput);
                   end;
               #83:{Delete}
                   if (px<i)and(px<length(inpmesage)) then
                      begin
                      delete(inpmesage,px+1,1);
                      if length(inpmesage)<l then dec(i);
                      move:=true;
                   end;
               #79:{End}
                   begin
                   px:=length(inpmesage);
                   i:=px;
                   if length(inpmesage)>l then b:=i-l+1 else b:=1;
                   move:=true;
                   end;
               #71:{Home}
                   begin
                   b:=1;
                   px:=0;
                   i:=l;
                   if length(inpmesage)<l then i:=length(inpmesage);
                   move:=true;
                   end;
               end;
               if not ex then
                  case ch of
                  #8:{Backspace}
                     if px>=1 then begin
                        delete(inpmesage,px,1);
                        dec(px);
                        if (px=b-1)and(px>0)then begin dec(b);dec(i)end;
                        move:=true;
                     end;
                  else if not (ch in [#8,#9,#27,#13]) then
                       if (ins<>1)or(inpnrcar=0)or((inpnrcar<>0)and(length(inpmesage)<inpnrcar)) then
                       begin
                               if ins=1 then
                               begin
                                insert(ch,inpmesage,px+1);
                                if (i-b+1)<l then inc(i);
                                if px=i then begin inc(b);inc(i);end;
                                inc(px);
                               end
                               else if px>0 then inpmesage[px]:=ch;
                               move:=true;
                       end;
                  end;
            print;
            end;
            getmousestatus(n,p,m);
            if n<>n1 then
               begin
               if n>n1 then fd;
               if n<n1 then bk;
               n1:=n;
               print;
               end;
            until ((not ex)and((ch=#27)or(ch=#13)or(ch=#9)))or(m=1);
            showmouse;
            Show;
            if (not ex)and(ch=#27)then begin inpmesage:=temp;show;end;
            end
        else
            begin
            setcolor(darkgray);
            setlinestyle(1,0,1);
            hidemouse;
            if textwidth(inpmesage)<inplung then
            line(x1+2,y1+textheight(inpmesage)+7,x1+textwidth(inpmesage),y1+textheight(inpmesage)+7)
            else line(x1+2,y1+textheight(inpmesage)+7,x1+inplung-4,y1+textheight(inpmesage)+7);
            showmouse;
            setlinestyle(0,0,1);
            waitrelease;
            end;
  inpchanged:=(temp<>inpmesage);
  if not inpenabled then inpchanged:=false;
  waitrelease;
  edit:=inpmesage;
end;

procedure TInput.Enable;
begin
if not inpenabled then
 begin
  inpenabled:=true;
  show;
 end;
end;

procedure TInput.Disable;
begin
if inpenabled then
 begin
  inpenabled:=false;
  show;
 end;
end;


destructor TInput.Done;
begin
end;

constructor TChkBox.Init;
begin
 chkx:=x;
 chky:=y;
 chklung:=length(mesage)*8+25;
 chklat:=20;
 chktip:=tip;
 chkmesage:=mesage;
 chkwin:=w;
 chkchecked:=checked;
 chkenabled:=true;
end;

procedure TChkBox.Show;
var x1,y1:integer;
begin
 x1:=chkwin^.winx+chkx;
 y1:=chkwin^.winy+chky;
 hidemouse;
 setfillstyle(solidfill,lightgray);
 bar(x1,y1,x1+chklung,y1+20);
 keret(x1,y1,x1+chklung,y1+20,1);
if chkenabled then keret(x1+2,y1+2,x1+18,y1+18,1)
           else keret(x1+2,y1+2,x1+18,y1+18,0);
settextjustify(lefttext,centertext);
settextstyle(0,0,1);
if chkenabled then setcolor(black)
           else setcolor(darkgray);
outtextxy(x1+22,y1+10,chkmesage);
if chkenabled then
      case chktip of
           0:begin
             setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
             rectangle(x1+5,y1+5,x1+15,y1+15);
             if chkchecked then
                        begin
                        line(x1+5,y1+5,x1+15,y1+15);
                        line(x1+5,y1+15,x1+15,y1+5);
                        end;
             end;
           1:begin
             setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
             circle(x1+10,y1+10,5);
             if chkchecked then
                        begin
                        settextjustify(centertext,centertext);
                        settextstyle(0,0,1);
                        outtextxy(x1+10,y1+11,#4);
                        end;
             end;
           2:begin
             setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
             moveto(x1+8,y1+15);
             linerel(-3,0);
             linerel(0,-10);
             linerel(3,0);
             moverel(4,0);
             linerel(3,0);
             linerel(0,10);
             linerel(-3,0);
             if chkchecked then
                        begin
                        setcolor(red);
                        settextjustify(centertext,centertext);
                        settextstyle(0,0,1);
                        outtextxy(x1+10,y1+11,'*');
                        end;
             end;
      end;
showmouse;
end;

procedure TChkBox.Enable;
begin
if not chkenabled then begin chkenabled:=true;show;end;
end;

procedure TChkBox.Disable;
begin
if chkenabled then begin chkenabled:=false;show;end;
end;

procedure TChkBox.Toggle;
var x1,y1:integer;
begin
 x1:=chkwin^.winx+chkx;
 y1:=chkwin^.winy+chky;
 if chkenabled then
           begin
           if chkchecked then chkchecked:=false else chkchecked:=true;
              hidemouse;
              setfillstyle(solidfill,lightgray);
              bar(x1+4,y1+4,x1+16,y1+16);
              case chktip of
                   0:begin
                     setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
                     rectangle(x1+5,y1+5,x1+15,y1+15);
                     if chkchecked then
                        begin
                        setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
                        line(x1+5,y1+5,x1+15,y1+15);
                        line(x1+5,y1+15,x1+15,y1+5);
                        end;
                     end;
                   1:begin
                     setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
                     circle(x1+10,y1+10,5);
                     if chkchecked then
                        begin
                        settextjustify(centertext,centertext);
                        outtextxy(x1+10,y1+11,#4);
                        end;
                     end;
                   2:begin
                     setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
                     moveto(x1+8,y1+15);
                     linerel(-3,0);
                     linerel(0,-10);
                     linerel(3,0);
                     moverel(4,0);
                     linerel(3,0);
                     linerel(0,10);
                     linerel(-3,0);
                     if chkchecked then
                        begin
                        setcolor(red);setlinestyle(0,0,0);setwritemode(copyput);
                        settextjustify(centertext,centertext);
                        settextstyle(0,0,1);
                        outtextxy(x1+10,y1+11,'*');
                        end;
                     end;
                   end;
                   Showmouse;
             end;
 waitrelease;
end;

function TChkBox.Clicked;
begin
 Clicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx>chkwin^.winx+chkx)and(ev.mx<chkwin^.winx+chkx+chklung)and
        (ev.my>chkwin^.winy+chky)and(ev.my<chkwin^.winy+chky+chklat)
        and chkenabled
 then Clicked:=true;
end;

destructor TChkBox.Done;
begin
end;

constructor TUpDown.Init;
begin
 updx:=x;updy:=y;
 updlung:=20;
 updlat:=40;
 updtip:=tip;
 updenabled:=true;
 updWin:=w;
end;

procedure TUpDown.Show;
var x1,y1:integer;
begin
 x1:=updwin^.winx+updx;
 y1:=updwin^.winy+updy;
     hidemouse;
     setcolor(lightgray);setlinestyle(0,0,0);setwritemode(copyput);
     rectaNGLE(x1,y1,x1+20,y1+40);
     setfillstyle(solidfill,lightgray);
     bar(x1+2,y1+2,x1+18,y1+38);
     keret(x1,y1,x1+20,y1+20,1);
     keret(x1,y1+20,x1+20,y1+40,1);
     case updtip of
     1:begin
            setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
            line(x1+4,y1+16,x1+10,y1+4);
            line(x1+10,y1+4,x1+16,y1+16);
            line(x1+4,y1+17,x1+10,y1+5);
            line(x1+10,y1+5,x1+16,y1+17);

            line(x1+4,y1+24,x1+10,y1+36);
            line(x1+10,y1+36,x1+16,y1+24);
            line(x1+4,y1+25,x1+10,y1+37);
            line(x1+10,y1+37,x1+16,y1+25);
       end;
     2:begin
            moveto(x1+8,y1+3);
            linerel(3,0);
            linerel(0,5);
            linerel(5,0);
            linerel(0,3);
            setcolor(white);setlinestyle(0,0,0);setwritemode(copyput);
            linerel(-5,0);
            setcolor(darkgray);
            linerel(0,5);
            setcolor(white);
            linerel(-3,0);
            linerel(0,-5);
            linerel(-5,0);
            linerel(0,-3);
            setcolor(darkgray);
            linerel(5,0);
            setcolor(white);
            linerel(0,-5);
            keret(x1+4,y1+27,x1+17,y1+32,0);
       end;
       3:begin
            moveto(x1+10,y1+5);
            setcolor(white);setlinestyle(0,0,0);setwritemode(copyput);
            linerel(-7,10);
            linerel(14,0);
            setcolor(darkgray);
            linerel(-7,-10);
            moveto(x1+3,y1+25);
            linerel(14,0);
            setcolor(white);
            linerel(-7,10);
            linerel(-7,-10);
         end;
     end;
     ShowMouse;
end;

procedure TUpDown.ShowPressed;
var x1,y1:integer;
begin
 x1:=updwin^.winx+updx;
 y1:=updwin^.winy+updy;
 hidemouse;
     setcolor(lightgray);setlinestyle(0,0,0);setwritemode(copyput);
     rectaNGLE(x1,y1,x1+20,y1+40);
     setfillstyle(solidfill,lightgray);
     bar(x1+2,y1+2,x1+18,y1+38);
if ypoz<y1+20 then
begin
     keret(x1,y1,x1+20,y1+20,0);
     keret(x1,y1+20,x1+20,y1+40,1);
     case updtip of
     1:begin
            setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
            line(x1+5,y1+15,x1+11,y1+3);
            line(x1+11,y1+3,x1+17,y1+15);
            line(x1+5,y1+16,x1+11,y1+4);
            line(x1+11,y1+4,x1+17,y1+16);

            line(x1+4,y1+24,x1+10,y1+36);
            line(x1+10,y1+36,x1+16,y1+24);
            line(x1+4,y1+25,x1+10,y1+37);
            line(x1+10,y1+37,x1+16,y1+25);
       end;
     2:begin
            moveto(x1+9,y1+2);
            linerel(3,0);
            linerel(0,5);
            linerel(5,0);
            linerel(0,3);
            setcolor(white);setlinestyle(0,0,0);setwritemode(copyput);
            linerel(-5,0);
            setcolor(darkgray);
            linerel(0,5);
            setcolor(white);
            linerel(-3,0);
            linerel(0,-5);
            linerel(-5,0);
            linerel(0,-3);
            setcolor(darkgray);
            linerel(5,0);
            setcolor(white);
            linerel(0,-5);
            keret(x1+4,y1+27,x1+17,y1+32,0);
       end;
       3:begin
            moveto(x1+11,y1+4);
            setcolor(white);setlinestyle(0,0,0);setwritemode(copyput);
            linerel(-7,10);
            linerel(14,0);
            setcolor(darkgray);
            linerel(-7,-10);
            moveto(x1+3,y1+25);
            linerel(14,0);
            setcolor(white);
            linerel(-7,10);
            linerel(-7,-10);
         end;
     end;
end
else
begin
     keret(x1,y1,x1+20,y1+20,1);
     keret(x1,y1+20,x1+20,y1+40,0);
     case updtip of
     1:begin
            setcolor(black);setlinestyle(0,0,0);setwritemode(copyput);
            line(x1+4,y1+16,x1+10,y1+4);
            line(x1+10,y1+4,x1+16,y1+16);
            line(x1+4,y1+17,x1+10,y1+5);
            line(x1+10,y1+5,x1+16,y1+17);

            line(x1+5,y1+25,x1+11,y1+37);
            line(x1+11,y1+37,x1+17,y1+25);
            line(x1+5,y1+26,x1+11,y1+38);
            line(x1+11,y1+38,x1+17,y1+26);
       end;
     2:begin
            moveto(x1+8,y1+3);
            setcolor(darkgray);setlinestyle(0,0,0);setwritemode(copyput);
            linerel(3,0);
            linerel(0,5);
            linerel(5,0);
            linerel(0,3);
            setcolor(white);
            linerel(-5,0);
            setcolor(darkgray);
            linerel(0,5);
            setcolor(white);
            linerel(-3,0);
            linerel(0,-5);
            linerel(-5,0);
            linerel(0,-3);
            setcolor(darkgray);
            linerel(5,0);
            setcolor(white);
            linerel(0,-5);
            keret(x1+5,y1+28,x1+18,y1+33,0);
       end;
       3:begin
            moveto(x1+10,y1+5);
            setcolor(white);setlinestyle(0,0,0);setwritemode(copyput);
            linerel(-7,10);
            linerel(14,0);
            setcolor(darkgray);
            linerel(-7,-10);
            moveto(x1+4,y1+26);
            linerel(14,0);
            setcolor(white);
            linerel(-7,10);
            linerel(-7,-10);
         end;
     end;
end;
     ShowMouse;
end;

procedure TUpDown.Enable;
begin
 updenabled:=true;
end;

procedure TUpDown.Disable;
begin
 updenabled:=false;
end;

function TUpDown.Clicked;
begin
 Clicked:=0;
 if not updenabled then exit;
 if (ev.tip=evmouse)and(ev.but=1) then
   begin
     if (ev.mx>updwin^.winx+updx)and(ev.mx<updwin^.winx+updx+updlung)and
        (ev.my>updwin^.winy+updy)and(ev.my<updwin^.winy+updy+(updlat div 2))
          then begin showpressed(ev.my);waitrelease;show;Clicked:=1;end;
     if (ev.mx>updwin^.winx+updx)and(ev.mx<updwin^.winx+updx+updlung)and
        (ev.my>updwin^.winy+updy+(updlat div 2))and(ev.my<updwin^.winy+updy+updlat)
          then begin showpressed(ev.my);waitrelease;show;Clicked:=2;end;
   end;
end;

destructor TUpDown.Done;
begin
end;

Constructor TRuler.Init;
begin
  rulwin:=w;
  rulx:=x;ruly:=y;
  rullat:=lat;if rullat<8 then rullat:=8;
  rullung:=lung;if rullung<2*rullat+5 then rullung:=2*rullat+5;
  rultip:=tip;
  rulmin:=min;rulmax:=max;rulstep:=step;rulpos:=pos;
  if (rulpos<rulmin)or(rulpos>rulmax)then rulpos:=(rulmin+rulmax)div 2;
  rulenabled:=true;
end;

procedure truler.drawmark(pr:integer);
var x1,y1:integer;
begin
 x1:=rulwin^.winx+rulx;
 y1:=rulwin^.winy+ruly;
setlinestyle(0,0,0);setwritemode(copyput);
d:=round((rullung-2*rullat-2)/(abs(rulmax-rulmin)/rulstep));
if d<10 then d:=10;
p:=round((rulpos-rulmin)*(rullung-2*rullat-2)/abs(rulmax-rulmin));
if rultip=0 then
   begin
   if (p<d div 2-1)then p:=d div 2-1;
   if p>rullung-2*rullat+1-d div 2 then p:=rullung-2*rullat+1-d div 2;
   keret(x1+p+rullat-d div 2,y1,x1+rullat+p+d div 2,y1+rullat,pr);
   end
   else begin
   if (p<d div 2-1)then p:=d div 2-1;
   if p>rullung-2*rullat+1-d div 2 then p:=rullung-2*rullat+1-d div 2;
   keret(x1,y1+p+rullat-d div 2,x1+rullat,y1+rullat+p+d div 2,pr);
   end;
end;
procedure truler.delmark;
var x1,y1:integer;
begin
 x1:=rulwin^.winx+rulx;
 y1:=rulwin^.winy+ruly;
setcolor(lightgray);setlinestyle(0,0,0);setwritemode(copyput);
if rultip=0 then
   begin
   if (p<d div 2-1)then p:=d div 2-1;
   if p>rullung-2*rullat+1-d div 2 then p:=rullung-2*rullat+1-d div 2;
   rectangle(x1+p+1+rullat-d div 2,y1+1,x1-1+rullat+p+d div 2,y1-1+rullat);
   end
   else begin
   if (p<d div 2-1)then p:=d div 2-1;
   if p>rullung-2*rullat+1-d div 2 then p:=rullung-2*rullat+1-d div 2;
   rectangle(x1+1,y1+1+p+rullat-d div 2,x1-1+rullat,y1-1+rullat+p+d div 2);
   end;

end;

procedure TRuler.Show;
var x1,y1,sc:integer;
begin
 x1:=rulwin^.winx+rulx;
 y1:=rulwin^.winy+ruly;
setfillstyle(solidfill,lightgray);
setlinestyle(0,0,0);setwritemode(copyput);
sc:=(rullat-1) div 8;
d:=round((rullung-2*rullat-2)/(abs(rulmax-rulmin)/rulstep));
if d<10 then d:=10;
p:=round((rulpos-rulmin)*(rullung-2*rullat-2)/abs(rulmax-rulmin));
hidemouse;
if rultip=0 then
         begin
           bar(x1,y1,x1+rullung,y1+rullat);
           keret(x1-1,y1-1,x1+rullung+1,y1+rullat+1,1);
           keret(x1,y1,x1+rullat,y1+rullat,1);
           keret(x1+rullung-rullat,y1,x1+rullung,y1+rullat,1);
           if rulenabled then setcolor(black) else setcolor(white);
           moveto(x1+rullat div 2,y1+rullat div 2);
           moverel(-3*sc,0);
           linerel(3*sc,-3*sc);
           linerel(0,2*sc);
           linerel(3*sc,0);
           linerel(0,2*sc);
           linerel(-3*sc,0);
           linerel(0,2*sc);
           linerel(-3*sc,-3*sc);
           moveto(x1+rullung-rullat div 2,y1+rullat div 2);
           moverel(3*sc,0);
           linerel(-3*sc,3*sc);
           linerel(0,-2*sc);
           linerel(-3*sc,0);
           linerel(0,-2*sc);
           linerel(3*sc,0);
           linerel(0,-2*sc);
           linerel(3*sc,3*sc);
           if rulenabled then
              begin
              drawmark(1);
              end
              else begin
              setfillstyle(solidfill,white);
              bar(x1+rullat,y1+1,x1+rullung-rullat,y1+rullat-1);
              setcolor(black);
              rectangle(x1+rullat,y1+1,x1+rullung-rullat,y1+rullat-1);
              end;
         end
         else begin
           bar(x1,y1,x1+rullat,y1+rullung);
           keret(x1-1,y1-1,x1+1+rullat,y1+1+rullung,1);
           keret(x1,y1,x1+rullat,y1+rullat,1);
           keret(x1,y1+rullung-rullat,x1+rullat,y1+rullung,1);
           if rulenabled then setcolor(black) else setcolor(white);
           moveto(x1+rullat div 2,y1+rullat div 2);
           moverel(0,-3*sc);
           linerel(-3*sc,3*sc);
           linerel(2*sc,0);
           linerel(0,3*sc);
           linerel(2*sc,0);
           linerel(0,-3*sc);
           linerel(2*sc,0);
           linerel(-3*sc,-3*sc);
           moveto(x1+rullat div 2,y1+rullung-rullat div 2);
           moverel(0,3*sc);
           linerel(3*sc,-3*sc);
           linerel(-2*sc,0);
           linerel(0,-3*sc);
           linerel(-2*sc,0);
           linerel(0,3*sc);
           linerel(-2*sc,0);
           linerel(3*sc,3*sc);
           if rulenabled then
              begin
              drawmark(1);
              end
              else begin
              setfillstyle(solidfill,white);
              bar(x1+1,y1+rullat,x1+rullat-1,y1+rullung-rullat);
              setcolor(black);
              rectangle(x1+1,y1+rullat,x1+rullat-1,y1+rullung-rullat);
              end;
         end;
showmouse;
end;

procedure TRuler.SetPos;
begin
 if (pos<=rulmax)and(pos>=rulmin)then rulpos:=pos;
 show;
end;

function TRuler.GetPos;
begin
 getpos:=rulpos;
end;

procedure TRuler.Enable;
begin
if not rulenabled then begin
                         rulenabled:=true;
                         show;
                       end;
end;

procedure TRuler.Disable;
begin
if rulenabled then begin
                         rulenabled:=false;
                         show;
                       end;
end;

procedure Truler.rule;
var w,yr,but:integer;
    x1,y1:integer;
begin
if rulenabled then begin
hidemouse;
 x1:=rulwin^.winx+rulx;
 y1:=rulwin^.winy+ruly;
 setlinestyle(0,0,0);setwritemode(copyput);
if rultip=0 then
         begin
         if (x<x1+rullat)and(rulpos>rulmin) then
                                          begin
                                          delmark;
                                          rulpos:=rulpos-rulstep;
                                          if rulpos<rulmin then rulpos:=rulmin;
                                          drawmark(1);
                                          end;
         if (x>x1+rullung-2*rullat)and(rulpos<rulmax)then
                                          begin
                                          delmark;
                                          rulpos:=rulpos+rulstep;
                                          if rulpos>rulmax then rulpos:=rulmax;
                                          drawmark(1);
                                          end;
         if (x>x1+p+1+rullat-d div 2)and(x<x1+p+1+rullat+d div 2)then
            begin
            drawmark(0);
            showmouse;
            getmousestatus(x,y,but);
            w:=x;
            repeat
            getmousestatus(x,y,but);
            if x<>w then begin
                         hidemouse;
                         delmark;
                         rulpos:=round((rulmax-rulmin)*(p-w+x)/(rullung-2*rullat-2))+rulmin;
                         if rulpos>rulmax then
                                         begin
                                         rulpos:=rulmax;
                                         end else w:=x;
                         if rulpos<rulmin then
                                         begin
                                         rulpos:=rulmin;
                                         end else w:=x;
                         drawmark(0);
                         showmouse;
                         end
            until but=0;
            hidemouse;
            drawmark(1);
            end;
         end
         else begin
         if (y<y1+rullat)and(rulpos>rulmin) then
                                          begin
                                          delmark;
                                          rulpos:=rulpos-rulstep;
                                          if rulpos<rulmin then rulpos:=rulmin;
                                          drawmark(1);
                                          end;
         if (y>y1+rullung-2*rullat-1)and(rulpos<rulmax) then
                                          begin
                                          delmark;
                                          rulpos:=rulpos+rulstep;
                                          if rulpos>rulmax then rulpos:=rulmax;
                                          drawmark(1);
                                          end;
         if (y>y1+1+rullat+p-d div 2)and(y<y1-1+rullat+p+d div 2)then
            begin
            drawmark(0);
            showmouse;
            getmousestatus(x,y,but);
            w:=y;
            repeat
            getmousestatus(x,y,but);
            if y<>w then begin
                         hidemouse;
                         delmark;
                         rulpos:=round((rulmax-rulmin)*(p-w+y)/(rullung-2*rullat-2))+rulmin;
                         if rulpos>rulmax then
                                         begin
                                         rulpos:=rulmax;
                                         end else w:=y;
                         if rulpos<rulmin then
                                         begin
                                         rulpos:=rulmin;
                                         end else w:=y;
                         drawmark(0);
                         showmouse;
                         end
            until but=0;
            hidemouse;
            drawmark(1);
            end;
         end;
showmouse;
{waitrelease;}
end;
end;

function TRuler.Clicked;
var lung,lat:integer;
begin
 if rultip=0 then begin lung:=rullung;lat:=rullat;end;
 if rultip=1 then begin lung:=rullat;lat:=rullung;end;
 Clicked:=false;if not rulenabled then exit;
 if (ev.tip=evmouse)and(ev.but=1) and
     (ev.mx>rulwin^.winx+rulx)and(ev.mx<rulwin^.winx+rulx+lung)and
        (ev.my>rulwin^.winy+ruly)and(ev.my<rulwin^.winy+ruly+lat) then
   begin rule(ev.mx,ev.my);clicked:=true;end;
end;


destructor TRuler.Done;
begin
end;

Constructor TText.Init;
begin
  texwin:=w;
  texx:=x;texy:=y;texlung:=lung;texlat:=lat;
  textip:=tip;
  texbcol:=lightgray;
  texfcol:=black;
  texfont:=0;texsize:=1;
  texwrap:=true;
  texhor:=centertext;
  texver:=centertext;
  texmesage:=mesage;
end;

procedure TText.SetAttr;
begin
 texfont:=font;
 texsize:=size;
 texfcol:=fcol;
 texbcol:=bcol;
end;

procedure TText.Redefine;
begin
 texmesage:=mesage;
 show;
end;


procedure TText.SetJustify;
begin
 texhor:=hor;
 texver:=ver;
 texwrap:=wrap;
end;

procedure TText.Show;
const separators=[' ', ',' , '.' , '?' , '!' , ';' , ':'];
var ViewPort: ViewPortType;
    b,e,t:byte;
    co:integer; {Counting the line wraps}
    dy:integer; {The y differance between two lines}
    y,x: integer; {The x and y position of text line}
    mesage:string;{Save the mesage}
    x1,y1,x2,y2:integer;
begin
 x1:=texwin^.winx+texx;y1:=texwin^.winy+texy;
 x2:=x1+texlung;y2:=y1+texlat;
mesage:=texmesage;
GetViewSettings(ViewPort);
hidemouse;
   case textip of
    1:begin
      setfillstyle(solidfill,texbcol);bar(x1,y1,x2,y2);
      keret(x1-1,y1-1,x2+1,y2+1,1);
      keret(x1,y1,x2,y2,0);
      end;
    2:begin
      setfillstyle(solidfill,texbcol);bar(x1,y1,x2,y2);
      keret(x1-1,y1-1,x2+1,y2+1,0);
      keret(x1,y1,x2,y2,1);
      end;
    3:begin
      setfillstyle(solidfill,texbcol);bar(x1,y1,x2,y2);
      keret(x1-2,y1-2,x2+2,y2+2,0);
      setcolor(black);
      rectangle(x1,y1,x2,y2);
      keret(x1,y1,x2,y2,1);
      end;
    4:begin
      setfillstyle(solidfill,texbcol);bar(x1,y1,x2,y2);
      setcolor(black);
      rectangle(x1,y1,x2,y2);
      end;
    5:begin
      setfillstyle(solidfill,texbcol);bar(x1,y1,x2,y2);
      keret(x1,y1,x2,y2,0);
      end;
    6:begin
      setfillstyle(solidfill,texbcol);bar(x1,y1,x2,y2);
      end;
   end;
setviewport(ViewPort.x1+x1,ViewPort.y1+y1,ViewPort.x1+x2,ViewPort.y1+y2,clipon);
setcolor(texfcol);
msettextstyle(texfont,horizdir,texsize);
case texhor of
                  centertext: x:=(x2-x1)div 2;
                  lefttext  : x:=2;
                  righttext : begin
                              x:=(x2-x1)-2;
                              if not texwrap then texmesage:=copy(mesage,
                               length(mesage)-((x2-x1)div textwidth('A'))+1,((x2-x1)div textwidth('A')));
                              end;
                  end;
if (not texwrap)or(textwidth(texmesage)<(x2-x1))then
   begin
   settextjustify(texhor,texver);
   t:=1;
   repeat
   if texmesage[t]=#13 then texmesage[t]:=#32;
   inc(t);
   until t>length(texmesage);
   case texver of
        toptext:outtextxy(x,3,texmesage);
        centertext:outtextxy(x,(y2-y1)div 2,texmesage);
        bottomtext:outtextxy(x,y2-y1-3,texmesage);
   end;
   end
   else
       begin
            {Determining the number of text lines to be writen,}
            {storing this number in 'co' and delimiting lines with #0 character}
            b:=1;
            co:=0;
            repeat
            t:=b;e:=t;
            repeat
                 inc(t);
                 if (((texmesage[t] in separators)or(t>=length(texmesage)))and(textwidth(copy(texmesage,b,t-b))<(x2-x1)))
                    then e:=t;
            until (t>=length(texmesage))or(textwidth(copy(texmesage,b,t-b))>(x2-x1));
            if b=e then
               begin
               insert(#0,texmesage,t);
               b:=t;
               inc(co);
               end else
                   if (e<length(texmesage))then
                      begin
                      if texmesage[e]=#32 then texmesage[e]:=#0
                         else insert(#0,texmesage,e+1);
                      inc(co);
                      b:=e;
                      end;
            until t>=length(texmesage);
            t:=1;
            repeat
            if texmesage[t]=#13 then
                           begin
                           inc(co);
                           texmesage[t]:=#0;
                           end;
            inc(t);
            until t>length(texmesage);
            if texver=centertext then
               dy:=(y2-y1)div (co+2)
               else dy:=round(textheight(texmesage)*2);
            settextjustify(texhor,centertext);
            texmesage:=texmesage+' ';
            e:=0;
            case texver of
                 toptext:y:=8;
                 centertext:y:=dy;
                 bottomtext:y:=y2-y1-(co+1)*textheight(texmesage)-12;
            end;
            repeat
                  b:=e+1;
                  repeat
                  inc(e)
                  until (e>=length(texmesage))or(texmesage[e]=#0)or(texmesage[e]=#13);
                  outtextxy(x,y,copy(texmesage,b,e-b));
                  y:=y+dy;
            until e>length(texmesage)
       end;
 SetViewPort(ViewPort.x1,ViewPort.y1,ViewPort.x2,ViewPort.y2,ViewPort.Clip);
ShowMouse;
texmesage:=mesage;
end;

function TText.Clicked;
begin
 Clicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx>texwin^.winx+texx)and(ev.mx<texwin^.winx+texx+texlung)and
        (ev.my>texwin^.winy+texy)and(ev.my<texwin^.winy+texy+texlat)
 then Clicked:=true;
end;

destructor TText.Done;
begin
end;

Constructor TFrame.Init;
begin
 frax:=x;fray:=y;fralung:=lung;fralat:=lat;
 fratip:=tip;
 fracol:=col;
 fratitle:=title;
 frawin:=w;
end;

procedure TFrame.Show;
var x1,y1,x2,y2:integer;
begin
 x1:=frawin^.winx+frax;y1:=frawin^.winy+fray;
 x2:=x1+fralung;y2:=y1+fralat;
     hidemouse;
     setcolor(lightgray);
     setlinestyle(0,0,0);setwritemode(copyput);
     case fratip of
          0:begin
                 rectangle(x1+1,y1+1,x2-1,y2-1);
                 keret(x1-1,y1-1,x2+1,y2+1,1);
                 keret(x1+1,y1+1,x2-1,y2-11,0);
                 setfillstyle(solidfill,fracol);
                 bar(x1+3,y1+3,x2-3,y2-13);
                 setcolor(black);
                 rectangle(x1+3,y1+3,x2-3,y2-13);
                 settextstyle(defaultfont,horizdir,1);
                 outtextxy((x1+x2)div 2,y2-5,fratitle);
            end;
          1:begin
                 setcolor(black);
                 rectangle(x1,y1,x2,y2);
                 rectangle(x1+2,y1+2,x2-2,y2-2);
                 setfillstyle(solidfill,fracol);
                 bar(x1+3,y1+3,x2-3,y2-3);
            end;
          2:begin
                 setcolor(black);
                 rectangle(x1,y1,x2,y2);
                 rectangle(x1+1,y1+1,x2-1,y2-1);
                 rectangle(x1+2,y1+2,x2-2,y2-2);
                 setfillstyle(solidfill,fracol);
                 bar(x1+3,y1+3,x2-3,y2-3);
            end;
          3:begin
                 setcolor(black);
                 rectangle(x1+2,y1+2,x2-2,y2-2);
                 setfillstyle(solidfill,fracol);
                 bar(x1+3,y1+3,x2-3,y2-3);
            end;
          4:begin
                 rectangle(x1+1,y1+1,x2-1,y2-1);
                 keret(x1-1,y1-1,x2+1,y2+1,1);
                 setcolor(lightgray);
                 rectangle(x1,y1,x2,y2);
                 keret(x1+1,y1+1,x2-1,y2-1,0);
                 setfillstyle(solidfill,fracol);
                 bar(x1+3,y1+3,x2-3,y2-3);
            end;
          5:begin
                 setfillstyle(solidfill,fracol);
                 bar(x1,y1,x2,y2);
            end;
          end;
     ShowMouse;
end;

function TFrame.Clicked;
begin
 Clicked:=false;
 if (ev.tip=evmouse)and(ev.but=1) then
     if (ev.mx>frawin^.winx+frax)and(ev.mx<frawin^.winx+frax+fralung)and
        (ev.my>frawin^.winy+fray)and(ev.my<frawin^.winy+fray+fralat)
 then
    begin
      fraclickx:=ev.mx-frawin^.winx-frax;
      fraclicky:=ev.my-frawin^.winy-fray;
      Clicked:=true;
    end;
end;

function TFrame.GetX;
begin
 getx:=fraclickx;
end;

function TFrame.GetY;
begin
 gety:=fraclicky;
end;

procedure TFrame.Activate;
var x1,y1,x2,y2:integer;
begin
 x1:=frawin^.winx+frax;y1:=frawin^.winy+fray;
 x2:=x1+fralung;y2:=y1+fralat;
     getviewsettings(wp);
     setviewport(0,0,getmaxx,getmaxy,clipon);
     if fratip>0 then setviewport(x1+4,y1+4,x2-4,y2-4,clipon)
        else setviewport(x1+4,y1+4,x2-4,y2-14,clipon);
end;

procedure TFrame.Deactivate;
begin
     setviewport(wp.x1,wp.y1,wp.x2,wp.y2,wp.clip);
end;

destructor TFrame.Done;
begin
end;



Constructor TMenu.Init;
begin
 nritem:=1;
 last:=0;selected:=0;out:=false;
 menx:=x;meny:=y;mentitle:=title;
end;


Function TMenu.IsEnabled;
begin
 IsEnabled:=Line[NrIt].Enabled;
end;

Function TMenu.IsChecked;
begin
 IsChecked:=Line[NrIt].Checked;
end;


procedure tmenu.writeitem(i:integer;act:boolean);
var Items:integer;
begin
items:=nritem-1;
if (i>0) and (i<=items) then
   begin
        hidemouse;
        settextjustify(lefttext,toptext);
        if act then begin
                setcolor(white);
                setfillstyle(solidfill,blue);
                end
           else begin
                setcolor(black);
                setfillstyle(solidfill,lightgray);
                end;
        bar(menx+2,meny+i*12+4,menx+8*maxl+9,meny+i*12+13);
        if not line[i].enabled then setcolor(darkgray);
        outtextxy(menx+10,meny+i*12+5,line[i].item);
        if line[i].checked then outtextxy(menx+2,meny+i*12+5,{#249}#7);
        showmouse;
   end;
end;

Procedure TMenu.Show;
var items,i:integer;
begin
 items:=nritem-1;
 maxl:=length(line[1].item);
 for i:=2 to items do if length(line[i].item)>maxl
         then maxl:=length(line[i].item);
 menlung:=8*maxl+12;menlat:=items*12+16;
 if menx+menlung>getmaxx then menx:=getmaxx-menlung-1;
 if meny+menlat>getmaxy then meny:=getmaxy-menlat-1;
 if menx<0 then menx:=0;if meny<0 then meny:=0;
getviewsettings(vp);
marpoint:=imagesize(menx,meny,menx+8*maxl+12,meny+items*12+16);
if maxavail<marpoint then
  begin
   closegraph;
   writeln(' Eroare de executie !');
   writeln(' Insuficienta memorie pentru a rula acest program !');
   halt(2);
  end
else getmem(point,marpoint);
hidemouse;
getimage(menx,meny,menx+8*maxl+12,meny+items*12+16,point^);
 setfillstyle(solidfill,lightgray);
if Zoom=0 then
 bar(menx,meny,menx+8*maxl+12,meny+items*12+16)
else
 PanouCuZoom(menx,meny,menx+8*maxl+12,meny+items*12+16,lightgray,zoom);
 keret(menx,meny,menx+8*maxl+12,meny+items*12+16,1);
 setcolor(black);
 graph.line(menx,meny+items*12+16,menx+8*maxl+12,meny+items*12+16);
 graph.line(menx+8*maxl+12,meny+items*12+16,menx+8*maxl+12,meny);
settextstyle(0,0,0);
settextjustify(centertext,toptext);
setcolor(darkgray);outtextxy((2*menx+8*maxl+12)div 2,meny+3,mentitle);
setcolor(blue);outtextxy((2*menx+8*maxl+12)div 2+1,meny+4,mentitle);
setcolor(darkgray);
graph.line(menx+2,meny+12,menx+8*maxl+10,meny+12);
setcolor(white);
graph.line(menx+2,meny+13,menx+8*maxl+10,meny+13);
for i:=1 to items do writeitem(i,false);
showmouse;
end;


Procedure TMenu.ResetItems;
begin
 nritem:=1;
end;


Procedure TMenu.NewItem;
begin
 line[nritem].item:=item;
 line[nritem].enabled:=enabled;
 line[nritem].checked:=checked;
 inc(nritem);
end;

Procedure TMenu.SetItems;
begin
 move(ItP^,line[1],NrIt*SizeOf(MenuItem));
 nritem:=NrIt+1;
end;

Procedure TMenu.ChangeItem;
begin
 line[nrit].item:=item;
 line[nrit].enabled:=enabled;
 line[nrit].checked:=checked;
end;

Function TMenu.Run;
var
    xm,ym,i,ind:integer;
    inarea,moved:boolean;
    ch:char;Items:integer;
begin

if selected<>0 then begin
settextjustify(centertext,toptext);
setcolor(darkgray);outtextxy((2*menx+8*maxl+12)div 2,meny+3,mentitle);
setcolor(blue);outtextxy((2*menx+8*maxl+12)div 2+1,meny+4,mentitle);
for i:=1 to items do writeitem(i,false);
writeitem(last,true);
selected:=0;end;

items:=nritem-1;
xm:=ev.mx;ym:=ev.my;but:=ev.but;
xm:=xm-vp.x1-menx;
ym:=ym-vp.y1-meny;
ind:=ym div 12;
inarea:=(xm>4)and(xm<8*maxl+6)and(ym>12)and(ym<=items*12+10);
moved:=(xm<>xx)or(ym<>yy);
if inarea and(last<>ind)and moved
   then
       begin
        if last>0 then writeitem(last,false);
        writeitem(ind,true);
        last:=ind;
       end;
if not(inarea)and (last<>0)and moved
   then begin
   writeitem(last,false);
   last:=0;
   end;
if ev.tip=evkbd then
   begin
      case ev.scankey of
         kbUp:if last=0 then
                           begin
                            last:=items;
                            while not line[last].enabled do dec(last);
                            writeitem(last,true);
                           end
                       else
                           begin
                            writeitem(last,false);
                            repeat
                            last:=last-1;
                            if last<1 then last:=items;
                            until line[last].enabled;
                            writeitem(last,true);
                           end;
         kbDown:if last=0 then
                           begin
                            last:=1;
                            while not line[last].enabled do inc(last);
                            writeitem(last,true);
                           end
                       else
                           begin
                            writeitem(last,false);
                            repeat
                            last:=last+1;
                            if last>items then last:=1;
                            until line[last].enabled;
                            writeitem(last,true);
                           end;
                  end;
   if (ev.scankey=kbEnter)and(line[last].enabled)and(last<>0)then
      begin
       selected:=last;
      end;
   if ev.scankey=kbEsc then
      begin
      out:=true;
      selected:=0;
      end;
   end;
   if (but=1)and(line[last].enabled)and(last<>0)then
      begin
       selected:=last;
      end;
   if (but=1)and(last=0)then
      begin
       out:=true;
       selected:=0;
      end;
 xx:=xm;yy:=ym;
    run:=0;
 if selected<>0 then
    begin
    waitrelease;
    settextjustify(centertext,toptext);
    setcolor(lightgray);outtextxy((2*menx+8*maxl+12)div 2,meny+3,mentitle);
    setcolor(darkgray);outtextxy((2*menx+8*maxl+12)div 2+1,meny+4,mentitle);
    showmouse;
    run:=last;
    end;
 if out then begin run:=-1;out:=false;waitrelease;end;
end;


Destructor TMenu.Done;
var items:integer;
begin
 items:=1;
 hidemouse;
 putimage(menx,meny,point^,normalput);
 freemem(point,marpoint);
 showmouse;
end;

Constructor TMenuXMS.Init;
begin
 nritem:=1;
 last:=0;selected:=0;out:=false;
 menx:=x;meny:=y;mentitle:=title;
end;


Function TMenuXMS.IsEnabled;
begin
 IsEnabled:=Line[NrIt].Enabled;
end;

Function TMenuXMS.IsChecked;
begin
 IsChecked:=Line[NrIt].Checked;
end;


procedure tmenuXMS.writeitem(i:integer;act:boolean);
var Items:integer;
begin
items:=nritem-1;
if (i>0) and (i<=items) then
   begin
        hidemouse;
        settextjustify(lefttext,toptext);
        if act then begin
                setcolor(white);
                setfillstyle(solidfill,blue);
                end
           else begin
                setcolor(black);
                setfillstyle(solidfill,lightgray);
                end;
        bar(menx+2,meny+i*16+2+4,menx+8*maxl+9,meny+i*16+15+4);  {}
        if not line[i].enabled then setcolor(darkgray);
        outtextxy(menx+10,meny+i*16+4,line[i].item);  {}
        if line[i].checked then outtextxy(menx+2,meny+i*16+4,#7); {}
        showmouse;
   end;
end;

Procedure TMenuXMS.Show;
var items,i:integer;
begin
 items:=nritem-1;
 if items<1 then exit;
 maxl:=length(line[1].item);
 for i:=2 to items do if length(line[i].item)>maxl
         then maxl:=length(line[i].item);
 menlung:=8*maxl+12;menlat:=items*16+20;
 if menx+menlung>getmaxx then menx:=getmaxx-menlung-1;
 if meny+4+menlat>getmaxy then meny:=getmaxy-menlat-1-4;   {}
 if menx<0 then menx:=0;if meny<0 then meny:=0;
getviewsettings(vp);
 marpoint:=getimagesize(menx,meny,menx+8*maxl+12,meny+items*16+20+4); {}
 if not xmsinstalled then
 begin
   closegraph;
   writeln('Eroare XMS. Probabil sunteti deja in modul protejat');
   halt;
  end;
 allocextmem(marpoint,pointhan);
 if xmserror>0 then begin closegraph;writeln('Eroare XMS.');halt;end;
hidemouse;
storeimage(menx,meny,menx+8*maxl+12,meny+items*16+20+4,pointhan,0); {}
 setfillstyle(solidfill,lightgray);
if Zoom=0 then
 bar(menx,meny,menx+8*maxl+12,meny+items*16+20+4)  {}
else
 PanouCuZoom(menx,meny,menx+8*maxl+12,meny+items*16+20+4,lightgray,zoom); {}
 keret(menx,meny,menx+8*maxl+12,meny+items*16+20+4,1); {}
 setcolor(black);
 graph.line(menx,meny+items*16+20+4,menx+8*maxl+12,meny+items*16+20+4); {}
 graph.line(menx+8*maxl+12,meny+items*16+20+4,menx+8*maxl+12,meny); {}
 msettextstyle(5,0,5);
settextjustify(centertext,toptext);
setcolor(blue);outtextxy((2*menx+8*maxl+12)div 2,meny,mentitle);
setcolor(darkgray);graph.line(menx+2,meny+12+4,menx+8*maxl+10,meny+12+4); {}
setcolor(white);graph.line(menx+2,meny+13+4,menx+8*maxl+10,meny+13+4);    {}
for i:=1 to items do writeitem(i,false);
showmouse;
end;


Procedure TMenuXMS.ResetItems;
begin
 nritem:=1;
end;


Procedure TMenuXMS.NewItem;
begin
 line[nritem].item:=item;
 line[nritem].enabled:=enabled;
 line[nritem].checked:=checked;
 inc(nritem);
end;

Procedure TMenuXMS.SetItems;
begin
 move(ItP^,line[1],NrIt*SizeOf(MenuItemXMS));
 nritem:=NrIt+1;
end;

Procedure TMenuXMS.ChangeItem;
begin
 line[nrit].item:=item;
 line[nrit].enabled:=enabled;
 line[nrit].checked:=checked;
end;

Function TMenuXMS.Run;
var
    xm,ym,i,ind:integer;
    inarea,moved:boolean;
    ch:char;Items:integer;
begin
if nritem<2 then begin run:=-1;exit;end;
if selected<>0 then begin
settextjustify(centertext,toptext);
setcolor(blue);outtextxy((2*menx+8*maxl+12)div 2,meny,mentitle);
for i:=1 to items do writeitem(i,false);
writeitem(last,true);
selected:=0;end;

items:=nritem-1;
xm:=ev.mx;ym:=ev.my;but:=ev.but;
xm:=xm-vp.x1-menx;
ym:=ym-vp.y1-meny;
ind:=ym div 16;
inarea:=(xm>4)and(xm<8*maxl+6)and(ym>16)and(ym<=items*16+10);
moved:=(xm<>xx)or(ym<>yy);
if inarea and(last<>ind)and moved
   then
       begin
        if last>0 then writeitem(last,false);
        writeitem(ind,true);
        last:=ind;
       end;
if not(inarea)and (last<>0)and moved
   then begin
   writeitem(last,false);
   last:=0;
   end;
if ev.tip=evkbd then
   begin
      case ev.scankey of
         kbUp:if last=0 then
                           begin
                            last:=items;
                            while not line[last].enabled do dec(last);
                            writeitem(last,true);
                           end
                       else
                           begin
                            writeitem(last,false);
                            repeat
                            last:=last-1;
                            if last<1 then last:=items;
                            until line[last].enabled;
                            writeitem(last,true);
                           end;
         kbDown:if last=0 then
                           begin
                            last:=1;
                            while not line[last].enabled do inc(last);
                            writeitem(last,true);
                           end
                       else
                           begin
                            writeitem(last,false);
                            repeat
                            last:=last+1;
                            if last>items then last:=1;
                            until line[last].enabled;
                            writeitem(last,true);
                           end;
                  end;
   if (ev.scankey=kbEnter)and(line[last].enabled)and(last<>0)then
      begin
       selected:=last;
      end;
   if ev.scankey=kbEsc then
      begin
      out:=true;
      selected:=0;
      end;
   end;
   if (but=1)and(line[last].enabled)and(last<>0)then
      begin
       selected:=last;
      end;
   if (but=1)and(last=0)then
      begin
       out:=true;
       selected:=0;
      end;
 xx:=xm;yy:=ym;
    run:=0;
 if selected<>0 then
    begin
    waitrelease;
    settextjustify(centertext,toptext);
    setcolor(darkgray);outtextxy((2*menx+8*maxl+12)div 2,meny,mentitle);
    showmouse;
    run:=last;
    end;
 if out then begin run:=-1;out:=false;waitrelease;end;
end;


Destructor TMenuXMS.Done;
var items:integer;
begin
 items:=nritem-1;
 if items<1 then exit;
 hidemouse;
 restoreimage(menx,meny,pointhan,0);
 freeextmem(pointhan);
 showmouse;
end;


{  --- Versiunea veche a lui TMenuXMS ---
   --- O pastrez pana ma conving ca cea noua functioneaza bine ---

Constructor TMenuXMS.Init;
begin
 nritem:=1;
 last:=0;selected:=0;out:=false;
 menx:=x;meny:=y;mentitle:=title;
end;


Function TMenuXMS.IsEnabled;
begin
 IsEnabled:=Line[NrIt].Enabled;
end;

Function TMenuXMS.IsChecked;
begin
 IsChecked:=Line[NrIt].Checked;
end;


procedure tmenuXMS.writeitem(i:integer;act:boolean);
var Items:integer;
begin
items:=nritem-1;
if (i>0) and (i<=items) then
   begin
        hidemouse;
        settextjustify(lefttext,toptext);
        if act then begin
                setcolor(white);
                setfillstyle(solidfill,blue);
                end
           else begin
                setcolor(black);
                setfillstyle(solidfill,lightgray);
                end;
        bar(menx+2,meny+i*12+4,menx+8*maxl+9,meny+i*12+13);
        if not line[i].enabled then setcolor(darkgray);
        outtextxy(menx+10,meny+i*12+5,line[i].item);
        if line[i].checked then outtextxy(menx+2,meny+i*12+5,#7);
        showmouse;
   end;
end;

Procedure TMenuXMS.Show;
var items,i:integer;
begin
 items:=nritem-1;
 if items<1 then exit;
 maxl:=length(line[1].item);
 for i:=2 to items do if length(line[i].item)>maxl
         then maxl:=length(line[i].item);
 menlung:=8*maxl+12;menlat:=items*12+16;
 if menx+menlung>getmaxx then menx:=getmaxx-menlung-1;
 if meny+menlat>getmaxy then meny:=getmaxy-menlat-1;
 if menx<0 then menx:=0;if meny<0 then meny:=0;
getviewsettings(vp);
 marpoint:=getimagesize(menx,meny,menx+8*maxl+12,meny+items*12+16);
 if not xmsinstalled then
 begin
   closegraph;
   writeln('Eroare XMS. Probabil sunteti deja in modul protejat');
   halt;
  end;
 allocextmem(marpoint,pointhan);
 if xmserror>0 then begin closegraph;writeln('Eroare XMS.');halt;end;
hidemouse;
storeimage(menx,meny,menx+8*maxl+12,meny+items*12+16,pointhan,0);
 setfillstyle(solidfill,lightgray);
if Zoom=0 then
 bar(menx,meny,menx+8*maxl+12,meny+items*12+16)
else
 PanouCuZoom(menx,meny,menx+8*maxl+12,meny+items*12+16,lightgray,zoom);
 keret(menx,meny,menx+8*maxl+12,meny+items*12+16,1);
 setcolor(black);
 graph.line(menx,meny+items*12+16,menx+8*maxl+12,meny+items*12+16);
 graph.line(menx+8*maxl+12,meny+items*12+16,menx+8*maxl+12,meny);
settextstyle(0,0,1);
settextjustify(centertext,toptext);
setcolor(darkgray);outtextxy((2*menx+8*maxl+12)div 2,meny+3,mentitle);
setcolor(blue);outtextxy((2*menx+8*maxl+12)div 2+1,meny+4,mentitle);
setcolor(darkgray);
graph.line(menx+2,meny+12,menx+8*maxl+10,meny+12);
setcolor(white);
graph.line(menx+2,meny+13,menx+8*maxl+10,meny+13);
for i:=1 to items do writeitem(i,false);
showmouse;
end;


Procedure TMenuXMS.ResetItems;
begin
 nritem:=1;
end;


Procedure TMenuXMS.NewItem;
begin
 line[nritem].item:=item;
 line[nritem].enabled:=enabled;
 line[nritem].checked:=checked;
 inc(nritem);
end;

Procedure TMenuXMS.SetItems;
begin
 move(ItP^,line[1],NrIt*SizeOf(MenuItemXMS));
 nritem:=NrIt+1;
end;

Procedure TMenuXMS.ChangeItem;
begin
 line[nrit].item:=item;
 line[nrit].enabled:=enabled;
 line[nrit].checked:=checked;
end;

Function TMenuXMS.Run;
var
    xm,ym,i,ind:integer;
    inarea,moved:boolean;
    ch:char;Items:integer;
begin
if nritem<2 then begin run:=-1;exit;end;
if selected<>0 then begin
settextjustify(centertext,toptext);
setcolor(darkgray);outtextxy((2*menx+8*maxl+12)div 2,meny+3,mentitle);
setcolor(blue);outtextxy((2*menx+8*maxl+12)div 2+1,meny+4,mentitle);
for i:=1 to items do writeitem(i,false);
writeitem(last,true);
selected:=0;end;

items:=nritem-1;
xm:=ev.mx;ym:=ev.my;but:=ev.but;
xm:=xm-vp.x1-menx;
ym:=ym-vp.y1-meny;
ind:=ym div 12;
inarea:=(xm>4)and(xm<8*maxl+6)and(ym>12)and(ym<=items*12+10);
moved:=(xm<>xx)or(ym<>yy);
if inarea and(last<>ind)and moved
   then
       begin
        if last>0 then writeitem(last,false);
        writeitem(ind,true);
        last:=ind;
       end;
if not(inarea)and (last<>0)and moved
   then begin
   writeitem(last,false);
   last:=0;
   end;
if ev.tip=evkbd then
   begin
      case ev.scankey of
         kbUp:if last=0 then
                           begin
                            last:=items;
                            while not line[last].enabled do dec(last);
                            writeitem(last,true);
                           end
                       else
                           begin
                            writeitem(last,false);
                            repeat
                            last:=last-1;
                            if last<1 then last:=items;
                            until line[last].enabled;
                            writeitem(last,true);
                           end;
         kbDown:if last=0 then
                           begin
                            last:=1;
                            while not line[last].enabled do inc(last);
                            writeitem(last,true);
                           end
                       else
                           begin
                            writeitem(last,false);
                            repeat
                            last:=last+1;
                            if last>items then last:=1;
                            until line[last].enabled;
                            writeitem(last,true);
                           end;
                  end;
   if (ev.scankey=kbEnter)and(line[last].enabled)and(last<>0)then
      begin
       selected:=last;
      end;
   if ev.scankey=kbEsc then
      begin
      out:=true;
      selected:=0;
      end;
   end;
   if (but=1)and(line[last].enabled)and(last<>0)then
      begin
       selected:=last;
      end;
   if (but=1)and(last=0)then
      begin
       out:=true;
       selected:=0;
      end;
 xx:=xm;yy:=ym;
    run:=0;
 if selected<>0 then
    begin
    waitrelease;
    settextjustify(centertext,toptext);
    setcolor(lightgray);outtextxy((2*menx+8*maxl+12)div 2,meny+3,mentitle);
    setcolor(darkgray);outtextxy((2*menx+8*maxl+12)div 2+1,meny+4,mentitle);
    showmouse;
    run:=last;
    end;
 if out then begin run:=-1;out:=false;waitrelease;end;
end;


Destructor TMenuXMS.Done;
var items:integer;
begin
 items:=nritem-1;
 if items<1 then exit;
 hidemouse;
 restoreimage(menx,meny,pointhan,0);
 freeextmem(pointhan);
 showmouse;
end;


  --- Versiunea veche a lui TMenuXMS ---
  --- O pastrez pana ma conving ca cea noua functioneaza bine ---

}



constructor TList.Init;
begin
 lisx:=x;lisy:=y;lislungcar:=lung;
 if lislungcar<1 then lislungcar:=1;
 lislatcar:=lat;
 if lislatcar<3 then lislatcar:=3;
 lislung:=8*lislatcar+4;lislat:=9*lislungcar+23;
 lisenabled:=true;
 liswin:=w;
 liscol:=col;lissize:=liscol^.size;
 printbeg:=col^.header;
 akt:=liscol^.header;
 clickcont:=0;
 liscul:=cul;
end;


procedure TList.viewlist;
var i,x1,y1:integer;
    temp:ColItPo;
begin
if liscol^.counter>0 then begin
HideMouse;
i:=0;
x1:=liswin^.winx+lisx;
y1:=liswin^.winy+lisy;
temp:=printbeg;
getviewsettings(wp);
setviewport(wp.x1+x1,wp.y1+y1+10,wp.x1+x1+8*lislatcar+4,wp.y1+y1+9*lislungcar+13,clipon);
if liscol^.counter>0 then
while (i<lislungcar)and(temp<>nil) do
      begin
      setfillstyle(solidfill,liscul);
      bar(1,i*9+2,8*lislatcar+3,(i+1)*9+1);
      setcolor(black);
      view(temp^.item,3,i*9+3,8*lislatcar+3,(i+1)*9+2);
      if (temp=akt)and LisEnabled then
         begin
         setcolor(black);
         setlinestyle(4,$AAAA,1);
         rectangle(1,i*9+2,8*lislatcar+3,(i+1)*9+1{2});
         setlinestyle(0,0,1);
         LisIndex:=i;
         end;
      inc(i);
      temp:=temp^.next;
      end;
setviewport(wp.x1,wp.y1,wp.x2,wp.y2,wp.clip);
ShowMouse;
end;
end;

procedure TList.Show;
var x1,y1:integer;
begin
HideMouse;
x1:=liswin^.winx+lisx;y1:=liswin^.winy+lisy;
setfillstyle(solidfill,liscul);
bar(x1,y1,x1+8*lislatcar+4,y1+9*lislungcar+23);
setcolor(black);
rectangle(x1,y1,x1+8*lislatcar+4,y1+9*lislungcar+23);
line(x1,y1+10,x1+8*lislatcar+4,y1+10);
line(x1,y1+9*lislungcar+13,x1+8*lislatcar+4,y1+9*lislungcar+13);
setfillstyle(solidfill,lightgray);
bar(x1+1,y1+1,x1+8*lislatcar+3,y1+9);
keret(x1,y1,x1+8*lislatcar+4,y1+10,1);
bar(x1+1,y1+9*lislungcar+14,x1+8*lislatcar+3,y1+9*lislungcar+22);
keret(x1,y1+9*lislungcar+13,x1+8*lislatcar+4,y1+9*lislungcar+23,1);
if LisEnabled then setcolor(black) else setcolor(white);
settextjustify(lefttext,toptext);
outtextxy(x1+5,y1+2,#30#30);
settextjustify(righttext,bottomtext);
outtextxy(x1+8*lislatcar+1,y1+9*lislungcar+23,#31#31);
if LisEnabled then setcolor(black) else setcolor(lightgray);
viewlist;
if LisEnabled then drawselect;
ShowMouse;
end;


procedure TList.enable;
begin
if not LisEnabled then
   begin
   LisEnabled:=true;
   show;
   end;
end;

procedure TList.disable;
begin
if LisEnabled then
   begin
   LisEnabled:=false;
   show;
   end;
end;

procedure TList.view;
begin
if po<>nil then
begin
settextjustify(lefttext,toptext);
outtextxy(a,b,string(po^));
end;
end;

procedure TList.drawselect;
var x1,y1:integer;
begin
   HideMouse;
   x1:=liswin^.winx+lisx;y1:=liswin^.winy+lisy;
   getviewsettings(wp);
   setviewport(wp.x1+x1,wp.y1+y1+10,wp.x1+x1+8*lislatcar+4,wp.y1+y1+9*lislungcar+13,clipon);
   setfillstyle(solidfill,blue);
   bar(1,LisIndex*9+2,8*lislatcar+3,(LisIndex+1)*9+1);
   setcolor(white);
   view(akt^.item,3,LisIndex*9+3,8*lislatcar+3,(LisIndex+1)*9+2);
   setviewport(wp.x1,wp.y1,wp.x2,wp.y2,wp.clip);
   ShowMouse;
end;

procedure TList.delselect;
var x1,y1:integer;
begin
   HideMouse;
   x1:=liswin^.winx+lisx;y1:=liswin^.winy+lisy;
   getviewsettings(wp);
   setviewport(wp.x1+x1,wp.y1+y1+10,wp.x1+x1+8*lislatcar+4,wp.y1+y1+9*lislungcar+13,clipon);
   setfillstyle(solidfill,liscul);
   bar(1,LisIndex*9+2,8*lislatcar+3,(LisIndex+1)*9+1);
   setcolor(black);
   view(akt^.item,3,LisIndex*9+3,8*lislatcar+3,(LisIndex+1)*9+2);
   setviewport(wp.x1,wp.y1,wp.x2,wp.y2,wp.clip);
   ShowMouse;
end;


function TList.Clicked;
var x1,y1,yy:integer;
procedure fd;
begin
if (LisIndex<lislungcar-1)and(akt^.next<>nil)then
   begin
    delselect;
    inc(LisIndex);
    liscol^.next(akt);
    drawselect;
   end else
if (LisIndex=lislungcar-1)and(akt^.next<>nil)then
   begin
    liscol^.next(printbeg);
    liscol^.next(akt);
    viewlist;
    drawselect;
   end;
end;
procedure bk;
begin
if (LisIndex>0)and(akt^.last<>nil)then
   begin
    delselect;
    liscol^.last(akt);
    dec(LisIndex);
    drawselect;
   end else
if (LisIndex=0)and(akt^.last<>nil)then
   begin
   liscol^.last(printbeg);
   liscol^.last(akt);
   viewlist;
   drawselect;
   end;
end;
begin
clicked:='';
x1:=liswin^.winx+lisx;y1:=liswin^.winy+lisy;
if (ev.mx<x1) or (ev.mx>x1+8*lislatcar+4) then exit;
if (ev.my<y1) or (ev.my>y1+9*lislungcar+23) then exit;
if (ev.but<>1) or not lisenabled then exit;
if ev.my<y1+10 then
   begin {Up}
   hidemouse;keret(x1,y1,x1+8*lislatcar+4,y1+10,0);showmouse;
   bk;
   WaitRelease;
   hidemouse;keret(x1,y1,x1+8*lislatcar+4,y1+10,1);showmouse;
   end
      else if ev.my>y1+9*lislungcar+13 then
              begin {Down}
              hidemouse;keret(x1,y1+9*lislungcar+13,x1+8*lislatcar+4,y1+9*lislungcar+23,0);showmouse;
              fd;
              WaitRelease;
              hidemouse;keret(x1,y1+9*lislungcar+13,x1+8*lislatcar+4,y1+9*lislungcar+23,1);showmouse;
              end
                 else
                     begin {Inside}
                     clickcont:=2;
                     delselect;
                     LisIndex:=0;
                     akt:=printbeg;
                     while (LisIndex<>(ev.my-y1)div 9-1)and(LisIndex<lislungcar-1)and(akt^.next<>nil) do
                     begin
                     liscol^.next(akt);
                     inc(LisIndex);
                     end;
                     drawselect;
                     WaitRelease;
                     end;
  if clickcont=2 then begin Clicked:=string(akt^.item^);clickcont:=0;end;
end;

procedure TList.reinit;
begin
 done;
 init(liswin,lisx,lisy,lislungcar,lislatcar,liscul,liscol);
end;

destructor TList.Done;
begin
end;



Constructor TScollImage.Init;
var luima,laima:longint;
begin
 win:=w;
 px:=x;
 py:=y;
 pdx:=dx;
 pdy:=dy;
 plung:=lung-15;
 plat:=lat;
 prlung:=plung;
 prlat:=plat;
 pfilehandle:=filehandle;
 pcolor:=white;

 readextmem(4,pfilehandle,0,luima);
 readextmem(4,pfilehandle,4,laima);
 pluima:=luima;plaima:=laima;

 if pdx>luima-plung-5 then pdx:=luima-plung-10;if pdx<0 then pdx:=0;
 if pdy>laima-plat-5 then pdy:=laima-plat-10;if pdy<0 then pdy:=0;

 new(r1,init(w,px,plat+py,plung,15,0,0,luima-plung,16,pdx));
 new(r2,init(w,plung+px,py,plat,15,1,0,laima-plat,16,pdy));
 new(b1,Init(w,plung+px+2,plat+py+2,13,13,'H'));

 if pluima<plung then begin r1^.rulpos:=0;r1^.disable;prlung:=pluima;pdx:=0;end;
 if plaima<plat  then begin r2^.rulpos:=0;r2^.disable;prlat:=plaima;pdy:=0;end;
 if (not r1^.rulenabled)and(not r2^.rulenabled) then b1^.disable;
end;

Procedure TScollImage.Show;
begin
 SetColor(Black);
 hidemouse;
 if (pluima<plung)or(plaima<plat)then
  begin
   SetFillStyle(SolidFill,PColor);
   Bar(win^.winx+px,win^.winy+py,win^.winx+px+plung,win^.winy+py+plat);
  end;
 Rectangle(win^.winx+px-1,win^.winy+py-1,win^.winx+px+plung+16,win^.winy+py+plat+16);
 RestoreFrame(win^.winx+px,win^.winy+py,pfilehandle,pdx,pdy,prlung,prlat);
 showmouse;
 r1^.Show;
 r2^.Show;
 b1^.Show;
end;

Procedure TScollImage.Run;
begin
 if b1^.clicked(ev) then
  begin
    r1^.SetPos(pdx);
    r2^.Setpos(pdy);
    hidemouse;
    RestoreFrame(win^.winx+px,win^.winy+py,pfilehandle,r1^.getpos,r2^.getpos,prlung,prlat);
    showmouse;
  end;
 if (r1^.clicked(ev)or
     r2^.clicked(ev)) then
      RestoreFrame(win^.winx+px,win^.winy+py,pfilehandle,r1^.getpos,r2^.getpos,prlung,prlat);
end;

Destructor TScollImage.Done;
begin
 Dispose(r1,Done);
 Dispose(r2,Done);
 Dispose(b1,Done);
end;

end.


