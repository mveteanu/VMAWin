{     In acest unit sunt implementate cateva obiecte pentru a crea    }
{     cazuri particulare de ferestre cu cate 1, 2 sau 3 butoane       }
{     Sunt disponibile 2 tipuri de obiecte                            }


unit OBJ2;
interface
uses events,graph,obj;

type P1BWindow=^T1BWindow;   { Fereastra cu un buton }
     T1BWindow=object
                   ev:tevent;
                   b1:pbutton;
                   fer:pwindow;tex:ptext;
                   winbox:boolean;
                   Constructor Init(x,y,tipwin,tipfra:integer;mesajb1,title,mesaj:string);
                   Procedure   SetAttr(texture:string;font,size,fcol,bcol:integer);
                   Procedure   SetJustify(hor,ver:byte;wrap:boolean);
                   Procedure   DisableWinBox;
                   Function    Run:byte;
                   Destructor  Done;
                  end;

type P2BWindow=^T2BWindow;   { Fereastra cu doua butonane }
     T2BWindow=object
                   ev:tevent;
                   b1,b2:pbutton;
                   fer:pwindow;tex:ptext;
                   winbox:boolean;
                   Constructor Init(x,y,tipwin,tipfra:integer;mesajb1,mesajb2,title,mesaj:string);
                   Procedure   SetAttr(texture:string;font,size,fcol,bcol:integer);
                   Procedure   SetJustify(hor,ver:byte;wrap:boolean);
                   Procedure   DisableWinBox;
                   Function    Run:byte;
                   Destructor  Done;
                  end;

type P3BWindow=^T3BWindow;   { Fereastra cu trei butoane }
     T3BWindow=object
                   ev:tevent;
                   b1,b2,b3:pbutton;
                   fer:pwindow;tex:ptext;
                   winbox:boolean;
                   Constructor Init(x,y,tipwin,tipfra:integer;mesajb1,mesajb2,mesajb3,title,mesaj:string);
                   Procedure   SetAttr(texture:string;font,size,fcol,bcol:integer);
                   Procedure   SetJustify(hor,ver:byte;wrap:boolean);
                   Procedure   DisableWinBox;
                   Function    Run:byte;
                   Destructor  Done;
                  end;

type P1BWin=^T1BWin;         { Fereastra cu un buton }
     T1BWin=object
              ev:tevent;
              b1:pbutton;
              fer:pwindow;tex:ptext;
              winbox:boolean;
              winx,winy,txtx,txty:integer;
              Constructor Init(x,y:integer;mesajb1,title,mesaj:string);
              Procedure   SetAttr(font,size,fcol:integer);
              Procedure   SetJustify(hor,ver:byte;wrap:boolean);
              Procedure   DisableWinBox;
              Procedure   ShowTxt;virtual;
              Function    Run:byte;virtual;
              Destructor  Done;virtual;
            end;

type P2BWin=^T2BWin;         { Fereastra cu doua butoane }
     T2BWin=object
              ev:tevent;
              b1,b2:pbutton;
              fer:pwindow;tex:ptext;
              winbox:boolean;
              winx,winy,txtx,txty:integer;
              Constructor Init(x,y:integer;mesajb1,mesajb2,title,mesaj:string);
              Procedure   SetAttr(font,size,fcol:integer);
              Procedure   SetJustify(hor,ver:byte;wrap:boolean);
              Procedure   DisableWinBox;
              Procedure   ShowTxt;virtual;
              Function    Run:byte;virtual;
              Destructor  Done;virtual;
            end;

type P3BWin=^T3BWin;         { Fereastra cu trei butoane }
     T3BWin=object
              ev:tevent;
              b1,b2,b3:pbutton;
              fer:pwindow;tex:ptext;
              winbox:boolean;
              winx,winy,txtx,txty:integer;
              Constructor Init(x,y:integer;mesajb1,mesajb2,mesajb3,title,mesaj:string);
              Procedure   SetAttr(font,size,fcol:integer);
              Procedure   SetJustify(hor,ver:byte;wrap:boolean);
              Procedure   DisableWinBox;
              Procedure   ShowTxt;virtual;
              Function    Run:byte;virtual;
              Destructor  Done;virtual;
            end;


implementation
uses mouse;

