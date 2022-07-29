import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class BoardInfoMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xB2];
  final int length = 17;

  String modelNumber;
  
  BoardInfoMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
    modelNumber = String.fromCharCodes(message.sublist(1, 17));
  }
}