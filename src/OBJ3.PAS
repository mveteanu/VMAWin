{                                                               }
{  Acest unit implementeaza utilizarea contoalelor stil Borland }
{                                                               }

unit OBJ3;
interface
uses appmcga,graph,mouse,events,obj,obj2;

type PBorButton =^TBorButton;
     TBorButton =object(TUsrButton)
                  nrbuton:byte;
                  constructor Init(w:pwindow;x,y,tip:integer);
                 end;

type PBorWindow1B =^TBorWindow1B;
     TBorWindow1B =object(T1BWin)
                    tipfer:byte;icoaddr:pointer;
                    constructor Init(x,y,tip:integer;mesajb1,title,mesaj:string);
                    procedure   ShowTxt;virtual;
                    private imalung,imalat:word;
                   end;

type PBorWindow2B =^TBorWindow2B;
     TBorWindow2B =object(T2BWin)
                    tipfer:byte;icoaddr:pointer;
                    constructor Init(x,y,tip:integer;mesajb1,mesajb2,title,mesaj:string);
                    procedure   ShowTxt;virtual;
                    private imalung,imalat:word;
                   end;

type PBorWindow3B =^TBorWindow3B;
     TBorWindow3B =object(T3BWin)
                    tipfer:byte;icoaddr:pointer;
                    constructor Init(x,y,tip:integer;mesajb1,mesajb2,mesajb3,title,mesaj:string);
                    procedure   ShowTxt;virtual;
                    private imalung,imalat:word;
                   end;

type PBor2Window1B =^TBor2Window1B;
     TBor2Window1B =object(T1BWin)
                    tipfer:byte;icoaddr,butaddr:pointer;
                    bu1:pusrbutton;
                    constructor Init(x,y,tip:integer;but1:byte;title,mesaj:string);
                    procedure   ShowTxt;virtual;
                    Function    Run:byte;virtual;
                    Destructor  Done;virtual;
                    private imalung,imalat:word;
                   end;

type PBor2Window2B =^TBor2Window2B;
     TBor2Window2B =object(T2BWin)
                    tipfer:byte;icoaddr,butaddr1,butaddr2:pointer;
                    bu1,bu2:pusrbutton;
                    constructor Init(x,y,tip:integer;bt1,bt2:byte;title,mesaj:string);
                    procedure   ShowTxt;virtual;
                    Function    Run:byte;virtual;
                    Destructor  Done;virtual;
                    private imalung,imalat:word;
                   end;

type PBor2Window3B =^TBor2Window3B;
     TBor2Window3B =object(T3BWin)
                    tipfer:byte;icoaddr,butaddr1,butaddr2,butaddr3:pointer;
                    bu1,bu2,bu3:pusrbutton;
                    constructor Init(x,y,tip:integer;bt1,bt2,bt3:byte;title,mesaj:string);
                    procedure   ShowTxt;virtual;
                    Function    Run:byte;virtual;
                    Destructor  Done;virtual;
                    private imalung,imalat:word;
                   end;

const
 But_OK=1;
 But_Cancel=2;
 But_Abort=3;
 But_Retry=4;
 But_Ignore=5;
 But_Yes=6;
 But_No=7;
 But_Help=8;

implementation

{$F+}
procedure butok;external;{$l b1.obj}
procedure butcancel;external;{$l b2.obj}
procedure butabort;external;{$l b3.obj}
procedure butretry;external;{$l b4.obj}
procedure butignore;external;{$l b5.obj}
procedure butyes;external;{$l b6.obj}
procedure butno;external;{$l b7.obj}
procedure buthelp;external;{$l b8.obj}
procedure imintrebare;external;{$l s1.obj}
procedure immirare;external;{$l s2.obj}
procedure iminfo;external;{$l s3.obj}
procedure imstop;external;{$l s4.obj}
{$F-}

