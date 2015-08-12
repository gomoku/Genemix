unit genetic;

interface

type
     entry=class
        name:string;
        datatype:integer;{0=int, 1=real}
        initval:real;  {vychozi hodnota}
        randomization:integer; {0 nerandomizovat, 1 vsechny krome jednoho, 2 vsechny}
        min, max:real; {maximalni a minimalni mozne hodnoty}
        step:real;     {hodnota, o kterou se to meni}
     end;

     tenvironment=class
        entriesnum:integer;{pocet polozek v entries}
        popsize:integer;{pocet jedincu}
        crossovers:real;{pravdepodobnost krizeni; mezi 0 a 1}
        mutations:real;{pravdepodobnost mutace; mezi 0 a 1}
        elite:integer;{pocet elitnich jedincu, kteri se nemeni}
        epochs:integer;{pocet epoch}

        procedure init;
        procedure writeoutput(filename:string; index:integer);
        procedure loadinput(filename:string; index:integer);
        procedure swapmembers(i,j:integer);
        procedure sort;
        function nextgeneration1:string;
        procedure roulette(totalfit:real; var mother:integer; var father:integer);
        procedure survive(i, j : integer);
        procedure crossover1(i, j : integer);
        procedure mutate1(index : integer);
        procedure tournament(var mother:integer; var father:integer);
        procedure saveentries(filename:string);
        procedure loadentries(filename:string);
     end;

const
  MaxEntries=1000;

var
  Entries: array[0..MaxEntries-1] of entry;
  fitness: array of real;
  population, offspring: array of array of real;
  environment: tenvironment;

implementation

uses sysutils;

procedure tenvironment.survive(i, j : integer);
{copies a member to new population without change}
var
  k:integer;
begin
  for k:=0 to entriesnum-1 do offspring[j][k]:=population[i][k];
end;

procedure tenvironment.crossover1(i, j : integer);
{performs crossover on offspring}
var
  k:integer;
  r:real;
begin
  for k:=0 to entriesnum-1 do if (random<0.5) then begin
    r:=offspring[i][k];
    offspring[i][k]:=offspring[j][k];
    offspring[j][k]:=r;
  end;
end;

procedure tenvironment.mutate1(index : integer);
var
  i:integer;
  pom:int64;
begin
  for i:=0 to entriesnum-1 do if random<0.1 then begin

      if entries[i].datatype=0 then begin
        pom:=1 + trunc(entries[i].max) - trunc(entries[i].min);
        if pom>high(integer) then pom:=high(integer);
        offspring[index][i] := entries[i].min + random(pom);
      end;

      if entries[i].datatype=1 then begin
        pom:=1 + trunc((entries[i].max - entries[i].min) / entries[i].step);
        if pom>high(integer) then pom:=high(integer);
        offspring[index][i] := entries[i].min + random(pom) * entries[i].step;
      end;

  end;
end;

procedure tenvironment.roulette(totalfit:real; var mother:integer; var father:integer);
var
  r, aux:real;
begin
  r:=random*totalfit;

  mother:=0;
  aux:=fitness[0];
  while (aux<=r) do begin
    mother:=mother+1;
    aux:=aux+fitness[mother];
  end;

  father:=0;
  aux:=fitness[0];
  while (aux<=r) do begin
    father:=father+1;
    aux:=aux+fitness[father];
  end;
end;

procedure tenvironment.tournament(var mother:integer; var father:integer);
var
  i, j:integer;
const
  betterprob=0.8;
begin
  i:=random(popsize);
  j:=random(popsize);
  if (fitness[i]>=fitness[j]) then begin
    if random<betterprob then mother:=i else mother:=j;
  end else begin
    if random<betterprob then mother:=j else mother:=i;
  end;

  i:=random(popsize);
  j:=random(popsize);
  if (fitness[i]>=fitness[j]) then begin
    if random<betterprob then father:=i else father:=j;
  end else begin
    if random<betterprob then father:=j else father:=i;
  end;
end;


function tenvironment.nextgeneration1():string;
{
        Creates new population
leaves elite, others chooses by roulette, sometimes crosses, sometimes mutates
using vars population and offspring
returns list of mutated members
}
var
  i, mother, father:integer;
  totalfit:real;
  mutants, aux:string;
begin
  for i:=0 to elite-1 do survive(i,i);

  totalfit:=0;
  for i:=0 to popsize-1 do totalfit:=totalfit+fitness[i];

  mutants:='';
  i:=elite;
  while (i<popsize) do begin
