import 'package:chessupdriver/models/GameType.dart';
import 'package:chessupdriver/models/PlayerColor.dart';

class GameSettings {
  final GameType gameType;
  final int whiteType;
  final int whiteLevel;
  final bool whiteButtonLock;
  final int blackType;
  final int blackLevel;
  final bool blackButtonLock;
  final int hintLimit;
  final int whiteRemote;
  final int blackRemote;
  final PlayerColor deviceUser;

  GameSettings({this.gameType, this.whiteType, this.whiteLevel, this.whiteButtonLock, this.blackType, this.blackLevel, this.blackButtonLock, this.hintLimit, this.whiteRemote, this.blackRemote, this.deviceUser});

  List<int> toBytes() {
    return [
      gameType.index,

    ];
  }
}