import 'package:chrono/common/refiners/AbstractMergeDateRangeRefiner.dart';

/**
 * Merging before and after results (see. AbstractMergeDateRangeRefiner)
 * This implementation should provide Russian connecting phases
 * - c 06.09.1989 [до|по] 11.12.1996
 * - c пятницы и до среды
 */
class RUMergeDateRangeRefiner extends AbstractMergeDateRangeRefiner {
  @override
  RegExp patternBetween() {
    return RegExp(r'^\s*(и до|и по|до|по|-)\s*$', caseSensitive: false);
  }
}
