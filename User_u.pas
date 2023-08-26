unit User_u;

interface
uses Person_u;
  type
  TUser = class(TPerson)  // child class of TParent
    private
    fpassword,femail : string; //attributes pertaining to users of the program
    frememberme,fisadmin : boolean;
    public
    Constructor Create(sfirstname,ssurname,spassword,semail : string; bisadmin : boolean);
    Function getPassword : string;  //getter
    Function getEmail : string;
    Function getRememberMe : boolean;
    Function getisAdmin : boolean;    // setter , allows admin status to be chnages
    procedure setPassword(spassword : string);
    procedure setRememberMe(bRememberMe : boolean);
  end;

implementation

{ TUser }

constructor TUser.Create(sfirstname,ssurname,spassword, semail: string;
  bisadmin: boolean);
begin
  Inherited Create(sfirstname,ssurname);   // inherites Create method from base class,
  fpassword := spassword;                  // allows inherited attributes to be instantiated through base class
  femail := semail;
  fisAdmin := bisadmin;
  frememberme := False;
end;


function TUser.getEmail: string;
begin
 Result := femail;
end;

function TUser.getisAdmin: boolean;
begin
 Result := fisadmin;
end;

function TUser.getPassword: string;
begin
 Result := fpassword;
end;

function TUser.getRememberMe: boolean;
begin
 Result := frememberme;
end;

procedure TUser.setPassword(spassword: string);
begin
 fpassword := spassword;
end;

procedure TUser.setRememberMe(bRememberMe: boolean);
begin
frememberme := bRememberMe;
end;

end.
