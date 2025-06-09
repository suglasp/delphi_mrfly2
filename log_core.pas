unit log_core;

 {Fly 2 - slaughter in the rain
  log unit
  V0.1
  By suglasp}

interface

Uses forms, sysutils;

 //constants
  Const LOG_FILENAME: String = 'log.txt';

 //functions
  function logopened: Boolean;

 //Procedures
  procedure OpenLog;
  procedure Writelog(Amsg: String);
  procedure closelog;

 //variables
  var log_open: Boolean = false;
      logf: Textfile;

implementation

function logopened: Boolean;
begin
 If log_open then result := True else result := false;
end;

procedure OpenLog;
begin
 Assignfile(logf, Extractfilepath(Application.exename) + LOG_FILENAME);
 ReWrite(logf);
 Log_open := True;
end;

procedure Writelog(Amsg: String);
begin
 If not logopened then Openlog;
 writeln(logf, ('[' + Timetostr(now) + '] ' + Amsg));
end;

procedure closelog;
begin
 closefile(logf);
 log_open := false;
end;

end.
