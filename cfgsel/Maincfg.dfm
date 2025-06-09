object Form1: TForm1
  Left = 192
  Top = 107
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'FLY 2 - Slaughter in the rain settings'
  ClientHeight = 335
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object SpeedButton1: TSpeedButton
    Left = 224
    Top = 304
    Width = 81
    Height = 25
    Hint = 'Quit & save settings'
    Caption = 'Save'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 136
    Top = 304
    Width = 81
    Height = 25
    Hint = 'Quit & don'#39't save settings'
    Caption = 'Nah'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton2Click
  end
  object Label3: TLabel
    Left = 8
    Top = 304
    Width = 22
    Height = 14
    Caption = 'V0.5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 297
    Height = 289
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Video'
      object CheckBox1: TCheckBox
        Left = 8
        Top = 8
        Width = 273
        Height = 17
        Hint = 'Play fullscreen'
        Caption = 'Render fullscreen'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object CheckBox4: TCheckBox
        Left = 8
        Top = 32
        Width = 273
        Height = 17
        Caption = 'Play intro'
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Sound'
      ImageIndex = 1
      object CheckBox2: TCheckBox
        Left = 8
        Top = 8
        Width = 273
        Height = 17
        Hint = 'Enable/disable sound effects'
        Caption = 'Sound effects'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Game'
      ImageIndex = 2
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 80
        Height = 16
        Caption = 'player name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 56
        Width = 56
        Height = 16
        Caption = 'play skill'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 8
        Top = 24
        Width = 273
        Height = 24
        Hint = 'Player name'
        MaxLength = 255
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'Edit1'
      end
      object ComboBox1: TComboBox
        Left = 8
        Top = 72
        Width = 273
        Height = 24
        Hint = 'Skill to play'
        Style = csDropDownList
        ItemHeight = 16
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Items.Strings = (
          'Tiny baby - easy'
          'I'#39'll get him ... yah! - medium'
          'WTF?!!! - hard')
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 112
        Width = 273
        Height = 17
        Hint = 'Enable to random set the playing skill'
        Caption = 'Random skill select'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
    end
  end
end
