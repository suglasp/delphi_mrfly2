program Fly2cfger;

uses
  Forms,
  Maincfg in 'Maincfg.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'FLY 2 - Slaughter in the rain settings';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
