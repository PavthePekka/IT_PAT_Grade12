unit StudentInfo_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, Grids, DBGrids,ConnectDb_u;

type
  TfrmStudentInfo = class(TForm)
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Image5: TImage;
    Image6: TImage;
    Image8: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Image3: TImage;
    Edit2: TEdit;
    Image4: TImage;
    Image2: TImage;
    Label4: TLabel;
    edtfirstname: TEdit;
    edtSurname: TEdit;
    edtemailaddress: TEdit;
    edtpassword: TEdit;
    DBGrid2: TDBGrid;
    Image9: TImage;
    Image10: TImage;
    edtSearch: TEdit;
    Image11: TImage;
    Image12: TImage;
    procedure FormShow(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure Image1Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure Image11Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStudentInfo: TfrmStudentInfo;
  iUserID : integer;
implementation
uses Home_u;
{$R *.dfm}



procedure TfrmStudentInfo.DBGrid2CellClick(Column: TColumn);
begin
edtfirstname.Text := qryKnights4Nature['FirstName'];
edtsurname.Text := qryKnights4Nature['SurName'];
edtemailaddress.Text := qryKnights4Nature['UserEmail'];
edtpassword.Text := qryKnights4Nature['UserPassword'];
iUserID := qryKnights4Nature['UserID'];
end;

procedure TfrmStudentInfo.edtSearchChange(Sender: TObject);
begin
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROM tblUsers WHERE (isAdmin = False) AND (FirstName LIKE "' + edtSearch.Text + '%")' ;
qryKnights4Nature.Open;

if qryKnights4Nature.RecordCount = 0 then
 begin
   qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROM tblUsers WHERE isAdmin = False' ;
qryKnights4Nature.Open;

 end;
end;

procedure TfrmStudentInfo.FormShow(Sender: TObject);
begin
DBGrid2.DataSource := dscKnights4Nature;
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.Sql.Text := 'SELECT * FROM tblUsers WHERE isAdmin = False' ;
qryKnights4Nature.Open;
end;

procedure TfrmStudentInfo.Image10Click(Sender: TObject);
begin
frmStudentInfo.Hide;
frmHome.Show;
end;

procedure TfrmStudentInfo.Image11Click(Sender: TObject);
begin
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROM tblUsers WHERE (isAdmin = False) AND (FirstName LIKE "' + edtSearch.Text + '%")' ;
qryKnights4Nature.Open;

if qryKnights4Nature.RecordCount = 0 then
 showmessage('No results match your search')
else
 showmessage(IntToStr(qryKnights4Nature.RecordCount) + ' results found');
end;

procedure TfrmStudentInfo.Image1Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to delete this record',mtConfirmation,mbYesNo,0) = mrYes then
 begin
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'DELETE FROM tblUsers WHERE [UserID] = ' + IntToStr(iUserID) ;
qryKnights4Nature.Execsql;
Showmessage('Student deleted successfully!');
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FroM tblUsers WHERE isAdmin = False';
qryKnights4Nature.Open;
 end;
end;

procedure TfrmStudentInfo.Image8Click(Sender: TObject);

begin
qryKnights4Nature.Close;

qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Add('UPDATE tblUsers set FirstName = ' + QuotedStr(edtfirstname.Text) + ',');
qryKnights4Nature.SQL.Add('Surname= "' + edtsurname.Text + '",' + 'UserEmail = "' + edtemailaddress.Text + '",');
qryKnights4Nature.SQL.Add('UserPassword = "' + edtpassword.Text + '" WHERE USERID = ' + IntToStr(iUSerID) );
qryKnights4Nature.ExecSql;

Showmessage('Student updated successfully!');
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT * FROm tblUsers';
qryKnights4Nature.Open;

edtfirstname.Clear;
edtSurname.Clear;
edtemailaddress.Clear;
edtpassword.Clear;
end;

procedure TfrmStudentInfo.Image9Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');
  Application.Terminate;

end;
end;

end.
