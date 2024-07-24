unit cells;

{$mode objfpc}{$H+}

interface

uses
  Classes, ExtCtrls, Graphics, SysUtils;

type
  TCell = class

  private
    x: integer;
    y: integer;
    color: TColor;

  public
    neighbor: integer;
    alive: boolean;

    Constructor Create(const theImage: TImage; const xPos: integer; const yPos: integer; const randomCell: boolean);
    procedure live(const theImage: TImage);
  end;

var
  Cell: array of array of TCell;

implementation

uses
  constants;

Constructor TCell.Create(const theImage: TImage; const xPos: integer; const yPos: integer; const randomCell: boolean);
var r: integer;
begin
  if randomCell then r:= random(RANDOM_SPARSENESS)
  else r:= 1;

  inherited create;

  x := xPos;
  y := yPos;

  neighbor := 0;

  if r=0 then alive := true
  else alive := false;

  live(theImage);
end;

procedure TCell.live(const theImage: TImage);
begin
  if (alive) then begin
    color := clLime
  end else begin
    color := clBlack
  end;

  with theImage.Canvas do begin
    Brush.Color:= color;
    Pen.Color:= color;
    Rectangle(x, y, x + PIXELS_PER_CELL, y + PIXELS_PER_CELL);
  end;
end;

end.

