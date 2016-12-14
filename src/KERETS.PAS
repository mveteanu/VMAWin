unit Kerets;
interface

Procedure Panou(x1,y1,x2,y2:integer);
Procedure Panou3D(x1,y1,x2,y2:integer);
Procedure PanouCuZoom(x1,y1,x2,y2:integer;col:byte;dela:word);
Procedure Keret(xr1,yr1,xr2,yr2,tip:integer);

implementation
uses crt,graph,vesadrv;


Procedure Panou(x1,y1,x2,y2:integer);
var f,g:integer;
begin
 setfillstyle(solidfill,lightgray);
 graph.bar(x1,y1,x2,y2);
 g:=y1;
 repeat
   f:=x1;
   repeat
     putpixel(f,g,white);inc(f,2);
   until f>=x2;
   inc(g,2);
 until g>=y2;
end;


Procedure Panou3D(x1,y1,x2,y2:integer);
begin
  SetLineStyle(0,0,0);SetWriteMode(CopyPut);
  if GetMaxColor>15 then
     begin
         dec(x1);dec(y1);inc(x2);inc(y2);
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
     end
     else
     begin
         setfillstyle(solidfill,lightgray);
         Bar(x1,y1,x2,y2);

         setcolor(white);
         line(x1+1,y1+1,x2-1,y1+1);
         line(x1+1,y1+2,x2-2,y1+2);
         line(x1+1,y1+1,x1+1,y2-2);
         line(x1+2,y1+1,x1+2,y2-3);

         setcolor(darkgray);
         line(x1+1,y2-1,x2-1,y2-1);
         line(x1+2,y2-2,x2-1,y2-2);
         line(x2-1,y1+2,x2-1,y2-1);
         line(x2-2,y1+3,x2-2,y2-1);

         setcolor(black);
         line(x1+1,y1,x2-1,y1);
         line(x1+1,y2,x2-1,y2);
         line(x1,y1+1,x1,y2-1);
         line(x2,y1+1,x2,y2-1);
     end;
end;

Procedure PanouCuZoom(x1,y1,x2,y2:integer;col:byte;dela:word);
  function sgn(a:real):integer;
  begin
       if a>0 then sgn:=+1;
       if a<0 then sgn:=-1;
       if a=0 then sgn:=0;
  end;
var a,b,c,d,i,s,d1x,d1y,d2x,d2y,u,v,m,n:integer;
begin
     u:= x2 - x1;
     v:= y2 - y1;
     d1x:= SGN(u);
     d1y:= SGN(v);
     d2x:= SGN(u);
     d2y:= 0;
     m:= ABS(u);
     n := ABS(v);
     IF NOT (M>N) then
     BEGIN
          d2x := 0 ;
          d2y := SGN(v);
          m := ABS(v);
          n := ABS(u);
     END;
     s := m shr 1;
     a:=(x1+x2)div 2;c:=a;
     b:=(y1+y2)div 2;d:=b;
     setcolor(col);
     setlinestyle(0,0,0);setwritemode(copyput);
     FOR i := 0 TO m div 2 DO
     BEGIN
          rectangle(a,b,c,d);delay(dela);
          inc(s,n);
          IF not (s<m) THEN
          BEGIN
               dec(s,m);
               inc(a,d1x);inc(b,d1y);
               dec(c,d1x);dec(d,d1y);
          END
          ELSE
          BEGIN
               inc(a,d2x);inc(b,d2y);
               dec(c,d2x);dec(d,d2y);
          END;
     end;
END;

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


end.

