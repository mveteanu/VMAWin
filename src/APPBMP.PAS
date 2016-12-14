{$G+,X+,R-,F-,S-,D-,L-}
unit AppBMP;
interface
uses AppMcga,Graph,XMS,FileOs;
procedure LoadBMPFile(x,y:LongInt;NameCode:string;scr:virtualscreen;var pal:virtualpal);
procedure SaveBMPFile(x1,y1,x2,y2:LongInt;NameCode:string;scr:virtualscreen;pal:virtualpal);
procedure LoadQuickBMPFile(NameCode:string;scr:virtualscreen;var pal:virtualpal);
function  BMPError: Boolean;
procedure LoadBMP(x,y:integer;NameCode: string);
procedure SaveBMP(x1,y1,x2,y2:LongInt;NameCode:string;pal:virtualpal);
procedure LoadBMPinXMS(NameCode:string;handler:word;ofs:longint;var pal:virtualpal);
procedure LoadBMPinXMS2(NameCode:string;handler:word;ofs:longint;palfix:virtualpal);

type
BitMapFileHeader=record
                   Types:array[1..2] of char;
                   Size:LongInt;
                   Reserved1:word;
                   Reserved2:word;
                   OffBits:LongInt;
                 end;

BitMapInfoHeader=record
                   Size:LongInt;
                   Width:LongInt;
                   Height:LongInt;
                   Planes:word;
                   BitCount:word;
                   Compression:LongInt;
                   SizeImage:LongInt;
                   XPelsPerMeter:LongInt;
                   YPelsPerMeter:LongInt;
                   ClrUsed:LongInt;
                   ClrImportant:LongInt;
                 end;

RGBQuad = record
                   Blue:byte;
                   Green:byte;
                   Red:byte;
                   Reserved:byte;
          end;

BitMapInfo=record
                   H:BitMapInfoHeader;
                   C:array[0..255] of RGBQuad;
           end;

var  testH: BitMapFileHeader;
     testI: BitMapInfo;

implementation
var
     cRed, cGreen, cBlue: byte;
     cRGB: RGBQuad;
     cReg: byte;
     fBMP: file;
     iBMP, jBMP: LongInt;
     memBMP: byte;
     nrcul:word;
     extra:word;
     readByte: byte;
     LineBuff: array[0..1279] of byte;
     Error: Boolean;
     pal:virtualpal;


procedure LoadBMPFile;
begin
   if Lib_Reset(fBMP, NameCode)<>0 then
  begin
   Assign(fBMP, NameCode);
   {$I-}Reset(fBMP, 1);{$I+}
   if ioresult<>0 then begin
                       settext;
                        writeln(' Eroare de executie !');
                        writeln(' Fisierul '+NameCode+' este inexistent');
                        halt(1);
                      end;
  end;
   BlockRead(fBMP, testH, SizeOf(testH));
   BlockRead(fBMP, testI.H, SizeOf(testI.H));
   nrcul:=(testh.offbits-testi.h.size-14) div 4;
   extra:=(testh.size-testI.H.Width*testI.H.Height-testh.offbits) div testI.H.Height;

   if testI.H.BitCount < 4 then
      begin
         SetText;
         Error := True;
         Exit
      end
   else if (testI.H.BitCount = 8) and (testI.H.ClrImportant >= 0) then
      begin
         for iBMP := 0 to nrcul-1 do
             begin
                BlockRead(fBMP, testI.C[iBMP], SizeOf(testI.C[iBMP]));
                testI.C[iBMP].Blue := testI.C[iBMP].Blue div 4;
                testI.C[iBMP].Green := testI.C[iBMP].Green div 4;
                testI.C[iBMP].Red := testI.C[iBMP].Red div 4;
             end;
      end;
   for ibmp:=0 to nrcul-1 do begin
                           pal[ibmp,1]:=testi.c[ibmp].red;
                           pal[ibmp,2]:=testi.c[ibmp].green;
                           pal[ibmp,3]:=testi.c[ibmp].blue;
                         end;

   for iBMP := 0 to testI.H.Height - 1 do
       begin
          BlockRead(fBMP, LineBuff, testI.H.Width+Extra);
          for jBMP := 0 to testI.H.Width - 1 do
              Mem[seg(scr^):jBMP + x +
                         320 * y + 320 * (testI.H.Height - iBMP - 1)] :=
              LineBuff[jBMP];
       end;
   Close(fBMP);
