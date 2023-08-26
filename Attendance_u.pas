unit Attendance_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, Grids, DBGrids,ConnectDB_u, Spin;

type
  TfrmAttendance = class(TForm)
    Image2: TImage;
    Image5: TImage;
    Image6: TImage;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Image1: TImage;
    Image8: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    edtstudentfirstname: TEdit;
    edtstudentsurname: TEdit;
    dbgDuty: TDBGrid;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox1: TComboBox;
    dbgUser: TDBGrid;
    Image9: TImage;
    Image10: TImage;
    Image3: TImage;
    edtSearch: TEdit;
    Image4: TImage;
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure dbgUserCellClick(Column: TColumn);
    procedure dbgDutyCellClick(Column: TColumn);
    procedure Image10Click(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAttendance: TfrmAttendance;

implementation
 uses Home_u;
{$R *.dfm}

procedure TfrmAttendance.dbgDutyCellClick(Column: TColumn);
begin
// When a cell in dbgDuty is clicked, display the selected duty name in ComboBox1
ComboBox1.Text := qryKnights4Nature['DutyName'];
end;

procedure TfrmAttendance.dbgUserCellClick(Column: TColumn);
begin
// When a cell in dbgUser is clicked, populate first name and surname edit boxes
edtstudentfirstname.Text := tblusers['FirstName'];
edtstudentsurname.Text := tblusers['Surname'];
end;

procedure TfrmAttendance.edtSearchChange(Sender: TObject);
begin
// When the search text changes, filter duties based on the search text

qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROM tblDuties WHERE Dutyname LIKE "' + edtSearch.Text + '%"' ;
qryKnights4Nature.Open;

if qryKnights4Nature.RecordCount = 0 then
 begin
   qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROM tblDuties' ;
qryKnights4Nature.Open;

 end;
end;

procedure TfrmAttendance.FormShow(Sender: TObject);
Var i : integer;
begin
// This event occurs when the form is shown
  // Initialize components and populate ComboBox1 with duty names


dbgDuty.DefaultDrawing := True;
dbgDuty.DataSource := dscKnights4Nature;
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT DutyName FROM tblDuties';
qryKnights4Nature.Open;

dbgUser.DataSource := dscUsers;
  // Retrieve duty names from the database and populate ComboBox1
for I := 0 to qryKnights4Nature.RecordCount - 1 do
 begin
 ComboBox1.Items[i] := (qryKnights4Nature['DutyName']);
 qryKnights4Nature.Next;
 end;



end;

procedure TfrmAttendance.Image10Click(Sender: TObject);
begin
frmAttendance.Hide;
frmHome.Show;
end;

procedure TfrmAttendance.Image1Click(Sender: TObject);
var iUserID, iDutyID : integer;

begin
 // When Image1 is clicked, record attendance for the selected user and duty
while tblusers.Eof = False do
begin
begin
if (tblusers['FirstName'] = edtstudentfirstname.Text) and  (tblusers['Surname'] = edtstudentsurname.Text) then
  iUserID := tblusers['UserID'];
end;
tblusers.Next;
end;
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT DutyID from tblDuties WHERE Dutyname =  "' + ComboBox1.Text + '"';
qryKnights4Nature.Open;

iDutyID := qryKnights4Nature['DutyID'];

qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Add('INSERT INTO tblAttendence (UserID,DateOfDuty,IsPresent,DutyID)');
qryKnights4Nature.SQL.Add(' VALUES (' + IntToStr(iUserID) + ' ,#' + DateToStr(Now) + '#,');
qryKnights4Nature.SQL.Add( BoolToStr(CheckBox1.Checked) +',' + IntToStr(iDutyID) + ')' );
qryKnights4Nature.ExecSQL;

qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROm tblDuties ';
qryKnights4Nature.Open;
end;





procedure TfrmAttendance.Image4Click(Sender: TObject);
begin
 // When Image4 is clicked, perform a search for duties based on the search text
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROM tblDuties WHERE Dutyname LIKE "' + edtSearch.Text + '%"' ;
qryKnights4Nature.Open;

if qryKnights4Nature.RecordCount = 0 then
 showmessage('No results match your search')
else
 showmessage(IntToStr(qryKnights4Nature.RecordCount) + ' results found');
end;

procedure TfrmAttendance.Image9Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');
  Application.Terminate;

end;
end;

end.
