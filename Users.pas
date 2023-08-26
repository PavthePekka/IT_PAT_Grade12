unit Users;

interface
type
TUser = class
 private
  ffirstname,fsurname,femail,fpassword : string;
  fisAdmin : boolean;
  public
  Constructor Create(sfirstname, ssurname, semail, spassword: string);
  Function getEmail : string;
  Function getPasword : string;
  Procedure setAdmin(bisAdmin : boolean);

end;
implementation

{ TUser }

constructor TUser.Create(sfirstname, ssurname, semail, spassword: string);
begin
  sfirstname := ffirstname;
  ssurname := fsurname;
  semail := femail;
  spassword := fpassword;
  fisAdmin := True;
end;

function TUser.getEmail: string;
begin
  Result := fEmail;
end;

function TUser.getPasword: string;
begin
Result := fpassword;
end;

procedure TUser.setAdmin(bisAdmin: boolean);
begin
  fisAdmin := bisAdmin;
end;

end.
