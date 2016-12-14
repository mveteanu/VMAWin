{
{   Unit pentru folosirea fonturilor romƒnesti din fisierul FONTS.FNT  }
{   Literele romƒnesti au urmatoarele coduri ASCII:                    }
{      † = 134 ; ƒ = 131 ; Œ = 140 ; t = 128 ; s = 129                 }
{      A = 135 ; A = 136 ; I = 137 ; T = 132 ; S = 133                 }
{

{$D+}
unit Fonts;
interface
uses graph,crt;
Const FontsFile:String='FONTS.FNT';
      Indexes:array[1..11] of LongInt=(60,14452,22749,40840,52661,57768,
                                       71000,81897,90206,106591,123632);
      Names:array[1..10] of string[8]=('BOLD','EURO','GOTH','LCOM','LITT',
                                       'SANS','SCRI','SIMP','TRIP','TSCR');

      DefaultFont=0;
      BoldFont=1;
      EuroFont=2;
      GothFont=3;
      LcomFont=4;
      LittFont=5;
      SansFont=6;
      ScriFont=7;
      SimpFont=8;
      TripFont=9;
      TscrFont=10;

Procedure MSetTextStyle(Font,Direction,Size:Integer);
procedure FreeFont;

implementation
var  FontDriver:Pointer;
     FontFile:File;
     OldFont,gf:Integer;
     xxx:String;

procedure MSetTextStyle(Font,Direction,Size:Integer);
Begin
   if OldFont>0 then FreeMem(FontDriver,Indexes[OldFont+1]-Indexes[OldFont]);
   if (Font>0) and (Font<11)
     then begin
             OldFont:=Font;
             assign(FontFile,FontsFile); reset(FontFile,1);
             Seek(FontFile,Indexes[Font]);
             GetMem(FontDriver,Indexes[Font+1]-Indexes[Font]);
             BlockRead(FontFile,FontDriver^,Indexes[Font+1]-Indexes[Font]);
             Close(FontFile);
             gf:=RegisterBGIFont(FontDriver);
             if GraphResult<>grOK
               then begin
                       RestoreCRTMode;
                       writeln('Eroare la initializarea fontului ',Names[Font],' !');
                       Halt(1);
                    end;
          end
     else begin gf:=0; OldFont:=-1; end;
   SetTextStyle(gf,Direction,Size);
End;

procedure FreeFont;
begin
     if OldFont<>-1
       then FreeMem(FontDriver,Indexes[OldFont+1]-Indexes[OldFont]);
     OldFont:=-1; FontDriver:=nil;
end;

begin
   GetDir(0,xxx);
   if xxx[length(xxx)]='\'
     then FontsFile:=xxx+FontsFile
     else FontsFile:=xxx+'\'+FontsFile;
   OldFont:=-1;
end.
