import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupProtocol.dart';

class PawnPromotionMessage extends ChessupMessageOut {
  static const headerPrefix = [0x97];

  final String piece;

  PawnPromotionMessage(this.piece);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ChessupProtocol.pieces.entries.firstWhere((e) => e.value == piece.toUpperCase()).key,
    ];
  }
}