//    roulette(totalfit, mother, father);
    tournament(mother, father);
    survive(mother, i);
    if (i+1<popsize) then survive(father, i+1);
    if (i+1<popsize) and (random < crossovers) then crossover1(i,i+1);
    if (random < mutations) then begin
      mutate1(i);
      str(i,aux);
      mutants:=mutants+' '+ aux + ',';
    end;
    if (i+1<popsize) and (random < mutations) then mutate1(i+1);

    i:=i+2;
  end;

  population:=offspring;
  nextgeneration1:=mutants;
end;


procedure tenvironment.swapmembers(i,j:integer);
var
  k:integer;
  r:real;
begin
  for k:=0 to entriesnum-1 do begin
    r:=population[i][k];
    population[i][k]:=population[j][k];
    population[j][k]:=r;
  end;
end;

procedure tenvironment.sort;
var
  i,j, bestj:integer;
  bestf:real;
begin
  for i:=0 to popsize-2 do begin
    bestj:=i;
    bestf:=fitness[bestj];
    for j:=i+1 to popsize-1 do begin
      if fitness[j]>bestf then begin
        bestj:=j;
        bestf:=fitness[bestj];
      end;
    end;

    fitness[bestj]:=fitness[i];
    fitness[i]:=bestf;
    swapmembers(i, bestj)
  end;
end;

procedure tenvironment.init;
var i, j:integer;
  pom:int64;
begin
{$IFDEF NORANDOM}
  randseed:=0;
{$ELSE}
  Randomize;
{$ENDIF}

  SetLength(population, popsize, entriesnum);
  SetLength(offspring, popsize, entriesnum);
  SetLength(fitness, popsize);
  for i:=0 to entriesnum-1 do begin
    if entries[i].randomization > 0 then begin
      if entries[i].datatype=0 then begin
        pom:=1 + trunc(entries[i].max) - trunc(entries[i].min);
        if pom>high(integer) then pom:=high(integer);
        for j:=0 to popsize-1 do
          population[j][i] := entries[i].min + random(pom);
      end;

      if entries[i].datatype=1 then begin
        pom:=1 + trunc((entries[i].max - entries[i].min) / entries[i].step);
        if pom>high(integer) then pom:=high(integer);
        for j:=0 to popsize-1 do
          population[j][i] := entries[i].min + random(pom) * entries[i].step;
      end;

      if entries[i].randomization =1 then population[0][i] := entries[i].initval;
    end else begin
      for j:=0 to popsize-1 do population[j][i] := entries[i].initval;
    end;
  end;
end;

procedure tenvironment.writeoutput(filename:string; index:integer);
var t:textfile;
    i:integer;
begin
  assignfile(t,filename);
  rewrite(t);
  writeln(t, 'This is output file of Gene genius');
  for i:=0 to entriesnum-1 do begin
    writeln(t, entries[i].name);
    if entries[i].datatype=0 then writeln(t, trunc(population[index][i]))
    else writeln(t, population[index][i]:1:3);
  end;
  closefile(t);
end;

procedure tenvironment.loadinput(filename:string; index:integer);
var t:textfile;
begin
  assignfile(t,filename);
  reset(t);
  readln(t);
  readln(t, fitness[index]);
  closefile(t);
end;

procedure tenvironment.saveentries(filename:string);
var t:textfile;
    i:integer;
begin
  assignfile(t,filename);
  rewrite(t);
  writeln(t, 'This is entries file of Gene genius');
  writeln(t, entriesnum);
  for i:=0 to entriesnum-1 do begin
    writeln(t, entries[i].name);
    writeln(t, entries[i].datatype);
    writeln(t, entries[i].initval);
    writeln(t, entries[i].randomization);
    writeln(t, entries[i].min);
    writeln(t, entries[i].max);
    writeln(t, entries[i].step);
  end;
  closefile(t);
end;

procedure tenvironment.loadentries(filename:string);
var t:textfile;
    i:integer;
    s:string;
begin
  assignfile(t,filename);
  reset(t);
  readln(t);
  readln(t, s);
  entriesnum:=strtoint(s);
  for i:=0 to entriesnum-1 do begin
    entries[i]:=entry.Create;

    readln(t, entries[i].name);
    readln(t, entries[i].datatype);
    readln(t, entries[i].initval);
    readln(t, entries[i].randomization);
    readln(t, entries[i].min);
    readln(t, entries[i].max);
    readln(t, entries[i].step);
  end;
  closefile(t);
end;

end.
