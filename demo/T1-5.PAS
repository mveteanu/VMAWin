uses crt,bk,appmcga,graph,vesadrv,mouse,obj2,obj3,events;
var fer1:p2bwindow;
    fer2:p3bwindow;
    fer3:p1bwindow;
    fe1:PBorWindow1B;
    fe2:PBorWindow2B;
    fe3:PBorWindow3B;
    rasp:byte;

begin
 OpenGraph(VESA_800x600x256);
 SetUniformPal;
 InitMouse;
 ShowMouse;
 SetSenzitivity(trunc(120*0.75),120,2);

 new(fe1,init(240,220,1,'O.K.','Mesaj','Doriti sa iesiti din acest program ?'));
 fe1^.setattr(10,1,blue);
 fe1^.run;
 dispose(fe1,done);

 new(fe2,init(240,220,2,'O.K.','Cancel','Mesaj','Te mai intreb odata !'));
 fe2^.run;
 dispose(fe2,done);

 new(fe3,init(240,220,3,'Yes','No','Cancel','Mesaj','Programul s-a terminat.'));
 fe3^.run;
 dispose(fe3,done);

 CloseGraph;

end.
