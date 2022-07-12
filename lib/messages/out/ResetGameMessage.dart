import 'package:chessupdriver/ChessupMessage.dart';

class ResetGameMessage extends ChessupMessageOut {
  static const headerPrefix = [0x64];

  ResetGameMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}