end;

procedure LoadQuickBMPFile;
begin
   if Lib_Reset(fBMP, NameCode)<>0 then
  begin
   Assign(fBMP, NameCode);
   {$I-}Reset(fBMP, 1);{$I+}
   if ioresult<>0 then begin
                        settext;
                        writeln(' Eroare de executie !');
                        writeln(' Fisierul '+NameCode+' este inexistent');
                        halt(1);
                      end;
  end;
   BlockRead(fBMP, testH, SizeOf(testH));
   BlockRead(fBMP, testI.H, SizeOf(testI.H));
         for iBMP := 0 to 255 do
             begin
                BlockRead(fBMP, testI.C[iBMP], SizeOf(testI.C[iBMP]));
                testI.C[iBMP].Blue := testI.C[iBMP].Blue div 4;
                testI.C[iBMP].Green := testI.C[iBMP].Green div 4;
                testI.C[iBMP].Red := testI.C[iBMP].Red div 4;
             end;
   for ibmp:=0 to 255 do begin
                           pal[ibmp,1]:=testi.c[ibmp].red;
                           pal[ibmp,2]:=testi.c[ibmp].green;
                           pal[ibmp,3]:=testi.c[ibmp].blue;
                         end;

   BlockRead(fBMP,scr^,64000);
end;

procedure SaveBMPFile;
begin
   Assign(fBMP, NameCode);
   Rewrite(fBMP, 1);
   testH.Types[1] := 'B';
   testH.Types[2] := 'M';
   testH.Size := (x2 - x1 + 1) * (y2 - y1 + 1) + 1078;
   testH.Reserved1 := 0;
   testH.Reserved2 := 0;
   testH.OffBits := 1078;
   testI.H.Size := 40;
   testI.H.Width := x2 - x1 + 1;
   testI.H.Height := y2 - y1 + 1;
   testI.H.Planes := 1;
   testI.H.BitCount := 8;
   testI.H.Compression := 0;
   testI.H.SizeImage := 0;
   testI.H.XPelsPerMeter := 0;
   testI.H.YPelsPerMeter := 0;
   testI.H.ClrUsed := 256;
   testI.H.ClrImportant := 256;
   BlockWrite(fBMP, testH, SizeOf(testH));
   BlockWrite(fBMP, testI.H, SizeOf(testI.H));
   for iBMP := 0 to 255 do
       begin
          testI.C[iBMP].Blue     := pal[ibmp,3] * 4;
          testI.C[iBMP].Green    := pal[ibmp,2] * 4;
          testI.C[iBMP].Red      := pal[ibmp,1] * 4;
          testI.C[iBMP].Reserved := 0;
          BlockWrite(fBMP, testI.C[iBMP], SizeOf(testI.C[iBMP]));
       end;
  for iBMP := 0 to testI.H.Height - 1 do
       begin
          for jBMP := 0 to testI.H.Width - 1 do
              LineBuff[jBMP] := Mem[seg(scr^): jBMP + x1 + 320 * y1 + 320 * (testI.H.Height - iBMP - 1)];
          BlockWrite(fBMP, LineBuff, testI.H.Width);
       end;
  Close(fBMP);
end;

function BMPError;
begin
  BMPError := Error;
  Error := False
end;

