unit ShapeApp_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, pngimage, jpeg,Login_u;

type
  TfrmWelcome = class(TForm)
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Timer1: TTimer;
    Label4: TLabel;
    Shape12: TShape;
    procedure FormCreate(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 // Declare GLOBAL variables here
  frmWelcome: TfrmWelcome;
  i : integer = 1;
  j : integer = 1;
  sParagraph : string;
  sLine : string =' "The truth is : The natural world is' + #13 +'   changing and we are totally dependant' + #13 + '   on that world. It provides our food, water' +  #13 + '   and air. It is the most precious thing we' + #13 +'   have and we need to defend it" ' + #13 +'   -David Attenborough';

implementation
uses Home_u,StudentProfile_u;  // Include other units that are used (Home_u, StudentProfile_u, etc.)
{$R *.dfm}

procedure TfrmWelcome.FormCreate(Sender: TObject);
begin
  // Initialize form components and settings here
shape1.Pen.Width := 5;
Shape1.Brush.Color := clWebPink;

label2.Color := clAqua;
label3.Color := clAqua;
shape2.Pen.Width := 5;
Shape2.Brush.Color := clAqua;

Shape3.Pen.Width := 5;
Shape3.Brush.Color := clWebMediumAquamarine;
Shape4.Pen.Width := 5;

Shape4.Pen.Width := 5;
Shape4.Brush.Color := clBlack;

Shape5.Pen.Width := 5;

Shape12.Brush.Color := clWebPink;
Shape12.Pen.Color := clAqua;
sParagraph := '';

Shape6.Pen.Width := 5;
Shape6.Brush.Color := clWebBrown;

Shape7.Pen.Width := 5;
Shape7.Brush.Color := clWebGreen;

Shape8.Pen.Width := 5;
Shape8.Brush.Color := clWebGreen;

Shape9.Pen.Width := 5;
Shape9.Brush.Color := clWebBrown;

Shape10.Pen.Width := 5;
Shape10.Brush.Color := clWebGreen;

Shape11.Pen.Width := 5;
Shape11.Brush.Color := clWebBrown;

end;

procedure TfrmWelcome.Label3Click(Sender: TObject);
var tUserfile : textfile;
bRememberMe,bPerms : boolean;     // Logic for handling user settings and navigation
sLine : string;
begin
bRememberMe := False;
bPerms := False;
Label3.Font.Color := clPurple;
AssignFile(tUserfile,'User.txt');
Reset(tUserfile);
while not Eof(tUserfile) do
 begin
  readln(tUserfile,sLine);
  if ((copy(sLine,Pos('#',sLIne) + 2,length(sLine)) = 'TRUE') AND (sLIne[1] = 'R'))  then
   begin
   bRememberMe := True;

   end;



   if ((copy(sLine,Pos('#',sLIne) + 2,length(sLine)) = 'TRUE') AND (sLIne[1] = 'i'))  then
   begin
    bPerms := True
   end;
 end;

 if (bPerms = True) and (bRememberMe = True) then
   begin
    frmHome.Show;
    frmWelcome.Hide;
   end
 else if  (bRememberMe = False)  then
    begin
      frmLogin.Show;
      frmWelcome.Hide;
    end
 else
 begin
    frmStudentprofile.Show;
    frmWelcome.Hide;
 end;

end;

procedure TfrmWelcome.Label3MouseEnter(Sender: TObject);
begin
Label3.Font.Style := [fsUnderline,fsBold];   // Change label appearance on mouse enter
end;

procedure TfrmWelcome.Label3MouseLeave(Sender: TObject);
begin
Label3.Font.Style := [fsBold];     // Change label appearance on mouse leave
end;

procedure TfrmWelcome.Timer1Timer(Sender: TObject);
begin
if i <= Length(sline) then
begin
Label4.Update;
label4.Caption := label4.Caption + sLine[i]; // Timer logic for displaying text progressively
i := i + 1;

end

end;

end.
