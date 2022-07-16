import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class BoardPiecesInStartPositionMessage extends ChessupMessageIn {
  static const headerPrefix = [0xB0];
  final int length = 2;

  bool isInStartPosition;
  
  BoardPiecesInStartPositionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
    isInStartPosition = message[1] == 1;
  }
}