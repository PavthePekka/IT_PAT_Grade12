program ShapeApp_p;

uses
  Forms,
  ShapeApp_u in 'ShapeApp_u.pas' {frmWelcome},
  Login_u in 'Login_u.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
