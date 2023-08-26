unit Captcha_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls, pngimage;

type
  TfrmCaptcha = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    edtcaptcha: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCaptcha: TfrmCaptcha;

implementation

{$R *.dfm}

end.
