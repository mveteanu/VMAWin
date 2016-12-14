{$D+}
unit GraphIni;
interface
uses graph,crt;
Const BGIsFile:String='DRIVERS.DRV';
      Indexes:array[1..6] of LongInt=(0,5527,11862,15978,22323,25612);
      Names:array[1..5] of string[8]=('EGAVGA','SVGA256','VESA','VESA16','VGA256');
      EGAVGADriver=1;
      SVGA256Driver=2;
      VESADriver=3;
      VESA16Driver=4;
      VGA256Driver=5;

      EGAVGAM_640x480x16=2;
      SVGA256M_320x200x256=0;
      SVGA256M_640x400x256=1;
      SVGA256M_640x350x256=2;
      SVGA256M_640x480x256=3;
      SVGA256M_800x600x256=4;
      SVGA256M_1024x768x256=5;
      SVGA256M_1280x1024x256=6;
      VESAM_320x200x256=0;
      VESAM_640x400x256=1;
      VESAM_640x480x256=2;
      VESAM_800x600x256=3;
      VESAM_1024x768x256=4;
      VESA16M_800x600x16=0;
      VESA16M_1024x768x16=1;
      VESA16M_1280x1024x16=2;
      VGA256M_320x200x256=0;

var   GraphColors:integer;

Procedure GetResolution(Driver,Mode:Integer);
procedure CloseResolution;
Procedure MemoAtribute(a:boolean);

implementation
var  GraphDriver:Pointer;
     BGIFile:File; xxx:String;
     GDriver,gd,OldDriver:Integer;

    FillInfo  : FillSettingsType;
    linst     : Linesettingstype;
    cul,culo  : word;
    textst    : textsettingstype;
    OldPattern: FillPatternType;

Procedure MemoAtribute(a:boolean);
Begin
Case a of
 False : Begin
           GetFillSettings(FillInfo);
           GetLineSettings(Linst);
           Cul:=GetColor;
           GetTextSettings(Textst);
           GetFillPattern(OldPattern);
         End;
 True  : Begin
           SetFillPattern(OldPattern,FillInfo.Color);
           with FillInfo do SetFillStyle(Pattern, Color);
           with Linst do SetLineStyle(LineStyle, Pattern, Thickness);
           SetColor(Cul);
           with Textst do Begin SetTextJustify(Horiz, Vert);
                                SetTextStyle(Font, Direction, CharSize);
                          End;
         End;
End;End;

function DetectDriver:Integer; far; begin DetectDriver:=0; end;

procedure CloseResolution;
begin
     CloseGraph;
     FreeMem(GraphDriver,Indexes[OldDriver+1]-Indexes[OldDriver]);
     OldDriver:=-1;
end;

procedure GetResolution(Driver,Mode:Integer);
Begin
   if OldDriver>0
     then FreeMem(GraphDriver,Indexes[OldDriver+1]-Indexes[OldDriver]);
   if Driver in [2,3,5] then GraphColors:=256 else GraphColors:=16;
   OldDriver:=Driver;
   assign(BGIFile,BGIsFile); reset(BGIFile,1);
   Seek(BGIFile,Indexes[Driver]);
   GetMem(GraphDriver,Indexes[Driver+1]-Indexes[Driver]);
   BlockRead(BGIFile,GraphDriver^,Indexes[Driver+1]-Indexes[Driver]);
   Close(BGIFile);
   GDriver:=InstallUserDriver(Names[Driver],@DetectDriver);
   gd:=RegisterBGIDriver(GraphDriver);
   if GraphResult<>grOK
     then begin
             writeln('Eroare la initializarea driverului ',Names[Driver],' !');
             Halt(1);
          end;
   InitGraph(GDriver,Mode,'');
End;

begin
   GetDir(0,xxx);
   if xxx[length(xxx)]='\'
     then BGIsFile:=xxx+BGIsFile
     else BGIsFile:=xxx+'\'+BGIsFile;
   OldDriver:=-1;
end.
