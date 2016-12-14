unit events;
interface
const evmouse : byte =1;
      evkbd   : byte =2;
      evnone  : byte =0;
type tevent=record
             tip:byte;
             scankey:word;
             mx,my,but:integer;
            end;

Procedure GetEvent(var event:TEvent);

implementation
uses mouse,Ukbd;

Procedure GetEvent(var event:TEvent);
begin
 event.tip:=evmouse;
 getmousestatus(event.mx,event.my,event.but);
 if kbdkeypressed then
    begin
      event.tip:=evkbd;
      event.scankey:=kbdreadkey;
    end;
end;

end.

