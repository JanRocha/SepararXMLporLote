unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,xmllote, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    OpenTextFileDialog1: TOpenTextFileDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
     procedure TrimAppMemorySize;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}




procedure TForm1.Button1Click(Sender: TObject);
begin
with TFileOpenDialog.Create(nil) do
    try
      Title := 'Selecione o XML de Lote';
      Options := [fdoFileMustExist];
      if Execute then
      Edit1.Text:= FileName;
    finally
      Free;
    end
end;

procedure TForm1.Button2Click(Sender: TObject);
var oLote:TLoteXML;
begin
    oLote:= TLoteXML.Create;
    try
    oLote.caminhoXMO:= Edit1.Text;
    oLote.memo:= Memo1;
    oLote.CarregarArquivo;
    finally
     oLote.Free;
     self.TrimAppMemorySize();
    end;
end;

procedure TForm1.TrimAppMemorySize;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;
  Application.ProcessMessages;

end;

end.
