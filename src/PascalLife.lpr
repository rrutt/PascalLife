// Copyright 2024 Rick Rutt
// Adapted from https://github.com/sto3psl/game-of-live by Fabian Gündel.

program PascalLife;

{$mode objfpc}{$H+}

uses
  Forms, Interfaces, SysUtils,
  code,
  constants;

{$R *.res}

begin
  Randomize;

  Application.Scaled:=True;
  Application.Initialize;
  Application.Title:='PascalLife';
  Application.CreateForm(TForm1, Form1);
  Form1.Label1.Caption := Format('Min 10x10    Max %dx%d', [MAX_WIDTH, MAX_HEIGHT]);
  Form1.xEdit.Text := Format('%d', [INITIAL_WIDTH]);
  Form1.yEdit.Text := Format('%d', [INITIAL_HEIGHT]);
  Form1.SizeButton.Click;
  Application.Run;
end.
