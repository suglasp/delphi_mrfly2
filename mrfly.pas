unit mrfly;

 {Fly 2 - slaughter in the rain
  mrfly unit
  V0.3
  By suglasp}

interface

Uses graphics, sysutils, classes, basetypes, fly2cfg, winsound_core;

 //constants
  const mrFlyFrames = 7; //max frames
        SPLATTERS = 99;
        TELES = 2;

        FULLHEALTH: FLYByte = 200; //health status
        HELMETHEALTH: FLYByte = 100;
        DEADHEALTH: FLYByte = 0;

        MRFLY_HELM_LEFT_WING = 0; //frame index
        MRFLY_HELM_LEFT_NOWING = 1;
        MRFLY_HELM_RIGHT_WING = 2;
        MRFLY_HELM_RIGHT_NOWING = 3;
        MRFLY_NOHELM_LEFT_WING = 4;
        MRFLY_NOHELM_LEFT_NOWING = 5;
        MRFLY_NOHELM_RIGHT_WING = 6;
        MRFLY_NOHELM_RIGHT_NOWING = 7;

        MRFLYTEXFILE: String = 'mrFly.lst';
        SPLATTERTEXFILE: String = 'splatter.bmp';

 //types
  type TDirection = (dir_Left, dir_Right);
       TAIstate = (AI_fly, AI_teleport);
       TFlySpeed = (speed_slow, speed_medium, speed_fast);

       TmrFly = Class
                 X, Y: FLYInt;
                 Wing: FLYBool;
                 Direction: TDirection;
                 AIstate: TAIstate;
                 Flyspeed: TFlyspeed;
                 Playername: String;
                 Health, Helmlost: FLYByte;
                 Function RndDir: TDirection;
                 Function RndAIstate: TAIState;
                 Function RndFlyspeed: TFlyspeed;
                 Function GetClick(MX, MY: FLYInt): Boolean;
                 Procedure TeleportmrFly(TeleCanvas: TCanvas);
                 Procedure RendermrFly(Acanvas: TCanvas);
                End;

       TSplatter = Class
                    X, Y: FLYInt;
                    splatterTex: TBitmap;
                    Constructor Create(Spl_X, Spl_Y: FLYInt);
                    Destructor Destroy; Override;
                    Procedure RenderSplatter(Acanvas: TCanvas);
                   End;

      TTeleAnim = Class
                   X, Y: FLYInt;
                   TeleFrame: FLYByte;
                   TeleTex: Array[0..TELES] of TBitmap;
                   Constructor Create(Tele_X, Tele_Y: FLYInt);
                   Destructor Destroy; Override;
                   Procedure RenderTele(Acanvas: TCanvas);
                  End;

 //procedures & functions
  Procedure LoadmrFly(TexFileList: String);
  Procedure SpawnmrFly(Speed: FLYByte; PlName: String);
  Procedure KillmrFly;
  Procedure UnloadAll;

 //variables
  Var mem_mrFrame: Array[0..mrFlyFrames] of TBitmap;

      splatter: Array[0..SPLATTERS] of TSplatter;
      splatterindex: FLYByte;

      mrFly_player: TmrFly;
      mrFlyLoaded: FLYBool = False;

      score: FLYInt;

      Teleport: TTeleAnim;

implementation

{=== overall ===}
Procedure LoadmrFly(TexFileList: String);
var data: String;
    f: Textfile;
    texindex: FLYbyte;
begin
 UnloadAll;
 If Fileexists(TexFileList) then
  begin
   texindex := 0;
   Assignfile(f, TexFileList);
   Reset(f);
    While NOT EoF(f) do
     begin
      Readln(f, data);
      If data <> '' then Data := Trim(Data);
      If Fileexists(GetAppdir + texdir + data) then
       begin
        mem_mrframe[texindex] := TBitmap.Create;
        mem_mrframe[texindex].LoadFromFile(GetAppdir + texdir + data);
        mem_mrframe[texindex].TransparentColor := $FF00FF;
        mem_mrframe[texindex].Transparent := True;
       end;
      Inc(Texindex);
     end;
   Closefile(f);
  end;
end;

