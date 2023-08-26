unit dmITPAT_u;

interface

uses
  SysUtils, Classes,ADODB,Db;

type
  TdmITPAT = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmITPAT: TdmITPAT;
  conPAT : TADOConnection;
  qryPAT : TADOQuery;
  dscPAT : TDataSource;
  tblPAT : TADOTABLE;
implementation

{$R *.dfm}

procedure TdmITPAT.DataModuleCreate(Sender: TObject);
begin
conPAT := TADOConnection.Create(dmITPAT);
conPAT.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Knights4Nwd.mdb;Mode=ReadWrite;Persist Security Info=False';
conPAT.Connected := true;

qryPAT := TADOQuery.Create(dmITPAT);
qryPAT.Connection := conPAT;
qryPAT.Active := True;
end;

end.
