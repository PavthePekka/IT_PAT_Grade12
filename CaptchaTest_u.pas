unit CaptchaTest_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, MPlayer,Math,Signup_u;

type
  TfrmCaptchaTest = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtAnswer: TEdit;
    Label2: TLabel;
    imgCaptcha: TImage;
    imgRetry: TImage;
    Button1: TButton;
    MediaPlayer1: TMediaPlayer;
    imgSound: TImage;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure imgSoundClick(Sender: TObject);
    procedure imgRetryClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
    Function ImgShow(Image : String) : TImage;
    //Shows image
    Function Check(Index : Integer;sAnswer : string) : Boolean;
    // checks if users answer is valid returns True/False
    Function SoundPlay(Index : Integer) : Boolean;
     //plays text to speech
  end;

var
  frmCaptchaTest: TfrmCaptchaTest;
  I : integer;
  arrSounds : array[1..5] of string = ('Assembly.wav','Cricket.wav','Ethiopia.wav','Pharmacy.wav','Veranda.wav');
  // used array to store names of text to speech
  arrImages : array[1..5] of string  = ('assembly.jpg','cricket.jpg','ethiopia.jpg','pharmacy.jpg','veranda.jpg') ;
  // used array to store names of images
  implementation




{$R *.dfm}

function TfrmCaptchaTest.Imgshow(Image : string): TImage;
begin
  imgCaptcha.Picture.LoadFromFile('Assets\Images\'  + Image);    // loads images
end; // end of function



procedure TfrmCaptchaTest.imgSoundClick(Sender: TObject);
begin
SoundPlay(I);
end;

procedure TfrmCaptchaTest.Button1Click(Sender: TObject);
begin
 if Check(I,edtAnswer.Text) = True then
 begin
   frmCaptchaTest.Hide;
   frmSignup.Visible := True;
 end
 else
 Showmessage('Incorrect')
end;

function TfrmCaptchaTest.Check(Index: Integer; sAnswer : string): Boolean;
var sRightanswer,sIndex : string;
begin
sIndex := IntToStr(Index);
 case sIndex[1] of
  '1'  : sRightAnswer := copy(arrImages[1],1,pos('.',arrImages[1]) - 1);  // case copies img names
  '2'  : sRightAnswer := copy(arrImages[2],1,pos('.',arrimages[2]) - 1);  // from arrays and removes
  '3'  : sRightAnswer := copy(arrImages[3],1,pos('.',arrimages[3]) - 1); // extensions to check if
  '4'  : sRightAnswer := copy(arrImages[4],1,pos('.',arrImages[4]) - 1); // user entered right answer
  '5'  : sRightAnswer := copy(arrImages[5],1,pos('.',arrImages[5]) - 1);

 end;
 if sRightanswer = Lowercase(sAnswer) then
    result := True
 else
    result := False
end;

function TfrmCaptchaTest.SoundPlay(Index: integer): Boolean;
begin
MediaPlayer1.FileName := 'Assets\Sounds\' + arrSounds[Index];
MediaPlayer1.Open;
MediaPlayer1.Play;   // plays text to speech when sound image is pressed
end;





procedure TfrmCaptchaTest.FormShow(Sender: TObject);
begin
 I :=  Randomrange(1,6);
ImgShow(arrImages[I]);

end;

procedure TfrmCaptchaTest.imgRetryClick(Sender: TObject);
var iTemp : integer;
bRun : Boolean;
begin
iTemp := I;
bRun := True;
Randomize;
while bRun = True do
begin
I := randomrange(1,6);
if iTemp = I then
I := randomrange(1,6)
else
begin
imgCaptcha.Picture.LoadFromFile('Assets\Images\'  + arrImages[I]);
brun := False;
end;  //end of else
end;  // end of while
end; // end of procedure

end. //end of file
