import 'dart:convert';

import 'package:chessupdriver/ChessupMessage.dart';

class LoadFenMessage extends ChessupMessageOut {
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