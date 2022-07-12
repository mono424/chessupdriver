import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class BoardPawnPromotionAckMessage extends ChessupMessageIn {
  static const headerPrefix = [0x23];
  final int length = 1;

  String piece;

  BoardPawnPromotionAckMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
  }
}