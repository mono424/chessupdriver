import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/ChessUpProtocol.dart';

class PawnPromotionMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x97];

  final String piece;

  PawnPromotionMessage(this.piece);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ChessUpProtocol.pieces.entries.firstWhere((e) => e.value == piece.toUpperCase()).key,
    ];
  }
}