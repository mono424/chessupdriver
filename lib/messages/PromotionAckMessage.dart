import 'package:chessupdriver/ChessupMessage.dart';

class PromotionAckMessage extends ChessupMessageOut {
  static const headerPrefix = [0x23];

  PromotionAckMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
    ];
  }
}