import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';
import 'package:chessupdriver/ChessUpProtocol.dart';
import 'package:chessupdriver/models/CastelingOptions.dart';
import 'package:chessupdriver/models/PlayerColor.dart';

class BoardPositionMessage extends ChessUpMessageIn {
  static const headerPrefix = [0x67];
  final int length = 72;

  late Map<String, String?> board;
  late PlayerColor turn;
  late CastelingOptions castelingOptions;
  late bool enPassant;
  late int halfMove;
  late int fullMove;

  BoardPositionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);

    board = {};
    for (var i = 1; i < 65; i++) {
      board[ChessUpProtocol.squares[i - 1]] = ChessUpProtocol.pieces[message[i]];
    }
    turn = PlayerColor.values[message[65]];
    castelingOptions = CastelingOptions(message[66] == 1, message[67] == 1, message[68] == 1, message[69] == 1);
    enPassant = message[70] == 1;
    halfMove = message[71];
    fullMove = message[72];
  }
}