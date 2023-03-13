import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class BoardPawnPromotionAckMessage extends ChessUpMessageIn {
  static const headerPrefix = [0x23];
  final int length = 1;

  late String? piece;

  BoardPawnPromotionAckMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
  }
}