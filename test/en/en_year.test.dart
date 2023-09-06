 import "../../src.dart" as chrono ; import "../test_util.dart" show testSingleCase , testUnexpectedResult ;
 void main() {
   test("Test - Year numbers with BCE/CE Era label", () {
     testSingleCase(
         chrono, "10 August 234 BCE", new Date (2012, 7, 10), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("10 August 234 BCE");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(-234);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(10);
       expect(result.start).toBeDate(new Date (-234, 8 - 1, 10, 12));
     });
     testSingleCase(
         chrono, "10 August 88 CE", new Date (2012, 7, 10), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("10 August 88 CE");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(88);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(10);
       final resultDate = result.start.date();
       final expectDate = new Date (88, 8 - 1, 10, 12);
       expectDate.setFullYear(88);
       expect(expectDate.getTime()).toBeCloseTo(resultDate.getTime());
     });
   });
   test("Test - Year numbers with BC/AD Era label", () {
     testSingleCase(
         chrono, "10 August 234 BC", new Date (2012, 7, 10), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("10 August 234 BC");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(-234);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(10);
       expect(result.start).toBeDate(new Date (-234, 8 - 1, 10, 12));
     });
     testSingleCase(
         chrono, "10 August 88 AD", new Date (2012, 7, 10), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("10 August 88 AD");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(88);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(10);
       final resultDate = result.start.date();
       final expectDate = new Date (88, 8 - 1, 10, 12);
       expectDate.setFullYear(88);
       expect(expectDate.getTime()).toBeCloseTo(resultDate.getTime());
     });
   });
   test("Test - Year numbers with Buddhist Era label", () {
     testSingleCase(
         chrono, "10 August 2555 BE", new Date (2012, 7, 10), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("10 August 2555 BE");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(10);
       expect(result.start).toBeDate(new Date (2012, 8 - 1, 10, 12));
     });
   });
 }