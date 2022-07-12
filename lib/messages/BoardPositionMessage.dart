import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/ChessupProtocol.dart';

class BoardPositionMessage extends ChessupMessageIn {
  static const headerPrefix = [0x67];
  final int length = 72;

  Map<String, String> board;

  BoardPositionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);

    board = {};
    for (var i = 1; i < length; i++) {
      board[ChessupProtocol.squares[i]] = ChessupProtocol.pieces[message[i]];
    }
  }
}