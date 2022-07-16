import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class PieceReleasedMessage extends ChessupMessageIn {
  static const headerPrefix = [0xBB];
  final int length = 1;
  
  PieceReleasedMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
  }
}