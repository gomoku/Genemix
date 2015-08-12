object LogForm: TLogForm
  Left = 192
  Top = 114
  BorderStyle = bsSingle
  Caption = 'Evolution process'
  ClientHeight = 406
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 145
    Height = 29
    Caption = 'Evolution log:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LogBook: TMemo
    Left = 40
    Top = 48
    Width = 345
    Height = 305
    TabStop = False
    ReadOnly = True
    TabOrder = 1
  end
  object StopButton: TButton
    Left = 176
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 0
    OnClick = StopButtonClick
  end
end
