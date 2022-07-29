import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';
import 'package:chessupdriver/ChessUpProtocol.dart';

class MoveFromBoardMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xA3, 0x35];
  final int length = 6;

  String from;
  String to;

  MoveFromBoardMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
    int source = message[2] + message[3] * 8;
    int destination = message[4] + message[5] * 8;
    from = ChessUpProtocol.squares[source];
    to = ChessUpProtocol.squares[destination];
  }
}