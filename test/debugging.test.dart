import 'package:chrono/debugging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test - BufferedDebugHandler", () {
    final debugHandler = new BufferedDebugHandler();
    final debugBlockA = jest.fn();
    debugHandler.debug(() => debugBlockA());
    expect(debugBlockA).not.toBeCalled();
    final debugBlockB = jest.fn();
    debugHandler.debug(() => debugBlockB());
    expect(debugBlockB).not.toBeCalled();
    debugHandler.executeBufferedBlocks();
    expect(debugBlockA).toBeCalled();
    expect(debugBlockB).toBeCalled();
  });
}
