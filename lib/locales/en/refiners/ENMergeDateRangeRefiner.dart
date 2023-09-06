/*
  
*/

/**
 * Merging before and after results (see. AbstractMergeDateRangeRefiner)
 * This implementation should provide English connecting phases
 * - 2020-02-13 [to] 2020-02-13
 * - Wednesday [-] Friday
 */
class ENMergeDateRangeRefiner extends AbstractMergeDateRangeRefiner {
  RegExp patternBetween() {
    return new RegExp(r'^\s*(to|-|–|until|through|till)\s*$',
        caseSensitive: false);
  }
}
