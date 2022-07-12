import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class BoardInfoMessage extends ChessupMessageIn {
  static const headerPrefix = [0xB2];
  final int length = 17;

  String modelNumber;
  
  BoardInfoMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
    modelNumber = String.fromCharCodes(message.sublist(1, 17));
  }
}