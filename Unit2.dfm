object Form2: TForm2
  Left = 0
  Top = 0
  Width = 428
  Height = 589
  AutoScroll = True
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object LabelMinions: TLabel
    Left = 16
    Top = 106
    Width = 71
    Height = 13
    Caption = 'Minion in shop:'
  end
  object LabelProgress: TLabel
    Left = 16
    Top = 125
    Width = 87
    Height = 13
    Caption = 'Current in basket:'
  end
  object LabelMinionsCount: TLabel
    Left = 16
    Top = 32
    Width = 34
    Height = 13
    Caption = 'Minion:'
  end
  object LabelBasketCapacity: TLabel
    Left = 16
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Capacity:'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 520
    Width = 410
    Height = 22
    Panels = <>
    SimplePanel = True
  end
  object ButtonStartShopping: TButton
    Left = 8
    Top = 179
    Width = 376
    Height = 25
    Caption = 'Shop!'
    TabOrder = 0
    OnClick = ButtonStartShoppingClick
  end
  object EditMinionsCount: TEdit
    Left = 240
    Top = 32
    Width = 64
    Height = 21
    TabOrder = 1
    Text = '5'
  end
  object EditBasketCapacity: TEdit
    Left = 240
    Top = 56
    Width = 64
    Height = 21
    TabOrder = 2
    Text = '100'
  end
  object ProgressBarCart: TProgressBar
    Left = 8
    Top = 156
    Width = 376
    Height = 17
    Smooth = True
    Step = 1
    TabOrder = 3
  end
end
