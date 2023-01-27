import 'base_command.dart';

abstract class BaseCommandHandler<C extends BaseCommand> {
  const BaseCommandHandler();

  Future<void> execute(C command);
}
