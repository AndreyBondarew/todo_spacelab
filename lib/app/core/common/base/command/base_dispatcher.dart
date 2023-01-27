import 'base_command.dart';

abstract class BaseCommandDispatcher {
  const BaseCommandDispatcher();

  Future<void> dispatch(BaseCommand command);
}
