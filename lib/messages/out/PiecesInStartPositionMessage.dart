import 'package:chessupdriver/ChessUpMessage.dart';

class PiecesInStartPositionMessage extends ChessUpMessageOut {
  static const headerPrefix = [0xB0];

  PiecesInStartPositionMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix
    ];
  }
}