procedure Keret(xr1,yr1,xr2,yr2,tip:integer);
begin
   setwritemode(copyput);setlinestyle(0,0,0);
   if tip=0 then setcolor(darkgray)else
   setcolor(white);
   graph.line(xr1+1,yr1+1,xr2-2,yr1+1);
   line(xr1+1,yr1+1,xr1+1,yr2-1);
   if tip=0 then setcolor(white)else
   setcolor(darkgray);
   line(xr2-1,yr1+1,xr2-1,yr2-1);
   line(xr2-1,yr2-1,xr1+1,yr2-1);
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

constructor TBorButton.Init;
begin
 case tip of
  1 : inherited init(w,x,y,@butok);
  2 : inherited init(w,x,y,@butcancel);
  3 : inherited init(w,x,y,@butabort);
  4 : inherited init(w,x,y,@butretry);
  5 : inherited init(w,x,y,@butignore);
  6 : inherited init(w,x,y,@butyes);
  7 : inherited init(w,x,y,@butno);
  8 : inherited init(w,x,y,@buthelp);
 end;
end;

Constructor TBorWindow1B.Init(x,y,tip:integer;mesajb1,title,mesaj:string);
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
 tipfer:=tip;
 case tipfer of
  1 : icoaddr:=@imintrebare;
  2 : icoaddr:=@immirare;
  3 : icoaddr:=@iminfo;
  4 : icoaddr:=@imstop;
 end;
 imaLung:=IconType(icoaddr^).lung;
 imaLat:=IconType(icoaddr^).lat;

 winbox:=true;winx:=x;winy:=y;txtx:=10+imalung+20;txty:=30;

 new(fer,init(x,y,300,200,title,1,true));fer^.show;

 setfillstyle(solidfill,lightgray);
 hidemouse;bar(winx+20,winy+30,winx+300-20,winy+130);
 keret(winx+20,winy+30,winx+300-20,winy+130,0);
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+146,fer^.winx+fer^.winlung-5,fer^.winy+146);
 setcolor(white);line(fer^.winx+5,fer^.winy+147,fer^.winx+fer^.winlung-5,fer^.winy+147);
 showmouse;

 new(tex,init(fer,txtx,txty,250-imalung,100,0,mesaj));
 new(b1,init(fer,110,162,80,20,mesajb1));
end;

Procedure TBorWindow1B.ShowTxT;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
var i,j:integer;
    lu,la:integer;
begin
 inherited showtxt;
 hidemouse;
 lu:=Icontype(icoaddr^).lung+1;
 la:=Icontype(icoaddr^).lat+1;
 if (GetMaxColor<>15) then putimage(30+winx,45+winy,Icontype(icoaddr^).lung,copyput)
  else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(30+winx+j,45+winy+i,lookuptable[Icontype(icoaddr^).front[1+i*lu+j]]);
    end;
 showmouse;
end;

Constructor TBorWindow2B.Init(x,y,tip:integer;mesajb1,mesajb2,title,mesaj:string);
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
 tipfer:=tip;
 case tipfer of
  1 : icoaddr:=@imintrebare;
  2 : icoaddr:=@immirare;
  3 : icoaddr:=@iminfo;
  4 : icoaddr:=@imstop;
 end;
 imaLung:=IconType(icoaddr^).lung;
 imaLat:=IconType(icoaddr^).lat;

 winbox:=true;winx:=x;winy:=y;txtx:=10+imalung+20;txty:=30;

 new(fer,init(x,y,300,200,title,1,true));fer^.show;

 setfillstyle(solidfill,lightgray);
 hidemouse;bar(winx+20,winy+30,winx+300-20,winy+130);
 keret(winx+20,winy+30,winx+300-20,winy+130,0);
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+146,fer^.winx+fer^.winlung-5,fer^.winy+146);
 setcolor(white);line(fer^.winx+5,fer^.winy+147,fer^.winx+fer^.winlung-5,fer^.winy+147);
 showmouse;

 new(tex,init(fer,txtx,txty,250-imalung,100,0,mesaj));
 new(b1,init(fer,40,162,80,20,mesajb1));
 new(b2,init(fer,180,162,80,20,mesajb2));
