unit Maincfg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fly2cfg, basetypes, ComCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    ComboBox1: TComboBox;
    CheckBox3: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    CheckBox4: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 If ((ssAlt in shift) and (key = VK_F4)) then key := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Loaddata(GetAppdir + cfgfilename);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 With cfgdata do
  begin
   Fullscreen := Checkbox1.Checked;
   Sound := Checkbox2.Checked;
   RndDifficulty := Checkbox3.Checked;
   Playintro := Checkbox4.Checked;
   Player := Edit1.Text;
   Difficulty := Combobox1.ItemIndex;
  end;
 Savedata(GetAppdir + cfgfilename);
 Application.Terminate;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 With cfgdata do
  begin
   Checkbox1.Checked := Fullscreen;
   Checkbox2.Checked := Sound;
   Checkbox3.Checked := RndDifficulty;
   Checkbox4.Checked := Playintro;
   Edit1.Text := Player;
   Combobox1.ItemIndex := Difficulty;
  end;
end;

end.
