import 'package:chessupdriver/ChessupMessage.dart';

class PawnPromotionAckMessage extends ChessupMessageOut {
  static const headerPrefix = [0x23];

  PawnPromotionAckMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}