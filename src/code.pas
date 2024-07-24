// Copyright 2024 Rick Rutt
// Adapted from https://github.com/sto3psl/game-of-live by Fabian Gündel.

unit code;

{$mode objfpc}{$H+}

{$WARN 5024 off : Parameter "$1" not used}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Menus;

type
  TForm1 = class(TForm)
    GenLabel: TLabel;
    FieldEdit: TEdit;
    FieldImage: TImage;
    Timer1: TTimer;
    RandomCheck: TCheckBox;
    ButtonStart: TButton;
    ClearButton: TButton;
    FigureBox: TComboBox;
    DrawGroup: TGroupBox;
    SpeedBar: TTrackBar;
    ButtonNext: TButton;
    GenBox: TGroupBox;
    SlowLabel: TLabel;
    FastLabel: TLabel;
    ButtonPause: TButton;
    SizeBox: TGroupBox;
    xEdit: TEdit;
    yEdit: TEdit;
    xLabel: TLabel;
    SizeButton: TButton;
    HeadLabel1: TLabel;
    HeadLabel3: TLabel;
    Label1: TLabel;
    procedure FieldImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FigureBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FieldImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure GenLabelClick(Sender: TObject);
    procedure RandomCheckClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure FieldImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedBarChange(Sender: TObject);
    procedure ButtonPauseClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure SizeButtonClick(Sender: TObject);

  private
    xMouse, yMouse: integer;
    xCell, yCell: integer;

    xSize, ySize: integer;
    gen: integer;
    drawOnDrag: boolean;

    procedure Size;
    procedure rules;
    procedure CellPosition;
    procedure generation;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  cells,
  constants,
  figures;

var
  figureTool: TFigureTool;

procedure TForm1.Size;
var
  i,j, XWidth, YHeight: integer;
begin
SizeButton.Enabled := false;

drawOnDrag := false;
xSize := strtoint(xEdit.Text);
ySize := strtoint(yEdit.Text);
setlength(Cell,xSize+1,ySize+1);
XWidth  := xSize * PIXELS_PER_CELL;
YHeight := ySize * PIXELS_PER_CELL;

FieldImage.Width  := XWidth;
FieldImage.Height := YHeight;

if (figureTool = NIL) then begin
  figureTool := TFigureTool.Create;
end;

figureTool.XMax := xSize;
figureTool.YMax := ySize;

for i:=0 to xSize do
  begin
    for j:=0 to ySize do
    begin
      Cell[i,j]:=TCell.Create(FieldImage, i * PIXELS_PER_CELL, j * PIXELS_PER_CELL, RandomCheck.Checked);
    end;
  end;
  with Fieldimage.Canvas do
  begin
    Brush.Color:= clblack;
    Rectangle(0, 0, XWidth, YHeight);
  end;

if (XWidth > 600) then begin
  Width := XWidth + 110;
end;

Height := FieldImage.Height + 250;

FieldImage.Left:= (Width div 2) - (FieldImage.Width div 2);

SizeButton.Enabled := true;
end;

procedure TForm1.rules;
var i,j: integer;
begin
  for i:=0 to xSize do
    begin
    for j:=0 to ySize do
      begin
        if (Cell[i,j].neighbor=3) and (not Cell[i,j].alive) then
          begin
           Cell[i,j].alive:= true;
           Cell[i,j].live(FieldImage);
          end
        else if (Cell[i,j].neighbor<2) and (Cell[i,j].alive) then
           begin
           Cell[i,j].alive:= false;
           Cell[i,j].live(FieldImage);
          end
        else if ((Cell[i,j].neighbor=2) or (Cell[i,j].neighbor=3))
                and (Cell[i,j].alive) then
           begin
           Cell[i,j].alive:= true;
           Cell[i,j].live(FieldImage);
          end
        else if (Cell[i,j].neighbor>3) and (Cell[i,j].alive) then
           begin
           Cell[i,j].alive:= false;
           Cell[i,j].live(FieldImage);
          end;
      end;
    end;
end;

procedure TForm1.CellPosition;
begin
  xMouse := xMouse div PIXELS_PER_CELL;
  xMouse := trunc(xMouse);
  xMouse := xMouse * PIXELS_PER_CELL;

  yMouse := yMouse div PIXELS_PER_CELL;
  yMouse := trunc(yMouse);
  yMouse := yMouse * PIXELS_PER_CELL;

  xCell := xMouse div PIXELS_PER_CELL;
  yCell := yMouse div PIXELS_PER_CELL;
end;

procedure TForm1.FieldImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if drawOnDrag then begin
    xMouse := X;
    yMouse := Y;
    CellPosition;
    Cell[xCell, yCell].alive := true;
    Cell[xCell, yCell].live(FieldImage);
  end;
end;

