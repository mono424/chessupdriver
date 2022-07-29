import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class LoadFenReadyMessage extends ChessUpMessageIn {
  static const headerPrefix = [0xB1];
  final int length = 1;
  
  LoadFenReadyMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
  }
}