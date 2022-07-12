import 'dart:async';
import 'dart:typed_data';

import 'package:chessupdriver/ChessupCommunicationClient.dart';
import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/ChessupMessageException.dart';
import 'package:chessupdriver/ChessupProtocol.dart';
import 'package:synchronized/synchronized.dart';

class chessupBoard {
  
  ChessupCommunicationClient _client;
  StreamController _inputStreamController;
  StreamController _boardUpdateStreamController;
  Stream<ChessupMessageIn> _inputStream;
  Stream<Map<String, String>> _boardUpdateStream;
  List<int> _buffer;

  Map<String, String> _currBoard = Map.fromEntries(ChessupProtocol.squares.map((e) => MapEntry(e, ChessupProtocol.pieces[0])));

  Map<String, String> get currBoard {
    return _currBoard;
  }

  chessupBoard();

  Future<void> init(ChessupCommunicationClient client) async {
    _client = client;
    _client.receiveStream.listen(_handleInputStream);
    _inputStreamController = StreamController<ChessupMessageIn>();
    _boardUpdateStreamController = StreamController<Map<String, String>>();
    _inputStream = _inputStreamController.stream.asBroadcastStream();
    _boardUpdateStream = _boardUpdateStreamController.stream.asBroadcastStream();

    getInputStream().map(_createBoardMap).listen(_newBoardState);

    Future<void> ack = getAckFuture();
    _send(Uint8List.fromList([0x21, 0x01, 0x00]));
    await ack;
  }

  void _newBoardState(Map<String, String> state) {
    _currBoard = state;
    _boardUpdateStreamController.add(_currBoard);
  }

  var lock = new Lock();
  void _handleInputStream(Uint8List rawChunk) async {
    await lock.synchronized(() async {
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
          _inputStreamController.addError(err);
        }
      }
    });
  }

  Stream<ChessupMessageIn> getInputStream() {
    return _inputStream;
  }

  Stream<Map<String, String>> getBoardUpdateStream() {
    return _boardUpdateStream;
  }

  Map<String, String> _createBoardMap(ChessupMessageIn message) {
    Map<String, String> map = {};
    for (var i = 0; i < message.pieces.length; i++) {
      map[ChessupProtocol.squares[i]] = ChessupProtocol.pieces[message.pieces[i]];
    }
    return map;
  }

  Future<void> _send(Uint8List message) async {
    await _client.send(message);
  }

  Future<void> getAckFuture() {
    return _client.waitForAck ? _client.ackStream.firstWhere((e) => equals(e.toList(), [0x23, 0x01, 0x00])).timeout(_client.ackTimeout) : Future.value();
  }

  bool equals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
  
}
