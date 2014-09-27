{"Mortal men and women, defending their own world...is not about death,
                               but life."}
Uses HSD, GFX;

Procedure LoadPCX(s:string; where:word; dopal:boolean); {Draws PCX of <64k from disk}
Var   f  :file;
      sz :word;
      p  :pointer;
Begin
   assign(f, s);
   reset(f,1);
   sz:=filesize(f);
   getmem(p, sz);
   blockread(f, p^, sz);
   close(f);
   DrawPCX(where, @P^, sz, dopal);
   freemem(p,sz);
End;

Begin
   asm mov ax, $13; int $10; end;
   LoadPCX('m1.pcx', $A000, True);
   readln;
End.