import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/ChessupProtocol.dart';

class MoveFromBoardMessage extends ChessupMessageIn {
  static const headerPrefix = [0xA3, 0x35];
  final int length = 6;

  String from;
  String to;

  MoveFromBoardMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
    int source = message[2] + message[3] * 8;
    int destination = message[4] + message[5] * 8;
    from = ChessupProtocol.squares[source];
    to = ChessupProtocol.squares[destination];
  }
}