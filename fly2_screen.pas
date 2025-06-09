unit fly2_screen;

 {Fly 2 - slaughter in the rain
  screen unit
  V0.1
  By suglasp}

interface

Uses Forms, windows, fly2cfg;

 //types
  type TResolution = Record
                      W, H, Depth: Integer;
                     End;

 //Hardware procedures
  Procedure SetScreen(Resolution: Tresolution);
  Procedure RestoreScreen;

 //variables
  var ScreenOK: Boolean = True;

implementation

Procedure SetScreen(Resolution: Tresolution);
Var dmScreenSettings: DEVMODE;
begin
With dmScreenSettings do
 begin
  dmsize := SizeOf(dmScreenSettings);
  dmPelsWidth := Resolution.W;
  dmPelsHeight := Resolution.H;
  dmBitsPerPel := Resolution.depth;
  dmFields := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL;
 end;
 If cfgdata.Fullscreen then
  begin
   If (ChangeDisplaySettings(dmScreenSettings, CDS_FULLSCREEN) = DISP_CHANGE_FAILED) then
    begin
     ScreenOK := False;
     Messagebox(application.handle, Pchar('Resolution not available!'), Pchar('Video card error'), Mb_Ok);
    end;
  end;
end;

Procedure RestoreScreen;
begin
 If ((cfgdata.fullscreen) and (ScreenOK)) then
  begin
   Changedisplaysettings(devmode(nil^), 0);
  end;
end;

end.
 