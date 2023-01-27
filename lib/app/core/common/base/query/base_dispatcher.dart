import 'base_query.dart';

abstract class BaseQueryDispatcher{
  const BaseQueryDispatcher();

  Future<dynamic> dispatch(BaseQuery query);
}