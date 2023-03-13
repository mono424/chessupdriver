
import 'package:chessupdriver/ChessUpProtocol.dart';

class RawBoardState {
  late Map<String, bool> state;

  RawBoardState(this.state);

  RawBoardState.fromBytes(List<int> bytes) {
    state = Map<String, bool>();
    for (int i = 63; i >= 0; i--) {
      state[ChessUpProtocol.rawSquares[i]] = bytes[i ~/ 8] & 0x01 > 0;
      bytes[i ~/ 8] >>= 1;
    }
  }
}