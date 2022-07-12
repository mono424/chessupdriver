# chessupdriver

The chessupdriver flutter package allows you to quickly get you chessup-board connected
to your Android application.

![Screenshot](https://github.com/mono424/chessupdriver/blob/demo/img/demo.png?raw=true)

## Getting Started with chessupdriver

Add dependencies to `pubspec.yaml`
```
dependencies:
	chessupdriver: ^0.0.1
```

include the package
```
import 'package:chessupdriver/chessupdriver.dart';
```


Connect to a connected board and listen to its events:
```dart
    chessupCommunicationClient chessupCommunichessupCommunicationClient = chessupCommunicationClient(
      chessupCommunicationType.bluetooth,
      (v) => flutterReactiveBle.writeCharacteristicWithResponse(write, value: v),
      waitForAck: ackEnabled
    );
    boardBtInputStreamA = flutterReactiveBle
        .subscribeToCharacteristic(readA)
        .listen((list) {
          chessupCommunichessupCommunicationClient.handleReceive(Uint8List.fromList(list));
        });
    boardBtInputStreamB = flutterReactiveBle
        .subscribeToCharacteristic(readB)
        .listen((list) {
          chessupCommunichessupCommunicationClient.handleAckReceive(Uint8List.fromList(list));
        });
      

    // connect to board and initialize
    chessupBoard nBoard = new chessupBoard();
    await nBoard.init(chessupCommunichessupCommunicationClient);
    print("chessupBoard connected");
```

## In action

To get a quick look, it is used in the follwoing project, which is not open source yet.

https://khad.im/p/white-pawn

