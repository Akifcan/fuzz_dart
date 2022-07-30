// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:math';

import 'package:fuzz_dart/generate_result.dart';

class FuzzerResult {
  String name;
  String? description;
  String message;

  FuzzerResult(this.name, this.description, this.message);
}

enum AcceptedTypes {
  string,
  integer,
  float,
  stringList,
  integerList,
  floatList,
}

List<String> characters = [
  'q',
  'w',
  'e',
  'r',
  't',
  'y',
  'u',
  'ı',
  'o',
  'p',
  'ğ',
  'ü',
  'a',
  's',
  'd',
  'f',
  'g',
  'h',
  'h',
  'j',
  'k',
  'l',
  'm',
  'o',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0'
];

class Fuzzer {
  final List<AcceptedTypes> type;
  final int iterateCount;
  final String fileName;

  final List _generatedValues = [];

  final List<FuzzerResult> _fuzzerResults = [];

  Fuzzer({required this.type, this.iterateCount = 100, required this.fileName});

  get generatedValues => _generatedValues;

  void iterate(Function fn, String name, {String? description}) {
    RegExp regex = RegExp(r'[\(][<>a-zA-Z0-9, ]{0,}[\)]');
    for (int i = 0; i < iterateCount; i++) {
      String message = '✅ This function is runned successfully';
      try {
        _fuzzer(regex.firstMatch(fn.toString())!.group(0)!.split(',').length);
        print(Function.apply(fn, _generatedValues));
      } catch (e) {
        message =
            '❌ Occured Error: $e. <b>Given Arguments: ${_generatedValues.toString()}</b>';
        print("$e - Arguments: ${_generatedValues.toString()}");
      } finally {
        _fuzzerResults.add(FuzzerResult(name, description, message));
      }
    }
    GenerateHtmlResult(_fuzzerResults).generate(name);
  }

  List _fuzzer(int length) {
    _generatedValues.length = 0;
    Random random = Random();
    int iterateCount = type.length > 1 ? 1 : length;

    for (var x in type) {
      switch (x) {
        case AcceptedTypes.string:
          for (int x = 0; x < iterateCount; x++) {
            String randomString = String.fromCharCodes(List.generate(
                random.nextInt(50), (index) => random.nextInt(33) + 95));
            _generatedValues.add(randomString);
          }
          break;
        case AcceptedTypes.integer:
          for (int x = 0; x < iterateCount; x++) {
            _generatedValues.add(random.nextInt(9999));
          }
          break;
        case AcceptedTypes.float:
          for (int x = 0; x < iterateCount; x++) {
            _generatedValues.add(random.nextDouble() + 9999);
          }
          break;
        case AcceptedTypes.stringList:
          List<String> fuzzList = [];
          for (int x = 0; x < 50; x++) {
            fuzzList.add(String.fromCharCodes(List.generate(
                random.nextInt(50), (index) => random.nextInt(33) + 95)));
          }
          _generatedValues.add(fuzzList);
          break;
        case AcceptedTypes.integerList:
          List<int> fuzzList = [];
          for (int x = 0; x < 50; x++) {
            fuzzList.add(random.nextInt(9999));
          }
          _generatedValues.add(fuzzList);
          break;
        case AcceptedTypes.floatList:
          List<double> fuzzList = [];
          for (int x = 0; x < 50; x++) {
            fuzzList.add(random.nextDouble() + 9000);
          }
          _generatedValues.add(fuzzList);
          break;
        default:
          break;
      }
    }
    return _generatedValues;
  }
}
