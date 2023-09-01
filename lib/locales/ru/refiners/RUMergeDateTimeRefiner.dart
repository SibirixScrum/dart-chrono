import 'package:chrono/common/refiners/AbstractMergeDateTimeRefiner.dart';

/**
 * Merging date-only result and time-only result (see. AbstractMergeDateTimeRefiner).
 * This implementation should provide Russian connecting phases
 * - 2020-02-13 [в] 6:00
 * - Завтра [,] 7:00
 */
class RUMergeDateTimeRefiner extends AbstractMergeDateTimeRefiner {
  RegExp patternBetween() {
    return new RegExp('''^\\s*(T|в|,|-)?\\s*\$''');
  }
}
