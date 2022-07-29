import 'package:chessupdriver/ChessUpMessage.dart';

class ResetGameMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x64];

  ResetGameMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}