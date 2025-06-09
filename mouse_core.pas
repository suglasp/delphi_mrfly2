unit mouse_core;

 {Fly 2 - slaughter in the rain
  mouse unit
  V0.1
  By suglasp}

interface

Uses Windows, types, controls, forms;

  //types
   Type TMouseState = (m_Visible, m_Invisible);

  //functions
   function MouseIntersect(RectArea, intersect: Trect): Boolean;

  //procedures
   procedure MouseState(AState: TMouseState);
   procedure MousePos(X, Y: Integer);

  //variables
   var MX, MY: Integer;

implementation

function MouseIntersect(RectArea, intersect: Trect): Boolean;
begin
 If intersectrect(Rectarea, Rect(MX, MY, MX + 1, MY + 1), intersect) then result := true else result := false;
end;

procedure MouseState(AState: TMouseState);
begin
 Case AState of
  m_Visible: ShowCursor(True);
  m_Invisible: Showcursor(False);
 End;
end;

procedure MousePos(X, Y: Integer);
begin
 SetCursorPos(X, Y);
end;

end.
