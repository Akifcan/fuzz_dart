# Fuzz Testing in Dart

## What is fuzz test.

- Fuzz testing is a way detect unexcepted inputs for functions.

- Create a folder for fuzz testing.
- And put your files under this folder.

import 'package:fuzz_dart/fuzz_dart.dart' as fuzz_dart;

```
void main(List<String> arguments) {

}
```

## Example.

- This is greeter function.
- We have a control here.
- But we don't have any constraint for substring. If name variable length less than 10 this function will throw error.
- So fuzz testing finds bug like this. And generate html file.
- Run this file `dart run {FILENAME}`

```
 void main(List<String> arguments) {
  greeter(String name, String lastname) {
    if (name.length > 13) {
      throw Exception('name is so long');
    }
    return "hello $name $lastname";
  }

  fuzz_dart.Fuzzer greeterFunctionFuzzer = fuzz_dart.Fuzzer(
      type: [fuzz_dart.AcceptedTypes.string],
      iterateCount: 12,
      fileName: 'greeter-fuzzer');
  greeterFunctionFuzzer.iterate(greeter, 'greeting!',
      description: 'Returns name and lastname');
}

```

- Output

```
    Exception: name is so long - Arguments: [ovfpdf|qelzyavu`, m}oqc~wgo]
RangeError (start): Invalid value: Not in inclusive range 0..2: 20 - Arguments: [g, du~klr]
Exception: name is so long - Arguments: [w{kpa}tdy}r~slrnvstp, s|_qr|rtsjzrz~vid}|dlvyvyi_~d~tbooj_|lvmq]
Exception: name is so long - Arguments: [ik|ca|k_gdilltbyyl|osooyzdirjza{{y, zuoo~u}woxsx|kqznyucvadwnpnmp_kp]
RangeError (start): Invalid value: Only valid value is 0: 20 - Arguments: [, fypr|cjnk|irec|vepfpypgs~rdjeltr_y{}io|{ucre`~d]
Exception: name is so long - Arguments: [vhedjuscuoervjauram`y}i{q{mxigw, sxypbkwjrqszjlszoy}siiswclhqdrpylwiprk]
Exception: name is so long - Arguments: [~ol{`butmq~how, jkfykl{i`spvoqz~qjkqcm`]
Exception: name is so long - Arguments: [~nmgrmmoujpqyssvgz{hjtm~_w, zqx{|tkhdpg]
Exception: name is so long - Arguments: [ylne}rmrwrear_fv~g`z{{dz_ecsefk|rot_bvfqa, ejwu]
```

## Example 2

- Make sure your parameter order is correct in type property.

```
 import 'package:fuzz_dart/fuzz_dart.dart' as fuzz_dart;

 String calculate(int num1, int num2) {
    if (num1 > 2000) {
      throw Exception('num1 should lower than 2000');
    }
    return "result of two number is ${num1 + num2}";
  }
  String calculate2(int num1, int num2, int num3) {
    return "result of three number is ${num1 + num2 + num3}";
  }

  fuzz_dart.Fuzzer greeterFunctionFuzzer = fuzz_dart.Fuzzer(
      type: [fuzz_dart.AcceptedTypes.string],
      iterateCount: 12,
      fileName: 'greeter-fuzzer');

  fuzz_dart.Fuzzer intFuzzer = fuzz_dart.Fuzzer(
      type: [fuzz_dart.AcceptedTypes.integer],
      iterateCount: 3,
      fileName: 'fuzzer 1');

  fuzz_dart.Fuzzer intFuzzer2 = fuzz_dart.Fuzzer(
      type: [fuzz_dart.AcceptedTypes.integer],
      iterateCount: 2,
      fileName: 'fuzzer-2');

 intFuzzer2.iterate(calculate, 'calculator 1');
  intFuzzer.iterate(calculate2, 'calculator 2');
  greeterFunctionFuzzer.iterate(greeter, 'greeting!',
      description: 'Returns name and lastname');
  listFuzzer.iterate(arrs, 'list fuzzer fun');
  cityFuzzer.iterate(city, 'city', description: 'Returns current index');

```

## HTML OUTPUTS

![img1](https://i.hizliresim.com/hkttgcu.PNG)
![img2](https://i.hizliresim.com/aoeelfz.PNG)
![img3](https://i.hizliresim.com/3chmhm1.PNG)
![img4](https://i.hizliresim.com/d4t27jv.PNG)
