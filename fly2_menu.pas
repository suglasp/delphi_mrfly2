unit fly2_menu;

 {Fly 2 - slaughter in the rain
  menu unit
  V0.3
  By suglasp}

interface

Uses Graphics, sysutils, Basetypes, fly2cfg, winsound_core, fly2_version;

 //constants
  const MAXITEMS = 5;

        MENUBG = 0; //Index
        MENUSEL = 1;
        MENURESLIGHT = 2;
        MENURESDARK = 3;
        MENUNEWGAME = 4;
        MENUQUIT = 5;

 //types

 //procedures
  Procedure GenMenu(MenuCanvas: TCanvas);
  Procedure NextItem;
  Procedure PreItem;

 //variables
  var Resume: Boolean = False;
      MenuIndex: FLYInt;
      MenuItem: Array [0..MAXITEMS] of TBitmap;

implementation

Function GetMenuFile(Index: FLYByte): String;
begin
 Case Index of
  0: Result := 'menubg.bmp';
  1: Result := 'menuselhead.bmp';
  2: Result := 'menureslight.bmp';
  3: Result := 'menuresdark.bmp';
  4: Result := 'menunewgame.bmp';
  5: Result := 'menuquit.bmp';
 end;
end;

Procedure GenMenu(MenuCanvas: TCanvas);
Var acnt: FLYByte;
begin
 For Acnt := 0 to MAXITEMS do
  begin
   MenuItem[Acnt] := Tbitmap.Create;
   MenuItem[Acnt].LoadFromFile(GetAppDir + texdir + GetMenufile(Acnt));
   If acnt <> 0 then
    begin
     MenuItem[Acnt].TransparentColor := $FF00FF;
     MenuItem[Acnt].Transparent := True;
    end;
  end;
 With MenuCanvas Do
  begin
   Draw(0, 0, MenuItem[MENUBG]);
   If Resume then Draw(10, 74, MenuItem[MENURESLIGHT]) else Draw(10, 74, MenuItem[MENURESDARK]);
   Draw(10, 106, MenuItem[MENUNEWGAME]);
   Draw(10, 138, MenuItem[MENUQUIT]);
   Case MenuIndex of
    0: Draw(10, 74, MenuItem[MENUSEL]);
    1: Draw(10, 106, MenuItem[MENUSEL]);
    2: Draw(10, 138, MenuItem[MENUSEL]);
   end;
   Brush.color := $000000;
   with font do
    begin
     Color := $FFFFFF;
     Name := 'Arial';
     Size := 7;
    end;
   TextOut(10, 240 - 20, Cfgdata.Player + ': ' + IntTostr(cfgdata.AScore));
   TextOut(270, 240 - 20, 'V' + core_version);
  end;
 For Acnt := 0 to MAXITEMS do
  begin
   FreeandNil(Menuitem[ACnt]);
  end;
end;

Procedure NextItem;
begin
 Inc(MenuIndex);
 If MenuIndex > 2 Then MenuIndex := 0;
 If ((NOT Resume) and (MenuIndex = 0)) Then MenuIndex := 1;
 If cfgdata.Sound then Play(GetAppDir + snddir + 'select.wav', False);
end;

Procedure PreItem;
begin
 Dec(MenuIndex);
 If MenuIndex < 0 Then MenuIndex := 2;
 If ((NOT Resume) and (MenuIndex = 0)) Then MenuIndex := 2;
 If cfgdata.Sound then Play(GetAppDir + snddir + 'select.wav', False);
end;

end.
