import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/ChessupProtocol.dart';
import 'package:chessupdriver/models/CastelingOptions.dart';
import 'package:chessupdriver/models/PlayerColor.dart';

class BoardPositionMessage extends ChessupMessageIn {
  static const headerPrefix = [0x67];
  final int length = 72;

  Map<String, String> board;
  PlayerColor turn;
  CastelingOptions castelingOptions;
  bool enPassant;
  int halfMove;
  int fullMove;

  BoardPositionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);

    board = {};
    for (var i = 1; i < 65; i++) {
      board[ChessupProtocol.squares[i - 1]] = ChessupProtocol.pieces[message[i]];
    }
    turn = PlayerColor.values[message[65]];
    castelingOptions = CastelingOptions(message[66] == 1, message[67] == 1, message[68] == 1, message[69] == 1);
    enPassant = message[70] == 1;
    halfMove = message[71];
    fullMove = message[72];
  }
}