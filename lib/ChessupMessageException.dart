abstract class ChessupMessageException implements Exception {
  final List<int> buffer;
  ChessupMessageException(this.buffer);
}

class ChessupMessageTooShortException extends ChessupMessageException {
  ChessupMessageTooShortException(List<int> buffer) : super(buffer);
}

class ChessupInvalidMessageLengthException extends ChessupMessageException {
  ChessupInvalidMessageLengthException(List<int> buffer) : super(buffer);
}

class ChessupInvalidMessageException extends ChessupMessageException {
  ChessupInvalidMessageException(List<int> buffer) : super(buffer);
}