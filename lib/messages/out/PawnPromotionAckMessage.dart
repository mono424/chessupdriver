import 'package:chessupdriver/ChessUpMessage.dart';

class PawnPromotionAckMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x23];

  PawnPromotionAckMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}