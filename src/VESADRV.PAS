{$G+}
{N$DEFINE trial}
unit VesaDrv;

interface
uses appmcga,graph,xms;
var Mode16:boolean;
    ModeCrt:Integer;
const
  VGA_640x480x16=-1;
  VESA_320x200x256=0;
  VESA_640x400x256=1;
  VESA_640x480x256=2;
  VESA_800x600x256=3;
  VESA_1024x768x256=4;

Const Black  = 0;
      White  = 15;
      White2 = 16;
      Gray1  = 17;
      Gray2  = 18;
      Gray3  = 19;
      Gray4  = 20;
      Gray5  = 21;
      Gray6  = 22;

function  IsVESA:boolean;
procedure OpenGraph(mode:integer);
procedure SetUniformPal;
function  GetImageSize(x1,y1,x2,y2:integer):word;
procedure StoreImage(x1,y1,x2,y2:integer;handler:word;ofs:longint);
procedure RestoreImage(x,y:integer;handler:word;ofs:longint);
procedure RestoreImage2(x,y:integer;handler:word;ofs:longint;pal:virtualpal);
procedure RestoreFrame(x,y:integer;handler:word;dx,dy,dlu,dla:integer);

implementation
{$IFDEF trial}uses crt;{$ENDIF}

var dr:integer;

function DetectDriver:Integer; far; begin DetectDriver:=0; end;

procedure VGADriver;external;{$L egavga.obj}
procedure VesaDriver;external;{$L vesa.obj}
procedure UniformPal;external;{$l uniform.obj}

{$IFDEF trial}{$I trial.inc}{$ENDIF}

procedure Opengraph;
var dr,mo:integer;
begin
ModeCrt:=Mode;
if mode=-1 then
begin
 dr:=VGA;mo:=VGAHi;
 If RegisterBGIDriver(@vgadriver)<0 then
   Begin
    writeln(' Eroare la inregistrarea fisierului egavga.obj');
    halt(2);
   End;
 InitGraph(dr,mo,'');
 Mode16:=true;
end
 else
begin
 dr:=InstallUserDriver('VESA',@DetectDriver);
 if RegisterBGIDriver(@VesaDriver)<0
   then begin
          writeln('Eroare la initializarea driverului VESA !');
          Halt(1);
        end;
 {$IFDEF trial}ThisProgramIsShareware;{$ENDIF}
 InitGraph(dr,Mode,'');
 Mode16:=false;
end;
end;

Function IsVESA:boolean;assembler;
var VesaInfo: array[0..255] of Byte;
asm
        MOV     AX,SS
        MOV     ES,AX
        LEA     DI,VesaInfo
        MOV     AX,4F00H
        INT     10H
        CMP     AX,004FH
        MOV     AX,0 { 0 = FALSE }
        JNZ     @@Exit
        CMP     WORD PTR ES:[DI][0], 'EV'
        JNZ     @@Exit
        CMP     WORD PTR ES:[DI][2], 'AS'
        JNZ     @@Exit
        MOV     AX,1 { 1 = TRUE }
@@Exit:
end;

procedure SetUniformPal;
var p:pointer;
    f:integer;
begin
if Mode16 then for f:=0 to 15 do setpalette(f,f);
p:=@UniformPal;
Asm
   push  ds
   lds   si, p
   mov   dx, 3c8h
   xor   al,al
   out   dx, al
   inc   dx
   mov   cx, 768
   rep   outsb
   pop   ds
end;
end;

function GetImageSize(x1,y1,x2,y2:integer):word;
var l:longint;
begin
 l:=(x2-x1+1);
 l:=l*(y2-y1+1)+8;
 GetImageSize:=succ(l div 1024);
end;

procedure StoreImage(x1,y1,x2,y2:integer;handler:word;ofs:longint);
var LineBuff:
      record
        lung  : word;
        lat   : word;
        bytes : array[0..1279] of byte;
      end;
    f,g:integer;ofs2:longint;
    lung,lat:longint;
    delta:integer;
    p:pointer;mp:word;
begin
ofs2:=ofs;
lung:=x2-x1+1;lat:=y2-y1+1;
if odd(lung) then delta:=1 else delta:=0;
writeextmem(lung,4,handler,ofs2);inc(ofs2,4);
writeextmem(lat ,4,handler,ofs2);inc(ofs2,4);
mp:=lung+1024;getmem(p,mp);
for g:=y1 to y2 do
 begin
  {for f:=x1 to x2 do LineBuff.bytes[f-x1]:=getpixel(f,g);}
  getimage(x1,g,x2,g,LineBuff);
  writeextmem(LineBuff.bytes,lung+delta,handler,ofs2);inc(ofs2,lung);
 end;
freemem(p,mp);
end;

