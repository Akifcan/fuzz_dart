import 'package:fuzz_dart/fuzz_dart.dart' as fuzz_dart;

void main(List<String> arguments) {
  greeter(String name, String lastname) {
    if (name.length > 13) {
      throw Exception('name is so long');
    }
    return "hello $name $lastname";
  }

  String calculate(int num1, int num2) {
    if (num1 > 2000) {
      throw Exception('num1 should lower than 2000');
    }
    return "result of two number is ${num1 + num2}";
  }

  String calculate2(int num1, int num2, int num3) {
    return "result of three number is ${num1 + num2 + num3}";
  }

  String city(List<String> arr, int index, int index2) {
    print("your index is $index and $index2");
    if (index > arr.length) {
      throw Exception("index is so big");
    }
    return arr[5];
  }

  List<List> arrs(List<String> strings, List<int> ints) {
    print("strings ${strings.length}");
    return [strings, ints];
  }

  fuzz_dart.Fuzzer greeterFunctionFuzzer = fuzz_dart.Fuzzer(
      type: [fuzz_dart.AcceptedTypes.string],
      iterateCount: 1,
      fileName: 'greeter-fuzzer');

  fuzz_dart.Fuzzer listFuzzer = fuzz_dart.Fuzzer(type: [
    fuzz_dart.AcceptedTypes.stringList,
    fuzz_dart.AcceptedTypes.integerList
  ], iterateCount: 1, fileName: 'list-fuzzer');

  fuzz_dart.Fuzzer intFuzzer = fuzz_dart.Fuzzer(
      type: [fuzz_dart.AcceptedTypes.integer],
      iterateCount: 3,
      fileName: 'fuzzer 1');

  fuzz_dart.Fuzzer intFuzzer2 = fuzz_dart.Fuzzer(
      type: [fuzz_dart.AcceptedTypes.integer],
      iterateCount: 2,
      fileName: 'fuzzer-2');

  fuzz_dart.Fuzzer cityFuzzer = fuzz_dart.Fuzzer(type: [
    fuzz_dart.AcceptedTypes.stringList,
    fuzz_dart.AcceptedTypes.integer,
    fuzz_dart.AcceptedTypes.integer
  ], iterateCount: 1, fileName: 'city');

  intFuzzer2.iterate(calculate, 'calculator 1');
  intFuzzer.iterate(calculate2, 'calculator 2');
  greeterFunctionFuzzer.iterate(greeter, 'greeting!',
      description: 'Returns name and lastname');
  listFuzzer.iterate(arrs, 'list fuzzer fun');
  cityFuzzer.iterate(city, 'city', description: 'Returns current index');
}
