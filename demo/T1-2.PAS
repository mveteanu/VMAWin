uses crt,bk,appmcga,graph,vesadrv,mouse,obj2,events;


var fer1:p2bwindow;
    fer2:p3bwindow;
    fer3:p1bwindow;
    fe1:p1bwin;
    fe2:p2bwin;
    fe3:p3bwin;
    rasp:byte;
begin
 OpenGraph(VESA_800x600x256);
 SetUniformPal;
 InitMouse;
 ShowMouse;
 SetSenzitivity(trunc(120*0.75),120,2);

 new(fe1,init(240,220,'O.K.','Mesaj','Doriti sa iesiti ?'));
 fe1^.run;
 dispose(fe1,done);

 new(fe2,init(240,220,'O.K.','Cancel','Mesaj','Doriti sa iesiti ?'));
 fe2^.run;
 dispose(fe2,done);

 new(fe3,init(240,220,'Yes','No','Cancel','Mesaj','Doriti sa iesiti ?'));
 fe3^.run;
 dispose(fe3,done);

{
 new(fer3,init(240,220,2,0,'O.K.','Mesaj','Doriti sa parasiti acest program ?'));
 fer3^.setattr('',10,1,blue,lightgray);
 rasp:=fer3^.run;
 dispose(fer3,done);

 new(fer1,init(240,220,2,0,'Da','Nu','Mesaj','Doriti sa parasiti acest program ?'));
 fer1^.setattr('',10,1,blue,lightgray);
 rasp:=fer1^.run;
 dispose(fer1,done);

 new(fer2,init(240,220,4,1,'Da','Nu','Cancel','Mesaj','Sunteti sigur ?'));
 fer2^.setattr('',10,1,blue,lightgray);
 fer2^.disablewinbox;
 fer2^.run;
 dispose(fer2,done);

}
 CloseGraph;
end.
