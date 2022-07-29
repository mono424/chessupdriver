import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class PieceReleasedMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xBB];
  final int length = 1;
  
  PieceReleasedMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
  }
}