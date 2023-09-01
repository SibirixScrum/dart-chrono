typedef AsyncDebugBlock = dynamic Function();
typedef DebugConsume = void Function(AsyncDebugBlock debugLog);

abstract class DebugHandler {
  DebugConsume get debug;
}

class BufferedDebugHandler implements DebugHandler {
  List<AsyncDebugBlock> buffer = [];

  List<dynamic> executeBufferedBlocks() {
    final logs = this.buffer.map((block) => block());
    this.buffer = [];
    return logs.toList();
  }

  @override
  get debug {
    return (AsyncDebugBlock debugLog) {
      this.buffer.add(debugLog);
    };
  }
}
