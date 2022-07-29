import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/models/PlayerSettings.dart';

class SetBlackSettings extends ChessUpMessageOut {
  static const headerPrefix = [0xB4];

  final PlayerSettings settings;

  SetBlackSettings(this.settings);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ...settings.toBytes()
    ];
  }
}