procedure TForm1.FigureBoxChange(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Position:= poScreenCenter;
gen:=0;
Size;
end;

procedure TForm1.FieldImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  xMouse := X;
  yMouse := Y;
  CellPosition;

  drawOnDrag := false;

  if FigureBox.Text = 'Cell' then
  begin
    drawOnDrag := true;
    if FieldImage.Canvas.Pixels[X,Y] = clblack then
    begin
      Cell[xCell, yCell].alive := true;
    end else begin
      Cell[xCell, yCell].alive := false;
    end;
    Cell[xCell, yCell].live(FieldImage);
  end
  else if FigureBox.Text= 'f-Pentomino' then figureTool.fpentomino(FieldImage, xCell, yCell)
  else if FigureBox.Text= 'Glider' then figureTool.Glider(FieldImage, xCell, yCell)
  else if FigureBox.Text= 'Spaceship (lightweight)' then figureTool.LSpaceship(FieldImage, xCell, yCell)
  else if FigureBox.Text= 'Spaceship (middleweight)' then figureTool.MSpaceship(FieldImage, xCell, yCell)
  else if FigureBox.Text= 'Spaceship (heavyweight)' then figureTool.HSpaceship(FieldImage, xCell, yCell)
  else if FigureBox.Text= 'Gosper Gun' then figureTool.GosperGun(FieldImage, xCell, yCell);
end;

procedure TForm1.generation;
var i, j, ip1, im1, jp1, jm1: integer;
begin
  for i := 0 to xSize - 1 do
    begin
    for j := 0 to ySize - 1 do
      begin
        // Implement index bounds check with wraparound.
        if (i > 0) then im1 := i - 1 else im1 := xSize - 1;
        if (j > 0) then jm1 := j - 1 else jm1 := ySize - 1;

        if (i < xSize - 1) then ip1 := i + 1 else ip1 := 0;
        if (j < ySize - 1) then jp1 := j + 1 else jp1 := 0;

        Cell[i,j].neighbor:=0;

        if Cell[im1, jm1].alive then
          Inc (Cell[i, j].neighbor);

        if Cell[i, jm1].alive then
          Inc (Cell[i,j].neighbor);

        if Cell[ip1, jm1].alive then
          Inc (Cell[i,j].neighbor);

        if Cell[im1, j].alive then
          Inc (Cell[i,j].neighbor);

        if Cell[ip1, j].alive then
          Inc (Cell[i,j].neighbor);

        if Cell[im1, jp1].alive then
          Inc (Cell[i,j].neighbor);

        if Cell[i, jp1].alive then
          Inc (Cell[i,j].neighbor);

        if Cell[ip1, jp1].alive then
          Inc (Cell[i,j].neighbor);
      end;
    end;
rules;
Inc(gen);
FieldEdit.Text:= inttostr (gen);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  generation;
  Timer1.Enabled := true;
end;

procedure TForm1.GenLabelClick(Sender: TObject);
begin

end;

procedure TForm1.RandomCheckClick(Sender: TObject);
var i,j:integer;
begin
  for i := 0 to xSize do begin
    for j := 0 to ySize do begin
      Cell[i,j] := TCell.Create(FieldImage, i * PIXELS_PER_CELL, j * PIXELS_PER_CELL, RandomCheck.Checked);
    end;
  end;
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  if ButtonStart.Caption = 'Start' then begin
    Timer1.Enabled := true;
    ButtonStart.Caption := 'Stop';
    ButtonPause.Caption := 'Pause';
    ButtonPause.Enabled := true;
    ButtonNext.Enabled := false;
    FigureBox.Enabled := false;
    RandomCheck.Enabled := false;
    ClearButton.Enabled := false;
    SizeButton.Enabled := false;
  end else begin
    Timer1.Enabled := false;
    ButtonStart.Caption := 'Start';
    ButtonPause.Caption := 'Pause';
    ButtonPause.Enabled := false;
    ButtonNext.Enabled := true;
    FigureBox.Enabled := true;
    RandomCheck.Enabled := true;
    ClearButton.Enabled := true;
    SizeButton.Enabled := true;
    ClearButton.Click;
  end;
end;

procedure TForm1.ClearButtonClick(Sender: TObject);
var i,j:integer;
begin
  for i:=0 to xSize do begin
    for j:=0 to ySize do begin
      Cell[i,j].alive:= false;
      Cell[i,j].live(FieldImage);
    end;
  end;
  RandomCheck.Checked := false;
  gen := 0;
  FieldEdit.Text := IntToStr(gen);
end;

procedure TForm1.FieldImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  drawOnDrag := false;
end;

procedure TForm1.SpeedBarChange(Sender: TObject);
begin
if SpeedBar.Position=0 then Timer1.Interval:= 100 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=1 then Timer1.Interval:= 90 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=2 then Timer1.Interval:= 80 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=3 then Timer1.Interval:= 70 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=4 then Timer1.Interval:= 60 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=5 then Timer1.Interval:= 50 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=6 then Timer1.Interval:= 40 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=7 then Timer1.Interval:= 30 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=8 then Timer1.Interval:= 20 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=9 then Timer1.Interval:= 10 * TIMER_INTERVAL_UNIT;
if SpeedBar.Position=10 then Timer1.Interval:= 5 * TIMER_INTERVAL_UNIT;
end;

procedure TForm1.ButtonPauseClick(Sender: TObject);
begin
  if ButtonPause.Caption = 'Pause' then begin
    Timer1.Enabled := false;
    ButtonNext.Enabled := true;
    FigureBox.Enabled := true;
    ButtonPause.Caption := 'Run';
  end else begin
    ButtonNext.Enabled := false;
    Timer1.Enabled := true;
    FigureBox.Enabled := false;
    ButtonPause.Caption := 'Pause';
  end;
end;

procedure TForm1.ButtonNextClick(Sender: TObject);
begin
  Timer1.Enabled := false;
  ButtonStart.Caption := 'Stop';
  ButtonPause.Caption := 'Run';
  ButtonPause.Enabled := true;
  generation;
end;


procedure TForm1.SizeButtonClick(Sender: TObject);
var x,y : integer;
begin
  x:= strtoint (xEdit.Text);
  y:= strtoint (yEdit.Text);

  if (x < 10) or (y < 10) or (x > MAX_WIDTH) or (y > MAX_HEIGHT) then begin
    ShowMessage(Format('The grid may only be sized between 10x10 and %dx%d cells.', [MAX_WIDTH, MAX_HEIGHT]));
    xEdit.Text:= inttostr (xSize);
    yEdit.Text:= inttostr (ySize);
  end else begin
    Size;
  end;
end;

end.
