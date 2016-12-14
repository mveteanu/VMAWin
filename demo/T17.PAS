uses appbmp,appmcga,mouse,obj,events,graph,vesadrv,bk,browse,fileos;

var pal:virtualpal;
    brow:PBrowse;
    s:string;

begin
 OpenGraph(VESA_800x600x256);
 VideoScreenOff;LoadBMP(0,0,'..\win-img\tigru.bmp');VideoScreenOn;
 initmouse;showmouse;

 UseFile('..\win-img\textures.lib');
 new(brow,init(100,100,3,'u9.bmp','Open','*.pas',$01+$20));
 if brow^.run then s:=brow^.DirName+brow^.FileName else s:='';
 dispose(brow,done);


 CloseGraph;
 writeln(s);
end.