end;

Procedure TBorWindow2B.ShowTxT;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
var i,j:integer;
    lu,la:integer;
begin
 inherited showtxt;
 hidemouse;
 lu:=Icontype(icoaddr^).lung+1;
 la:=Icontype(icoaddr^).lat+1;
 if (GetMaxColor<>15) then putimage(30+winx,45+winy,Icontype(icoaddr^).lung,copyput)
  else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(30+winx+j,45+winy+i,lookuptable[Icontype(icoaddr^).front[1+i*lu+j]]);
    end;
 showmouse;
end;

Constructor TBorWindow3B.Init(x,y,tip:integer;mesajb1,mesajb2,mesajb3,title,mesaj:string);
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
 tipfer:=tip;
 case tipfer of
  1 : icoaddr:=@imintrebare;
  2 : icoaddr:=@immirare;
  3 : icoaddr:=@iminfo;
  4 : icoaddr:=@imstop;
 end;
 imaLung:=IconType(icoaddr^).lung;
 imaLat:=IconType(icoaddr^).lat;

 winbox:=true;winx:=x;winy:=y;txtx:=10+imalung+20;txty:=30;

 new(fer,init(x,y,300,200,title,1,true));fer^.show;

 setfillstyle(solidfill,lightgray);
 hidemouse;bar(winx+20,winy+30,winx+300-20,winy+130);
 keret(winx+20,winy+30,winx+300-20,winy+130,0);
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+146,fer^.winx+fer^.winlung-5,fer^.winy+146);
 setcolor(white);line(fer^.winx+5,fer^.winy+147,fer^.winx+fer^.winlung-5,fer^.winy+147);
 showmouse;

 new(tex,init(fer,txtx,txty,250-imalung,100,0,mesaj));
 new(b1,init(fer,25,162,60,20,mesajb1));
 new(b2,init(fer,120,162,60,20,mesajb2));
 new(b3,init(fer,215,162,60,20,mesajb3));
end;

Procedure TBorWindow3B.ShowTxT;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
var i,j:integer;
    lu,la:integer;
begin
 inherited showtxt;
 hidemouse;
 lu:=Icontype(icoaddr^).lung+1;
 la:=Icontype(icoaddr^).lat+1;
 if (GetMaxColor<>15) then putimage(30+winx,45+winy,Icontype(icoaddr^).lung,copyput)
 else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(30+winx+j,45+winy+i,lookuptable[Icontype(icoaddr^).front[1+i*lu+j]]);
    end;
 showmouse;
end;

Constructor TBor2Window1B.Init(x,y,tip:integer;but1:byte;title,mesaj:string);
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
 tipfer:=tip;
 case tipfer of
  1 : icoaddr:=@imintrebare;
  2 : icoaddr:=@immirare;
  3 : icoaddr:=@iminfo;
  4 : icoaddr:=@imstop;
 end;
 case but1 of
  1 : butaddr:=@butok;
  2 : butaddr:=@butcancel;
  3 : butaddr:=@butabort;
  4 : butaddr:=@butretry;
  5 : butaddr:=@butignore;
  6 : butaddr:=@butyes;
  7 : butaddr:=@butno;
  8 : butaddr:=@buthelp;
 end;
 imaLung:=IconType(icoaddr^).lung;
 imaLat:=IconType(icoaddr^).lat;

 winbox:=true;winx:=x;winy:=y;txtx:=10+imalung+20;txty:=30;

 new(fer,init(x,y,300,200,title,1,true));fer^.show;

 setfillstyle(solidfill,lightgray);
 hidemouse;bar(winx+20,winy+30,winx+300-20,winy+130);
 keret(winx+20,winy+30,winx+300-20,winy+130,0);
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+142,fer^.winx+fer^.winlung-5,fer^.winy+142);
 setcolor(white);line(fer^.winx+5,fer^.winy+143,fer^.winx+fer^.winlung-5,fer^.winy+143);
 showmouse;

 new(tex,init(fer,txtx,txty,250-imalung,100,0,mesaj));
 new(bu1,init(fer,118,148,butaddr));
