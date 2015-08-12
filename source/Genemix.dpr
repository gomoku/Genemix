program Genemix;

uses
  Forms,
  main in 'main.pas' {MainForm},
  genetic in 'genetic.pas',
  add in 'add.pas' {AddForm},
  log in 'log.pas' {LogForm},
  AboutUnit in 'AboutUnit.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddForm, AddForm);
  Application.CreateForm(TLogForm, LogForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
