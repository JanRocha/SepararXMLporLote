unit xmllote;

interface
uses
xmldom, XMLIntf,XMLDoc,System.Generics.Collections, Vcl.StdCtrls, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

  type
    TXML = class
  private
    FLoteCFe: IXMLNode;
    Fxml: TXMLDocument;
    FenvCFe: IXMLNode;
    FCFe: IXMLNode;
    FinfCFe: IXMLNode;
    FId: string;
    FLoteCFeCanc: IXMLNode;
    FCFeCanc: IXMLNode;
    FcancCFe: IXMLNode;
  published
    property LoteCFe : IXMLNode read FLoteCFe write FLoteCFe;
    property xml: TXMLDocument   read Fxml     write Fxml;
    property envCFe :IXMLNode  read FenvCFe write FenvCFe;
    property CFe :IXMLNode  read FCFe write FCFe;
    property infCFe :IXMLNode read   FinfCFe write FinfCFe;
    property Id  :string read FId write FId;
    property cancCFe :IXMLNode  read FcancCFe    write FcancCFe;
    property LoteCFeCanc :IXMLNode  read FLoteCFeCanc   write FLoteCFeCanc;
    property CFeCanc :IXMLNode    read FCFeCanc  write FCFeCanc  ;

    end;

  TLoteXML = class(TXML)
    private
      FcaminhoXMO: string;
      Flog: string;
      Fmemo: TMemo;
      lst: TList<IXMLNode>;
      i:integer;
      FXml:WideString;
      xml1: TXMLDocument;
      xmlCan: TXMLDocument;
    procedure separar_cancelados;
    procedure separar_venda;
    published
          property caminhoXMO: string read FcaminhoXMO write FcaminhoXMO;
          property memo :TMemo   read Fmemo write Fmemo;
          property log :string read Flog write Flog;
    public
          procedure CarregarArquivo;

  end;



implementation

{ TLoteXML }

procedure TLoteXML.CarregarArquivo;
begin
  lst:= TList<IXMLNode>.Create;
  xml:=nil;
   xml:= TXMLDocument.Create(xml);
   xml.LoadFromFile(self.caminhoXMO); //Carregando o XML
   envCFe := xml.childNodes.FindNode('envCFe');

    memo.Lines.Clear;
   if envCFe<>nil then
    separar_venda
   else
   begin
    xmlCan:= TXMLDocument.Create(xmlCan);
    xmlCan.LoadFromFile(self.caminhoXMO); //Carregando o XML
    cancCFe  := xmlCan.childNodes.FindNode('cancCFe');
    if cancCFe = nil then
    begin
      memo.Lines.Add('Aquivo invalido');
      exit;
    end
    else
    separar_cancelados;
   end;

  if(Assigned(xml1)) then
    xml1:= nil;
  if(Assigned(xmlCan)) then
  xmlCan:= nil;
  if(Assigned(xml)) then
  xml:= nil;
  envCFe:=nil;

end;

procedure TLoteXML.separar_cancelados;
var i:integer;
begin
   LoteCFeCanc:= cancCFe.ChildNodes.FindNode('LoteCFeCanc');
   CFe:= LoteCFeCanc.ChildNodes.FindNode('CFeCanc');
   CFe.ChildNodes.First;

    repeat
      if CFe<> nil then
      begin
         lst.Add(CFe);
      end;
      CFe:= CFe.NextSibling;
    until CFe = nil;
    lst.First;

    memo.Lines.Add('Total de notas no Lote: '+ intTostr(lst.Count));
    xml1:= TXMLDocument.Create(xml1);

   for i :=0 to lst.Count  -1 do
   begin
       CFe:= lst.Items[i];
       infCFe:= CFe.ChildNodes.FindNode('infCFe');
       Id := infCFe.GetAttributeNS('Id','');
       FXml :='<CFe>'+CFe.XML+'</CFe>';
       xml1.LoadFromXML(FXml);
       xml1.SaveToFile(id+'.xml');
       memo.Lines.Add('XML separado do Lote: ' + id+'-can.xml')
   end;
end;

procedure TLoteXML.separar_venda;
 var i:integer;
begin
    LoteCFe:= envCFe.ChildNodes.FindNode('LoteCFe');
   CFe:= LoteCFe.ChildNodes.FindNode('CFe');
   CFe.ChildNodes.First;

    repeat
      if CFe<> nil then
      begin
         lst.Add(CFe);
      end;
      CFe:= CFe.NextSibling;
    until CFe = nil;
    lst.First;

    memo.Lines.Add('Total de notas no Lote: '+ intTostr(lst.Count));
    xml1:= TXMLDocument.Create(xml1);

   for i :=0 to lst.Count  -1 do
   begin
       CFe:= lst.Items[i];
       infCFe:= CFe.ChildNodes.FindNode('infCFe');
       Id := infCFe.GetAttributeNS('Id','');
       FXml :='<CFe>'+CFe.XML+'</CFe>';
       xml1.LoadFromXML(FXml);
       xml1.SaveToFile(id+'.xml');
       memo.Lines.Add('XML separado do Lote: ' + id+'.xml')
   end;
end;

end.
