import 'package:chessupdriver/ChessupMessage.dart';

class RequestBoardPositionMessage extends ChessupMessageOut {
  static const headerPrefix = [0x67];

  RequestBoardPositionMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}