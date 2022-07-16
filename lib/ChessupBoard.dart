import 'dart:async';
import 'dart:typed_data';

import 'package:chessupdriver/ChessupCommunicationClient.dart';
import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/messages/in/BoardMoveAckMessage.dart';
import 'package:chessupdriver/messages/in/BoardPawnPromotionAckMessage.dart';
import 'package:chessupdriver/messages/in/BoardPositionMessage.dart';
import 'package:chessupdriver/messages/in/MoveFromBoardMessage.dart';
import 'package:chessupdriver/messages/in/BoardPawnPromotionMessage.dart';
import 'package:chessupdriver/messages/out/LoadFenMessage.dart';
import 'package:chessupdriver/messages/out/MoveAckMessage.dart';
import 'package:chessupdriver/messages/out/MoveToBoardMessage.dart';
import 'package:chessupdriver/messages/out/PawnPromotionAckMessage.dart';
import 'package:chessupdriver/messages/out/PawnPromotionMessage.dart';
import 'package:chessupdriver/messages/out/PiecesInStartPositionMessage.dart';
import 'package:chessupdriver/messages/out/RequestBoardPositionMessage.dart';
import 'package:chessupdriver/messages/out/ResetGameMessage.dart';
import 'package:chessupdriver/messages/out/SetBlackSettings.dart';
import 'package:chessupdriver/messages/out/SetGameSettings.dart';
import 'package:chessupdriver/messages/out/WinOnTimeMessage.dart';
import 'package:chessupdriver/models/GameSettings.dart';
import 'package:chessupdriver/models/PlayerColor.dart';
import 'package:chessupdriver/models/PlayerSettings.dart';
import 'package:synchronized/synchronized.dart';

class ChessupBoard {
  
  ChessupCommunicationClient _client;
  StreamController _inputStreamController;
  Stream<ChessupMessageIn> _inputStream;
  List<int> _buffer;

  ChessupBoard();

  Future<void> init(ChessupCommunicationClient client) async {
    _client = client;
    _client.receiveStream.listen(_handleInputStream);
    _inputStreamController = StreamController<ChessupMessageIn>();
    _inputStream = _inputStreamController.stream.asBroadcastStream();

    getInputStream().listen(_sendAck);
  }

  var lock = new Lock();
  void _handleInputStream(Uint8List rawChunk) async {
    await lock.synchronized(() async {
      print(rawChunk);
      List<int> chunk = rawChunk.toList();

      if (_buffer == null)
        _buffer = chunk.toList();
      else
        _buffer.addAll(chunk);

      while(_buffer.length > 0) {
        try {
          ChessupMessageIn message = ChessupMessageIn.parse(_buffer);
          _inputStreamController.add(message);
          _buffer.removeRange(0, message.length);
        } on ChessupInvalidMessageException catch (e) {
          _buffer = e.buffer;
          _inputStreamController.addError(e);
        } on ChessupMessageTooShortException catch (_) {
          break;
        } catch (err) {
          _buffer = [];
          _inputStreamController.addError(err);
        }
      }
    });
  }

  void _sendAck(ChessupMessageIn message) {
    if (ChessupMessageIn is MoveFromBoardMessage) {
      _send(MoveAckMessage().toBytes());
    }
    if (ChessupMessageIn is BoardPawnPromotionMessage) {
      _send(PawnPromotionAckMessage().toBytes());
    }
  }

  Stream<ChessupMessageIn> getInputStream() {
    return _inputStream;
  }

  Future<void> loadFenString(String fen) {
    return _send(LoadFenMessage(fen).toBytes());
  }

  Future<void> sendMoveToBoard(String from, String to, {bool waitForAck = false, Duration timeout = const Duration(seconds: 3)}) async {
    Future<ChessupMessageIn> ackFuture = waitForAck ? _inputStream.firstWhere((e) => e is BoardMoveAckMessage).timeout(timeout) : Future.value(null);
    await _send(MoveToBoardMessage(from, to).toBytes());
    await ackFuture;
  }

  Future<void> sendPawnPromotion(String piece, {Duration timeout = const Duration(seconds: 3)}) async {
    Future<BoardPawnPromotionAckMessage> ackFuture = _inputStream.firstWhere((e) => e is BoardPawnPromotionAckMessage).timeout(timeout);
    await _send(PawnPromotionMessage(piece).toBytes());
    await ackFuture;
  }

  Future<BoardPositionMessage> requestBoardPosition({Duration timeout = const Duration(seconds: 3)}) async {
    Future<ChessupMessageIn> ackFuture = _inputStream.firstWhere((e) => e is BoardPositionMessage).timeout(timeout);
    await _send(RequestBoardPositionMessage().toBytes());

    ChessupMessageIn message = await ackFuture;
    if (message is BoardPositionMessage) {
      return message;
    }
    return null;
  }

  Future<void> waitForPiecesInStartPosition({Duration timeout}) async {
    Future<BoardPositionMessage> resFuture = _inputStream.firstWhere((e) => e is BoardPositionMessage);
    await _send(RequestBoardPositionMessage().toBytes());
    return timeout == null ? resFuture : resFuture.timeout(timeout);
  }

  Future<void> resetGame() async {
    await _send(ResetGameMessage().toBytes());
  }

  Future<void> setBlackSettings(PlayerSettings settings) async {
    await _send(SetBlackSettings(settings).toBytes());
  }

  Future<void> setWhiteSettings(PlayerSettings settings) async {
    await _send(SetBlackSettings(settings).toBytes());
  }

  Future<void> winOnTime(PlayerColor winner) async {
    await _send(WinOnTimeMessage(winner).toBytes());
  }

  Future<void> piecesInStartPosition() async {
    await _send(PiecesInStartPositionMessage().toBytes());
  }

  Future<void> setGameSettigns(GameSettings settings) async {
    await _send(SetGameSettings(settings).toBytes());
  }

  Future<void> _send(List<int> message) async {
    await _client.send(Uint8List.fromList(message));
  }

  bool equals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
  
}
