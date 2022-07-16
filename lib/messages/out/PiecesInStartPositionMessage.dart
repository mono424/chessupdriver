import 'package:chessupdriver/ChessupMessage.dart';

class PiecesInStartPositionMessage extends ChessupMessageOut {
  static const headerPrefix = [0xB0];

  PiecesInStartPositionMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix
    ];
  }
}