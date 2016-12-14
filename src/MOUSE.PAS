unit mouse;
interface

  {$I MOUSE.INC}
  procedure ShowMouse;
  procedure HideMouse;
  procedure InitMouse;
  function  MouseX:integer;
  function  MouseY:integer;
  function  LeftPressed:boolean;
  function  LeftPressed1:boolean;
  function  RightPressed:boolean;
  function  RightPressed1:boolean;
  function  Midpressed:boolean;
  function  ExistMouse:boolean;
  procedure MoveMouse(x,y:integer);
  procedure SetAreaX(x,y:integer);
  procedure SetAreaY(x,y:integer);
  procedure SetArea(x,y,z,t:integer);
  procedure SelectCursor(s:string);
  procedure SelectStdCursor(shape:Byte);
  function  GetStdCursor:byte;
  procedure GetMouseStatus(var x,y,b:integer);
  procedure WaitRelease;
  procedure SetSenzitivity(x,y,prag:word);
  procedure GetSenzitivity(var x,y,prag:word);
  function  GetLogitechSignature:string;
  function  IsLogitech:boolean;

implementation
uses dos;

var re:registers;
    existm,ml,mr:boolean;
    m1,m2,m3,m4:integer;
    di:integer;
    LogitechSignature:string;first:boolean;
    curentcursor:byte;

    procedure pMouse; assembler;
    asm
      MOV AX,m1
      MOV BX,m2
      MOV CX,m3
      MOV DX,m4
      INT $33
      MOV m1,AX
      MOV m2,BX
      MOV m3,CX
      MOV m4,DX
    end;

procedure GetMouseStatus(var x,y,b:integer);
    begin
         m1:=3;
         pMouse;
         b:=m2;
         x:=m3 div di;
         y:=m4
    end;

procedure waitrelease;
var xx,yy,but:integer;
begin
repeat
getmousestatus(xx,yy,but);
until but=0;
end;

Procedure initmouse;
  begin
    if (mem[0:$449]>$13)and(not IsLogitech) then
       begin
        asm mov ax,3; int 10h; end;
        writeln(' Eroare de executie !');
        writeln(' Driverul de mouse LOGITECH V6.2+ trebuie sa fie rezident.');
        halt(1);
       end;

    re.ax:=0;
    intr($33,re);
    if re.ax=$ffff then existm:=true else exit;
    di:=1;if mem[0:$449]=$13 then di:=2;
    if mem[0:$449]>$13 then SelectStdCursor(Arrow);
  end;

procedure showmouse;
  begin
    if not existm then exit;
    re.ax:=1;
    intr($33,re);
  end;

procedure hidemouse;
  begin
    if not existm then exit;
    re.ax:=2;
    intr($33,re);
  end;

function leftpressed;
  begin
    if not existm then begin leftpressed:=false;exit;end;
    re.ax:=3;
    intr($33,re);
    if re.bx and 1 <> 0 then leftpressed:=true else leftpressed:=false;
  end;

function leftpressed1;
  begin
    if not existm then begin leftpressed1:=false;exit;end;
    re.ax:=3;
    intr($33,re);
    if (re.bx and 1<>0) and ml then begin leftpressed1:=false;exit; end;
    ml:=false;
    re.ax:=3;
    intr($33,re);
    if re.bx and 1 <> 0 then begin ml:=true;leftpressed1:=true;end else leftpressed1:=false;
  end;

function rightpressed1;
  begin
    if not existm then begin rightpressed1:=false;exit;end;
    re.ax:=3;
    intr($33,re);
    if (re.bx and 2<>0) and mr then begin rightpressed1:=false;exit; end;
    mr:=false;
    re.ax:=3;
    intr($33,re);
    if re.bx and 2 <> 0 then begin mr:=true;rightpressed1:=true;end else rightpressed1:=false;
  end;

