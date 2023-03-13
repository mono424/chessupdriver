import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';
import 'package:chessupdriver/ChessUpProtocol.dart';

class BoardPawnPromotionMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xA3, 0x35];
  final int length = 3;

  late String? piece;

  BoardPawnPromotionMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
    piece = ChessUpProtocol.pieces[message[2]];
  }
}