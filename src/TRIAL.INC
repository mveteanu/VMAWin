procedure ThisProgramIsShareware;
var t:integer;
begin
 clrscr;
 writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
 writeln('³                VMAWin - UNREGISTRED VERSION               ³');
 writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
 writeln('³                                                           ³');
 writeln('³       This program was made with a 30 day Trial version   ³');
 writeln('³                     of VMAWin Library                     ³');
 writeln('³                                                           ³');
 writeln('³  Please buy the full and registred product from VMA soft. ³');
 writeln('³                                                           ³');
 writeln('³       VMA soft address:                                   ³');
 writeln('³       Email : vma@electra.upit.ro                         ³');
 writeln('³       Web   : http://vmasoft.webjump.com                  ³');
 writeln('³               http://hobbiton.org/~vma                    ³');
 writeln('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
 writeln;writeln;
 write('Wait 3 seconds:');
 t:=1;
 repeat
  write('.');delay(1000);
  inc(t);
 until t=3;
 writeln;
end;

