import 'package:cli/cli.dart' as cli;
import 'package:cli/hello.dart' as hello;

main(List<String> arguments) {
  print('Hello world: ${cli.calculate()}! ${hello.hello()}');
}
