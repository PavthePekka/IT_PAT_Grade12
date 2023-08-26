unit StudentProfile_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls,Student_u,ConnectDB_u, ComCtrls;

type
  TfrmStudentProfile = class(TForm)
    Label2: TLabel;
    Image1: TImage;
    Image7: TImage;
    Image8: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Image2: TImage;
    RichEdit1: TRichEdit;
    Image3: TImage;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStudentProfile: TfrmStudentProfile;
  objStudent : TStudent;
  tUserfile : textfile;
implementation

{$R *.dfm}

procedure TfrmStudentProfile.FormShow(Sender: TObject);
var sLine : string;
begin
AssignFile(tUserfile,'User.txt');
Reset(tUserfile);
Readln(tUserfile,sLine);
while tblusers.Eof = False do
 begin
   if tblusers['UserID'] = Copy(sLine,Pos('#',sline) + 1,length(sLine)) then
     Label2.Caption := 'WELCOME ' + tblusers['Firstname'] + ' ' + tblusers['Surname'] + ' !';
     tblusers.Next;
 end;

end;

procedure TfrmStudentProfile.Image1Click(Sender: TObject);

var iHours : integer;

sLine : string;
begin
AssignFile(tUserfile,'User.txt');
Reset(tUserfile);
iHours := 0;
tblAttendence.First;
Readln(tUserfile,sLine);
     while tblAttendence.Eof = False do
      begin
        if  tblAttendence['UserID'] = Copy(sLine,Pos('#',sline) + 1,length(sLine)) then
          begin
          tblDuties.First;
            while tblDuties.Eof = False do
              begin
                if (tblAttendence['DutyID'] = tblDuties['DutyID']) and (tblAttendence['isPresent'] = True)  then
                   begin
                   iHours := iHours + tblDuties['Duration'] ;
                   end;
                tblDuties.Next;
              end;

          end;
            tblAttendence.Next;
      end;

     tblusers.First;
   while tblusers.Eof = False do
    begin
    if Copy(sLine,Pos('#',sline) + 1,length(sLine)) = tblusers['UserID'] then
      begin

   objStudent := tStudent.Create(tblusers['FirstName'],tblusers['Surname'],iHours);
   RichEdit1.Text := objStudent.toString;
      end;
      tblusers.Next
    end;
end;

procedure TfrmStudentProfile.Image3Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');
  Application.Terminate;

end;
end;

end.
