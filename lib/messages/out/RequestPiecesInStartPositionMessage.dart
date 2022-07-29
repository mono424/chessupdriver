import 'package:chessupdriver/ChessUpMessage.dart';

class RequestPiecesInStartPositionMessage extends ChessUpMessageOut {
  static const headerPrefix = [0xB0];

  RequestPiecesInStartPositionMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}