Procedure SpawnmrFly(Speed: FLYByte; PlName: String);
begin
 mrfly_player := TmrFly.Create;
 With mrfly_player do
  begin
   Direction := RndDir;
   AIState := AI_fly;
   Case Speed of
    0: Flyspeed := Speed_slow;
    1: Flyspeed := Speed_medium;
    2: Flyspeed := Speed_fast;
   end;
   PlayerName := PlName;
   Health := FULLHEALTH;
   Wing := True;
   Y := Random(SCREENHEIGHT);
   Case Direction of
    dir_left: X := 0 - 20;
    dir_right: X := SCREENWIDTH + 20;
   end;
  end;
end;

Procedure KillmrFly;
var rndsnd: FLYByte;
begin
 If splatterindex >= SPLATTERS Then splatterindex := 0;
 If splatter[splatterindex] = nil then splatter[splatterindex] := Tsplatter.Create(mrFly_Player.X, mrFly_player.Y) else
  begin
   Splatter[splatterindex].X := mrFly_Player.X;
   Splatter[splatterindex].Y := mrFly_Player.Y;
  end;
 FreeAndnil(mrFly_Player);
 Inc(SplatterIndex);
 rndsnd := Random(5);
 Case rndsnd of
  0: If cfgdata.Sound then Play(GetAppDir + snddir + 'die1.wav', False);
  1: If cfgdata.Sound then Play(GetAppDir + snddir + 'die2.wav', False);
  2: If cfgdata.Sound then Play(GetAppDir + snddir + 'die3.wav', False);
  3: If cfgdata.Sound then Play(GetAppDir + snddir + 'die4.wav', False);
  4: If cfgdata.Sound then Play(GetAppDir + snddir + 'die5.wav', False);
 end;
end;

Procedure UnloadAll;
var Acnt: Flybyte;
begin
 If mrfly_player <> Nil then FreeAndnil(mrFly_player);
 For Acnt := 0 to mrFlyFrames do
  begin
   If mem_mrframe[Acnt] <> Nil then FreeAndnil(mem_mrframe[Acnt]);
  end;
 for Acnt := 0 to SPLATTERS do
  begin
   If Splatter[Acnt] <> Nil then FreeAndnil(splatter[Acnt]);
  end;
 SplatterIndex := 0;
end;

{=== TmrFly ===}
Function TmrFly.RndDir: TDirection;
var arnddir: FLYByte;
begin
 arnddir := Random(1 + 1);
 Case arnddir of
  0: Result := dir_left;
  1: Result := dir_right;
 end;
end;

Function TmrFly.RndAIstate: TAIState;
var arndstate: FLYByte;
begin
 arndstate := Random(Ord(AIstate) + 1);
 Case arndstate of
  0: Result := AI_fly;
  1: Result := AI_teleport;
 end;
end;

Function TmrFly.RndFlyspeed: TFlyspeed;
var arndspeed: FLYByte;
begin
 arndspeed := Random(Ord(Flyspeed) + 1);
 Case arndspeed of
  0: Result := speed_slow;
  1: Result := speed_medium;
  2: Result := speed_fast;
 end;
end;

Function TmrFly.GetClick(MX, MY: FLYInt): Boolean;
begin
 If MX > X Then
  begin
   If MY > Y Then
    begin
     If MX < X + 18 then
      begin
       If MY < Y + 14 then
        begin
         Result := True;
        end else Result := False;
      end else Result := False;
    end else Result := False;
  end else Result := False;
end;

Procedure TmrFly.TeleportmrFly(TeleCanvas: TCanvas);
Var TCnt: FLYByte;
begin
 Teleport := TTeleAnim.Create(X, Y);
 For TCnt := 0 To TELES do
  begin
   If mrfly_Player <> Nil Then mrfly_Player.RendermrFly(TeleCanvas);
   Teleport.TeleFrame := TCnt;
   Teleport.RenderTele(TeleCanvas);
  End;
 Teleport.Destroy;
 Direction := Rnddir;
 X := Random(SCREENWIDTH);
 Y := Random(SCREENHEIGHT);
 AIState := AI_Fly;
 If cfgdata.Sound then Play(GetAppDir + snddir + 'teleport.wav', False);
end;

