unit Clock;
interface
uses events,obj;

type  PClock=^TClock;
      TClock=object
                   clockx,clocky,ctip:integer;clocktitle:string;
                   clockcol:integer;clockbk:string;
                   Constructor Init(xx,yy,lu,la,tip,culo:integer;filename,title:string);
                   Procedure   SetClock(cul1:integer);
                   Procedure   Run;
                   Destructor  Done;
                   private
                   fer1:PWindow;fra:pframe;but1:pbutton;evw:tevent;
                   ora1, ora2,ox, oy,rx, ry,kisrx, nagyrx, mprx,
                   kisry, nagyry, mpry,x, y,kisx, kisy,
                   nagyx, nagyy,mpx, mpy,ratio: real;
                   systemyear, systemmonth, systemday, dayofweek,
                   hour, minute,systemhour, systemminute, systemsecond,sec100,
		   proghour, progminute, progsecond,jelzes1, jelzes2,jelzes3,
		   dateposx, timeposx, sor1,sor2, sor3 ,xasp, yasp: word;
                   sec60, min60: boolean;
                   af:boolean;
                   function fnX(i : real) : real;
	           function fnY(i : real) : real;
                   function fnKisX(i : real) : real;
                   function fnKisY(i : real) : real;
                   function fnNagyX(i : real) : real;
                   function fnNagyY(i : real) : real;
                   function fnMpX(i : real) : real;
                   function fnMpY(i : real) : real;
                   procedure Hidecursor;
                   procedure ShowCursor;
                   procedure CeasAnalogic(culu,cul:word);
	           procedure MyLine(x1,y1,x2,y2 : real);
                   function  TimeToStr(hour1, minute1, second1 : word) : string;
                   procedure SystemDateTime;
                   procedure preinit;
                   procedure InitCeas(cx,cy,cr:integer);
             end;

Implementation
uses dos,graph,mouse;

Constructor TClock.Init;
begin
 clockbk:=filename;
 clockx:=xx;clocky:=yy;ctip:=tip;clocktitle:=title;
 new(fer1);fer1^.init(clockx,clocky,lu,la,clocktitle,ctip,true);
 fer1^.LoadUnifImage(clockbk);fer1^.show;
 new(but1);but1^.init(fer1,lu div 2-40,la-40,80,20,'O.K.');but1^.show;
 new(fra);fra^.init(fer1,15,30,lu-30,la-90,4,culo,'Desen');fra^.show;
 clockcol:=fra^.fracol xor 15;
end;

Procedure TClock.SetClock;
begin
 clockcol:=cul1;
end;

procedure TClock.HideCursor;
begin
 if (mousex>fer1^.winx+fra^.frax-15)and(mousex<fer1^.winx+fra^.frax+fra^.fralung+15)and
    (mousey>fer1^.winy+fra^.fray-15)and(mousey<fer1^.winy+fra^.fray+fra^.fralat+15)and not af
    then begin af:=true;HideMouse;end;
end;

procedure TClock.ShowCursor;
begin
 if af then begin ShowMouse;af:=false;end;
end;



function TClock.fnX(i : real) : real;
begin
  fnx := rx * sin(-i) + ox;
end;

function TClock.fnY(i : real) : real;
begin
  fny := ry * cos(-i) + oy;
end;

function TClock.fnKisX(i : real) : real;
begin
  fnKisx := kisrx * sin(-i) + ox;
end;

function TClock.fnKisY(i : real) : real;
begin
  fnkisy := kisry * cos(-i) + oy;
end;

function TClock.fnNagyX(i : real) : real;
begin
  fnNagyx := Nagyrx * sin(-i) + ox;
end;

function TClock.fnNagyY(i : real) : real;
begin
  fnNagyy := Nagyry * cos(-i) + oy;
end;

function TClock.fnMpX(i : real) : real;
begin
  fnMpx := Mprx * sin(-i) + ox;
end;

function TClock.fnMpY(i : real) : real;
begin
  fnMpy := Mpry * cos(-i) + oy;
end;

procedure TClock.MyLine(x1,y1,x2,y2 : real);
begin
  HideCursor;
  setwritemode(copyput);
  line(round(x1),round(y1),round(x2),round(y2));
  ShowCursor;
end;

function TClock.TimeToStr(hour1, minute1, second1 : word) : string;
var
  s1, s2, s3 : string;
begin
  str(hour1:2,s1);
  str(minute1:2,s2);
  str(second1:2,s3);
  timetostr := s1 + ':' + s2 + ':' + s3;
end;

