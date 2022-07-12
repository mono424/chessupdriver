import 'package:chessupdriver/ChessupMessage.dart';

class MoveAckMessage extends ChessupMessageOut {
  static const headerPrefix = [0x21];

  MoveAckMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}