import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:chess/chess.dart' as chess;
import 'package:chessupdriver/ChessupBoard.dart';
import 'package:chessupdriver/ChessupCommunicationClient.dart';
import 'package:chessupdriver/ChessupMessage.dart';
import 'package:chessupdriver/messages/in/BoardPositionMessage.dart';
import 'package:chessupdriver/messages/in/MoveFromBoardMessage.dart';
import 'package:example/ble_scanner.dart';
import 'package:example/device_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final _ble = FlutterReactiveBle();
  final _scanner = BleScanner(ble: _ble, logMessage: print);
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: _scanner),
        StreamProvider<BleScannerState>(
          create: (_) => _scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter example',
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const FILES = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  final flutterReactiveBle = FlutterReactiveBle();

  final bleServiceId = Uuid.parse("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
  final bleReadCharacteristic = Uuid.parse("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");
  final bleWriteCharacteristic = Uuid.parse("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");

  ChessupBoard connectedBoard;
  StreamSubscription<ConnectionStateUpdate> boardBtStream;
  StreamSubscription<List<int>> boardBtInputStream;

  StreamController<Map<String, String>> boardStateStreamController = StreamController<Map<String, String>>();
  bool loading = false;

  void connectBle() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();

    String deviceId = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeviceListScreen()));

    setState(() {
      loading = true;
    });

    boardBtStream = flutterReactiveBle.connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 5),
    ).listen((e) async {
      if (e.connectionState == DeviceConnectionState.connected) {
        List<DiscoveredService> services = await flutterReactiveBle.discoverServices(e.deviceId);
        await flutterReactiveBle.requestMtu(deviceId: deviceId, mtu: 247); // Important: Increase MTU

        QualifiedCharacteristic readA;
        QualifiedCharacteristic write;
        for (var service in services) {
          for (var characteristicId in service.characteristicIds) {
            if (characteristicId == bleReadCharacteristic) {
              readA = QualifiedCharacteristic(
                serviceId: service.serviceId,
                characteristicId: bleReadCharacteristic,
                deviceId: e.deviceId
              );
            }

            if (characteristicId == bleWriteCharacteristic) {
              write = QualifiedCharacteristic(
                serviceId: service.serviceId,
                characteristicId: bleWriteCharacteristic,
                deviceId: e.deviceId
              );
            }
          }
        }

        ChessupCommunicationClient chessupCommunichessupCommunicationClient = ChessupCommunicationClient(
          (v) => flutterReactiveBle.writeCharacteristicWithResponse(write, value: v)
        );
        boardBtInputStream = flutterReactiveBle
            .subscribeToCharacteristic(readA)
            .listen((list) {
              chessupCommunichessupCommunicationClient.handleReceive(Uint8List.fromList(list));
            });
          
        // connect to board and initialize
        ChessupBoard nBoard = ChessupBoard();
        await nBoard.init(chessupCommunichessupCommunicationClient);
        print("chessupBoard connected");

        // listen to events
        nBoard.getInputStream().listen(newBoardEvent);

        // set connected board
        setState(() {
          connectedBoard = nBoard;
          loading = false;
        });
      }
    });
  }

  chess.Chess chessInstance = chess.Chess();
  Map<String, String> lastData;

  void newBoardEvent(ChessupMessageIn message) {
    if (message is BoardPositionMessage) {
      resetChess(message.board);
    }
    if (message is MoveFromBoardMessage) {
      chessInstance.move({ "from": message.from, "to": message.to });
    }

    lastData = getChessBoard();
    boardStateStreamController.add(lastData);
  }

  void resetChess(Map<String, String> board) {
    chessInstance = chess.Chess.fromFEN("");
    for (String square in board.keys) {
      String piece = board[square];
      if (piece != null) {
        chessInstance.put(chess.Piece(
          chess.Chess.PIECE_TYPES[piece.toLowerCase()],
          piece.toLowerCase() != piece ? chess.Color.WHITE : chess.Color.BLACK
        ), square);
      }
    }
  }

  Map<String, String> getChessBoard() {
    Map<String, String> res = {};
    for (var file in FILES) {
      for (int i = 1; i <= 8; i++) {
        String square = file + i.toString();
        chess.Piece piece = chessInstance.get(square);
        res[square] = piece == null ? null : (piece.color == chess.Color.WHITE ? piece.type.toUpperCase() : piece.type.toLowerCase());
      }
    }
    return res;
  }

  void randomMove() {
    List<chess.Move> moves = chessInstance.generate_moves();
    chess.Move randomMove = moves[Random().nextInt(moves.length)];
    chessInstance.move(randomMove);
    connectedBoard.sendMoveToBoard(randomMove.fromAlgebraic, randomMove.toAlgebraic);
  }

  void requestBoard() {
    connectedBoard.requestBoardPosition();
  }

  void disconnectBle() {
    boardBtInputStream.cancel();
    boardBtStream.cancel();
    setState(() {
      boardBtInputStream = null;
      boardBtStream = null;
      connectedBoard = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("chessupdriver example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: TextButton(
            child: Text(connectedBoard == null ? "Try to connect to board (BLE)" : (boardBtStream != null ? "Disconnect" : "")),
            onPressed: !loading && connectedBoard == null ? connectBle : (boardBtStream != null && !loading ? disconnectBle : null),
          )),
          Center(child: TextButton(
            child: Text("Send Random Move"),
            onPressed: !loading && connectedBoard != null ? randomMove : null),
          ),
          Center(child: TextButton(
            child: Text("Request Board"),
            onPressed: !loading && connectedBoard != null ? requestBoard : null),
          ),
          Center( child: StreamBuilder(
            stream: boardStateStreamController.stream,
            builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
              if (!snapshot.hasData && lastData == null) return Text("- no data -");

              Map<String, String> fieldUpdate = snapshot.data ?? lastData;
              lastData = fieldUpdate;
              List<Widget> rows = [];
              
              for (var i = 0; i < 8; i++) {
                List<Widget> cells = [];
                for (var j = 0; j < 8; j++) {
                    MapEntry<String, String> entry = fieldUpdate.entries.toList()[i * 8 + j];
                    cells.add(
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        width: width / 8 - 4,
                        height: width / 8 - 4,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black54,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(entry.key, style: TextStyle(color: Colors.white)),
                              Text(entry.value ?? ".", style: TextStyle(color: Colors.white, fontSize: 8)),
                            ],
                          )
                        ),
                      )
                  );
                }
                rows.add(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: cells,
                ));
              }

              return Column(
                children: rows,
              );
            }
          )),
        ],
      ),
    );
  }
}
