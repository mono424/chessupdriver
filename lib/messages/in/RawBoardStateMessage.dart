import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';
import 'package:chessupdriver/models/RawBoardState.dart';

class RawBoardStateMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xFD, 0xFD];
  final int length = 10;

  RawBoardState state;

  RawBoardStateMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
    state = RawBoardState.fromBytes(message.sublist(2, 10));
  }
}