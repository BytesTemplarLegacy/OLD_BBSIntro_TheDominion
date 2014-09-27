{$G+,A+,S-,R-,I-,D-,L-}
Program Dominion_Redo;
Uses HSD, GFX, CRTASM, CRT;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Const
     Quit     :Boolean=False;
     sPic     =31364;
     txt      :Array[1..3, 1..3] of String=
                            ((' Think you are worthy?',
                              'You''d better be if you',
                              '   plan on calling...'),
                             ('  The Dominion',
                              ' (860)-457-9427',
                              '  Sysop: Jester'),
                             ('',
                              ' 14.4kbps - Great Users',
                              'Best of all: NO BULLSHIT.'));
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Var
   syspal     :tPal;
   x,y,z      :word;
   orglight   :Array[32..40,1..3] of byte;
   c          :integer;
   curline    :Byte;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure Pic; External;  {$L PIC.OBJ}
Procedure Font; External; {$L FONT.OBJ}
Procedure Banner; External; {$L BANNER.OBJ}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure De(d:word);
Begin
  if not quit then
               begin
                delay(d);
                if keypressed then quit:=true;
               end;
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{$F+}
Procedure Lightning;
var x:byte;
Begin
   pal(254, abs(c),0,0);
   c:=c+1; if c>62 then c:=-c;
   if random(1000)>925 then
     begin
      for x:=32 to 40 do pal(x,orglight[x,1], orglight[x,2], orglight[x,3]);
      delay(20);
      for x:=32 to 40 do pal(x,0,0,0);
     end;
End;
{$F-}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure GlowIn(x,y:word; s:string);
Begin
  wString(x,y,8 ,s); de(50);
  wString(x,y,7 ,s); de(50);
  wString(x,y,15,s); de(50);
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure GlowIn2(x,y:word; s:string);
Begin
  wString(x,y,8,s); de(25);
  wString(x,y,red,s); de(25);
  wString(x,y,red+8,s); de(25);
  wString(x,y,yellow,s); de(25);
  wString(x,y,white,s); de(25);
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure MainLoop;
Begin
    For x:=1 to 3 do
         if not quit then
           begin
             flip(vaddr, $A000);
              if keypressed then quit:=true;
             GlowIn2(10,10, txt[x,1]);
              if keypressed then quit:=true;
             GlowIn2(10,10+14, txt[x,2]);
              if keypressed then quit:=true;
             GlowIn2(10,10+14+14, txt[x,3]);
             if not quit then de(5000);
           End;
    UnHook;
    fade2white;
    fade2black;
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure Init;
Begin
   asm mov ax, $13; int $10; end;
   InitV;
   Randomize;
   c:=0;
   curline:=0;
   Hook(@Lightning);
   ZDC;
   DrawPCX(vaddr, @Pic, sPic, True);
   for x:=32 to 40 do getpal(x, orglight[x,1],orglight[x,2],orglight[x,3]);
   pal(254, 0,0,0);
   for x:=32 to 40 do pal(x,0,0,0);
   GetTPal(syspal);
   flip(vaddr, $A000);
   wSetFont(@Font, 14, 8);
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure DeInit;
Begin
     DeInitV;
     asm mov ax, $3; int $10; end;
     CursorOff;
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Begin
  Init;
  MainLoop;
  DeInit;
  GetTPal(syspal);
  ZDC;
  if quit then readkey;
  move(@Banner^, mem[$B800:0], 640);
  writeln; writeln; writeln;
  FadeTo(syspal);
  CursorOn;
End.