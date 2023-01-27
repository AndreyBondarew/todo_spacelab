import 'package:todo_spacelab/app/core/common/base/exception.dart';

class BaseQueryException implements BaseException {}

class InvalidQueryException implements BaseQueryException {
  final String? message;

  InvalidQueryException({this.message});
}
