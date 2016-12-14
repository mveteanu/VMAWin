{$f+}
unit Collect;
interface
         type
         ColItPo=^ColItem;
         ColItem=Record
                 next,last:ColItPo;
                 item:pointer;
                 ind:integer;
                 end;
         PCollection=^TCollection;
         TCollection=Object
                 counter,size:integer;
                 first:boolean;
                 header,aktitem:ColItPo;
                 constructor  init(sizee:integer);
                 destructor   done;
                 procedure    clean;
                 procedure    insertitem(index,ind:integer;item:pointer;use:boolean);
                 procedure    deleteitem(index:integer;use:boolean);
                 procedure    setitem(index,ind:integer;item:pointer;use:boolean);
                 procedure    next(var po:ColItPo);
                 procedure    last(var po:ColItPo);
                 function     getitem(index:integer):pointer;
                 procedure    Reinit;
                 private
                 procedure    setactitem(item:pointer);
                 end;
function itemsin(po:PCollection):integer;
implementation
function itemsin(po:PCollection):integer;
begin
itemsin:=po^.counter;
end;
constructor Tcollection.init;
begin
header:=NIL;
first:=true;
counter:=0;
size:=sizee;
new(header);
header^.last:=nil;
header^.next:=nil;
aktitem:=header;
end;
destructor tcollection.done;
begin
repeat deleteitem(0,true) until counter=0;
end;
procedure tcollection.insertitem;
var temp:ColItPo;
    ti:integer;
begin
if first then begin
                first:=false;
                aktitem^.ind:=ind;
                setactitem(item);
              end
              else begin
              if index=0 then {Insert at the end}
                         begin
                         aktitem:=header;
                         while aktitem^.next<>nil do aktitem:=aktitem^.next;
                         new(aktitem^.next);
                         temp:=aktitem;
                         aktitem:=aktitem^.next;
                         aktitem^.last:=temp;
                         aktitem^.next:=nil;
                         aktitem^.ind:=ind;
                         setactitem(item);
                         end
                         else if (index<=counter)and(index>0)then
                         begin
                         if use then
                            begin
                            ti:=0;
                            aktitem:=header;
                            while ti<index do
                               begin
                               aktitem:=aktitem^.next;
                               inc(ti);
                               end;
                            end;
                         new(temp);
                         temp^.next:=aktitem^.next;
                         temp^.last:=aktitem;
                         aktitem^.next^.last:=temp;
                         aktitem^.next:=temp;
                         aktitem^.ind:=ind;
                         aktitem:=temp;
                         setactitem(item);
                         end;
              end;
inc(counter);
end;
procedure tcollection.deleteitem;
var ti:integer;
    temp:ColItPo;
begin
if not first then
   begin
    if use then
       begin
            ti:=0;
            aktitem:=header;
            while ti<index do
                  begin
                  aktitem:=aktitem^.next;
                  inc(ti);
                  end;
       end;
    temp:=aktitem;
    if aktitem^.last<>NIL then aktitem^.last^.next:=aktitem^.next;
    if aktitem^.next<>NIL then aktitem^.next^.last:=aktitem^.last;
    if aktitem^.last<>NIL then aktitem:=aktitem^.last else aktitem:=aktitem^.next;
    if aktitem^.last=NIL then header:=aktitem;
{ If aktitem=nil then the list is empty }
    freemem(temp^.item,size);
    dispose(temp);
    dec(counter);
   end;
end;
procedure tcollection.setitem;
var ti:integer;
begin
if use then begin
   ti:=0;
   aktitem:=header;
   while ti<index do
      begin
      aktitem:=aktitem^.next;
      inc(ti);
      end;
   end;
setactitem(item);
end;
function tcollection.getitem(index:integer):pointer;
var ti:integer;
begin
ti:=0;
aktitem:=header;
while ti<index do
      begin
      aktitem:=aktitem^.next;
      inc(ti);
      end;
getitem:=aktitem^.item;
end;
procedure tcollection.setactitem;
begin
getmem(aktitem^.item,size);
move(item^,aktitem^.item^,size);
end;
procedure tcollection.next;
begin
if po^.next<>NIL then po:=po^.next
end;
procedure tcollection.last;
begin
if po^.last<>NIL then po:=po^.last
end;
procedure tcollection.clean;
begin
repeat deleteitem(0,true) until aktitem=nil;
end;
procedure tcollection.reinit;
begin
 done;
 init(size);
end;

end.