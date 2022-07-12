import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/messages/MoveFromBoardMessage.dart';

// Messages received by the driver from the board.
abstract class ChessupMessageIn {

  static List<int> headerPrefix;
  int length;

  ChessupMessageIn(List<int> message);

  static ChessupMessageIn parse(List<int> message) {
    ChessupMessageIn _message;
    while (message.length > 0) {
      if (_hasPrefix(message, MoveFromBoardMessage.headerPrefix)) {
        _message = MoveFromBoardMessage(message);
        break;
      }
      message.removeAt(0);
    }

    if (_message == null) throw ChessupMessageTooShortException(message);
    return _message;
  }

  static bool _hasPrefix(List<int> message, List<int> prefix) {
    for (int i = 0; i < prefix.length; i++) {
      if (message[i] != prefix[i]) return false;
    }
    return true;
  }

}

// Messages sent by the driver to the board.
abstract class ChessupMessageOut {
  List<int> toBytes();
}