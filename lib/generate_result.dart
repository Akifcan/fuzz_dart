import 'dart:io';

import 'package:fuzz_dart/fuzz_dart.dart';

abstract class Result {
  generate(String fileName);
}

class GenerateHtmlResult extends Result {
  final List<FuzzerResult> results;
  GenerateHtmlResult(this.results);

  @override
  generate(String fileName) {
    int passed =
        results.where((element) => element.message.contains('✅')).length;

    int failed =
        results.where((element) => element.message.contains('❌')).length;

    final htmlFile =
        '${fileName.toLowerCase().replaceAll(' ', '-')}-dart_fuzz-results.html';

    String html = '''
        <head>
          <title>$fileName | dart_fuzz</title>
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        </head>
        <div class="container py-5">
          <h1 class='text-capitalize'>$fileName</h1>
          <span>
              <b>Time:</b>
              <time>${DateTime.now().toIso8601String()}</time>
          </span>
          <div class="d-flex py-5 text-white">
              <div class="flex-fill bg-success p-3">✅ Passed: $passed</div>
              <div class="flex-fill bg-danger p-3">❌ Failed: $failed</div>
          </div>
          <fieldset>
              <legend>Failed tests:</legend>
              <table class="table table-striped table-bordered">
                  <thead>
                      <tr>
                          <th scope="col">Name</th>
                          <th scope="col">Description</th>
                          <th scope="col">Message</th>
                      </tr>
                  </thead>
                  <tbody>
                      ${results.where((element) => element.message.contains('❌')).map((e) {
              return '''
                          <tr>
                              <td>${e.name}</td>
                              <td>${e.description}</td>
                              <td>${e.message}</td>
                          </tr>
                          ''';
            }).toList().toString().replaceAll(',', '').replaceAll('[', '').replaceAll(']', '')}
                  </tbody>
              </table>
          </fieldset>
      </div>
    ''';
    File(htmlFile).writeAsString(html);
  }
}
