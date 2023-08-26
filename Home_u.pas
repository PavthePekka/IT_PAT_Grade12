unit Home_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  TfrmHome = class(TForm)
    Label2: TLabel;
    Image3: TImage;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Image3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation
uses Analytics_u,Attendance_u,DutyRoster_u,studentInfo_u;
{$R *.dfm}

procedure TfrmHome.Button1Click(Sender: TObject);
begin
frmStudentInfo.Show;
frmHome.Hide;
end;

procedure TfrmHome.Button2Click(Sender: TObject);
begin
frmDutyRoster.Show;
frmHome.Hide;
end;

procedure TfrmHome.Button3Click(Sender: TObject);
begin
frmAnalytics.Show;
frmHome.Show;

end;

procedure TfrmHome.Button4Click(Sender: TObject);
begin
frmAttendance.Show;
frmHome.Hide;
end;

procedure TfrmHome.FormShow(Sender: TObject);
begin
Shape1.Pen.Width := 5;
Shape1.Brush.Color := clWebAquamarine;

Shape2.Pen.Width := 5;
Shape2.Brush.Color := clWhite;

Shape3.Pen.Width := 5;
Shape3.Brush.Color := clWebAquamarine;

Shape4.Pen.Width := 5;
Shape4.Brush.Color := clWhite;
end;

procedure TfrmHome.Image3Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');
  Application.Terminate;

end;
end;

procedure TfrmHome.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
frmStudentInfo.Show;
frmHome.Hide;
end;

procedure TfrmHome.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
frmDutyRoster.Show;
frmHome.Hide;
end;

procedure TfrmHome.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
frmAnalytics.Show;
frmHome.Hide;
end;

procedure TfrmHome.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
frmAttendance.Show;
frmHome.Hide;
end;

end.