procedure RestoreImage(x,y:integer;handler:word;ofs:longint);
var LineBuff:
     record
       lung   : word;
       lat    : word;
       bytes  : array[0..1279] of byte;
     end;
    f,g:integer;ofs2:longint;
    lung,lat:longint;delta:integer;
begin
 ofs2:=ofs;
 readextmem(4,handler,ofs2,lung);inc(ofs2,4);
 readextmem(4,handler,ofs2,lat);inc(ofs2,4);
 setwritemode(copyput);
 if odd(lung) then delta:=1 else delta:=0;

  LineBuff.lat:=0;LineBuff.lung:=lung-1;

if (x+lung-2<getmaxx) then
for g:=y to y+lat-1 do
 begin
  readextmem(lung+delta,handler,ofs2,LineBuff.bytes[0]);inc(ofs2,lung);
  PutImage(x,g,LineBuff.Lung,CopyPut);
 end
else
for g:=y to y+lat-1 do
 begin
  readextmem(lung+delta,handler,ofs2,LineBuff.bytes[0]);inc(ofs2,lung);
  for f:=x to x+lung-1 do putpixel(f,g,LineBuff.bytes[f-x]);
 end
end;

procedure RestoreImage2(x,y:integer;handler:word;ofs:longint;pal:virtualpal);
var LineBuff:
     record
       lung   : word;
       lat    : word;
       bytes  : array[0..1279] of byte;
     end;
    g:integer;ofs2:longint;
    lung,lat:longint;delta:integer;
    pal2:virtualpal;
    dist,savedist,dx,dy,dz:longint;
    f:word;a,b:byte;
    palnoua:array[0..255] of byte;
function findclosest(pa1,pa2:virtualpal;chkcol:byte):byte;
var i:byte;
    savecol:byte;
begin
  savedist:=200000;
  for i:=0 to 255 do begin
                dx:=pa2[i,1]-pa1[chkcol,1];
                dy:=pa2[i,2]-pa1[chkcol,2];
                dz:=pa2[i,3]-pa1[chkcol,3];
                dist:=dx*dx+dy*dy+dz*dz;
                if dist < savedist then
                        begin
                          savedist:=dist;
                          savecol:=i;
                        end;
                    end;
  findclosest:=savecol;
end;
begin
 ofs2:=ofs;
 readextmem(4,handler,ofs2,lung);inc(ofs2,4);
 readextmem(4,handler,ofs2,lat);inc(ofs2,4);
 getallpal(pal2);for f:=0 to 255 do palnoua[f]:=findclosest(pal,pal2,f);
 if odd(lung) then delta:=1 else delta:=0;setwritemode(copyput);
 LineBuff.lat:=0;LineBuff.lung:=lung-1;

if x+lung-2<getmaxx then
for g:=y to y+lat-1 do
 begin
  readextmem(lung+delta,handler,ofs2,LineBuff.bytes[0]);inc(ofs2,lung);
  for f:=0 to lung-1 do LineBuff.bytes[f]:=PalNoua[LineBuff.bytes[f]];
  PutImage(x,g,LineBuff.Lung,CopyPut);
 end
else
for g:=y to y+lat-1 do
 begin
  readextmem(lung+delta,handler,ofs2,LineBuff.bytes[0]);inc(ofs2,lung);
  for f:=0 to lung-1 do LineBuff.bytes[f]:=PalNoua[LineBuff.bytes[f]];
  for f:=0 to lung-1 do putpixel(f+x,g,LineBuff.bytes[f]);
 end;
end;


procedure RestoreFrame(x,y:integer;handler:word;dx,dy,dlu,dla:integer);
var LineBuff:
     record
       lung   : word;
       lat    : word;
       bytes  : array[0..1279] of byte;
     end;
    f,g:integer;ofs2:longint;
    lung,lat:longint;delta:integer;
begin
 ofs2:=0;if odd(dlu) then delta:=1 else delta:=0;
 readextmem(4,handler,ofs2,lung);inc(ofs2,4);
 readextmem(4,handler,ofs2,lat);inc(ofs2,4);
 inc(ofs2,lung*dy+dx);

 LineBuff.lat:=0;LineBuff.lung:=dlu-1;

 setwritemode(copyput);

if (x+dlu-2<getmaxx) then
for g:=y to y+dla-1 do
 begin
  readextmem(dlu+delta,handler,ofs2,LineBuff.bytes[0]);inc(ofs2,lung);
  PutImage(x,g,LineBuff.Lung,CopyPut);
 end
else
for g:=y to y+dla-1 do
 begin
  readextmem(dlu+delta,handler,ofs2,LineBuff.bytes[0]);inc(ofs2,lung);
  for f:=x to x+dlu-1 do putpixel(f,g,LineBuff.bytes[f-x]);
 end
end;



end.