Constructor T1BWindow.Init;
begin
 new(fer,init(x,y,320,160,title,tipwin,true));
 new(tex,init(fer,20,30,280,86,tipfra,mesaj));
 new(b1,init(fer,120,127,80,16,mesajb1));
 winbox:=true;
end;

Procedure T1BWindow.SetAttr;
begin
 fer^.loadunifimage(texture);
 tex^.setattr(font,size,fcol,bcol);
end;

Procedure T1BWindow.SetJustify(hor,ver:byte;wrap:boolean);
begin
 tex^.SetJustify(hor,ver,wrap);
end;

Procedure T1BWindow.DisableWinBox;
begin
 winbox:=false;
end;

Function T1BWindow.Run;
var return:byte;
begin
 fer^.show;tex^.show;
 b1^.show;
 return:=0;
 repeat
  getevent(ev);
  fer^.move;
  if b1^.clicked(ev)  then return:=1;
  if winbox and fer^.clicked(ev) then return:=2;
 until return<>0;
 if return=2 then return:=0;Run:=return;
end;

Destructor T1BWindow.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(b1,done);
end;


Constructor T2BWindow.Init;
begin
 new(fer,init(x,y,320,160,title,tipwin,true));
 new(tex,init(fer,20,30,280,86,tipfra,mesaj));
 new(b1,init(fer,50,127,80,16,mesajb1));
 new(b2,init(fer,190,127,80,16,mesajb2));
 winbox:=true;
end;

Procedure T2BWindow.SetAttr;
begin
 fer^.loadunifimage(texture);
 tex^.setattr(font,size,fcol,bcol);
end;

Procedure T2BWindow.SetJustify(hor,ver:byte;wrap:boolean);
begin
 tex^.SetJustify(hor,ver,wrap);
end;

Procedure T2BWindow.DisableWinBox;
begin
 winbox:=false;
end;

Function T2BWindow.Run;
var return:byte;
begin
 fer^.show;tex^.show;
 b1^.show;b2^.show;
 return:=0;
 repeat
  getevent(ev);
  fer^.move;
  if b1^.clicked(ev)  then return:=1;
  if b2^.clicked(ev)  then return:=2;
  if winbox and fer^.clicked(ev) then return:=3;
 until return<>0;
 if return=3 then return:=0;Run:=return;
end;

Destructor T2BWindow.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(b1,done);
 dispose(b2,done);
end;



Constructor T3BWindow.Init;
begin
 new(fer,init(x,y,320,160,title,tipwin,true));
 new(tex,init(fer,20,30,280,86,tipfra,mesaj));
 new(b1,init(fer,35,127,60,16,mesajb1));
 new(b2,init(fer,130,127,60,16,mesajb2));
 new(b3,init(fer,225,127,60,16,mesajb3));
 winbox:=true;
end;

Procedure T3BWindow.SetAttr;
begin
 fer^.loadunifimage(texture);
 tex^.setattr(font,size,fcol,bcol);
end;

Procedure T3BWindow.SetJustify(hor,ver:byte;wrap:boolean);
begin
 tex^.SetJustify(hor,ver,wrap);
end;

Procedure T3BWindow.DisableWinBox;
begin
 winbox:=false;
end;

Function T3BWindow.Run;
var return:byte;
begin
 fer^.show;tex^.show;
 b1^.show;b2^.show;b3^.show;
 return:=0;
 repeat
  getevent(ev);
  fer^.move;
  if b1^.clicked(ev)  then return:=1;
  if b2^.clicked(ev)  then return:=2;
  if b3^.clicked(ev)  then return:=3;
  if winbox and fer^.clicked(ev) then return:=4;
 until return<>0;
 if return=4 then return:=0;Run:=return;
end;

Destructor T3BWindow.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(b1,done);
 dispose(b2,done);
 dispose(b3,done);
end;

Constructor T1BWin.Init;
begin
 winbox:=true;
 winx:=x;winy:=y;
 txtx:=20;txty:=30;
 new(fer,init(x,y,300,200,title,1,true));
 new(tex,init(fer,txtx,txty,260,100,5,mesaj));
 new(b1,init(fer,110,162,80,20,mesajb1));
 fer^.show;
 hidemouse;
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+146,fer^.winx+fer^.winlung-5,fer^.winy+146);
 setcolor(white);line(fer^.winx+5,fer^.winy+147,fer^.winx+fer^.winlung-5,fer^.winy+147);
 showmouse;
end;

