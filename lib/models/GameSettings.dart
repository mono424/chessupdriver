import 'package:chessupdriver/models/GameType.dart';
import 'package:chessupdriver/models/PlayerColor.dart';
import 'package:chessupdriver/models/PlayerSettings.dart';

class GameSettings {
  final GameType gameType;
  final PlayerSettings whitePlayer;
  final PlayerSettings blackPlayer;
  final int hintLimit;
  final bool whiteRemote;
  final bool blackRemote;
  final PlayerColor deviceUser;

  GameSettings({this.gameType, this.whitePlayer, this.blackPlayer, this.hintLimit = 0, this.whiteRemote, this.blackRemote, this.deviceUser});

  List<int> toBytes() {
    return [
      gameType.index + 1,
      ...whitePlayer.toBytes(),
      ...blackPlayer.toBytes(),
      hintLimit,
      whiteRemote ? 1 : 0,
      blackRemote ? 1 : 0,
      deviceUser.index
    ];
  }
}