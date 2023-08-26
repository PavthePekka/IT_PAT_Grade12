unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, pngimage, ExtCtrls, ComCtrls,DataValidation_u,User_u,ConnectDB_u;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    tbsSignup: TTabSheet;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image4: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Label3: TLabel;
    Image3: TImage;
    Image5: TImage;
    Image2: TImage;
    edtfirstname: TEdit;
    edtpassword: TEdit;
    edtsurname: TEdit;
    Edit1: TEdit;
    cmbsignup: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    CheckBox1: TCheckBox;
    edtemail: TEdit;
    edtconfpassword: TEdit;
    tbsLogin: TTabSheet;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CheckBox2: TCheckBox;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    edtloginemail: TEdit;
    edtloginpassword: TEdit;
    ComboBox3: TComboBox;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Image21: TImage;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Memo1: TMemo;
    edtdutyname: TEdit;
    edtenddate: TEdit;
    edtstartdate: TEdit;
    edtduration: TEdit;
    v: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    procedure Image1Click(Sender: TObject);
    procedure tbsSignupShow(Sender: TObject);
    procedure edtfirstnameExit(Sender: TObject);
    procedure edtfirstnameEnter(Sender: TObject);
    procedure edtsurnameEnter(Sender: TObject);
    procedure edtsurnameExit(Sender: TObject);
    procedure edtemailEnter(Sender: TObject);
    procedure edtemailExit(Sender: TObject);
    procedure edtpasswordEnter(Sender: TObject);
    procedure edtpasswordExit(Sender: TObject);
    procedure edtconfpasswordExit(Sender: TObject);
    procedure edtconfpasswordEnter(Sender: TObject);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Image9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  objUser : TUser;
  objValidation : TDataValidation;
implementation

{$R *.dfm}

procedure TForm1.edtconfpasswordEnter(Sender: TObject);
begin
 if (edtconfpassword.Text = '* Required Field') or (edtconfpassword.Text = 'Does not match password') then
 begin
   edtconfpassword.Clear;
   edtconfpassword.Font.Color := clBlack;
 end;
end;

procedure TForm1.edtconfpasswordExit(Sender: TObject);
begin
if objValidation.checkNull(edtconfpassword.Text) then
 begin
  edtconfpassword.Text := '* Required Field';
  edtconfpassword.Font.Color := clGrayText
 end;
end;

procedure TForm1.edtemailEnter(Sender: TObject);
begin
 if (edtemail.Text = '* Required Field') or (edtemail.Text = 'Please enter a valid email address')  then
 begin
   edtemail.Clear;
   edtemail.Font.Color := clBlack;
 end;
end;

procedure TForm1.edtemailExit(Sender: TObject);
begin
if objValidation.checkNull(edtemail.Text) then
 begin
  edtemail.Text := '* Required Field';
  edtemail.Font.Color := clGrayText
 end;
end;

procedure TForm1.edtfirstnameEnter(Sender: TObject);
begin
if edtfirstname.Text = '* Required Field'  then
 begin
   edtfirstname.Clear;
   edtfirstname.Font.Color := clBlack;
 end;
end;

procedure TForm1.edtfirstnameExit(Sender: TObject);
begin
if objValidation.checkNull(edtfirstname.Text) then
 begin
  edtfirstname.Text := '* Required Field';
  edtfirstname.Font.Color := clGrayText
 end;
end;

procedure TForm1.edtpasswordEnter(Sender: TObject);
begin
 if edtpassword.Text = '* Required Field'  then
 begin
   edtpassword.Clear;
   edtpassword.Font.Color := clBlack;
 end;
end;

procedure TForm1.edtpasswordExit(Sender: TObject);
begin
 if objValidation.checkNull(edtpassword.Text) then
 begin
  edtpassword.Text := '* Required Field';
  edtpassword.Font.Color := clGrayText
 end;
end;

procedure TForm1.edtsurnameEnter(Sender: TObject);
begin
  if edtsurname.Text = '* Required Field'  then
 begin
   edtsurname.Clear;
   edtsurname.Font.Color := clBlack;

 end;
end;

procedure TForm1.edtsurnameExit(Sender: TObject);
begin
if objValidation.checkNull(edtsurname.Text) then
 begin
  edtsurname.Text := '* Required Field';
  edtsurname.Font.Color := clGrayText
 end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
with objValidation do
  begin
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

            if cmbsignup.Text = 'Teacher' then

              objUser := TUser.Create(edtfirstname.Text, edtsurname.Text,
                edtpassword.Text, edtemail.Text, True)
            else
              objUser := TUser.Create(edtfirstname.Text, edtsurname.Text,
                edtpassword.Text, edtemail.Text, False);
            qryKnights4Nature.Close;
            qryKnights4Nature.SQL.Clear;
            Showmessage(objUser.getPassword + '' + objUser.getEmail);
            qryKnights4Nature.SQL.Text := Format('INSERT INTO tblUsers (FirstName,Surname,UserEmail,UserPassword,RememberMe,isAdmin) VALUES("%s","%s","%s","%s",%s,%s)',[objUser.getFirstname,objUser.getSurname,objUser.getEmail,objUser.getPassword,BoolToStr(objUser.getRememberMe),BoolToStr(objUser.getisAdmin)]);
            qryKnights4Nature.ExecSQL;
            Showmessage('You have signed up successfully!');
            PageControl1.ActivePage := tbsLogin;
            objUser.Free;
          end
          else
          begin
            edtpassword.Text :=
              'Please enter a password containing at least 1 : special character , number and capital letter';
            edtpassword.Font.Color := clGrayText;
            edtpassword.SetFocus;
          end;
        end
        else
        begin
          edtemail.Text := 'Please enter a valid email address';
          edtemail.Font.Color := clGrayText;
          edtemail.SetFocus;
        end;
      end

      else
      begin
        edtconfpassword.Text := 'Does not match password';
        edtconfpassword.Font.Color := clGrayText;
        edtconfpassword.SetFocus;
      end;
    end
    else
      Showmessage('Please fill in all required fields');
  end;

end;

procedure TForm1.Image9Click(Sender: TObject);
var bFound : boolean;
begin
bFound := False;
tblusers.First;

 while tblusers.Eof = False do
    begin
      if (tblusers['UserEmail'] = edtloginemail.Text) and (tblusers['UserPassword'] = edtloginpassword.Text) then
         begin
           bFound := True;
           Showmessage('Logged in sucecssfully!');
           PageControl1.ActivePage := TabSheet1;
           tblusers['RememberMe'] := CheckBox1.Checked;
           try
           objUser := TUSer.Create(tblusers['FirstName'] , tblusers['Surname'] , tblusers['UserPassword'] , tblusers['UserEmail'] , tblusers['isAdmin']);
           except

           end;
           objUser.setRememberMe(tblusers['RememberMe'] );
         end;
         tblusers.Next;


end;
if bFound = False then
  ShowMessage('Login Failed: Please ensure that you have entered a valid email address and password');

end;

procedure TForm1.Label7MouseEnter(Sender: TObject);
begin
Label7.Font.Size := 10;
Label7.Font.Color := clPurple;
end;

procedure TForm1.Label7MouseLeave(Sender: TObject);
begin
Label7.Font.Color := clBlue;
Label7.Font.Size := 9;
end;

procedure TForm1.tbsSignupShow(Sender: TObject);
begin
  objValidation := TDataValidation.Create;
end;

end.
