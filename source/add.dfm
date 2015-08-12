object AddForm: TAddForm
  Left = 204
  Top = 179
  Width = 544
  Height = 375
  Caption = 'Attribute properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object NameLabel: TLabel
    Left = 8
    Top = 8
    Width = 126
    Height = 24
    Caption = 'Attribute name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 208
    Top = 72
    Width = 41
    Height = 13
    Caption = 'Minimum'
  end
  object Label2: TLabel
    Left = 208
    Top = 136
    Width = 44
    Height = 13
    Caption = 'Maximum'
  end
  object Label3: TLabel
    Left = 208
    Top = 200
    Width = 22
    Height = 13
    Caption = 'Step'
  end
  object Label4: TLabel
    Left = 208
    Top = 16
    Width = 53
    Height = 13
    Caption = 'Initial value'
  end
  object DataTypeRadio: TRadioGroup
    Left = 8
    Top = 80
    Width = 169
    Height = 97
    Caption = 'Data type'
    ItemIndex = 0
    Items.Strings = (
      'Integer'
      'Real number')
    TabOrder = 0
  end
  object EntryName: TEdit
    Left = 8
    Top = 40
    Width = 161
    Height = 21
    TabOrder = 1
  end
  object MinEdit: TEdit
    Left = 208
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object MaxEdit: TEdit
    Left = 208
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object StepEdit: TEdit
    Left = 208
    Top = 216
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '1'
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 264
    Width = 97
    Height = 41
    TabOrder = 5
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 184
    Top = 264
    Width = 113
    Height = 41
    TabOrder = 6
    Kind = bkCancel
  end
  object InitEdit: TEdit
    Left = 208
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object InitRadio: TRadioGroup
    Left = 368
    Top = 16
    Width = 145
    Height = 65
    Caption = 'Randomization'
    ItemIndex = 0
    Items.Strings = (
      'None'
      'All but one'
      'All')
    TabOrder = 8
  end
end
