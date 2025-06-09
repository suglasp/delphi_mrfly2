unit fly2_setup;

 {Fly 2 - slaughter in the rain
  setup unit
  V0.1
  By suglasp}

interface

Uses Forms, fly2_screen;

 //constants
  Const CORE_TITLE: String = 'FLY 2 - slaughter in the rain';

 //procedures
  Procedure Setupcore(AForm: Tform; ARes: TResolution; Ontop: Boolean);
  Procedure Resetcore;

 //variables
  var Keysready: Boolean = False;

implementation

Uses mouse_core, fly2_version, log_core, fly2cfg;

Procedure Setupcore(AForm: Tform; ARes: TResolution; Ontop: Boolean);
begin
 Writelog('Init engine "' + CORE_TITLE + '"');
 Writelog('CORE VERSION: V' + CORE_VERSION + ' found');
 Application.Title := CORE_TITLE + ' [' + CORE_VERSION + ']';
 With Aform do
  begin
   If OnTop then FormStyle := fsStayOntop;
   Caption := CORE_TITLE;
   Color := $000000;
   BorderIcons := [];
   Keypreview := True;
   Writelog('Keys ready ....');
   ClientWidth := ARes.W - 2;
   ClientHeight := Ares.H - 2;
   Writelog('CORE set');
   If ((cfgdata.Fullscreen) and (ScreenOK)) then
    begin
     BorderStyle := bsNone;
     Left := 0;
     Top := 0;
     SetScreen(ARes);
     Writelog('Resolution loaded ...');
     Writelog('Fullscreen mode!');
    end else
     begin
      BorderStyle := bsSingle;
      Left := Screen.Width div 2 - Clientwidth div 2;
      Top := Screen.Height div 2 - ClientHeight div 2;
      Writelog('Resolution loaded ...');
      Writelog('Windowed mode!');
     end;
   If NOT ScreenOk Then
    begin
     Writelog('*** Tried to set CORE to fullscreen,');
     Writelog('*** resolution not supported by videocard!');
    end;
   MousePos(Screen.Width div 2, Screen.height div 2);
   Writelog('Mouse reposition done');
  end;
 keysready := True;
 Writelog('Keys enabled');
end;

Procedure Resetcore;
begin
 RestoreScreen;
 Writelog('Screen reset ...');
 Writelog('Application shutdown');
 If Logopened then closelog; 
end;

end.
