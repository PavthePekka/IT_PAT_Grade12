unit Signup_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, jpeg,User_u,ConnectDB_u,DataValidation_u,Login_u;
type
  TfrmSignup = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Image3: TImage;
    Edit3: TEdit;
    Image4: TImage;
    Edit4: TEdit;
    Image5: TImage;
    Edit5: TEdit;
    Image6: TImage;
    Image7: TImage;
    Label3: TLabel;
    Edit6: TEdit;
    CheckBox1: TCheckBox;
    edtfirstname: TEdit;
    edtsurname: TEdit;
    edtemail: TEdit;
    edtpassword: TEdit;
    edtconfpassword: TEdit;
    ComboBox1: TComboBox;
    Image9: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure edtfirstnameEnter(Sender: TObject);
    procedure edtfirstnameExit(Sender: TObject);
    procedure edtpasswordExit(Sender: TObject);
    procedure edtpasswordEnter(Sender: TObject);
    procedure edtsurnameEnter(Sender: TObject);
    procedure edtsurnameExit(Sender: TObject);
    procedure edtconfpasswordEnter(Sender: TObject);
    procedure edtconfpasswordExit(Sender: TObject);
    procedure edtemailEnter(Sender: TObject);
    procedure edtemailExit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignup: TfrmSignup;
  objUser : TUser; // Instance of the user class
  objValidation : TDatavalidation;  // Object for data validation
implementation
 uses CaptchaTest_u;  // Include other units that are used
{$R *.dfm}

procedure TfrmSignup.CheckBox1Click(Sender: TObject);    // Display captcha test form upon checkbox click
begin
frmSignup.Visible := False;
frmCaptchaTest.Show;
end;

procedure TfrmSignup.edtconfpasswordEnter(Sender: TObject);
begin
  // Clear the confirmation password edit if it displays default text
if (edtconfpassword.Text = '* Required Field') or (edtconfpassword.Text = 'Does not match password') then
 begin
   edtconfpassword.Clear;
   edtconfpassword.Font.Color := clBlack;
 end;
end;

procedure TfrmSignup.edtconfpasswordExit(Sender: TObject);
begin
// Validate and handle exiting the confirmation password edit
if objValidation.checkNull(edtconfpassword.Text) then
 begin
  edtconfpassword.Text := '* Required Field';
  edtconfpassword.Font.Color := clGrayText
 end;
end;

procedure TfrmSignup.edtemailEnter(Sender: TObject);
begin
// Clear the email edit if it displays default text
if (edtemail.Text = '* Required Field') or (edtemail.Text = 'Please enter a valid email address')  then
 begin
   edtemail.Clear;
   edtemail.Font.Color := clBlack;
 end;
end;

procedure TfrmSignup.edtemailExit(Sender: TObject);
begin
 // Validate and handle exiting the email edit
if objValidation.checkNull(edtemail.Text) then
 begin
  edtemail.Text := '* Required Field';
  edtemail.Font.Color := clGrayText
 end;
end;

procedure TfrmSignup.edtfirstnameEnter(Sender: TObject);
begin
// Clear the first name edit if it displays default text
if edtfirstname.Text = '* Required Field'  then
 begin
   edtfirstname.Clear;
   edtfirstname.Font.Color := clBlack;
 end;
end;

procedure TfrmSignup.edtfirstnameExit(Sender: TObject);
begin
 // Validate and handle exiting the first name edit
if objValidation.checkNull(edtfirstname.Text) then
 begin
  edtfirstname.Text := '* Required Field';
  edtfirstname.Font.Color := clGrayText
 end;
end;

procedure TfrmSignup.edtpasswordEnter(Sender: TObject);
begin
 // Clear the password edit if it displays default text
if edtpassword.Text = '* Required Field'  then
 begin
   edtpassword.Clear;
   edtpassword.Font.Color := clBlack;
 end;
end;

procedure TfrmSignup.edtpasswordExit(Sender: TObject);
begin
 // Validate and handle exiting the password edit
 if objValidation.checkNull(edtpassword.Text) then
 begin
  edtpassword.Text := '* Required Field';
  edtpassword.Font.Color := clGrayText
 end;
end;

procedure TfrmSignup.edtsurnameEnter(Sender: TObject);
begin
if edtsurname.Text = '* Required Field'  then
 begin
 // Clear the surname edit if it displays default text
   edtsurname.Clear;
   edtsurname.Font.Color := clBlack;

 end;
end;

procedure TfrmSignup.edtsurnameExit(Sender: TObject);
begin
  // Validate and handle exiting the surname edit
if objValidation.checkNull(edtsurname.Text) then
 begin
  edtsurname.Text := '* Required Field';
  edtsurname.Font.Color := clGrayText
 end;
end;

procedure TfrmSignup.FormCreate(Sender: TObject);
begin
 // Initialize data validation object when the form is created
objValidation := TDataValidation.Create;
end;

procedure TfrmSignup.Image1Click(Sender: TObject);
begin
with objValidation do
  begin
   // Validate and handle user signup process
    if (checkNull(edtfirstname.Text) = False) and
      (checkNull(edtsurname.Text) = False) and
      (checkNull(edtemail.Text) = False) and
      (checkNull(edtpassword.Text) = False) and
      (checkNull(edtconfpassword.Text) = False) then
    begin
      if edtpassword.Text = edtconfpassword.Text then
      begin
        if checkEmail(edtemail.Text) then
        begin
          if checkPassword(edtpassword.Text) then
          begin

            if ComboBox1.Text = 'Teacher' then

              objUser := TUser.Create(edtfirstname.Text, edtsurname.Text,
                edtpassword.Text, edtemail.Text, True)
            else
              objUser := TUser.Create(edtfirstname.Text, edtsurname.Text,
                edtpassword.Text, edtemail.Text, False);
            qryKnights4Nature.Close;

            if objValidation.checkDB('UserEmail', objUser.getEmail,'tblUsers','STRING',qryKnights4Nature) = False then
             begin
            qryKnights4Nature.SQL.Clear;

            qryKnights4Nature.SQL.Text := Format('INSERT INTO tblUsers (FirstName,Surname,UserEmail,UserPassword,RememberMe,isAdmin) VALUES("%s","%s","%s","%s",%s,%s)',[objUser.getFirstname,objUser.getSurname,objUser.getEmail,objUser.getPassword,BoolToStr(objUser.getRememberMe),BoolToStr(objUser.getisAdmin)]);
            qryKnights4Nature.ExecSQL;
            Showmessage('You have signed up successfully!');
            frmLogin.Show;
            frmSignup.Hide;
            objUser.Free;
            end
           else
            begin
              if MessageDlg('This email is already in use, would you like to log in instead?',mtConfirmation,mbYesNo,0) = mrYes then
                begin
                frmLogin.Show ;
                frmSignup.Hide;
                end;
            end;
          end
          else
          begin
           edtpassword.Font.Color := clGrayText;
            edtpassword.Text :=
              'Please enter a password containing at least 1 : special character , number and capital letter';


          end;
        end
        else
        begin
         edtemail.Font.Color := clGrayText;
          edtemail.Text := 'Please enter a valid email address';


        end;
      end

      else
      begin
        edtconfpassword.Text := 'Does not match password';
        edtconfpassword.Font.Color := clGrayText;

      end;
    end
    else
      Showmessage('Please fill in all required fields');
  end;

end;

procedure TfrmSignup.Image9Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');  // Handle application exit upon clicking the "Exit" button
  Application.Terminate;

end;
end;
end.
