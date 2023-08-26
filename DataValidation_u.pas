unit DataValidation_u;

interface
uses sysutils,DB,ADODB,Dialogs;
type
TDataValidation = class
  public
  Function checkNull(sinput : string) : boolean;
  function checkRange(iInput,iStart : integer;sUpDown : string) : boolean;overload;
  function checkrange(iinput,iStart,iEnd : integer) : boolean;overload;
  function checkPassword(sPassword : string) : boolean;
  function checkEmail(semail : string) : boolean;
  Function checkDB(sField,sInput,sTableName,sType : string;query : TADOQUERY) : boolean;
end;
implementation

{ TDataValidation }

function TDataValidation.checkDB(sField, sInput, sTableName,
  sType: string; query : TADOQUERY): boolean;
begin
Result := False;
Showmessage(UPPERCASE(sType));
if UPPERCASE(sType) = 'STRING' then
 begin
 query.Close;
 query.SQL.Clear;
 query.SQL.Text := 'SELECT * FROM ' + sTableName;
 query.Open;
 query.First;
  while query.Eof = false do
    begin
      if query[sfield] =  sinput then
      begin
       Result := True;
       end;
      query.Next;
    end;
 end;


end;

function TDataValidation.checkEmail(semail: string): boolean;
var i,iat,idot : integer;
begin
Result := False;
iat := 0;
idot := 0;

  for I := 1 to Length(semail) do
   begin
    case semail[i] of
      '@' : inc(iat);
      '.' : inc(idot);
    end;
   if (iat > 0) and (idot > 0) then
    Result := True;
   end;
end;


function TDataValidation.checkNull(sinput: string): boolean;
begin
Result := False;
if sinput = '' then
 Result := True
end;

function TDataValidation.checkPassword(sPassword: string): boolean;
var iNumber,iCapital,iSpecial,i : integer;
begin
iNumber := 0;
iCapital := 0;
iSpecial := 0;
Result := False;
for I := 1 to Length(sPassword) do
  begin
    case sPassword[i] of
      'A' .. 'Z' : inc(iCapital);
      '0' .. '9' : inc(iNumber);
      '!','@','#','$','%','&','*'  : inc(iSpecial);
    end;

  if (iNumber > 0) and (iCapital > 0) and (iSpecial > 0) then
    Result := True;
  end;
end;

function TDataValidation.checkRange(iInput, iStart: integer;sUpDown : string): boolean;
begin
Result := False;

 if UPPERCASE(sUpdown) = 'UP' then
 begin
   if iInput > iStart then
     Result := True
 end

 else if UPPERCASE(sUpDown) = 'DOWN' then
 begin
   if iInput < iStart then
     Result := True
 end

 else
 Exception.Create('Please enter either up or down!');



end;

function TDataValidation.checkRange(iInput,iStart, iEnd: integer): boolean;
begin
Result := False;
 if (iInput >= iStart) and (iInput <= iEnd) then
   Result := True

end;

end.
