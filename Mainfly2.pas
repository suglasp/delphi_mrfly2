unit Mainfly2;

 {Fly 2 - slaughter in the rain
  main unit
  V0.1
  By suglasp}

interface
  
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fly2_screen, basetypes, mouse_core, ExtCtrls;

type TGameState = (gs_Intro, gs_Menu, gs_Ingame);

type
  TForm1 = class(TForm)
    Clock: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ClockTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
   Gamestate: TGameState;
   Procedure MainLoop;
   Procedure DrawBuffer;
   Procedure SetClock(Delay: FLYInt);
   Procedure LoadCur;
   Procedure MouseCheck;
  end;

var
  Form1: TForm1;
  buffer: TBitmap;
  tempres: TResolution;
  FRUN: Boolean = True;

  tmpMX, tmpMy: FLYInt;
  tmpMDown: FLYBool = False;
  Paused: FLYBool = False;

  willTeleport, TeleportTrigger: FLYInt;
  needHealth, HealthTrigger: FLYInt;

  MClip: TRect;
  
implementation

Uses fly2_envir, fly2_hud, fly2_intro, fly2_menu, fly2cfg, fly2_setup, log_core, winsound_core, map, mrFly;

{$R *.dfm}
{$R cursor.res}

Procedure Tform1.MainLoop;
begin
 Case GameState of
  gs_intro: Begin
             MouseState(m_Invisible);
             RenderIntro(Buffer.Canvas);
             Drawbuffer;
             Writelog('Keysready enabled');
             GameState := gs_menu;
            End;
  gs_Menu: Begin
            MouseState(m_Visible);
            MousePos(Screen.Width div 2, Screen.height div 2);
            KeysReady := True;
            If resume then MenuIndex := 0 else Menuindex := 1;
            GenMenu(Buffer.Canvas);
            drawBuffer;
            Clock.Enabled := False;
           End;
  gs_Ingame: begin
              RenderMap(Buffer.Canvas);
              RenderHUD(Score, Buffer.Canvas);
              DrawBuffer;
              If cfgdata.RndDifficulty then
               begin
                Case cfgdata.Difficulty of
                 0: SetClock(50);
                 1: SetClock(30);
                 2: SetClock(20);
                end;
               end;
              Inc(TeleportTrigger);
              If TeleportTrigger >= willTeleport Then
               begin
                If mrfly_player <> NIL Then mrfly_Player.TeleportmrFly(Buffer.Canvas);
                TeleportTrigger := 0;
                Case cfgData.Difficulty of
                 0: willTeleport := Random(1111) + 1;
                 1: willTeleport := Random(700) + 1;
                 2: willTeleport := Random(500) + 1;
                end;
               end;
              Inc(HealthTrigger);
              If HealthTrigger >= NeedHealth Then
               begin
                MakeHealth(Random(SCREENWIDTH), Random(SCREENHEIGHT));
                HealthTrigger := 0;
                Case cfgData.Difficulty of
                 0: NeedHealth := Random(1111) + 1;
                 1: NeedHealth := Random(700) + 1;
                 2: NeedHealth := Random(500) + 1;
                end;
               end;
              cfgdata.AScore := Score;
              If (score < 0) Then
               begin
                Resume := False;
                Score := 0;
                GameState := gs_menu;
                ClearMap;
                cfgdata.AScore := Score;
                If cfgdata.Sound then Play(GetAppDir + snddir + 'lost.wav', False);
                Writelog('You lost with a score of ' + IntToStr(Score));
               end;
              If ((score > 6000) and (Score < 7000)) Then
               begin
                Resume := False;
                GameState := gs_menu;
                ClearMap;
                cfgdata.AScore := Score;
                If cfgdata.Sound then Play(GetAppDir + snddir + 'won.wav', False);
                Writelog('You won with a score of ' + IntToStr(Score));
               end;
              cfgdata.AScore := Score;
             end;
 end;
end;

Procedure TForm1.DrawBuffer;
begin
 Form1.Canvas.Draw(0, 0, Buffer);
end;

Procedure TForm1.SetClock(Delay: FLYInt);
begin
 Clock.Interval := Delay;
end;

Procedure Tform1.LoadCur;
Var Mycur: Tcursor;
begin
Screen.cursors[mycur] := Loadcursor(Hinstance, Pchar('MINCUR'));
Screen.cursor := Mycur;
end;

