unit DutyRoster_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, Spin,ConnectDb_u,User_u,
  Grids, DBGrids,Datavalidation_u;

type
  TfrmDutyRoster = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtdutyname: TEdit;
    edtenddate: TEdit;
    edtstartdate: TEdit;
    Image4: TImage;
    dtpEndDate: TDateTimePicker;
    SpinEdit1: TSpinEdit;
    dtpstartdate: TDateTimePicker;
    dbgDutyRoster: TDBGrid;
    Image3: TImage;
    c: TImage;
    edtSearch: TEdit;
    Image9: TImage;
    Image10: TImage;
    procedure Image1Click(Sender: TObject);
    procedure edtenddateExit(Sender: TObject);
    procedure edtstartdateExit(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpEndDateChange(Sender: TObject);
    procedure edtstartdateEnter(Sender: TObject);
    procedure edtenddateEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgDutyRosterCellClick(Column: TColumn);
    procedure Image8Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure cClick(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDutyRoster: TfrmDutyRoster;
  objUser : Tuser;  // A User object
  iDutyID : integer;   // ID of the selected duty
  objValidation : TDataValidation; // Data validation object
implementation
uses Home_u; // Include other units that are used
{$R *.dfm}

procedure TfrmDutyRoster.cClick(Sender: TObject);
begin
 // Handle navigation to the home form
frmDutyRoster.Hide;
frmHome.Show;
end;

procedure TfrmDutyRoster.dbgDutyRosterCellClick(Column: TColumn);
begin
 // Handle cell click in the duty roster grid
edtdutyname.Text := qryKnights4Nature['DutyName'];
edtstartdate.Text := DateToStr(qryKnights4Nature['StartDate']);
edtStartDate.Font.Color := 0;

edtenddate.Text := DateToStr(qryKnights4Nature['EndDate']);
edtenddate.Font.Color := 0;
SpinEdit1.Value := qryKnights4Nature['Duration'];
iDutyID := qryKnights4Nature['DutyID'];
end;

procedure TfrmDutyRoster.dtpEndDateChange(Sender: TObject);
begin
 // Update the end date edit when the DateTimePicker value changes
edtenddate.Font.Color := 0;
edtenddate.Text :=  DateToStr(dtpEndDate.DateTime);
end;

procedure TfrmDutyRoster.dtpstartdateChange(Sender: TObject);
begin
 // Update the start date edit when the DateTimePicker value changes
edtstartdate.Font.Color := 0;
edtstartdate.Text := DateToStr(dtpstartdate.DateTime);
end;

procedure TfrmDutyRoster.edtenddateEnter(Sender: TObject);
begin
  // Handle entering the end date edit

if edtenddate.Text = 'YYYY/MM/DD' then
begin
  edtenddate.Clear;
  edtenddate.Font.Color := clBlack;
end;
end;

procedure TfrmDutyRoster.edtenddateExit(Sender: TObject);
begin
 // Handle exiting the end date edit
if edtenddate.Text = '' then
begin
  edtenddate.Font.Color := clGray;
  edtenddate.Text := 'YYYY/MM/DD'
end;
end;

procedure TfrmDutyRoster.edtSearchChange(Sender: TObject);
begin
// Handle search text change and update the duty roster query
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

procedure TfrmDutyRoster.edtstartdateEnter(Sender: TObject);
begin
// Handle entering the start date edit
if edtstartdate.Text = 'YYYY/MM/DD' then
begin
  edtstartdate.Clear;
  edtstartdate.Font.Color := clBlack;
end;
end;

procedure TfrmDutyRoster.edtstartdateExit(Sender: TObject);
begin
if edtstartdate.Text = '' then
begin
  // Handle exiting the start date edit
  edtstartdate.Font.Color := clGray;
  edtstartdate.Text := 'YYYY/MM/DD'
end;
end;

procedure TfrmDutyRoster.FormShow(Sender: TObject);
begin
 // Handle form show event, initialises database
dbgDutyRoster.DefaultDrawing := True;
dbgDutyRoster.DataSource := dscKnights4Nature;
 qryKnights4Nature.Close;
  qryKnights4Nature.SQL.Clear;
  qryKnights4Nature.SQL.Text := 'SELECT * FROM tblDuties';
  qryKnights4Nature.Open;
edtdutyname.SetFocus;

end;

procedure TfrmDutyRoster.Image10Click(Sender: TObject);
begin
 // Handle click on the search button
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROM tblDuties WHERE Dutyname LIKE "' + edtSearch.Text + '%"' ;
qryKnights4Nature.Open;

if qryKnights4Nature.RecordCount = 0 then
 showmessage('No results match your search')
else
 showmessage(IntToStr(qryKnights4Nature.RecordCount) + ' results found');
end;

procedure TfrmDutyRoster.Image1Click(Sender: TObject);
var sLine : string;
begin
 // Adds Duty to roaster
 qryKnights4Nature.Close;
 qryKnights4Nature.SQL.Clear;
 if objValidation.checkDB('DutyName',edtdutyname.Text,'tblDuties','STRING',qryKnights4Nature) = True then
   begin
    Showmessage('Duty is already in roster');
   end
   else
   begin
 qryKnights4Nature.SQL.Add('Insert Into tblDuties (DutyName,DateAssigned,StartDate,EndDate,Duration)');
 qryKnights4Nature.SQL.Add('VALUES('+ QuotedStr(edtdutyname.Text) + ',' + ',#' + DateToStr(Now) + '#,' +'#' + edtstartdate.Text + '#, #' + edtenddate.Text + '#,');
 qryKnights4Nature.SQL.Add(IntToStr(SpinEdit1.Value) + ')');
 qryKnights4Nature.ExecSQL;
 Showmessage('Duty Added Successfully');
   end;

 qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROm tblDuties';
qryKnights4Nature.Open;

edtdutyname.Clear;
edtstartdate.Clear;
edtenddate.Clear;
SpinEdit1.Clear;
end;

procedure TfrmDutyRoster.Image3Click(Sender: TObject);
begin
// Handle click on the exit button
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');
  Application.Terminate;

end;
end;

procedure TfrmDutyRoster.Image7Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to delete this record',mtConfirmation,mbYesNo,0) = mrYes then
  begin
  // Handle click on the delete duty button
   iDutyID := qryKnights4Nature['DutyID'];
   qryKnights4Nature.Close;
   qryKnights4Nature.SQL.Clear;
   qryKnights4Nature.SQL.Text := 'Delete from tblDuties WHERE DutyID = ' + IntToStr(iDutyID) ;

   qryKnights4Nature.ExecSQL;

    qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROm tblDuties';
qryKnights4Nature.Open;

edtdutyname.Clear;
edtstartdate.Clear;
edtenddate.Clear;
SpinEdit1.Clear;
  end;
end;

procedure TfrmDutyRoster.Image8Click(Sender: TObject);
begin
// Handle click on the update duty button
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Add('UPDATE tblDuties set DutyName = ' + QuotedStr(edtdutyname.Text) + ',');
qryKnights4Nature.SQL.Add('StartDate = #' + edtstartdate.Text + '#,' + 'EndDate = #' + edtenddate.Text + '#,');
qryKnights4Nature.SQL.Add('Duration = ' + IntTOStr(SpinEdit1.Value) + ' WHERE DutyID = ' + IntToStr(iDutyID));
qryKnights4Nature.ExecSql;

Showmessage('Duty updated successfully!');
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROm tblDuties';
qryKnights4Nature.Open;

edtdutyname.Clear;
edtstartdate.Clear;
edtenddate.Clear;
SpinEdit1.Clear;
end;

end.
