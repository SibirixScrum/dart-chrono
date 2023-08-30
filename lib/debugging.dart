abstract class DebugHandler {
  DebugConsume debug;
}

class BufferedDebugHandler implements DebugHandler {
  Array<AsyncDebugBlock> buffer;
  BufferedDebugHandler() {
    this.buffer = [];
  }
  void debug(AsyncDebugBlock debugMsg) {
    this.buffer.push(debugMsg);
  }

  Array<unknown> executeBufferedBlocks() {
    final logs = this.buffer.map((block) => block());
    this.buffer = [];
    return logs;
  }
}
