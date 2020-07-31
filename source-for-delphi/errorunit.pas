unit errorunit;

interface

uses Windows,Messages,SysUtils,Variants,
     Classes,Graphics,
     Controls,Forms,Dialogs,StdCtrls,Vcl.Imaging.pngimage,
     ExtCtrls,
     typeunit;//ustring;

    {Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
     System.Classes, Vcl.Graphics,
     Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
     Vcl.ExtCtrls}

type //
     re_type = (re_none);
  TerrorForm = class(TForm)
    errPanel: TPanel;
    Bevel1: TBevel;
    buttonPanel: TPanel;
    okButton: TButton;
    errImage: TImage;
    errMemo: TMemo;
    procedure okButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    result: re_type;
    function re_showerror(s: ustring): re_type;
    { Public-Deklarationen }
  end;

var
  errorForm: TerrorForm;

implementation

{$R *.dfm}

function TerrorForm.re_showerror(s: ustring): re_type;
begin result:=re_none;//?...
      show;
      errmemo.SetFocus;
      errmemo.lines.append(s);
      okButton.SetFocus;
      //show//modal;
      //
end;

procedure TerrorForm.okButtonClick(Sender: TObject);
begin errorForm.hide//modal?
end;

end.


// (c) 2020 Fpstefan
