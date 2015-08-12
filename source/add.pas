unit add;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TAddForm = class(TForm)
    DataTypeRadio: TRadioGroup;
    EntryName: TEdit;
    NameLabel: TLabel;
    MinEdit: TEdit;
    MaxEdit: TEdit;
    StepEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    InitEdit: TEdit;
    InitRadio: TRadioGroup;
    procedure RandCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddForm: TAddForm;

implementation

{$R *.dfm}

procedure TAddForm.RandCheckClick(Sender: TObject);
begin
  InitEdit.Enabled:=InitRadio.ItemIndex<>2;

end;

end.
