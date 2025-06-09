program Fly2_slaughter;

uses
  Forms,
  Mainfly2 in 'Mainfly2.pas' {Form1},
  mrfly in 'mrfly.pas',
  basetypes in 'basetypes.pas',
  map in 'map.pas',
  fly2cfg in 'fly2cfg.pas',
  fly2_menu in 'fly2_menu.pas',
  fly2_intro in 'fly2_intro.pas',
  fly2_hud in 'fly2_hud.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
