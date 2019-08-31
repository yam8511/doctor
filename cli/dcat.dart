import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';

const lineNumber = 'line-number';

ArgResults argResults;

void main(List<String> arguments) {
  exitCode = 0; //presume success
  final parser = ArgParser()
      ..addFlag(lineNumber, negatable: false, abbr: 'n');
    
  print('Start');

  argResults = parser.parse(arguments);
  print('rest ${argResults.rest}');
  print('args ${argResults.arguments}');
  print('options ${argResults.options.contains("-n") }');
  List<String> paths = argResults.rest;

  dcat(paths, argResults[lineNumber]);
  print('End');
}

Future dcat(List<String> paths, bool showLineNumbers) async {
  if (paths.isEmpty) {
    // No files provided as arguments. Read from stdin and print each line.
    await stdin.pipe(stdout);
  } else {
    for (var path in paths) {
      int lineNumber = 1;
      Stream lines = File(path)
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter());
      try {
        await for (var line in lines) {
          if (showLineNumbers) {
            stdout.write('${lineNumber++} ');
          }
          stdout.writeln(line);
        }
      } catch (_) {
        await _handleError(path);
      }
    }
  }
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
