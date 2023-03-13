
import 'package:chessupdriver/models/PlayerType.dart';

class PlayerSettings {
  final PlayerType type;
  final int level;
  final bool buttonLock;

  PlayerSettings({
    required this.type,
    required this.level,
    required this.buttonLock
  }) {
    if (type == PlayerType.ai && (level < 1 || level > 30)) throw new ArgumentError('AI Level must be between 1 and 30');
    if (type == PlayerType.player && (level < 1 || level > 6)) throw new ArgumentError('Player Assistance Level must be between 1 and 30');
  }

  List<int> toBytes() {
    return [
      type.index,
      level,
      buttonLock ? 1 : 0
    ];
  }
}