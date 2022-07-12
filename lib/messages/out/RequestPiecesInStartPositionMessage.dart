import 'package:chessupdriver/ChessupMessage.dart';

class RequestPiecesInStartPositionMessage extends ChessupMessageOut {
  static const headerPrefix = [0xB0];

  RequestPiecesInStartPositionMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}