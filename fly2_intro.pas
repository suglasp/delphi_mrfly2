unit fly2_intro;

interface

Uses graphics, sysutils, basetypes, mainfly2, fly2cfg, winsound_core;

 //constants
  const DELAY: FLYInt = 5000;
        Introfile: String = 'intro.bmp';
        Introsound: String = 'intro.wav';

 //type

 //procedures
  Procedure RenderIntro(IntroCanvas: TCanvas);

 //variables
  Var IntroPic: Tbitmap;

implementation

Procedure RenderIntro(IntroCanvas: TCanvas);
begin
 Form1.Setclock(DELAY);
 IntroPic := Tbitmap.Create;
 IntroPic.LoadFromFile(GetAppdir + texdir + Introfile);
 IntroCanvas.Draw(0, 0, IntroPic);
 Freeandnil(IntroPic);
 If cfgdata.Sound then Play(GetAppDir + snddir + Introsound, False);
end;

end.