end;

Procedure TBor2Window1B.ShowTxT;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
var i,j:integer;
    lu,la:integer;
begin
 inherited showtxt;
 hidemouse;
 lu:=Icontype(icoaddr^).lung+1;
 la:=Icontype(icoaddr^).lat+1;
 if (GetMaxColor<>15) then putimage(30+winx,45+winy,Icontype(icoaddr^).lung,copyput)
  else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(30+winx+j,45+winy+i,lookuptable[Icontype(icoaddr^).front[1+i*lu+j]]);
    end;
 showmouse;
end;

Function TBor2Window1B.Run;
var return:byte;
begin
 showtxt;
 bu1^.show;
 return:=0;
 repeat
  getevent(ev);
  fer^.move;
  if bu1^.clicked(ev)  then return:=1;
  if winbox and fer^.clicked(ev) then return:=2;
 until return<>0;
 if return=2 then return:=0;Run:=return;
end;

Destructor TBor2Window1B.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(bu1,done);
end;

Constructor TBor2Window2B.Init;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
 tipfer:=tip;
 case tipfer of
  1 : icoaddr:=@imintrebare;
  2 : icoaddr:=@immirare;
  3 : icoaddr:=@iminfo;
  4 : icoaddr:=@imstop;
 end;
 case bt1 of
  1 : butaddr1:=@butok;
  2 : butaddr1:=@butcancel;
  3 : butaddr1:=@butabort;
  4 : butaddr1:=@butretry;
  5 : butaddr1:=@butignore;
  6 : butaddr1:=@butyes;
  7 : butaddr1:=@butno;
  8 : butaddr1:=@buthelp;
 end;
 case bt2 of
  1 : butaddr2:=@butok;
  2 : butaddr2:=@butcancel;
  3 : butaddr2:=@butabort;
  4 : butaddr2:=@butretry;
  5 : butaddr2:=@butignore;
  6 : butaddr2:=@butyes;
  7 : butaddr2:=@butno;
  8 : butaddr2:=@buthelp;
 end;
 imaLung:=IconType(icoaddr^).lung;
 imaLat:=IconType(icoaddr^).lat;

 winbox:=true;winx:=x;winy:=y;txtx:=10+imalung+20;txty:=30;

 new(fer,init(x,y,300,200,title,1,true));fer^.show;

 setfillstyle(solidfill,lightgray);
 hidemouse;bar(winx+20,winy+30,winx+300-20,winy+130);
 keret(winx+20,winy+30,winx+300-20,winy+130,0);
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+142,fer^.winx+fer^.winlung-5,fer^.winy+142);
 setcolor(white);line(fer^.winx+5,fer^.winy+143,fer^.winx+fer^.winlung-5,fer^.winy+143);
 showmouse;

 new(tex,init(fer,txtx,txty,250-imalung,100,0,mesaj));
 new(bu1,init(fer,57,148,butaddr1));
 new(bu2,init(fer,178,148,butaddr2));
end;

Procedure TBor2Window2B.ShowTxT;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
var i,j:integer;
    lu,la:integer;
begin
 inherited showtxt;
 hidemouse;
 lu:=Icontype(icoaddr^).lung+1;
 la:=Icontype(icoaddr^).lat+1;
 if (GetMaxColor<>15) then putimage(30+winx,45+winy,Icontype(icoaddr^).lung,copyput)
  else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(30+winx+j,45+winy+i,lookuptable[Icontype(icoaddr^).front[1+i*lu+j]]);
    end;
 showmouse;
end;

Function TBor2Window2B.Run;
var return:byte;
begin
 showtxt;
 bu1^.show;bu2^.show;
 return:=99;
 repeat
  getevent(ev);
  fer^.move;
  if bu1^.clicked(ev)  then return:=1;
  if bu2^.clicked(ev)  then return:=2;
  if winbox and fer^.clicked(ev) then return:=0;
 until return<>99;
 Run:=return;
