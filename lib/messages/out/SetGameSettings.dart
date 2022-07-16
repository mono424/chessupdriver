import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/models/GameSettings.dart';

class SetGameSettings extends ChessupMessageOut {
  static const headerPrefix = [0xB9];

  final GameSettings settings;

  SetGameSettings(this.settings);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ...settings.toBytes()
    ];
  }
}