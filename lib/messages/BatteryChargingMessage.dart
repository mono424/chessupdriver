import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';

class BatteryChargingMessage extends ChessupMessageIn {
  static const headerPrefix = [0x33];
  final int length = 2;

  bool charging;
  
  BatteryChargingMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessupMessageTooShortException(message);
    charging = message[1] == 1;
  }
}