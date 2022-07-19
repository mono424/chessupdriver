import 'package:chessupdriver/models/GameType.dart';
import 'package:chessupdriver/models/PlayerColor.dart';
import 'package:chessupdriver/models/PlayerSettings.dart';

class GameSettings {
  final GameType gameType;
  final PlayerSettings whitePlayer;
  final PlayerSettings blackPlayer;
  final int hintLimit;
  final int whiteRemote;
  final int blackRemote;
  final PlayerColor deviceUser;

  GameSettings({this.gameType, this.whitePlayer, this.blackPlayer, this.hintLimit, this.whiteRemote, this.blackRemote, this.deviceUser});

  List<int> toBytes() {
    return [
      gameType.index + 1,
      ...whitePlayer.toBytes(),
      ...blackPlayer.toBytes(),
      
    ];
  }
}