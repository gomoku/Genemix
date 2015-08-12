unit log;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, genetic;

type
  TLogForm = class(TForm)
    LogBook: TMemo;
    Label1: TLabel;
    StopButton: TButton;
    procedure Work(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogForm: TLogForm;
  cancelled: boolean;
  inf, outf, exef, logd: string;

implementation

{$R *.dfm}

function alignnum(what:integer; len:integer; c:char):string;
var
  i:integer;
  s:string;
begin
  s:='';
  for i:=0 to len-1 do begin
    if (what=0) and (i>0) then s:=c + s
    else s:=chr((what mod 10) + ord('0')) + s;
    what:=what div 10;
  end;
  while (what>0) do begin
    s:=chr((what mod 10) + ord('0')) + s;
    what:=what div 10;
  end;
  alignnum:=s;
end;

procedure writelog(epoch:integer);
var t:textfile;
    i, j:integer;
    dir:string;
begin
  dir:=logd + '\' + alignnum(epoch,4,'0');

  for j:=0 to environment.popsize-1 do begin
    assignfile(t,dir+'\'+ alignnum(j,4,'0'));
    rewrite(t);
    writeln(t, 'This is log file of Gene genius');
    writeln(t, 'Fitness: ', fitness[j]:1:2);
    writeln(t, 'Number of entries: ', environment.entriesnum);
    for i:=0 to environment.entriesnum-1 do begin
      if entries[i].datatype=0
        then writeln(t, entries[i].name, ': ', trunc(population[j][i]))
        else writeln(t, entries[i].name, ': ', population[j][i]);
    end;
    closefile(t);
  end;
end;

function WinExecAndWait(FileName: string; Visibility: Integer): Integer;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  { Naplníme strukturu StartupInfo. }
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.CB := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW; // spustit v normálním oknì
  StartupInfo.wShowWindow := Visibility;       // zpùsob zobrazení okna
                                               // (normální, maximalizované,...)
  if not CreateProcess(
    nil,
    PChar(FileName),       // pøíkazová øádka - to, co se spustí
    nil,                   // bezpeènostní atributy vzniklého procesu...
    nil,                   // ... a vlákna - ani jedno nepotøebujeme
    False,                 // dìdìní handlù - nechceme
    NORMAL_PRIORITY_CLASS, // proces má normální prioritu
    nil,                   // ukazatel na promìnné prostøedí - hodnota nil...
                           // ... znamená jejich zdìdìní od volajícího procesu
    PChar(ExtractFilePath(filename)), // aktuální adresáø, nil opìt znamená zdìdìní
    StartupInfo,           // ukazatele na potøebné struktury
    ProcessInfo)
  then
    Result := - 1 // pøi chybì vracíme -1
  else
  begin
    { Pokud spuštìní probìhne v poøádku, èekáme na ukonèení procesu. }
{    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);}
  while WaitForSingleObject(ProcessInfo.hProcess, 0) <> WAIT_OBJECT_0
    do application.ProcessMessages;

   { Nakonec vrátíme návratový kód procesu. }
    GetExitCodeProcess(ProcessInfo.hProcess, cardinal(Result));
  end;
end;

procedure TLogForm.Work(Sender: TObject);
var
  i, j:integer;
  progress: array of real;
  average: array of real;
  exitcode:integer;
  mutants:string;
  sum:real;
begin
  { TODO :
cancelovani}
  update;

  SetLength(progress, environment.epochs+1);
  SetLength(average, environment.epochs+1);
  createdir(logd);

  logbook.Lines.Add('Genetic algorithm started.');
  logbook.Update;
  logbook.Lines.SaveToFile(logd+'\progress.log');
  for i:=0 to environment.epochs-1 do begin
    if i > 0 then begin
      mutants:=environment.nextgeneration1();
      if mutants<>'' then begin
        logbook.Lines.Add('Mutation stroke members' + mutants + ' in epoch ' + alignnum(i,4,' '));
        logbook.Update;
        logbook.Lines.SaveToFile(logd+'\progress.log');
      end;
    end;

    sum:=0;
    for j:=0 to environment.popsize-1 do begin
      environment.writeoutput(outf, j);

      {handle:=ShellExecute(Application.MainForm.Handle, nil,
        StrPCopy(zFileName, GetCurrentDir + '\' + exef), StrPCopy(zParams, ''),
        StrPCopy(zDir, ExtractFilePath(exef)), SW_SHOWMINNOACTIVE);

      WaitForSingleObject(handle, INFINITE); }

      {logove vypisy:}
      createdir(logd + '\' + alignnum(i,4,'0'));
      environment.writeoutput(logd + '\' + alignnum(i,4,'0')+'\'+ 'member' + alignnum(j,4,'0'),j);

      update;
      repeat
        if(cancelled) then begin
          exit;
        end;
        exitcode:=WinExecAndWait(GetCurrentDir + '\' + exef, SW_SHOWMINNOACTIVE);
      until exitcode=0;
      {if (exitcode<>0) then begin
        logbook.Lines.Add('Error ' + alignnum(exitcode,4,' ') + ' executing member ' + alignnum(j,4,' ') + ' in epoch ' + alignnum(i,4,' '));
        logbook.Update;
        logbook.Lines.SaveToFile(logd+'\progress.log');
        fitness[j]:=0;
      end else} environment.loadinput(inf, j);
      sum:=sum+fitness[j];
    end;

    environment.sort();
    progress[i]:=fitness[0];
    average[i]:=sum/environment.popsize;
    logbook.Lines.Add('Epoch ' + inttostr(i) + ', best fitness ' + floattostr(progress[i]) + ', average fitness ' + floattostr(average[i]));
    logbook.Update;
    logbook.Lines.SaveToFile(logd+'\progress.log');
    writelog(i);
  end;
  logbook.Lines.Add('Genetic algorithm finished.');
  logbook.Update;
  logbook.Lines.SaveToFile(logd+'\progress.log');
  StopButton.Caption:='Close';
end;

procedure TLogForm.StopButtonClick(Sender: TObject);
begin
  if StopButton.Caption = 'Start' then begin
    Stopbutton.Caption:='Abort';
    cancelled:=false;
    work(Sender);
  end else begin
    if StopButton.Caption = 'Close' then close
    else begin
          StopButton.Caption:='Close';
          cancelled:=true;
          logbook.Lines.Add('Genetic algorithm aborted.');
          logbook.Update;
          logbook.Lines.SaveToFile(logd+'\progress.log');
    end;
  end;
end;


end.
