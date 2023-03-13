import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';
import 'package:chessupdriver/ChessUpProtocol.dart';

class PieceTouchedMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xB8];
  final int length = 3;

  late String square;
  late String? piece;
  
  PieceTouchedMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
    square = ChessUpProtocol.squares[message[1]];
    piece = ChessUpProtocol.pieces[message[2]];
  }
}