import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpMessageException.dart';

class BatteryChargingMessage extends ChessUpMessageIn {
  static const headerPrefix = [0x33];
  final int length = 2;

  late bool charging;
  
  BatteryChargingMessage(List<int> message) : super(message) {
    if (message.length < length) throw ChessUpMessageTooShortException(message);
    charging = message[1] == 1;
  }
}