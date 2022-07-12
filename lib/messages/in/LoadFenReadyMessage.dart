import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class LoadFenReadyMessage extends ChessupMessageIn {
  static const headerPrefix = [0xB1];
  final int length = 1;
  
  LoadFenReadyMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
  }
}