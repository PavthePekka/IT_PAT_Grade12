unit Person_u;

interface
type
TPerson = class //base  class
  private
  ffirstname,fsurname : string;
  public
  Constructor Create;overload;
  Constructor Create(sfirstname,ssurname : string);overload;  // Overloaded methods
  Function getFirstname : string;                             // display polymorphism
  Function getSurname : string;


end;
implementation


{ TPerson }



constructor TPerson.Create;
begin
 Inherited ;  // from TObject

end;

constructor TPerson.Create(sfirstname, ssurname: string);
begin
Inherited Create;
fFirstName := sFirstname;
fSurname := sSurname;
end;

function TPerson.getFirstname: string;
begin
  Result := ffirstname; // Getter method - Returns first name
end;


function TPerson.getSurname: string;
begin
  Result := fsurname; // Getter method - Returns surname
end;

end.
