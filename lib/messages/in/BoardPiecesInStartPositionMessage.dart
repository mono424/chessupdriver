import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class BoardPiecesInStartPositionMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xB0];
  final int length = 2;

  late bool isInStartPosition;
  
  BoardPiecesInStartPositionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
    isInStartPosition = message[1] == 1;
  }
}