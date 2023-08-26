unit ConnectDB_u;

interface

uses
  SysUtils, Classes,ADODB,Db;

type
  TdmKnights4Nature = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmKnights4Nature: TdmKnights4Nature;
  conknights4nature : TADOConnection;
  qryKnights4Nature : TADOQuery;

  tblusers : TADOTable;
  tblAttendence : TADOTABle;
  tblDuties : TADOTAble;
  dscKnights4Nature : TDataSource;
  dscUSers : TDataSource;
implementation

{$R *.dfm}

procedure TdmKnights4Nature.DataModuleCreate(Sender: TObject);
begin
conknights4nature := Tadoconnection.Create(dmKnights4Nature);
conknights4nature.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Knights4Nature.mdb;Mode=ReadWrite;Persist Security Info=False';
conknights4nature.LoginPrompt := False;
conknights4nature.Connected := True;

qryKnights4Nature := TADOQuery.Create(dmKnights4Nature);
qryKnights4Nature.Connection := conknights4nature;

tblusers := TADOTable.Create(dmKnights4Nature);
tblusers.Connection := conknights4nature;
tblusers.TableName := 'tblUsers';
tblusers.Active := True;

tblDuties := TADOTable.Create(dmKnights4Nature);
tblDuties.Connection := conknights4nature;
tblDuties.TableName := 'tblDuties';
tblDuties.Active := True;

tblAttendence := TADOTable.Create(dmKnights4Nature);
tblAttendence.Connection := conknights4nature;
tblAttendence.TableName := 'tblAttendence';
tblAttendence.Active := True;


dscKnights4Nature := TDataSource.Create(dmKnights4Nature);
dscKnights4Nature.Enabled := True;
dscKnights4Nature.DataSet := qryKnights4Nature;

dscUsers := TDataSource.Create(dmKnights4Nature);
dscUsers.Dataset := tblusers;
end;

end.
