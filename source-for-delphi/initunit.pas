unit initunit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TinitForm = class(TForm)
    questlabel: TLabel;
    celledit: TEdit;
    okbutton: TButton;
    cancelbutton: TButton;
    infopanel: TPanel;
    infobevel: TBevel;
    infoimage: TImage;
    infolabel1: TLabel;
    infolabel2: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  initForm: TinitForm;

implementation

{$R *.dfm}

end.


// (CC-BY-3.0) Fpstefan