Procedure T1BWin.SetAttr;
begin
 tex^.setattr(font,size,fcol,7);
end;

Procedure T1BWin.SetJustify(hor,ver:byte;wrap:boolean);
begin
 tex^.SetJustify(hor,ver,wrap);
end;

Procedure T1BWin.DisableWinBox;
begin
 winbox:=false;
end;

Procedure T1BWin.ShowTxt;
begin
 tex^.show;
end;

Function T1BWin.Run;
var return:byte;
begin
 showtxt;
 b1^.show;
 return:=0;
 repeat
  getevent(ev);
  fer^.move;
  if b1^.clicked(ev)  then return:=1;
  if winbox and fer^.clicked(ev) then return:=2;
 until return<>0;
 if return=2 then return:=0;Run:=return;
end;

Destructor T1BWin.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(b1,done);
end;

Constructor T2BWin.Init;
begin
 winbox:=true;
 winx:=x;winy:=y;
 txtx:=20;txty:=30;
 new(fer,init(x,y,300,200,title,1,true));
 new(tex,init(fer,txtx,txty,260,100,5,mesaj));
 new(b1,init(fer,40,162,80,20,mesajb1));
 new(b2,init(fer,180,162,80,20,mesajb2));
 fer^.show;
 hidemouse;
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+146,fer^.winx+fer^.winlung-5,fer^.winy+146);
 setcolor(white);line(fer^.winx+5,fer^.winy+147,fer^.winx+fer^.winlung-5,fer^.winy+147);
 showmouse;
end;

Procedure T2BWin.SetAttr;
begin
 tex^.setattr(font,size,fcol,7);
end;

Procedure T2BWin.SetJustify(hor,ver:byte;wrap:boolean);
begin
 tex^.SetJustify(hor,ver,wrap);
end;

Procedure T2BWin.DisableWinBox;
begin
 winbox:=false;
end;

Procedure T2BWin.ShowTxt;
begin
 tex^.show;
end;

Function T2BWin.Run;
var return:byte;
begin
 showtxt;
 b1^.show;b2^.show;
 return:=255;
 repeat
  getevent(ev);
  fer^.move;
  if b1^.clicked(ev)  then return:=1;
  if b2^.clicked(ev)  then return:=2;
  if winbox and fer^.clicked(ev) then return:=0;
 until return<>255;
 Run:=return;
end;

Destructor T2BWin.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(b1,done);
 dispose(b2,done);
end;

Constructor T3BWin.Init;
begin
 winbox:=true;
 winx:=x;winy:=y;
 txtx:=20;txty:=30;
 new(fer,init(x,y,300,200,title,1,true));
 new(tex,init(fer,txtx,txty,260,100,5,mesaj));
 new(b1,init(fer,25,162,60,20,mesajb1));
 new(b2,init(fer,120,162,60,20,mesajb2));
 new(b3,init(fer,215,162,60,20,mesajb3));
 fer^.show;
 hidemouse;
 setcolor(darkgray);line(fer^.winx+5,fer^.winy+146,fer^.winx+fer^.winlung-5,fer^.winy+146);
 setcolor(white);line(fer^.winx+5,fer^.winy+147,fer^.winx+fer^.winlung-5,fer^.winy+147);
 showmouse;
end;

Procedure T3BWin.SetAttr;
begin
 tex^.setattr(font,size,fcol,7);
end;

Procedure T3BWin.SetJustify(hor,ver:byte;wrap:boolean);
begin
 tex^.SetJustify(hor,ver,wrap);
end;

Procedure T3BWin.DisableWinBox;
begin
 winbox:=false;
end;

Procedure T3BWin.ShowTxt;
begin
 tex^.show;
end;

Function T3BWin.Run;
var return:byte;
begin
 showtxt;
 b1^.show;b2^.show;b3^.show;
 return:=255;
 repeat
  getevent(ev);
  fer^.move;
  if b1^.clicked(ev)  then return:=1;
  if b2^.clicked(ev)  then return:=2;
  if b3^.clicked(ev)  then return:=3;
  if winbox and fer^.clicked(ev) then return:=0;
 until return<>255;
 Run:=return;
end;

Destructor T3BWin.Done;
begin
 dispose(fer,done);
 dispose(tex,done);
 dispose(b1,done);
 dispose(b2,done);
 dispose(b3,done);
end;

end.

