import 'package:chessupdriver/ChessUpMessageException.dart';
import 'package:chessupdriver/messages/in/BatteryChargingMessage.dart';
import 'package:chessupdriver/messages/in/BoardInfoMessage.dart';
import 'package:chessupdriver/messages/in/BoardMoveAckMessage.dart';
import 'package:chessupdriver/messages/in/BoardPositionMessage.dart';
import 'package:chessupdriver/messages/in/BoardPromotionAckMessage.dart';
import 'package:chessupdriver/messages/in/LoadFenReadyMessage.dart';
import 'package:chessupdriver/messages/in/MoveFromBoardMessage.dart';
import 'package:chessupdriver/messages/in/BoardPawnPromotionMessage.dart';
import 'package:chessupdriver/messages/in/PieceReleasedMessage.dart';
import 'package:chessupdriver/messages/in/PieceTouchedMessage.dart';
import 'package:chessupdriver/messages/in/BoardPiecesInStartPositionMessage.dart';
import 'package:chessupdriver/messages/in/RawBoardStateMessage.dart';

// Messages received by the driver from the board.
abstract class ChessUpMessageIn {
  
  static List<int> headerPrefix = [];
  int length = 0;

  ChessUpMessageIn(List<int> message);

  static ChessUpMessageIn parse(List<int> message) {
    ChessUpMessageIn? _parsedMessage;
    while (message.length > 0) {
      if (_hasPrefix(message, RawBoardStateMessage.headerPrefix)) {
        _parsedMessage = RawBoardStateMessage(message);
        break;
      }

      if (_hasPrefix(message, BatteryChargingMessage.headerPrefix)) {
        _parsedMessage = BatteryChargingMessage(message);
        break;
      }

      if (_hasPrefix(message, BoardInfoMessage.headerPrefix)) {
        _parsedMessage = BoardInfoMessage(message);
        break;
      }

      if (_hasPrefix(message, BoardMoveAckMessage.headerPrefix)) {
        _parsedMessage = BoardMoveAckMessage(message);
        break;
      }

      if (_hasPrefix(message, BoardPositionMessage.headerPrefix)) {
        _parsedMessage = BoardPositionMessage(message);
        break;
      }

      if (_hasPrefix(message, BoardPromotionAckMessage.headerPrefix)) {
        _parsedMessage = BoardPromotionAckMessage(message);
        break;
      }

      if (_hasPrefix(message, LoadFenReadyMessage.headerPrefix)) {
        _parsedMessage = LoadFenReadyMessage(message);
        break;
      }

      if (_hasPrefix(message, MoveFromBoardMessage.headerPrefix)) {
        _parsedMessage = MoveFromBoardMessage(message);
        break;
      }

      if (_hasPrefix(message, BoardPawnPromotionMessage.headerPrefix)) {
        _parsedMessage = BoardPawnPromotionMessage(message);
        break;
      }

      if (_hasPrefix(message, BoardPiecesInStartPositionMessage.headerPrefix)) {
        _parsedMessage = BoardPiecesInStartPositionMessage(message);
        break;
      }

      if (_hasPrefix(message, PieceTouchedMessage.headerPrefix)) {
        _parsedMessage = PieceTouchedMessage(message);
        break;
      }

      if (_hasPrefix(message, PieceReleasedMessage.headerPrefix)) {
        _parsedMessage = PieceReleasedMessage(message);
        break;
      }

      message.removeAt(0);
    }

    if (_parsedMessage == null) throw ChessUpMessageTooShortException(message);
    return _parsedMessage;
  }

  static bool _hasPrefix(List<int> message, List<int> prefix) {
    for (int i = 0; i < prefix.length; i++) {
      if (message[i] != prefix[i]) return false;
    }
    return true;
  }

}

// Messages sent by the driver to the board.
abstract class ChessUpMessageOut {
  List<int> toBytes();
}