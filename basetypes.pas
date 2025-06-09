unit basetypes;

 {Fly 2 - slaughter in the rain
  basetypes unit
  V0.2
  By suglasp}

interface

Uses sysutils;

 //types
  type FLYInt = Integer;
       FLYByte = Byte;
       FLYWord = Word;
       FLYBool = Boolean;

 //constants
  const texdir: String = 'textures\';
        snddir: String = 'sounds\';

        SCREENWIDTH: FLYInt = 320;
        SCREENHEIGHT: FLYInt = 240;
        SCREENDEPTH: FLYInt = 32;

 //procedure
  Function GetAppdir: String;

implementation

Function GetAppdir: String;
begin
 Result := ExtractfilePath(ParamStr(0));
end;

end.
