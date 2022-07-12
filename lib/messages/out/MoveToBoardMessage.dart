import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupProtocol.dart';

class MoveToBoardMessage extends ChessupMessageOut {
  static const headerPrefix = [0x99];

  final String from;
  final String to;

  MoveToBoardMessage(this.from, this.to);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ChessupProtocol.squares.indexOf(from),
      ChessupProtocol.squares.indexOf(to),
    ];
  }
}