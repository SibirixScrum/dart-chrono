/**
 * Merging date-only result and time-only result (see. AbstractMergeDateTimeRefiner).
 * This implementation should provide English connecting phases
 * - 2020-02-13 [at] 6pm
 * - Tomorrow [after] 7am
 */
class ENMergeDateTimeRefiner extends AbstractMergeDateTimeRefiner {
  RegExp patternBetween() {
    return new RegExp("^\\s*(T|at|after|before|on|of|,|-)?\\s*\$");
  }
}