procedure TClock.CeasAnalogic(culu,cul:word);
begin
  if progsecond <> 0 then sec60 := false;
  if progminute <> 0 then min60 := false;
  ora2 := hour + (minute / 100) * 1.6667;
  if progSecond <> systemSecond then
  begin
    progSecond := SystemSecond;
    x := mpx;
    y := mpy;
    setcolor(cul);
    setlinestyle(solidln,0,normwidth);
    myline(ox,oy,x,y);
    mpx := fnmpx((progSecond+90)/9.55);
    mpy := fnmpy((progSecond+90)/9.55);
    setcolor(culu);
    myline(ox,oy,mpx,mpy);
    setlinestyle(solidln,0,thickwidth);
    myline(ox,oy,nagyx,nagyy);
    myline(ox,oy,kisx,kisy);
    setfillstyle(solidfill,cul);
    settextstyle(0,0,2);settextjustify(centertext,centertext);
    HideCursor;
     bar(0,fra^.fralat-18-textheight('T')div 2,fra^.fralung,fra^.fralat-18+textheight('T')div 2);
     outtextxy(fra^.fralung div 2,fra^.fralat-18,TimeToStr(proghour,progminute,progsecond));
    ShowCursor;
  end;
  if (progminute <> minute) then
  begin
    minute := progminute;
    x := nagyx;
    y := nagyy;
    setcolor(cul);
    setlinestyle(solidln,0,thickwidth);
    myline(ox,oy,x,y);
    nagyx := fnnagyx((progminute+90)/9.55);
    nagyy := fnnagyy((progminute+90)/9.55);
    setcolor(culu);
    myline(ox,oy,nagyx,nagyy);
    myline(ox,oy,kisx,kisy);
  end;
  if progsecond = 0 then
  begin
    if not(sec60) then
    begin
      inc(progminute);
      if progminute > 59 then progminute := 0;
      sec60 := true;
      x := nagyx;
      y := nagyy;
      setcolor(cul);
      setlinestyle(solidln,0,thickwidth);
      myline(ox,oy,x,y);
      nagyx := fnnagyx((progminute+90)/9.55);
      nagyy := fnnagyy((progminute+90)/9.55);
      setcolor(culu);
      myline(ox,oy,nagyx,nagyy);
      myline(ox,oy,kisx,kisy);
    end;
  end
  else
  begin
    sec60 := false;
  end;
  ora1 := proghour + (progminute / 100) * 1.6667;
  if (ora1 <> ora2) then
  begin
    hour := proghour;
    x := kisx;
    y := kisy;
    setcolor(cul);
    setlinestyle(solidln,0,thickwidth);
    myline(ox,oy,x,y);
    kisx := fnkisx((ora1+90)/1.91);
    kisy := fnkisy((ora1+90)/1.91);
    setcolor(culu);
    myline(ox,oy,kisx,kisy);
  end;
  if progminute = 0 then
  begin
    if not(min60) then
    begin
      inc(proghour);
      if proghour > 23 then proghour := 0;
      min60 := true;
      x := kisx;
      y := kisy;
      setcolor(cul);
      setlinestyle(solidln,0,thickwidth);
      myline(ox,oy,x,y);
      ora2 := proghour + (progminute / 100) * 1.6667;
      kisx := fnkisx((ora2+90)/1.91);
      kisy := fnkisy((ora2+90)/1.91);
      setcolor(culu);
      myline(ox,oy,kisx,kisy);
    end;
  end
  else
  begin
    min60 := false;
  end;
end;

procedure TClock.SystemDateTime;
begin
  GetDate(systemyear,systemmonth,systemday,dayofweek);
  GetTime(SystemHour,SystemMinute,SystemSecond,sec100);
end;

procedure TClock.preinit;
begin
  GetDate(SystemYear,SystemMonth,SystemDay,DayOfWeek);
  GetTime(SystemHour,SystemMinute,SystemSecond,sec100);
  if progsecond = 0 then sec60 := true
                    else sec60 := false;
  if progminute = 0 then min60 := true
                    else min60 := false;
  proghour := systemhour;
  progminute := systemminute;
  progsecond := systemsecond;
end;


procedure TClock.InitCeas(cx,cy,cr:integer);
var
  i        : integer;
begin
  getaspectratio(xasp,yasp);
  ratio := yasp / xasp;

  ox := cx;
  oy := cy;

  ry := cr;
  nagyry := ry * 80 / 100;
  kisry := ry / 2;
  mpry := ry * 90 / 100;
  rx := ry * ratio;
  nagyrx := nagyry * ratio;
  kisrx := kisry * ratio;
  mprx := mpry * ratio;
  setcolor(clockcol);
  for i := 0 to 11 do
  begin
    x := fnX((5*i+90)/9.55);
    y := fnY((5*i+90)/9.55);
    mpx := fnmpX((5*i+90)/9.55);
    mpy := fnmpY((5*i+90)/9.55);
    myline(x,y,mpx,mpy);
  end;

  preinit;

  mpx := fnmpx((progSecond+90)/9.55);
  mpy := fnmpy((progSecond+90)/9.55);
  nagyx := fnnagyx((progminute+90)/9.55);
  nagyy := fnnagyy((progminute+90)/9.55);
  ora1 := proghour + (progminute / 100) * 1.6667;
  kisx := fnkisx((ora1+90)/1.91);
  kisy := fnkisy((ora1+90)/1.91);


end;

Procedure TClock.Run;
function Min(x,y:integer):integer;
begin
     if x<y then Min:=x else Min:=y
end;
begin
 fra^.activate;
 InitCeas(fra^.fralung div 2,fra^.fralat div 2-15,min(fra^.fralung,fra^.fralat)div 2-20);
 fra^.deactivate;
 repeat
   fer1^.move;
   GetEvent(evw);
   fra^.activate;
   systemdatetime;CeasAnalogic(clockcol,fra^.fracol);
   fra^.deactivate;
 until fer1^.clicked(evw) or but1^.clicked(evw);
end;

Destructor TClock.Done;
begin
 dispose(fer1,done);
 dispose(fra,done);
 dispose(but1,done);
end;

end.

