// Copyright 2024 Rick Rutt
// Adapted from https://github.com/sto3psl/game-of-live by Fabian Gündel.

unit figures;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  cells;

type
  TFigureTool = class
  private
    procedure CellIndex(const theImage: TImage; const x: integer; const y:integer);
    procedure square(const theImage: TImage; const x: integer; const y:integer);
    procedure sixblocks(const theImage: TImage; const x: integer; const y:integer);
    procedure sglider(const theImage: TImage; const x: integer; const y:integer);
    procedure sglider2(const theImage: TImage; const x: integer; const y:integer);

  public
    XMax : integer;
    YMax : integer;
    procedure fpentomino(const theImage: TImage; const x: integer; const y:integer);
    procedure glider(const theImage: TImage; const x: integer; const y:integer);
    procedure LSpaceship(const theImage: TImage; const x: integer; const y:integer);
    procedure MSpaceship(const theImage: TImage; const x: integer; const y:integer);
    procedure HSpaceship(const theImage: TImage; const x: integer; const y:integer);
    procedure GosperGun(const theImage: TImage; const x: integer; const y:integer);
  end;

implementation

procedure TFigureTool.CellIndex(const theImage: TImage; const x: integer; const y:integer);
var
  safeX, safeY: integer;
begin
  if (x < 0) then begin
    safeX := XMax + x;
  end else if (x >= XMax) then begin
    safeX := x - XMax;
  end else begin
    safeX := x;
  end;

  if (y < 0) then begin
    safeY := YMax + y;
  end else if (y >= YMax) then begin
    safeY := y - XMax;
  end else begin
    safeY := y;
  end;

  Cell[safeX, safeY].alive := true;
  Cell[safeX, safeY].live(theImage);
end;

//
//Glider
//
procedure TFigureTool.glider(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y+1);
  CellIndex(theImage, x+1,y+2);
  CellIndex(theImage, x,y+2);
  CellIndex(theImage, x-1,y+2);
end;

//
// f-Pentomino
//
procedure TFigureTool.fpentomino(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x,y+1);
  CellIndex(theImage, x,y+2);
  CellIndex(theImage, x-1,y+1);
end;

//
//Spaceship (lightweight)
//
procedure TFigureTool.LSpaceship(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x+2,y);
  CellIndex(theImage, x+3,y);
  CellIndex(theImage, x+3,y+1);
  CellIndex(theImage, x+3,y+2);
  CellIndex(theImage, x-1,y+1);
  CellIndex(theImage, x-1,y+3);
  CellIndex(theImage, x+2,y+3);
end;

//
//Spaceship (middleweight)
//
procedure TFigureTool.MSpaceship(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x+2,y);
  CellIndex(theImage, x+3,y);
  CellIndex(theImage, x+4,y);
  CellIndex(theImage, x+4,y+1);
  CellIndex(theImage, x+4,y+2);
  CellIndex(theImage, x+3,y+3);
  CellIndex(theImage, x-1,y+1);
  CellIndex(theImage, x-1,y+3);
  CellIndex(theImage, x+1,y+4);
end;

//
//Spaceship (heavyweight)
//
procedure TFigureTool.HSpaceship(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x+2,y);
  CellIndex(theImage, x+3,y);
  CellIndex(theImage, x+4,y);
  CellIndex(theImage, x+5,y);
  CellIndex(theImage, x+5,y+1);
  CellIndex(theImage, x+5,y+2);
  CellIndex(theImage, x+4,y+3);
  CellIndex(theImage, x-1,y+1);
  CellIndex(theImage, x-1,y+3);
  CellIndex(theImage, x+1,y+4);
  CellIndex(theImage, x+2,y+4);
end;

procedure TFigureTool.square(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x,y+1);
  CellIndex(theImage, x+1,y+1);
end;

procedure TFigureTool.sixblocks(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x+1,y+1);
  CellIndex(theImage, x-1,y+1);
  CellIndex(theImage, x-1,y+2);
  CellIndex(theImage, x,y+2);
end;

procedure TFigureTool.sglider(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x+2,y+1);
  CellIndex(theImage, x,y+1);
  CellIndex(theImage, x,y+2);
end;

procedure TFigureTool.sglider2(const theImage: TImage; const x: integer; const y:integer);
begin
  CellIndex(theImage, x,y);
  CellIndex(theImage, x+1,y);
  CellIndex(theImage, x+2,y);
  CellIndex(theImage, x,y+1);
  CellIndex(theImage, x+1,y+2);
end;


procedure TFigureTool.GosperGun(const theImage: TImage; const x: integer; const y:integer);
begin
  square(theImage, x,y);
  sixblocks(theImage, x+9,y);
  Sixblocks(theImage, x+23,y-2);
  square(theImage, x+34,y-2);
  sglider(theImage, x+16,y+2);
  sglider(theImage, x+35,y+5);
  sglider2(theImage, x+24,y+10);
end;

end.
