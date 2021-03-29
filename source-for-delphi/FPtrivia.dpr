program FPtrivia;

uses
  Forms,
  guiunit in 'guiunit.pas' {guiForm},
  errorunit in 'errorunit.pas' {errorForm},
  initunit in 'initunit.pas' {initForm},
  serveunit in 'serveunit.pas',
  apiunit in 'apiunit.pas',
  vmunit in 'vmunit.pas',
  actunit in 'actunit.pas',
  primunit in 'primunit.pas',
  combiunit in 'combiunit.pas',
  boolunit in 'boolunit.pas',
  mathunit in 'mathunit.pas',
  stringunit in 'stringunit.pas',
  sequnit in 'sequnit.pas',
  typeunit in 'typeunit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TguiForm, guiForm);
  Application.CreateForm(TerrorForm, errorForm);
  Application.CreateForm(TinitForm, initForm);
  Application.Run;
end.


// (CC-BY-3.0) Fpstefan
