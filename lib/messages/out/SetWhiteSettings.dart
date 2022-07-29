import 'package:chessupdriver/ChessUpMessage.dart';
import 'package:chessupdriver/models/PlayerSettings.dart';

class SetWhiteSettings extends ChessUpMessageOut {
  static const headerPrefix = [0xB3];

  final PlayerSettings settings;

  SetWhiteSettings(this.settings);
  
  @override
  List<int> toBytes() {
    return [
      ...headerPrefix,
      ...settings.toBytes()
    ];
  }
}