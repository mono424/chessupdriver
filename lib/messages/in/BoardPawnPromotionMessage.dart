import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/ChessupProtocol.dart';

class BoardPawnPromotionMessage extends ChessupMessageIn {
  static const headerPrefix = [0xA3, 0x35];
  final int length = 3;

  String piece;

  BoardPawnPromotionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
    piece = ChessupProtocol.pieces[message[2]];
  }
}