end;

Destructor TBor2Window2B.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(bu1,done);
 dispose(bu2,done);
end;

Constructor TBor2Window3B.Init;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
begin
 tipfer:=tip;
 case tipfer of
  1 : icoaddr:=@imintrebare;
  2 : icoaddr:=@immirare;
  3 : icoaddr:=@iminfo;
  4 : icoaddr:=@imstop;
 end;
 case bt1 of
  1 : butaddr1:=@butok;
  2 : butaddr1:=@butcancel;
  3 : butaddr1:=@butabort;
  4 : butaddr1:=@butretry;
  5 : butaddr1:=@butignore;
  6 : butaddr1:=@butyes;
  7 : butaddr1:=@butno;
  8 : butaddr1:=@buthelp;
 end;
 case bt2 of
  1 : butaddr2:=@butok;
  2 : butaddr2:=@butcancel;
  3 : butaddr2:=@butabort;
  4 : butaddr2:=@butretry;
  5 : butaddr2:=@butignore;
  6 : butaddr2:=@butyes;
  7 : butaddr2:=@butno;
  8 : butaddr2:=@buthelp;
 end;
 case bt3 of
  1 : butaddr3:=@butok;
  2 : butaddr3:=@butcancel;
  3 : butaddr3:=@butabort;
  4 : butaddr3:=@butretry;
  5 : butaddr3:=@butignore;
  6 : butaddr3:=@butyes;
  7 : butaddr3:=@butno;
  8 : butaddr3:=@buthelp;
 end;
 imaLung:=IconType(icoaddr^).lung;
 imaLat:=IconType(icoaddr^).lat;

 winbox:=true;winx:=x;winy:=y;txtx:=10+imalung+20;txty:=30;

 new(fer,init(x,y,300,200,title,1,true));fer^.show;

 setfillstyle(solidfill,lightgray);
 hidemouse;bar(winx+20,winy+30,winx+300-20,winy+130);
 keret(winx+20,winy+30,winx+300-20,winy+130,0);
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+142,fer^.winx+fer^.winlung-5,fer^.winy+142);
 setcolor(white);line(fer^.winx+5,fer^.winy+143,fer^.winx+fer^.winlung-5,fer^.winy+143);
 showmouse;

 new(tex,init(fer,txtx,txty,250-imalung,100,0,mesaj));
 new(bu1,init(fer,028,148,butaddr1));
 new(bu2,init(fer,119,148,butaddr2));
 new(bu3,init(fer,210,148,butaddr3));
end;

Procedure TBor2Window3B.ShowTxT;
type IconType  =record lung,lat:word;front:array[1..50000]of byte;end;
var i,j:integer;
    lu,la:integer;
begin
 inherited showtxt;
 hidemouse;
 lu:=Icontype(icoaddr^).lung+1;
 la:=Icontype(icoaddr^).lat+1;
 if (GetMaxColor<>15) then putimage(30+winx,45+winy,Icontype(icoaddr^).lung,copyput)
  else
    begin
     getallpal(paltemp);
     for i:=0 to 255 do lookuptable[i]:=findclosest16(paltemp,i);
     for i:=0 to la-1 do
      for j:=0 to lu-1 do
       putpixel(30+winx+j,45+winy+i,lookuptable[Icontype(icoaddr^).front[1+i*lu+j]]);
    end;
 showmouse;
end;

Function TBor2Window3B.Run;
var return:byte;
begin
 showtxt;
 bu1^.show;bu2^.show;bu3^.show;
 return:=99;
 repeat
  getevent(ev);
  fer^.move;
  if bu1^.clicked(ev)  then return:=1;
  if bu2^.clicked(ev)  then return:=2;
  if bu3^.clicked(ev)  then return:=3;
  if winbox and fer^.clicked(ev) then return:=0;
 until return<>99;
 Run:=return;
end;

Destructor TBor2Window3B.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(bu1,done);
 dispose(bu2,done);
 dispose(bu3,done);
end;

end.

