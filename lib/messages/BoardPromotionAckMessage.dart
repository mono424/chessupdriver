import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class BoardPromotionAckMessage extends ChessupMessageIn {
  static const headerPrefix = [0x23];
  final int length = 1;

  BoardPromotionAckMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
  }
}