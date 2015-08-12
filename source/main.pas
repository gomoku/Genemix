unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Menus,

  genetic, Mask, ComCtrls, ExtCtrls, Shellapi;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    Exefile: TEdit;
    OutputFile: TEdit;
    Inputfile: TEdit;
    RunButton: TButton;
    MenuFile: TMenuItem;
    Help1: TMenuItem;
    MenuExit: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    VarList: TListBox;
    DelButton: TButton;
    AddButton: TButton;
    UpButton: TBitBtn;
    DownButton: TBitBtn;
    EditButton: TButton;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    PopEdit: TEdit;
    EliteEdit: TLabeledEdit;
    MutEdit: TLabeledEdit;
    MenuSave: TMenuItem;
    MenuLoad: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    EpochEdit: TLabeledEdit;
    CrossEdit: TLabeledEdit;
    Label5: TLabel;
    LogDir: TEdit;
    Readmetxt1: TMenuItem;
    About1: TMenuItem;
    procedure MenuExitClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
    procedure MenuSaveClick(Sender: TObject);
    procedure MenuLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Readmetxt1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses add, log, AboutUnit;

{$R *.dfm}

procedure TMainForm.MenuExitClick(Sender: TObject);
begin
  MainForm.Close;
end;

procedure TMainForm.AddButtonClick(Sender: TObject);
var p: entry;
begin
  AddForm.showmodal;
  if AddForm.modalresult=mrok then begin
    p:=entry.Create;

    p.name:=Addform.EntryName.text;
    p.datatype:=Addform.DataTypeRadio.ItemIndex;
    p.initval:=strtofloat(Addform.InitEdit.text);
    p.randomization:=Addform.InitRadio.ItemIndex;
    p.min:=strtofloat(Addform.MinEdit.text);
    p.max:=strtofloat(Addform.MaxEdit.text);
    p.step:=strtofloat(Addform.StepEdit.text);

    varlist.Items.Add(p.name);
    Entries[varlist.Items.Count-1]:=p;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
  for i:=0 to VarList.Items.Count-1 do entries[i].Destroy;
end;

procedure TMainForm.UpButtonClick(Sender: TObject);
var i:integer;
    e:entry;
begin
  i:=varlist.itemindex;
    if(i>0) then begin
    e:=entries[i];
    entries[i]:=entries[i-1];
    entries[i-1]:=e;
    varlist.Items.Exchange(i, i-1);
  end;
end;

procedure TMainForm.DownButtonClick(Sender: TObject);
var i:integer;
    e:entry;
begin
  i:=varlist.itemindex;
    if(i>-1) AND (i<varlist.items.Count-1) then begin
    e:=entries[i];
    entries[i]:=entries[i+1];
    entries[i+1]:=e;
    varlist.Items.Exchange(i, i+1);
  end;
end;

procedure TMainForm.DelButtonClick(Sender: TObject);
var i,j:integer;
begin
  i:=varlist.itemindex;
  if(i>=0) then begin
    entries[i].Destroy;
    for j:=i to varlist.Items.Count-2 do entries[j]:=entries[j+1];
    varlist.Items.Delete(i);
  end;
end;

procedure TMainForm.EditButtonClick(Sender: TObject);
var p: entry;
    i:integer;
begin
  i:=varlist.itemindex;
  if(i>=0) then begin
    p:=entries[i];
    addform.EntryName.Text:=p.name;
    addform.DataTypeRadio.ItemIndex:=p.datatype;
    addform.InitEdit.Text:=floattostr(p.initval);
    addform.InitRadio.ItemIndex:=p.randomization;
    addform.MinEdit.Text:=floattostr(p.min);
    addform.MaxEdit.text:=floattostr(p.max);
    addform.StepEdit.Text:=floattostr(p.step);

    AddForm.showmodal;
    if AddForm.modalresult=mrok then begin
      p.name:=Addform.EntryName.text;
      p.datatype:=Addform.DataTypeRadio.ItemIndex;
      p.initval:=strtofloat(Addform.InitEdit.text);
      p.randomization:=Addform.InitRadio.ItemIndex;
      p.min:=strtofloat(Addform.MinEdit.text);
      p.max:=strtofloat(Addform.MaxEdit.text);
      p.step:=strtofloat(Addform.StepEdit.text);

      varlist.Items[i]:=p.name;
    end;
  end;
end;

procedure TMainForm.RunButtonClick(Sender: TObject);
begin
  environment.entriesnum:=VarList.Items.Count;
  environment.popsize:=StrToInt(PopEdit.Text);
  environment.crossovers:=StrToFloat(CrossEdit.text);
  environment.mutations:=StrToFloat(MutEdit.text);
  environment.elite:=StrToInt(EliteEdit.Text);
  environment.epochs:=StrToInt(EpochEdit.Text);

  environment.init();

  outf:=OutputFile.Text;
  inf:=InputFile.Text;
  exef:=ExeFile.Text;
  logd:=LogDir.Text;

  cancelled:=true;
  logform.logbook.Clear;
  logform.StopButton.Caption :='Start';
  logform.StopButton.Enabled:=true;
  logform.ShowModal();
end;

procedure TMainForm.MenuSaveClick(Sender: TObject);
var
  s:string;
begin
  s:=getcurrentdir;
  environment.entriesnum:=VarList.Items.Count;
  if SaveDialog.Execute then environment.saveentries(SaveDialog.FileName);
  chdir(s);
end;

procedure TMainForm.MenuLoadClick(Sender: TObject);
var
  i:integer;
  s:string;
begin
  s:=getcurrentdir;
  if OpenDialog.Execute then begin
    environment.loadentries(OpenDialog.FileName);

    varlist.clear;
    for i:=0 to environment.entriesnum-1 do varlist.Items.Add(entries[i].name);
  end;
  chdir(s);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  environment:=(genetic.tenvironment).Create;
end;
procedure TMainForm.About1Click(Sender: TObject);
begin
  AboutBox.Showmodal;
end;

procedure TMainForm.Readmetxt1Click(Sender: TObject);
begin
ShellExecute(Application.MainForm.Handle, nil, 'Readme.txt', nil, nil, SW_SHOWNORMAL);
end;

end.
