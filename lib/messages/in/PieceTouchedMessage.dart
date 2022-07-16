import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/ChessupProtocol.dart';

class PieceTouchedMessage extends ChessupMessageIn {
  static const headerPrefix = [0xB8];
  final int length = 3;

  String square;
  String piece;
  
  PieceTouchedMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
    square = ChessupProtocol.squares[message[2]];
    piece = ChessupProtocol.pieces[message[3]];
  }
}