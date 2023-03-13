enum GameEndType {
  WHITE_WIN_MATE(1),
  WHITE_WIN_TIME(2),
  WHITE_RESIGNS(3),
  BLACK_WIN_MATE(4),
  BLACK_WIN_TIME(5),
  BLACK_RESIGNS(6),
  DRAW_ACCEPTED(7),
  DRAW_THREE_FOLD(8),
  DRAW_FIFTY_MOVE(9),
  DRAW_INSUFFICIENT_MATERIAL(10),
  STALEMATE(11);

  const GameEndType(this.value);
  final int value;
}