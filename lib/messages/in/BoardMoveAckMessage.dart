import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class BoardMoveAckMessage extends ChessUpMessageIn {
  static const headerPrefix = [0x22];
  final int length = 1;

  BoardMoveAckMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
  }
}