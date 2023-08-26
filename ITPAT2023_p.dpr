program ITPAT2023_p;

uses
  Forms,
  Signup_u in 'Signup_u.pas' {frmSignup},
  StudentInfo_u in 'StudentInfo_u.pas' {frmStudentInfo},
  DutyRoster_u in 'DutyRoster_u.pas' {frmDutyRoster},
  Attendance_u in 'Attendance_u.pas' {frmAttendance},
  StudentProfile_u in 'StudentProfile_u.pas' {frmStudentProfile},
  Login_u in 'Login_u.pas' {frmLogin},
  ConnectDB_u in 'ConnectDB_u.pas' {dmKnights4Nature: TDataModule},
  Person_u in 'Person_u.pas',
  User_u in 'User_u.pas',
  DataValidation_u in 'DataValidation_u.pas',
  Student_u in 'Student_u.pas',
  Analytics_u in 'Analytics_u.pas' {frmAnalytics},
  ShapeApp_u in 'ShapeApp\ShapeApp_u.pas' {frmWelcome},
  CaptchaTest_u in 'CaptchaTest_u.pas' {frmCaptchaTest},
  Home_u in 'Home_u.pas' {frmHome};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmStudentInfo, frmStudentInfo);
  Application.CreateForm(TfrmSignup, frmSignup);
  Application.CreateForm(TfrmAnalytics, frmAnalytics);
  Application.CreateForm(TfrmCaptchaTest, frmCaptchaTest);
  Application.CreateForm(TfrmStudentProfile, frmStudentProfile);
  Application.CreateForm(TfrmDutyRoster, frmDutyRoster);
  Application.CreateForm(TfrmAttendance, frmAttendance);
  Application.CreateForm(TdmKnights4Nature, dmKnights4Nature);
  Application.Run;
end.
