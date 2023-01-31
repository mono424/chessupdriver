import 'package:chessupdriver/ChessUpMessage.dart';

class EnableRawStreamMessage extends ChessUpMessageOut {
  static const headerPrefix = [0x50];

  EnableRawStreamMessage();
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix
    ];
  }
}