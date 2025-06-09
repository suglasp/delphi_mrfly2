unit fly2_envir;

 {Fly 2 - slaughter in the rain
  (map-) environment unit
  V0.1
  By suglasp}

interface

Uses graphics, sysutils, basetypes, mrfly, winsound_core, fly2cfg;

 //constants
  const PACKSIZE: FLYInt = 12;

 //types
  type THealthPack = Class
                      Left, Top: FLYInt;
                      Floatstat: FLYBool;
                     End;

 //procedures
  function GetHealth(X, Y: FLYInt): Boolean;
  procedure Loadpacks_to_mem;
  procedure Cleanpacks_from_mem;

  procedure MakeHealth(X, Y: FLYInt);
  procedure DestHealth;

  procedure RenderPacks(PackCanvas: TCanvas);

 //variables
  var HealthPack: THealthPack;

      HIMG: TBitmap;

      Pack_loaded: FLYBool = False;

implementation

function GetHealth(X, Y: FLYInt): Boolean;
begin
 If (Healthpack.Left + PACKSIZE div 2) > X Then
  begin
   If (Healthpack.Top + PACKSIZE div 2) > Y Then
    begin
     If (Healthpack.Left + PACKSIZE div 2) < X + 18  then
      begin
       If (Healthpack.Top + PACKSIZE div 2) < Y + 14 then
        begin
         Result := True;
        end else Result := False;
      end else Result := False;
    end else Result := False;
  end else Result := False;
end;

procedure Loadpacks_to_mem;
begin
 If NOT Pack_loaded Then
  begin
   HIMG := TBitmap.Create;
   HIMG.LoadFromFile(GetAppDir + texdir + 'healthpack.bmp');
   Pack_loaded := True;
  end;
end;

procedure Cleanpacks_from_mem;
begin
 If pack_loaded Then
  begin
   DestHealth;
   FreeAndNil(HIMG);
   Pack_loaded := False;
  end;
end;

procedure MakeHealth(X, Y: FLYInt);
begin
 If HealthPack = Nil then
  begin
   HealthPack := THealthPack.Create;
   Healthpack.Left := X;
   Healthpack.Top := Y;
   If cfgdata.Sound then Play(GetAppDir + snddir + 'healthspawn.wav', False);
  end;
end;

procedure DestHealth;
begin
 If HealthPack <> Nil then FreeAndnil(HealthPack);
end;

procedure RenderPacks(PackCanvas: TCanvas);
begin
 If pack_loaded then
  begin

   If HealthPack <> Nil then
    begin
     If HealthPack.Left > SCREENWIDTH Then Healthpack.Left := SCREENWIDTH - PACKSIZE;
     If HealthPack.TOP > SCREENHEIGHT Then Healthpack.Top := SCREENHEIGHT - PACKSIZE;
     If HealthPack.FloatStat Then
      begin
       Dec(HealthPack.Top);
       Dec(HealthPack.Left);
       HealthPack.Floatstat := False;
      end else
       begin
        Inc(HealthPack.Top);
        Inc(HealthPack.Left);
        HealthPack.Floatstat := True;
       end;
     PackCanvas.Draw(HealthPack.Left, HealthPack.Top, HIMG);
     If mrfly_player <> nil then
      begin
       If GetHealth(mrfly_player.X, mrfly_player.Y) Then
        begin
         DestHealth;
         If cfgdata.Sound then Play(GetAppDir + snddir + 'healthtake.wav', False);
         mrfly_player.Health := FULLHEALTH;
        end;
      end;
    end;

 end;
end;

end.
