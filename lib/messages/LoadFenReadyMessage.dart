import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class MoveFromBoardMessage extends ChessupMessageIn {
  static const headerPrefix = [0xB1];
  final int length = 1;
  
  MoveFromBoardMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
  }
}