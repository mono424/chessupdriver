import 'package:chessupdriver/ChessUpMessage.dart';

class RequestBoardPositionMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x67];

  RequestBoardPositionMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}