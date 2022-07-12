import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/models/WinnerColor.dart';

class WinOnTimeMessage extends ChessupMessageOut {
  static const headerPrefix = [0xB6];

  final WinnerColor winner;

  WinOnTimeMessage(this.winner);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      winner.index
    ];
  }
}