Procedure TmrFly.RendermrFly(Acanvas: TCanvas);
Var rndY: FLYByte;
begin
 rndY := Random(3); {*** move some up/down}
 Case rndY of
  0: Dec(Y);
  1: Y := Y;
  2: Inc(Y);
 end;
 If Y < 0 Then Y := 0;
 If Y + 14 > SCREENHEIGHT Then Y := SCREENHEIGHT - 14;
 Case Direction of {*** move left or right + render}
  dir_left: begin //render left direction
             Dec(X, 2); //move left
             If Health > HELMETHEALTH Then //helm needed?
              begin //with helm
               If Wing then ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_HELM_LEFT_WING]) else ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_HELM_LEFT_NOWING]);
              end else
               begin //without helm
                If Wing then ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_NOHELM_LEFT_WING]) else ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_NOHELM_LEFT_NOWING]);
               end;
            End;
  dir_right: begin //render right direction
              Inc(X, 2); //move right
              If Health > HELMETHEALTH Then //helm needed?
               begin //with helm
                If Wing then ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_HELM_RIGHT_WING]) else ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_HELM_RIGHT_NOWING]);
               end else
                begin //without helm
                 If Wing then ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_NOHELM_RIGHT_WING]) else ACanvas.Draw(X, Y, mem_mrFrame[MRFLY_NOHELM_RIGHT_NOWING]);
                end;
             end;
 end;
 If Wing then Wing := False else Wing := True;

 If health > HELMETHEALTH then Helmlost := 0;

 If health < HELMETHEALTH then
  begin
   If helmlost = 0 then
    begin
     If cfgdata.Sound then Play(GetAppDir + snddir + 'helmlost.wav', False);
     Helmlost := 1;
    end;
  end;

 If X + 18 < 0 then //check screen collides
  begin
   Health := FULLHEALTH;
   Score := Score - 100;
   Direction := RndDir;
   Case Direction of
    dir_left: X := SCREENWIDTH;
    dir_right: X := 0;
   end;
   Y := Random(SCREENHEIGHT);
   If Cfgdata.RndDifficulty then cfgdata.Difficulty := Random(3);
  end;

 If X > SCREENWIDTH then //check screen collides
  begin
   Health := FULLHEALTH;
   Score := Score - 100;
   Direction := RndDir;
   Case Direction of
    dir_left: X := SCREENWIDTH;
    dir_right: X := 0;
   end;
   Y := Random(SCREENHEIGHT);
   If Cfgdata.RndDifficulty then cfgdata.Difficulty := Random(3);
  end;

end;

{=== Tsplatter ===}
Constructor Tsplatter.Create(Spl_X, Spl_Y: FLyInt);
begin
 SplatterTex := TBitmap.Create;
 If Fileexists(Getappdir + texdir + SPLATTERTEXFILE) then
  begin
   Splattertex.LoadFromFile(Getappdir + texdir + SPLATTERTEXFILE);
   SplatterTex.TransparentColor := $FF00FF;
   SplatterTex.Transparent := True;
  end;
 X := Spl_X;
 Y := Spl_Y;
end;

Destructor TSplatter.Destroy;
begin
 If SplatterTex <> Nil then FreeAndNil(SplatterTex);
 Inherited;
end;

Procedure TSplatter.RenderSplatter(Acanvas: TCanvas);
begin
 ACanvas.draw(X, Y, SplatterTex);
end;


{=== TTeleAnim ===}
Constructor TTeleAnim.Create(Tele_X, Tele_Y: FLYInt);
Var ctelecnt: FLYByte;
begin
 For cTeleCnt := 0 to TELES do
  begin
   TeleTex[cTelecnt] := TBitmap.Create;
   TeleTex[cTelecnt].LoadFromFile(GetAppDir + TexDir + 'tele' + IntToStr(CTeleCnt + 1) + '.bmp');
   TeleTex[cTelecnt].TransparentColor := $FF00FF;
   TeleTex[cTelecnt].Transparent := True;
  End;
end;

Destructor TTeleAnim.Destroy;
Var dtelecnt: FLYByte;
begin
 For dTeleCnt := 0 to TELES do
  begin
   FreeAndNil(TeleTex[dTelecnt]);
  End;
 Inherited;
end;

Procedure TTeleAnim.RenderTele(Acanvas: TCanvas);
begin
 ACanvas.draw(X, Y, TeleTex[TeleFrame]);
end;

end.
