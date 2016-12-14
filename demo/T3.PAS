uses crt,appmcga,graph,vesadrv,mouse,obj,events;
var pal:virtualpal;
    evw:tevent;
    fer1:pwindow;
    but1:pmsbutton;
    but2:pmsbutton;

begin
 OpenGraph(VESA_320x200x256);Setuniformpal;
 new(fer1,init(300,200,200,100,'VMA soft',2,true));
 new(but1,init(fer1,15,50,80,32,'Buton 1'));
 new(but2,init(fer1,105,50,80,32,'Buton 2'));
 fer1^.show;but1^.show;but2^.show;
 initmouse;showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);
   but1^.clicked(evw);
   but2^.clicked(evw);
 until fer1^.clicked(evw);;
 dispose(fer1,done);dispose(but1,done);dispose(but2,done);
 CloseGraph;

 OpenGraph(VESA_800x600x256);Setuniformpal;
 new(fer1,init(300,200,200,100,'VMA soft',2,true));
 new(but1,init(fer1,15,50,80,32,'Buton 1'));
 new(but2,init(fer1,105,50,80,32,'Buton 2'));
 fer1^.show;but1^.show;but2^.show;
 initmouse;showmouse;
 repeat
   fer1^.move;
   GetEvent(evw);
   but1^.clicked(evw);
   but2^.clicked(evw);
 until fer1^.clicked(evw);;
 dispose(fer1,done);dispose(but1,done);dispose(but2,done);
 CloseGraph;

end.


