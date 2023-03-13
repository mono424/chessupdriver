import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/models/GameEndType.dart';

class SendGameEnded extends ChessUpMessageOut {
  static const headerPrefix = [0x52];

  final GameEndType endType;

  SendGameEnded(this.endType);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      endType.value,
    ];
  }
}