procedure LoadBMP;
begin
   if Lib_Reset(fBMP, NameCode)<>0 then
  begin
   Assign(fBMP, NameCode);
   {$I-}Reset(fBMP, 1);{$I+}
   if ioresult<>0 then begin
                        closegraph;
                        writeln(' Eroare de executie !');
                        writeln(' Fisierul '+NameCode+' este inexistent');
                        halt(1);
                      end;
  end;
   BlockRead(fBMP, testH, SizeOf(testH));
   BlockRead(fBMP, testI.H, SizeOf(testI.H));
   nrcul:=(testh.offbits-testi.h.size-14) div 4;
   extra:=(testh.size-testI.H.Width*testI.H.Height-testh.offbits) div testI.H.Height;

   if testI.H.BitCount < 4 then
      begin
         Closegraph;
         Error := True;
         Exit
      end
   else if (testI.H.BitCount = 8) and (testI.H.ClrImportant >= 0) then
      begin
         for iBMP := 0 to nrcul-1 do
             begin
                BlockRead(fBMP, testI.C[iBMP], SizeOf(testI.C[iBMP]));
                testI.C[iBMP].Blue := testI.C[iBMP].Blue div 4;
                testI.C[iBMP].Green := testI.C[iBMP].Green div 4;
                testI.C[iBMP].Red := testI.C[iBMP].Red div 4;
             end;
      end;
   for ibmp:=0 to nrcul-1 do begin
                           pal[ibmp,1]:=testi.c[ibmp].red;
                           pal[ibmp,2]:=testi.c[ibmp].green;
                           pal[ibmp,3]:=testi.c[ibmp].blue;
                         end;
   appmcga.setallpal(pal);
   for iBMP := 0 to testI.H.Height - 1 do
       begin
          BlockRead(fBMP, LineBuff, testI.H.Width+Extra);
          for jBMP := 0 to testI.H.Width - 1 do
              putpixel(jBMP+x ,(y+testI.H.Height - iBMP - 1),LineBuff[jBMP]);
       end;
   Close(fBMP);
end;

procedure LoadBMPinXMS;
var ofs2:longint;
    lung,lat:longint;
    delta:integer;
begin
   if Lib_Reset(fBMP, NameCode)<>0 then
  begin
   Assign(fBMP, NameCode);
   {$I-}Reset(fBMP, 1);{$I+}
   if ioresult<>0 then begin
                        closegraph;
                        writeln(' Eroare de executie !');
                        writeln(' Fisierul '+NameCode+' este inexistent');
                        halt(1);
                      end;
  end;
   BlockRead(fBMP, testH, SizeOf(testH));
   BlockRead(fBMP, testI.H, SizeOf(testI.H));
   nrcul:=(testh.offbits-testi.h.size-14) div 4;
   extra:=(testh.size-testI.H.Width*testI.H.Height-testh.offbits) div testI.H.Height;

   if testI.H.BitCount < 4 then
      begin
         Closegraph;
         Error := True;
         Exit
      end
   else if (testI.H.BitCount = 8) and (testI.H.ClrImportant >= 0) then
      begin
         for iBMP := 0 to nrcul-1 do
             begin
                BlockRead(fBMP, testI.C[iBMP], SizeOf(testI.C[iBMP]));
                testI.C[iBMP].Blue := testI.C[iBMP].Blue div 4;
                testI.C[iBMP].Green := testI.C[iBMP].Green div 4;
                testI.C[iBMP].Red := testI.C[iBMP].Red div 4;
             end;
      end;
   for ibmp:=0 to nrcul-1 do begin
                           pal[ibmp,1]:=testi.c[ibmp].red;
                           pal[ibmp,2]:=testi.c[ibmp].green;
                           pal[ibmp,3]:=testi.c[ibmp].blue;
                         end;

   lung:=testI.H.Width+Extra;lat:=testI.H.Height;
   ofs2:=(lat-1)*lung+8;
   writeextmem(lung,4,handler,ofs);
   writeextmem(lat ,4,handler,ofs+4);
   if odd(lung) then delta:=1 else delta:=0;
   for iBMP := 1 to lat do
       begin
         BlockRead(fBMP,LineBuff,lung);
         WriteExtMem(LineBuff,lung+delta,handler,ofs2);dec(ofs2,lung);
       end;
Close(fBMP);
end;

procedure LoadBMPinXMS2;
var ofs2:longint;
    lung,lat:longint;
    pal2:virtualpal;
    palnoua:array[0..255] of byte;
    delta,f:integer;
