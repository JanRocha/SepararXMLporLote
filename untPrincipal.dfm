object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 8
    Top = 272
    Width = 126
    Height = 19
    Caption = 'Caminho do XML:'
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 257
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 140
    Top = 269
    Width = 376
    Height = 27
    TabOrder = 1
  end
  object Button1: TButton
    Left = 522
    Top = 269
    Width = 32
    Height = 27
    Caption = '...'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 560
    Top = 269
    Width = 75
    Height = 27
    Caption = 'Processar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 312
    Top = 112
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 288
    Top = 184
  end
end
