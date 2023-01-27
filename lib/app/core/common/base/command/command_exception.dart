import 'package:todo_spacelab/app/core/common/base/exception.dart';

class BaseCommandException implements BaseException {}

class InvalidCommandException implements BaseCommandException {
  final String? message;

  InvalidCommandException({this.message});

  @override
  String toString() {
    return 'ERROR! Invalid command! $message';
  }
}
