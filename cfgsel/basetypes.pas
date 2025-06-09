unit basetypes;

 {Fly 2 - slaughter in the rain
  basetypes unit [CFG EDITION!!!]
  V0.3
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

 //procedure
  Function GetAppdir: String;

implementation

Function GetAppdir: String;
begin
 Result := ExtractfilePath(ParamStr(0));
end;

end.
