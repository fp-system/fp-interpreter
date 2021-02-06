object initForm: TinitForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = ' Initialization...'
  ClientHeight = 272
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object questlabel: TLabel
    Left = 32
    Top = 24
    Width = 141
    Height = 18
    Caption = 'Number of triple cells:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object infobevel: TBevel
    Left = 0
    Top = 179
    Width = 388
    Height = 3
    Align = alBottom
    ExplicitTop = 206
    ExplicitWidth = 503
  end
  object celledit: TEdit
    Left = 32
    Top = 49
    Width = 304
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'celledit'
  end
  object okbutton: TButton
    Left = 32
    Top = 104
    Width = 81
    Height = 33
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object cancelbutton: TButton
    Left = 128
    Top = 104
    Width = 81
    Height = 33
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object infopanel: TPanel
    Left = 0
    Top = 182
    Width = 388
    Height = 90
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 191
    object infoimage: TImage
      Left = 32
      Top = 24
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
        00200806000000737A7AF4000000097048597300000B1300000B1301009A9C18
        000002314944415478DAD597BB4E0241148667E3FDD26843039D35346A020F80
        BE00242662ECADD86847698781CADE808909BC80F20090A80DD476D2D068E3FD
        123C67D8DD9CDD9D9D59C8EE1AFE666659C27C3BF3FFE72C1AFB6769530B90DC
        DCCEC150312EF5DEFD6D333200583C0EC3A3E3E30440F4A30268C0902BEC7CF3
        EBFACD1C0E4D00C8870E008BA76168C7D687AC5E7AE39F154E97D9E089FF5406
        203A6103B461481FEF7D32BA0367570B38ED004026340058BC0843059FBE5579
        B5DDCBEA2BE62EA021AB6101A0F1E2F5D23B4B6EFCDAEEF51E66E0289670DA07
        8044E000B03846AE880B238048088020A02A40E88101D0D8E1D6E3110C9E3556
        BB9EE7F70F76BF586C6DC88F008FC290AF58FA05E0C643D3A1F9F8A2F0B4DDD1
        D3B214EC4ACDD81534A3114B5F8654021815AFE1345EEA70D5F6BDEEC58B3527
        86CCAB2AA41F006EBCF2D107CB6EFDF80268DDCDB293F3459C2A0D2905306327
        329E0C00450C298DA52700359E28762A00124B94A72165003C76D478E300A088
        213D63290430EB3DCECDD84D02E088A5B04F7801B8EAFD240028559F7001C8EA
        FD240028599FB00118C6C36D12D67BAA323CD5E5E87CD93EECD289C027A6689F
        C09DA586740270E361DE31F72AD14AA812D605AC0FCC61480B4054EF8304F0EA
        1314C055EF651AE7084C89FA84662C6EBD66C98C47358E09A98821792C4D005E
        EF65B173CAAB1BAA4462C9FB8426ABF73289DE07FC8AF6094DF69A1596682C2D
        804856768B03987FB1A286C018EAD3FBE73428FD013141551CDBA8E304000000
        0049454E44AE426082}
    end
    object infolabel1: TLabel
      Left = 80
      Top = 23
      Width = 256
      Height = 16
      Caption = 'Please note that a change will only be made '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object infolabel2: TLabel
      Left = 80
      Top = 39
      Width = 179
      Height = 16
      Caption = 'when the program is restarted.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
end
