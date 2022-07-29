import 'dart:convert';

import 'package:chessupdriver/ChessUpMessage.dart';

class LoadFenMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x66];

  final String fen;

  LoadFenMessage(this.fen);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ...fen.codeUnits,
    ];
  }
}