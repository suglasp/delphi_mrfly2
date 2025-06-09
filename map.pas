unit map;

 {Fly 2 - slaughter in the rain
  map unit
  V0.1
  By suglasp}

interface

Uses Graphics, mrFly, Sysutils, basetypes, fly2cfg, fly2_envir;

 //constants
  const MAXBGS = 2;

 //types
  type TCouldPoint = Record
                      Left, Top: FLYInt;
                     end;

 //procedures
  function GetIngameBgfile(Index: FLYByte): String;
  procedure Makemap;
  Procedure ClearMap;
  Procedure Moveclouds;
  Procedure RenderMap(rAcanvas: TCanvas);

 //variables
  var Background, Cloud1, Cloud2: TBitmap;
      CL1P: TCouldPoint;
      CL2P: TCouldPoint;

implementation

function GetIngameBgfile(Index: FLYByte): String;
begin
 Case Index of
  0: Result := 'ingamebg1.bmp';
  1: Result := 'ingamebg2.bmp';
  2: Result := 'ingamebg3.bmp';
 end;
end;

procedure Makemap;
begin
 Randomize;
 Background := Tbitmap.Create;
 Cloud1 := TBitmap.Create;
 Cloud2 := Tbitmap.Create;
 Background.LoadFromFile(GetAppdir + texdir + GetIngameBgFile(Random(MAXBGS + 1)));
 Cloud1.LoadFromFile(GetAppdir + texdir + 'Cloud1.bmp');
 Cloud2.LoadFromFile(GetAppdir + texdir + 'Cloud2.bmp');
 With Cloud1 do
  begin
   TransparentColor := $FF00FF;
   Transparent := True;
  end;
 With Cloud2 do
  begin
   TransparentColor := $FF00FF;
   Transparent := True;
  end;
 LoadMrFly(GetAppdir + texdir + MRFLYTEXFILE);
 Loadpacks_to_mem;
 if Cfgdata.RndDifficulty then SpawnmrFly(Random(3), cfgdata.Player) else SpawnmrFly(cfgdata.Difficulty, cfgdata.Player);
end;

Procedure ClearMap;
begin
 UnLoadall;
 Cleanpacks_from_mem; 
 If Background <> Nil then FreeAndNil(Background);
 If Cloud1 <> Nil then FreeAndNil(Cloud1);
 If Cloud2 <> Nil then FreeAndNil(Cloud2);
end;

Procedure Moveclouds;
begin
 If cfgdata.Difficulty = 0 Then Dec(CL1P.Left, 2) else Dec(CL1P.Left);
 If cfgdata.Difficulty = 0 Then Inc(CL2P.Left, 2) else Inc(CL2P.Left);
 If CL1P.Left + Cloud1.Width < 0 then
  begin
   CL1P.Left := SCREENWIDTH;
   CL1P.Top := Random(30);
  end;
 If CL2P.Left > SCREENWIDTH then
  begin
   CL2P.Left := 0 - Cloud2.Width;
   CL2P.Top := Random(30);
  end;
end;

Procedure RenderMap(RAcanvas: TCanvas);
Var sp_cnt: FLYByte;
begin
 Moveclouds;
 With raCanvas do
  begin
   Draw(0, 0, Background);
   Draw(CL1P.Left, CL1P.Top, Cloud1);
   For sp_cnt := 0 to SPLATTERS do
    begin
     If Splatter[sp_cnt] <> nil then Splatter[sp_cnt].RenderSplatter(rACanvas);
    end;
   RenderPacks(rACanvas);
   If mrFly_player <> nil then mrFly_player.RendermrFly(rACanvas);
   Draw(CL2P.Left, CL2P.Top, Cloud2);
  end;
end;

end.