function rightpressed;
  begin
    if not existm then begin rightpressed:=false;exit;end;
    re.ax:=3;
    intr($33,re);
    if re.bx and 2 <> 0 then rightpressed:=true else rightpressed:=false;
  end;

function midpressed;
  begin
    if not existm then begin midpressed:=false;exit;end;
    re.ax:=3;
    intr($33,re);
    if re.bx and 4 <> 0 then midpressed:=true else midpressed:=false;
  end;

function mousex;
  begin
    if not existm then exit;
    re.ax:=3;
    intr($33,re);
    mousex:=re.cx div di
  end;

function mousey;
  begin
    if not existm then exit;
    re.ax:=3;
    intr($33,re);
    mousey:=re.dx
  end;

function existmouse;
begin
  existmouse:=existm;
end;

procedure movemouse;
  begin
    if not existm then exit;
    hidemouse;
    re.ax:=4;
    re.cx:=x*di;
    re.dx:=y;
    intr($33,re);
    showmouse;
  end;

procedure setareax(x,y:integer);
  begin
    re.ax:=7;
    re.cx:=x*di;re.dx:=y*di;
    intr($33,re);
  end;

procedure setareay(x,y:integer);
  begin
    re.ax:=8;
    re.cx:=x;re.dx:=y;
    intr($33,re);
  end;

procedure setarea(x,y,z,t:integer);
  begin
    setareax(x,z);setareay(y,t);
  end;


procedure selectcursor;
type tip=array[1..32] of word;
     mous=record
                data:tip;
                x,y:integer;
               end;
var q:tip;
    m:mous;
    fis:file of mous;
    re:registers;
begin
  curentcursor:=0;
  assign(fis,s);
  {$i-}reset(fis);{$i+}
  if ioresult=0 then
                   begin
                      read(fis,m);
                      close(fis);
                      q:=m.data;
                      re.ax:=9;
                      re.bx:=m.x;
                      re.cx:=m.y;
                      re.es:=seg(q);
                      re.dx:=ofs(q);
                      intr($33,re);
                    end
               else
                   begin
                      initmouse;
                      showmouse;
                   end;
end;

procedure SelectStdCursor(shape:Byte);
begin
  if curentcursor=shape then exit;
  if shape=0 then begin initmouse;showmouse;end;
  re.ax:=9;
  re.bx:=Cursors[Shape].X;
  re.cx:=Cursors[Shape].Y;
  re.dx:=ofs(Cursors[Shape].ScreenMask);
  re.es:=seg(Cursors[Shape].CursorMask);
  Intr($33,re);
  CurentCursor:=Shape;
end;

function GetStdCursor;
begin
 GetStdCursor:=curentcursor;
end;

procedure SetSenzitivity(x,y,prag:word);assembler;
asm
 mov ax,001ah
 mov bx,x
 mov cx,y
 mov dx,prag
 int 33h
end;

procedure GetSenzitivity(var x,y,prag:word);assembler;
asm
 mov ax,001bh
 int 33h
 mov ax,bx
 les bx,x
 mov [es:bx],ax
 les bx,y
 mov [es:bx],cx
 les bx,prag
 mov [es:bx],dx
end;

Function GetLogitechSignature:string;
const f:byte=1;
var _es,_di:word;
var s:array[1..255]of char;
    a:^char;
begin
 if first
  then
   begin
     re.ax:=$156c;
     intr($33,re);
     _es:=re.es;_di:=re.di;
     repeat
      a:=ptr(_es,_di+f-1);
      s[f]:=a^;
      inc(f);
     until (a^=#13)or(f=252);
     LogitechSignature:=copy(s,1,f-3);
     GetLogitechSignature:=LogitechSignature;
     first:=false;
   end
  else GetLogitechSignature:=LogitechSignature;
end;

Function IsLogitech:boolean;
begin
 IsLogitech:=(copy(GetLogitechSignature,1,21)='LOGITECH MOUSE DRIVER');
end;

begin
  existm:=false;
  first:=true;
  curentcursor:=0;
end.

