unit Analytics_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, TeEngine, Series, TeeProcs,
  Chart,ConnectDB_u, DBChart, Grids, DBGrids,Student_u,DateUtils;

type
  TfrmAnalytics = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image2: TImage;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    rdbOtherStats: TRadioButton;
    RedDisplay: TRichEdit;
    DBChart1: TDBChart;
    Series1: TBarSeries;
    DBGrid1: TDBGrid;
    Image3: TImage;
    Image10: TImage;
    procedure RadioButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdbOtherStatsClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAnalytics: TfrmAnalytics;
  objStudent : TStudent;
  arrUsers : array[1..100] of string;
arrHours : array[1..100] of integer;
implementation
uses Home_u;
{$R *.dfm}

procedure TfrmAnalytics.FormCreate(Sender: TObject);
begin
DBChart1.Visible := False;
DBGrid1.Visible := False;    // hides output components
RedDisplay.Visible := False;
end;

procedure TfrmAnalytics.FormShow(Sender: TObject);
begin
DBGrid1.DataSource := dscKnights4Nature;
end;

procedure TfrmAnalytics.Image10Click(Sender: TObject);
begin
frmAnalytics.Hide;
frmHome.Show;
end;

procedure TfrmAnalytics.Image3Click(Sender: TObject);
begin
if MessageDlg('Are you sure you want to leave?',mtConfirmation,mbYesNo,0) = mrYes then
begin
  Showmessage('See ya next time!');
  Application.Terminate;

end;
end;

procedure TfrmAnalytics.RadioButton1Click(Sender: TObject);
var iHours,I,iHonours,iFull,iHalf,iScroll,iNone : integer;

begin
RedDisplay.Clear;
RedDisplay.Visible := True;
RedDisplay.Paragraph.TabCount := 4;
RedDisplay.Paragraph.Tab[0] := 50;
RedDisplay.Paragraph.Tab[1] := 115;
RedDisplay.Paragraph.Tab[2] := 165;
RedDisplay.Paragraph.Tab[3] := 250;
RedDisplay.Lines.Add('-------------------------------------------------------------------------------------');
RedDisplay.Lines.Add('|' + #9 + 'NAME' + #9 + '|' + #9 + 'AWARD' + #9 + '|');
RedDisplay.Lines.Add('-------------------------------------------------------------------------------------');
RedDisplay.Top := DBGrid1.Top;
RedDisplay.Height := 165;
DBGrid1.Visible := False;

DBChart1.Visible := True;
Series1.Clear;
DBChart1.Title.Text.Clear;
DBChart1.Title.Text.Add('Award Winners');
iHours := 0;
iNone := 0;
iScroll := 0;
iHalf := 0;
iFull := 0;
iHonours := 0;
tblusers.First;
for I := 1 to tblusers.RecordCount do
begin
tblAttendence.First;
     while tblAttendence.Eof = false do
      begin
        if  tblAttendence['UserID'] = tblusers['UserID']  then
          begin
          tblDuties.First;
            while tblDuties.Eof = False do
              begin
                if (tblAttendence['DutyID'] = tblDuties['DutyID']) and (tblAttendence['isPresent'] = True)  then
                   begin
                   iHours := iHours + tblDuties['Duration'] ;
                   end;
                tblDuties.Next;
              end;

          end;
            tblAttendence.Next;
      end;
     arrUsers[i] := tblUsers['Firstname'] + ' '  + tblUsers['Surname'];
  arrHours[i] := iHours;
  objStudent := TStudent.Create(copy(arrUsers[i],1,pos(' ',arrUsers[i]) - 1),copy(arrUsers[i],pos(' ',arrUsers[i]) + 1,length(arrUsers[i])),arrHours[i]);

  case objStudent.CalcAwards[1] of
   'N' : inc(iNone);
   'S' : inc(iScroll);
   'H' : inc(iHalf);
   'F' : inc(iFull);
   'W' : inc(iHonours);

  end;
  if objStudent.CalcAwards <> 'No Award' then
    begin
   RedDisplay.Lines.Add('|' + #9 + arrUsers[i] + #9 + '|' + #9 + objStudent.CalcAwards + #9 + '|');
   RedDisplay.Lines.Add('-------------------------------------------------------------------------------------');

    end;
    objStudent.Free;
  tblusers.Next;
 rdbOtherStats.Visible := True;

end;

                                               // shows the proportion of different awards
                                               //earned by various students in the club
Series1.AddBar(iNone,'No Award',clWhite);
Series1.AddBar(iScroll,'Scroll',clWebNavy);
Series1.AddBar(iHalf,'Half Colours',clWhite);
Series1.AddBar(iFull,'Full Colours',clWebNavy);
Series1.AddBar(iHonours,'White Blazer',clWhite);
end;

procedure TfrmAnalytics.RadioButton2Click(Sender: TObject);
var I : integer;
begin
RedDisplay.Visible := False;
DBGrid1.Visible := True;
                                  // shows what duties where attended the most
DBChart1.Visible := True;
DBChart1.Title.Text.Clear;
DBChart1.Title.Text.Add('Duty Attendence');
qryKnights4Nature.Close;
qryKnights4Nature.SQL.Clear;
qryKnights4Nature.SQL.Text := 'SELECT tblDuties.DutyName, Count(tblAttendence.DutyID) as TimesDone FROM tblDuties,tblAttendence WHERE (tblAttendence.DutyID = tblDuties.DutyID) GROUP BY tblDuties.DutyName ORDER BY COUNT(tblAttendence.DutyID) DESC';
qryKnights4Nature.Open;
series1.Clear;
for I := 1 to qryKnights4Nature.RecordCount  do
  begin
   Series1.AddBar(qryKnights4Nature['TimesDone'],qryKnights4Nature['DutyName'],clBlack);
   qryKnights4Nature.Next;
  end;
end;

procedure TfrmAnalytics.rdbOtherStatsClick(Sender: TObject);
var i,j,itemphours,k : integer;
stempusers : string;
begin
DBChart1.Visible := False;
DBGrid1.Visible :=  False;
RedDisplay.Visible := True;
RedDisplay.Clear;
RedDisplay.Top := 80;
RedDisplay.Height := 300;
RedDisplay.Paragraph.TabCount := 4;
RedDisplay.Paragraph.Tab[0] := 20;
RedDisplay.Paragraph.Tab[1] := 120;
RedDisplay.Paragraph.Tab[2] := 160;
RedDisplay.Paragraph.Tab[3] := 243;


for I := 1 to Length(arrHours) - 1 do
  begin
    for j := i +1  to Length(arrHours) do
      begin
      if arrHours[i] < arrHours[j] then
        begin
       itemphours := arrHours[i];
       arrHours[i] := arrHours[j];
       arrHours[j] := itemphours;

       stempusers := arrUsers[i];
       arrUsers[i] := arrUsers[j];
       arrUsers[j] := stempUsers;

        end;
      end;
  end;


    RedDisplay.Lines.Add('----------------------------------------------------------------------------------');
    RedDisplay.Lines.Add(  '|' + #9 + 'NAME' + #9 + '|' + #9 + 'Hours' + #9 + '|');
    RedDisplay.Lines.Add('----------------------------------------------------------------------------------');

  for k := 1 to tblusers.RecordCount do
   begin
    RedDisplay.Lines.Add(  '|' + #9 + arrUsers[k] + #9 + '|' + #9 + IntToStr(arrHours[k]) + #9 + '|');
    RedDisplay.Lines.Add('----------------------------------------------------------------------------------');
   end;

end;

end.
