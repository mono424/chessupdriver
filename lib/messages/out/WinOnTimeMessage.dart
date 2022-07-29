import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/models/PlayerColor.dart';

class WinOnTimeMessage extends ChessUpMessageOut {
  static const headerPrefix = [0xB6];

  final PlayerColor winner;

  WinOnTimeMessage(this.winner);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      winner.index
    ];
  }
}