Procedure TForm1.MouseCheck;
begin
 If tmpMDown then
  begin
   tmpMDown := False;
   If Gamestate = gs_ingame then
    begin
     If mrfly_Player <> Nil Then
      begin
       If Mrfly_player.GetClick(tmpMX, tmpMY) then
        begin
         if mrfly_player <> Nil then
          begin
            If mrfly_player.Health > 0 then
            begin
             Case cfgdata.Difficulty of
              0: begin
                  mrfly_player.Health := mrfly_player.Health - 50;
                  Score := Score + 50;
                 end;
              1: begin
                  mrfly_player.Health := mrfly_player.Health - 25;
                  Score := Score + 25;
                 end;
              2: begin
                  mrfly_player.Health := mrfly_player.Health - 10;
                  score := Score + 10;
                 end;
             end;
            end else
             begin
              KillMrFly;
              if Cfgdata.RndDifficulty then SpawnmrFly(Random(3), cfgdata.Player) else SpawnmrFly(cfgdata.Difficulty, cfgdata.Player);
              Score := Score + 100;
             end; //difficulty case else end
         end; //nil?
        end else
         begin
          Case cfgdata.Difficulty of
           0: begin
               Score := Score - 25;
              end;
           1: begin
               Score := Score - 50;
              end;
           2: begin
               score := Score - 100;
              end;
          end;
         end; //get click
      end; //mrfly ok
    end; //gamestate
 end; //Mdown
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 If keysready then
  begin
   Case GameState of
    gs_menu: begin
              //If key = VK_ESCAPE then Application.Terminate;
              If key = VK_DOWN then NextItem;
              If key = VK_UP then PreItem;
              If key = VK_RETURN then
               begin
                Case Menuindex of
                 0: Begin
                     Writelog('Resume to current game');
                     GameState := gs_Ingame;
                     Clock.enabled := True;
                    End;
                 1: Begin
                     Writelog('New game started');
                     ClearMap;
                     MakeMap;
                     Gamestate := gs_Ingame;
                     Case cfgdata.Difficulty of
                      0: SetClock(50);
                      1: SetClock(30);
                      2: SetClock(20);
                     end;
                     TeleportTrigger := 0;
                     HealthTrigger := 0;
                     Score := 250;
                     Case cfgData.Difficulty of
                      0: willTeleport := Random(1111) + 1;
                      1: willTeleport := Random(700) + 1;
                      2: willTeleport := Random(500) + 1;
                     end;
                     Case cfgData.Difficulty of
                      0: NeedHealth := Random(1111) + 1;
                      1: NeedHealth := Random(700) + 1;
                      2: NeedHealth := Random(500) + 1;
                     end;
                     Clock.Enabled := True;
                    End;
                 2: Application.Terminate;
                end;
                If cfgdata.Sound then Play(GetAppDir + snddir + 'click.wav', False);
               end;
              GenMenu(Buffer.Canvas);
              DrawBuffer;
             end;
    gs_Ingame: Begin
                If key = VK_ESCAPE then
                 begin
                  Resume := True;
                  GameState := gs_Menu;
                  GenMenu(Buffer.Canvas);
                 end;
               End;
   end;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Loaddata(GetappDir + cfgfilename);
 Writelog('CFG data loaded');
 LoadCur;
 Randomize;
 Writelog('Cursor loaded');
 with tempres do
  begin
   W := SCREENWIDTH;
   H := SCREENHEIGHT;
   Depth := SCREENDEPTH;
  end;
 Setupcore(Form1, tempres, False);
 KeysReady := False;
 Buffer := Tbitmap.Create;
 Buffer.Width := TempRes.W;
 Buffer.Height := TempRes.H;
 Writelog('Render GDI+ init: OK');
 If cfgdata.Sound Then Writelog('Sound enabled') else Writelog('Sound disabled');;
 If cfgdata.Playintro then
  begin
   Writelog('Intro playing enabled');
   Gamestate := gs_Intro;
  end else
   begin
    Writelog('Intro playing disabled');
    GameState := gs_menu;
   end;
 //Mclip := Rect(Form1.left, Form1.Top, Form1.left + SCREENWIDTH, Form1.Top + SCREENHEIGHT);
 //Clipcursor(@MClip);
 SetClock(20);
 clock.Enabled := True;
 Writelog('Game loop started!'); 
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 Resetcore;
 ClearMap;
 FreeAndNil(Buffer);
 Savedata(GetappDir + cfgfilename);
 //Clipcursor(Nil);
end;

procedure TForm1.ClockTimer(Sender: TObject);
begin
 MouseCheck;
 MainLoop;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
 If FRUN then
  begin
   DrawBuffer;
   FRUN := False;
  end else DrawBuffer;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 If KeysReady then
  begin
   tmpMX := X;
   tmpMY := Y;
   tmpMdown := True;
  end; //keysready
end;

end.
