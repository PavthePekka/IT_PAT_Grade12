unit Student_u;

interface
uses Sysutils, Person_u;
type
TStudent = class(TPerson) // Other Child of Person base class
private
fHours : integer; // refers to hours students spend on duty
EHoursException : Exception;
procedure setHours(iHours : integer);
public
Constructor Create(sFirstname,sSurname : string; iHours : integer);
property Hours : integer read fHours write setHours;
Function toString : string; // summarises characteristsics of student
function CalcAwards : string;
end;
implementation

{ TStudent }

function TStudent.CalcAwards: string;
begin                            // calculation method - uses number of hours worked to
                                  // determine rewards earned
if (fHours < 10) then
  Result := 'No Award'
else if (fHours >= 10) and (fHours < 20) then
  Result := 'Scroll Award'
else if (fHours >= 20) and (fHours < 50) then
  Result := 'Half-Colours Award'
else if (fHours >= 50) and (fHours < 100) then
  Result := 'Full-Colours Award'
else
  Result := 'White Blazer Award'
end;

constructor TStudent.Create(sFirstName,sSurname : string;iHours: integer);
begin
Inherited Create(sFirstName,sSurname); // inherites Create method from base class,
fHours := iHours;                       // allows inherited attributes to be instantiated through base class
EHoursException := Exception.Create('Hours must be greater than 0');
end;

procedure TStudent.setHours(iHours: integer);
begin
if iHours > 0 then
fHours := iHours
else

end;

function TStudent.toString: string;
begin
 Result := 'Name: ' + getFirstname + ' ' + getSurname + #13 + 'Hours worked: ' + IntToStr(Hours) + #13 + 'Awards Earned: ' + CalcAwards;

end;

end.
