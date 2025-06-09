unit fly2cfg;

 {Fly 2 - slaughter in the rain
  fly2cfg unit
  V0.3
  By suglasp}

interface

Uses basetypes, sysutils;

 //constants
  const cfgfilename: String = 'fly2cfg.dat';

 //types
  type TCfgCore = Packed Record
                   Fullscreen, Sound, RndDifficulty, Playintro: FLYBool;
                   Player: String[255];
                   Difficulty: FLYByte; //(0=slow; 1=medium; 2=fast)
                   AScore: FLYWord;
                  end;

       TCfgfile = File of TCfgcore;

 //procedures
  procedure LoadData(Afile: String);
  procedure SaveData(Afile: String);

 //variables
  var cfgfile: Tcfgfile;
      cfgdata: Tcfgcore;

implementation

procedure LoadData(Afile: String);
begin
 If Fileexists(Afile) then
  begin
   AssignFile(cfgfile, Afile);
   Reset(Cfgfile);
    Read(cfgfile, cfgdata);
   Closefile(cfgfile);
  end else
   begin
    With cfgdata do
     begin
      fullscreen := False;
      Sound := True;
      RndDifficulty := False;
      PlayIntro := True;
      Player := 'No Name';
      Difficulty := 1;
      AScore := 0;
     end;
    SaveData(GetappDir + cfgfilename);
   end;
end;

procedure SaveData(Afile: String);
begin
 AssignFile(cfgfile, Afile);
 ReWrite(Cfgfile);
  Write(cfgfile, cfgdata);
 Closefile(cfgfile);
end;

end.
