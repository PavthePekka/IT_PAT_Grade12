unit Login_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, pngimage, ExtCtrls,ConnectDB_u,DutyRoster_u,User_u;

type
  TfrmLogin = class(TForm)
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Image1: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label4: TLabel;
    edtloginemail: TEdit;
    Image3: TImage;
    edtloginpassword: TEdit;
    Image2: TImage;
    Label2: TLabel;
    Image4: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure ForgotClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  objUser : TUser;  // A User object
  lblerror : tLabel; // Label to show error messages
  btnforgot : TButton; // Button for password recovery
implementation
  uses Signup_u,Home_u,StudentProfile_u;
{$R *.dfm}

procedure TfrmLogin.ForgotClick(Sender: TObject);
var sEmail,sPassword,sconfpassword : string;
begin
// Logic for handling forgotten password process
lblerror.Visible := False;
 sEmail := InputBOx('Email','Enter your email address','');
 sPassword := InputBox('Password','Enter your password','');
 sconfpassword := InputBox('Confirm Password','Confirm your password','');

 qryKnights4Nature.Close;
 qryKnights4Nature.SQL.Clear;
 qryKnights4Nature.SQL.Text := 'SELECT * FROM tblUsers WHERE UserEmail = '  + QuotedStr(semail);
 qryKnights4Nature.Open;
 if qryKnights4Nature.RecordCount < 0  then
  begin
   showmessage('Invalid email address');
  end
  else if sPassword <> sConfpassword then
begin
   Showmessage('Confirmation password does not match password');
end
else
begin
while qryKnights4Nature.Eof = False do
 begin
   if (qryKnights4Nature['UserEmail'] = sEmail)  then
   begin
     qryKnights4Nature.Edit;
     qryKnights4Nature['UserEmail'] := sEmail;
     Showmessage('Youre password has been changed !');
   end;
   qryKnights4Nature.Next;
 end;
end;
end;



procedure TfrmLogin.Image1Click(Sender: TObject);
var bFound : boolean;
tUserfile : TextFile;
begin
 // Logic for handling login process
bFound := False;
tblusers.First;
 while tblusers.Eof = False do
    begin
      if (tblusers['UserEmail'] = edtloginemail.Text) and (tblusers['UserPassword'] = edtloginpassword.Text) then
         begin
           bFound := True;
           Showmessage('Logged in sucecssfully!');
           tblusers.Edit;
           tblusers['RememberMe'] := CheckBox1.Checked;

           objUser := TUSer.Create(tblusers['FirstName'] , tblusers['Surname'] , tblusers['UserPassword'] , tblusers['UserEmail'] , tblusers['isAdmin']);
           if objUser.getisAdmin = True then
             begin
           frmHome.Show;
           frmLogin.Hide;
             end
           else
           begin
           frmStudentProfile.Show;
           frmLogin.Hide;
           end;
           objUser.setRememberMe(tblusers['RememberMe'] );

           AssignFile(tUserfile,'IT PAT 2023/User.txt');
           Rewrite(tUserfile);
           Writeln(tUserfile,'UserID#' + IntTostr(tblusers['UserID']));
           Writeln(tUserfile,'FirstName#' + objUser.getFirstname);
           Writeln(tUserfile,'Surname#' + objUser.getSurname);
           Writeln(tUserfile,'Password#' + objUser.getPassword);
           Writeln(tUserfile,'Email#' + objUser.getEmail);
           Writeln(tUserfile,'isAdmin#' + Booltostr(objUser.getisAdmin),True);
           Writeln(tUserfile,'RememberMe#' + BoolToStr(objUser.getRememberMe),True);
           CloseFile(tUserfile);

         end;
         tblusers.Next;


end;
if bFound = False then
  begin
    lblerror := TLabel.Create(frmLogin);
    lblerror.Parent := frmLogin;
    lblerror.Left := edtloginpassword.Left;
    lblerror.Top := edtloginpassword.Top + 40;
    lblerror.Transparent := false;
    lblerror.Color := clBlack;
    lblerror.Font.Color := clWhite;
    lblerror.Font.Size := 9;
    lblerror.Caption := 'Username of password invalid, please click the button below if you have forgotton your password';

    btnforgot := TButton.Create(frmLogin);
    btnforgot.Parent := frmLogin;
    btnforgot.Left := edtloginpassword.Left;
    btnforgot.Top := edtloginpassword.Top + 75;
    btnforgot.Caption := 'Forgot Password';
    btnforgot.Width := 100;
    btnforgot.Height := 40;
    btnforgot.OnClick := Forgotclick;
  end;
end;

procedure TfrmLogin.Image3Click(Sender: TObject);

begin
 // Logic for handling application termination
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');
  Application.Terminate;

end;
end;





procedure TfrmLogin.Label4Click(Sender: TObject);
begin
// Logic for opening the sign-up form
  frmSignup.Show;
  frmLogin.Hide;
end;

procedure TfrmLogin.Label4MouseEnter(Sender: TObject);
begin
// Change label appearance on mouse enter
Label4.Font.Size := 10;
Label4.Font.Color := clPurple;
end;

procedure TfrmLogin.Label4MouseLeave(Sender: TObject);
begin
// Change label appearance on mouse leave
Label4.Font.Color := clBlue;
Label4.Font.Size := 9;
end;

end.
