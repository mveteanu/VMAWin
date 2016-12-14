unit browse;
interface
uses obj,events,collect;

type pcolec=^tcolec;
     tcolec= object(TCollection)
              procedure ReadDirectory(mask:string;attr:word);
             end;

type PBrowse=^TBrowse;
     TBrowse=object
              fer:pwindow;lis1,lis2:plist;
              col1,col2:pcolec;
              but1,but2:pbutton;
              bmask:string;batr:word;
              Constructor Init(x,y,tip:integer;bk,name,mask:string;atr:word);
              Function    Run:boolean;
              Function    DirName:string;
              Function    FileName:string;
              Destructor  Done;
              private ev:tevent;iesire:boolean;
             end;

implementation
uses dos,crt,appmcga,graph,vesadrv,fonts,mouse;

procedure ButtonOK;external;{$l tb-1.obj}
procedure ButtonStop;external;{$l tb-4.obj}

procedure TColec.ReadDirectory(mask:string;attr:word);
var DirInfo: SearchRec;
    i:integer;
begin
     FindFirst(mask,attr, DirInfo);
     while doserror=0 do
           begin
           if DirInfo.Name='..' then Dirinfo.name:='<UP DIR>';
           if (dirinfo.attr and VolumeId=0)and(DirInfo.Name<>'.')and(Dirinfo.attr and attr<>0)
              then begin
              if dirinfo.attr and directory = 0 then
                 for i := 1 to Length(Dirinfo.name) do
                     if Dirinfo.name[i] in ['A'..'Z'] then Dirinfo.name[i]:=chr(ord(Dirinfo.name[i])+32);
              insertitem(0,0,@DirInfo.Name,true);
              end;
           findnext(DirInfo);
           end;
end;


Constructor TBrowse.Init;
begin
 iesire:=false;bmask:=mask;batr:=atr;
 new(col1,init(256));new(col2,init(256));
 new(fer,init(x,y,310,200,name,tip,true));
 fer^.loadunifimage(bk);fer^.show;
 new(lis1,init(fer,20,35,14,12,lightgray,col1));col1^.ReadDirectory('*.*',directory+VolumeID);
 if col1^.counter=0 then lis1^.disable;lis1^.show;
 new(lis2,init(fer,135,35,14,12,lightgray,col2));col2^.ReadDirectory(mask,atr);
 if col2^.counter=0 then lis2^.disable;lis2^.show;
 new(but1,initico(fer,249,60,50,50,1,@ButtonSTOP));but1^.show;
 new(but2,initico(fer,249,120,50,50,1,@ButtonOK));but2^.show;
end;

Function TBrowse.Run;
var s1,s2,curent:string;
    ex:boolean;
begin
 getdir(0,curent);
 repeat
   fer^.move;
   GetEvent(ev);
   s1:=lis1^.clicked(ev);if s1='<UP DIR>' then s1:='..';
   s2:=lis2^.clicked(ev);
   if s1<>'' then
       begin
        chdir(s1);
        col1^.reinit;lis1^.reinit;col1^.ReadDirectory('*.*',directory+VolumeID);
        col2^.reinit;lis2^.reinit;col2^.ReadDirectory(bmask,batr);
        if col2^.counter=0 then lis2^.disable;
        if col1^.counter=0 then lis1^.disable;
	lis1^.show;lis2^.show;
       end;
   if but1^.clicked(ev) then begin iesire:=true;ex:=true;end;
   if but2^.clicked(ev) then begin iesire:=true;ex:=false;end;
 until fer^.clicked(ev) or iesire;
 if ex then run:=true else begin run:=false;chdir(curent);end;
end;

Function TBrowse.DirName;
var s1:string;
begin
 s1:=string(lis1^.akt^.item^);if s1='<UP DIR>' then s1:='..';
 Dirname:=fexpand(s1)+'\';
end;

Function TBrowse.FileName;
begin
 Filename:=string(lis2^.akt^.item^);
 if not lis2^.lisenabled then FileName:='';
end;

Destructor TBrowse.Done;
begin
 dispose(fer,done);
 dispose(col1,done);
 dispose(col2,done);
 dispose(lis1,done);
 dispose(lis2,done);
 dispose(but1,done);
 dispose(but2,done);
end;

end.




