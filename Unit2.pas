unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, System.SyncObjs;

type
  TForm2 = class(TForm)
    LabelMinions: TLabel;
    LabelProgress: TLabel;
    StatusBar1: TStatusBar;
    ButtonStartShopping: TButton;
    EditMinionsCount: TEdit;
    EditBasketCapacity: TEdit;
    LabelMinionsCount: TLabel;
    LabelBasketCapacity: TLabel;
    ProgressBarCart: TProgressBar;
    procedure ButtonStartShoppingClick(Sender: TObject);
  private
    FMinions: Integer;
    FCartCapacity: Integer;
    FCartFilled: Integer;
    FShoppingStarted: Boolean;
    FCartCriticalSection: TCriticalSection;
    FMinionThreads: TArray<TThread>;
    procedure MinionShoppingThreadProc(i: Integer);
    procedure UpdateUI;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

constructor TForm2.Create(AOwner: TComponent);
begin
  inherited;
  Randomize;
  FShoppingStarted := False;
  FCartCriticalSection := TCriticalSection.Create;
end;


procedure TForm2.ButtonStartShoppingClick(Sender: TObject);
var
  I: Integer;

  procedure CreateMinionThread(AIndex: Integer);
  begin
    FMinionThreads[AIndex] := TThread.CreateAnonymousThread(
      procedure
      begin
        MinionShoppingThreadProc(AIndex);
      end
    );
  end;

begin
if FShoppingStarted then
    Exit;

  FShoppingStarted := True;
  FMinions := StrToIntDef(EditMinionsCount.Text, 0);
  FCartCapacity := StrToIntDef(EditBasketCapacity.Text, 0);
  FCartFilled := 0;
  ProgressBarCart.Max := FCartCapacity;

  SetLength(FMinionThreads, FMinions);
  for I := 0 to FMinions - 1 do
    CreateMinionThread(I);

  for I := 0 to FMinions - 1 do
    FMinionThreads[I].Start;
end;




procedure TForm2.MinionShoppingThreadProc(i: Integer);
var
  MinionSpeed: Integer;
  Total: Integer;
  MinionLabel: TLabel;
begin
  MinionSpeed := Random(300) + 100;
  Total := 0;

  TThread.Synchronize(nil,
    procedure
    begin
      MinionLabel := TLabel.Create(Self);
      MinionLabel.Parent := Self;
      MinionLabel.Caption := 'Minion ' + IntToStr(i);
      MinionLabel.Left := 10;
      MinionLabel.Top := 260 + i * 20;
      MinionLabel.Visible := True;
    end
  );

  while not TThread.CurrentThread.CheckTerminated do
  begin
    Sleep(MinionSpeed);

    FCartCriticalSection.Enter;
    try
      if FCartFilled < FCartCapacity then
      begin
        Inc(FCartFilled);
        Inc(Total);
        TThread.Synchronize(nil,
          procedure
          begin
            MinionLabel.Caption := 'Minion ' + IntToStr(i) + ' Total: ' + IntToStr(Total);
          end
        );
        TThread.Queue(nil, UpdateUI);
      end
      else
      begin
        Break;
      end;
    finally
      FCartCriticalSection.Leave;
    end;
  end;
end;


procedure TForm2.UpdateUI;
begin
  ProgressBarCart.Position := FCartFilled;
  LabelMinions.Caption := 'Minions in shop: ' + IntToStr(FMinions);
  LabelProgress.Caption := 'Ñurrent amount: ' +
  IntToStr(FCartFilled * 100 div FCartCapacity) + '%';
end;

end.

