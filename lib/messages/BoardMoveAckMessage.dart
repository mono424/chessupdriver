import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class PawnPromotionMessage extends ChessupMessageIn {
  static const headerPrefix = [0x22];
  final int length = 1;

  PawnPromotionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
  }
}