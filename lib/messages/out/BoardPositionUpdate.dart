import 'dart:convert';

import 'package:chessupdriver/ChessUpMessage.dart';

class BoardPositionUpdate extends ChessUpMessageOut {
  static const headerPrefix = [0x51];

  final String fen;

  BoardPositionUpdate(this.fen);
  
  @override
  List<int> toBytes() {
    List<String> fenParts = fen.split(' ');
    if (fenParts.length < 6) throw ArgumentError('Invalid FEN string');

    int halfmoveClock = int.parse(fenParts[4]);
    int fullmoveNumber = int.parse(fenParts[5]);

    String fenString = "/" + fenParts.sublist(0, 4).join(" ") + " ";

    return [
      ...headerPrefix,
      ...utf8.encode(fenString),
      halfmoveClock,
      fullmoveNumber,
    ];
  }
}