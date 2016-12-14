uses crt,bk,appmcga,graph,vesadrv,mouse,obj2,obj3,events;
var fe1:PBor2Window1B;
    fe2:PBor2Window2B;
    fe3:PBor2Window3B;

begin
 OpenGraph(VESA_800x600x256);
 SetUniformPal;
 InitMouse;
 ShowMouse;
 SetSenzitivity(trunc(120*0.75),120,2);

 new(fe1,init(240,220,1,1,'Mesaj 1','Dori€i s† iei€i din acest program ?'));
 fe1^.setattr(10,1,blue);
 fe1^.run;
 dispose(fe1,done);

 new(fe2,init(280,180,2,1,2,'Mesaj 2','Sigur dori€i s† iei€i din acest program ?'));
 fe2^.setattr(4,1,blue);
 fe2^.setjustify(lefttext,centertext,true);
 fe2^.run;
 dispose(fe2,done);

 new(fe3,init(280,180,4,1,2,8,'Mesaj 3','Dorin€a vi se va respecta'));
 fe3^.setattr(10,1,blue);
 fe3^.run;
 dispose(fe3,done);

 CloseGraph;

end.

