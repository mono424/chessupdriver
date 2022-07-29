import 'package:chessupdriver/ChessUpMessage.dart';

class MoveAckMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x21];

  MoveAckMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}