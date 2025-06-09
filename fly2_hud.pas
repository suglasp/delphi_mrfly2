unit fly2_hud;

 {Fly 2 - slaughter in the rain
  H.U.D unit
  V0.5
  By suglasp}

interface

Uses graphics, sysutils, basetypes;

 //functions

 //procedures
  procedure RenderHUD(Number: FLYWord; nrCanvas: TCanvas);

 //variables
  var nr: TBitmap;

implementation

function ReturnnrFile(NR: FLYByte): String;
begin
 case NR of
  0: Result := 'nr0.bmp';
  1: Result := 'nr1.bmp';
  2: Result := 'nr2.bmp';
  3: Result := 'nr3.bmp';
  4: Result := 'nr4.bmp';
  5: Result := 'nr5.bmp';
  6: Result := 'nr6.bmp';
  7: Result := 'nr7.bmp';
  8: Result := 'nr8.bmp';
  9: Result := 'nr9.bmp';
 end;
end;

procedure RenderHUD(Number: FLYWord; nrCanvas: TCanvas);
Var nrStr: String;
    tmpCHR: Array[0..3] of String;
    nrCNT: FLYByte;
begin
 nrStr := IntToStr(Number);
 nr := TBitmap.Create;
 nr.TransparentColor := $FF00FF;
 nr.Transparent := True;
 Case Length(nrStr) of
  0: nrStr := '0000';
  1: nrStr := '000' + nrStr;
  2: nrStr := '00' + nrStr;
  3: nrStr := '0' + nrStr;
 end;
 For nrCNT := 0 to 3 do
  begin
   tmpCHR[nrCNT] := Copy(nrStr, nrCNT + 1, 1);
   Case nrCNT of
    0: begin
        nr.LoadFromFile(GetAppDir + texdir + ReturnnrFile(StrToInt(tmpCHR[0])));
        nrCanvas.draw(128, 5, nr);
       end;
    1: begin
        nr.LoadFromFile(GetAppDir + texdir + ReturnnrFile(StrToInt(tmpCHR[1])));
        nrCanvas.draw(144, 5, nr);
       end;
    2: begin
        nr.LoadFromFile(GetAppDir + texdir + ReturnnrFile(StrToInt(tmpCHR[2])));
        nrCanvas.draw(160, 5, nr);
       end;
    3: begin
        nr.LoadFromFile(GetAppDir + texdir + ReturnnrFile(StrToInt(tmpCHR[3])));
        nrCanvas.draw(176, 5, nr);
       end;
   end;
  end;
 FreeAndNil(nr);
end;

end.
