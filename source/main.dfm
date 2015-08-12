object MainForm: TMainForm
  Left = 191
  Top = 112
  Width = 606
  Height = 454
  Caption = 'Genemix v1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 32
    Width = 33
    Height = 13
    Caption = 'exe file'
  end
  object Label2: TLabel
    Left = 24
    Top = 80
    Width = 46
    Height = 13
    Caption = 'output file'
  end
  object Label3: TLabel
    Left = 24
    Top = 128
    Width = 39
    Height = 13
    Caption = 'input file'
  end
  object Label5: TLabel
    Left = 24
    Top = 176
    Width = 57
    Height = 13
    Caption = 'log directory'
  end
  object Exefile: TEdit
    Left = 24
    Top = 48
    Width = 177
    Height = 21
    TabOrder = 0
    Text = 'program\loader.bat'
  end
  object OutputFile: TEdit
    Left = 24
    Top = 96
    Width = 177
    Height = 21
    TabOrder = 1
    Text = 'program\GeneOut'
  end
  object Inputfile: TEdit
    Left = 24
    Top = 144
    Width = 177
    Height = 21
    TabOrder = 2
    Text = 'program\GeneIn'
  end
  object RunButton: TButton
    Left = 56
    Top = 264
    Width = 121
    Height = 33
    Caption = 'Run'
    TabOrder = 3
    OnClick = RunButtonClick
  end
  object PageControl1: TPageControl
    Left = 216
    Top = 8
    Width = 377
    Height = 385
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 4
    object TabSheet1: TTabSheet
      Caption = 'Data'
      object VarList: TListBox
        Left = 40
        Top = 16
        Width = 225
        Height = 257
        ItemHeight = 13
        TabOrder = 0
      end
      object DelButton: TButton
        Left = 96
        Top = 280
        Width = 57
        Height = 33
        Caption = 'Delete'
        TabOrder = 1
        OnClick = DelButtonClick
      end
      object AddButton: TButton
        Left = 40
        Top = 280
        Width = 57
        Height = 33
        Caption = 'Add'
        TabOrder = 2
        OnClick = AddButtonClick
      end
      object UpButton: TBitBtn
        Left = 200
        Top = 280
        Width = 33
        Height = 33
        TabOrder = 3
        OnClick = UpButtonClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
          3333333333777F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
          3333333777737777F333333099999990333333373F3333373333333309999903
          333333337F33337F33333333099999033333333373F333733333333330999033
          3333333337F337F3333333333099903333333333373F37333333333333090333
          33333333337F7F33333333333309033333333333337373333333333333303333
          333333333337F333333333333330333333333333333733333333}
        NumGlyphs = 2
      end
      object DownButton: TBitBtn
        Left = 232
        Top = 280
        Width = 33
        Height = 33
        TabOrder = 4
        OnClick = DownButtonClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
          333333333337F33333333333333033333333333333373F333333333333090333
          33333333337F7F33333333333309033333333333337373F33333333330999033
          3333333337F337F33333333330999033333333333733373F3333333309999903
          333333337F33337F33333333099999033333333373333373F333333099999990
          33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333300033333333333337773333333}
        NumGlyphs = 2
      end
      object EditButton: TButton
        Left = 152
        Top = 280
        Width = 49
        Height = 33
        Caption = 'Edit'
        TabOrder = 5
        OnClick = EditButtonClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Genetics'
      ImageIndex = 1
      object Label4: TLabel
        Left = 16
        Top = 16
        Width = 50
        Height = 13
        Caption = 'Population'
      end
      object PopEdit: TEdit
        Left = 16
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '20'
      end
      object EliteEdit: TLabeledEdit
        Left = 16
        Top = 80
        Width = 121
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Elite'
        LabelPosition = lpAbove
        LabelSpacing = 3
        TabOrder = 1
        Text = '2'
      end
      object MutEdit: TLabeledEdit
        Left = 16
        Top = 176
        Width = 121
        Height = 21
        EditLabel.Width = 92
        EditLabel.Height = 13
        EditLabel.Caption = 'Mutation Probability'
        LabelPosition = lpAbove
        LabelSpacing = 3
        TabOrder = 2
        Text = '0,1'
      end
      object EpochEdit: TLabeledEdit
        Left = 16
        Top = 224
        Width = 121
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Epochs'
        LabelPosition = lpAbove
        LabelSpacing = 3
        TabOrder = 3
        Text = '10000'
      end
      object CrossEdit: TLabeledEdit
        Left = 16
        Top = 128
        Width = 121
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'Crossover Probability'
        LabelPosition = lpAbove
        LabelSpacing = 3
        TabOrder = 4
        Text = '0,7'
      end
    end
  end
  object LogDir: TEdit
    Left = 24
    Top = 192
    Width = 177
    Height = 21
    TabOrder = 5
    Text = 'Test'
  end
  object MainMenu: TMainMenu
    object MenuFile: TMenuItem
      Caption = 'File'
      object MenuLoad: TMenuItem
        Caption = 'Load Attributes'
        OnClick = MenuLoadClick
      end
      object MenuSave: TMenuItem
        Caption = 'Save Attributes'
        OnClick = MenuSaveClick
      end
      object MenuExit: TMenuItem
        Caption = 'Exit'
        OnClick = MenuExitClick
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Readmetxt1: TMenuItem
        Caption = 'Readme.txt'
        OnClick = Readmetxt1Click
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object SaveDialog: TSaveDialog
    Left = 64
  end
  object OpenDialog: TOpenDialog
    Left = 32
  end
end
