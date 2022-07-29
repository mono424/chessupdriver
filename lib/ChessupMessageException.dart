abstract class ChessUpMessageException implements Exception {
  final List<int> buffer;
  ChessUpMessageException(this.buffer);
}

class ChessUpMessageTooShortException extends ChessUpMessageException {
  ChessUpMessageTooShortException(List<int> buffer) : super(buffer);
}

class ChessUpInvalidMessageLengthException extends ChessUpMessageException {
  ChessUpInvalidMessageLengthException(List<int> buffer) : super(buffer);
}

class ChessUpInvalidMessageException extends ChessUpMessageException {
  ChessUpInvalidMessageException(List<int> buffer) : super(buffer);
}