function findclosest(pa1,pa2:virtualpal;chkcol:byte):byte;
var i:byte;
    savecol:byte;
    dist,savedist,dx,dy,dz:longint;
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
   if Lib_Reset(fBMP, NameCode)<>0 then
  begin
   Assign(fBMP, NameCode);
   {$I-}Reset(fBMP, 1);{$I+}
   if ioresult<>0 then begin
                        closegraph;
                        writeln(' Eroare de executie !');
                        writeln(' Fisierul '+NameCode+' este inexistent');
                        halt(1);
                      end;
  end;
   BlockRead(fBMP, testH, SizeOf(testH));
   BlockRead(fBMP, testI.H, SizeOf(testI.H));
   nrcul:=(testh.offbits-testi.h.size-14) div 4;
   extra:=(testh.size-testI.H.Width*testI.H.Height-testh.offbits) div testI.H.Height;

   if testI.H.BitCount < 4 then
      begin
         Closegraph;
         Error := True;
         Exit
      end
   else if (testI.H.BitCount = 8) and (testI.H.ClrImportant >= 0) then
      begin
         for iBMP := 0 to nrcul-1 do
             begin
                BlockRead(fBMP, testI.C[iBMP], SizeOf(testI.C[iBMP]));
                testI.C[iBMP].Blue := testI.C[iBMP].Blue div 4;
                testI.C[iBMP].Green := testI.C[iBMP].Green div 4;
                testI.C[iBMP].Red := testI.C[iBMP].Red div 4;
             end;
      end;
   for ibmp:=0 to nrcul-1 do begin
                           pal2[ibmp,1]:=testi.c[ibmp].red;
                           pal2[ibmp,2]:=testi.c[ibmp].green;
                           pal2[ibmp,3]:=testi.c[ibmp].blue;
                         end;

   for f:=0 to 255 do palnoua[f]:=findclosest(pal2,palfix,f);

   lung:=testI.H.Width+Extra;lat:=testI.H.Height;
   ofs2:=(lat-1)*lung+8;
   writeextmem(lung,4,handler,ofs);
   writeextmem(lat ,4,handler,ofs+4);
   if odd(lung) then delta:=1 else delta:=0;
   for iBMP := 1 to lat do
       begin
         BlockRead(fBMP,LineBuff,lung);
         for f:=0 to lung-1 do LineBuff[f]:=PalNoua[LineBuff[f]];
         WriteExtMem(LineBuff,lung+delta,handler,ofs2);dec(ofs2,lung);
       end;
Close(fBMP);
end;

procedure SaveBMP;
begin
   Assign(fBMP, NameCode);
   Rewrite(fBMP, 1);
   testH.Types[1] := 'B';
   testH.Types[2] := 'M';
   testH.Size := (x2 - x1 + 1) * (y2 - y1 + 1) + 1078;
   testH.Reserved1 := 0;
   testH.Reserved2 := 0;
   testH.OffBits := 1078;
   testI.H.Size := 40;
   testI.H.Width := x2 - x1 + 1;
   testI.H.Height := y2 - y1 + 1;
   testI.H.Planes := 1;
   testI.H.BitCount := 8;
   testI.H.Compression := 0;
   testI.H.SizeImage := 0;
   testI.H.XPelsPerMeter := 0;
   testI.H.YPelsPerMeter := 0;
   testI.H.ClrUsed := 256;
   testI.H.ClrImportant := 256;
   BlockWrite(fBMP, testH, SizeOf(testH));
   BlockWrite(fBMP, testI.H, SizeOf(testI.H));
   for iBMP := 0 to 255 do
       begin
          testI.C[iBMP].Blue     := pal[ibmp,3] * 4;
          testI.C[iBMP].Green    := pal[ibmp,2] * 4;
          testI.C[iBMP].Red      := pal[ibmp,1] * 4;
          testI.C[iBMP].Reserved := 0;
          BlockWrite(fBMP, testI.C[iBMP], SizeOf(testI.C[iBMP]));
       end;
  for iBMP := 0 to testI.H.Height - 1 do
       begin
          for jBMP := 0 to testI.H.Width - 1 do
              LineBuff[jBMP] := getpixel(jBMP+x1 ,(y1+testI.H.Height-iBMP-1));
          BlockWrite(fBMP, LineBuff, testI.H.Width);
       end;
  Close(fBMP);
end;

end.
