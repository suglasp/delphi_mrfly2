unit winsound_core;

 {Fly 2 - slaughter in the rain
  sound unit
  V0.1
  By suglasp}

interface

Uses MMSystem, sysutils, basetypes, log_core;

 //constants
  Const SNDINDEX: FLYByte = 0;

 //procedures
  procedure Play(Soundfile: String; loop: FLYBool);
  procedure Stop;

implementation

procedure Play(Soundfile: String; loop: FLYBool);
begin
 If loop then
  begin
   If Fileexists(Soundfile) then Playsound(Pchar(Soundfile), SNDINDEX, snd_Loop) else Writelog('Sound file "' + Soundfile + '" not found!');
  end else
   begin
     If Fileexists(Soundfile) then Playsound(Pchar(Soundfile), SNDINDEX, snd_Async) else Writelog('Sound file "' + Soundfile + '" not found!');
   end;
end;

procedure Stop;
begin
 Playsound(Pchar(''), SNDINDEX, 0);
end;

end.
