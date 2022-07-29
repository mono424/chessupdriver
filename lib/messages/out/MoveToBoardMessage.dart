import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpProtocol.dart';

class MoveToBoardMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x99];

  final String from;
  final String to;

  MoveToBoardMessage(this.from, this.to);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ChessUpProtocol.squares.indexOf(from),
      ChessUpProtocol.squares.indexOf(to),
    ];
  }
}