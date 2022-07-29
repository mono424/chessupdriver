import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class BoardPromotionAckMessage extends ChessUpMessageIn {
  static const headerPrefix = [0x23];
  final int length = 1;

  BoardPromotionAckMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
  }
}