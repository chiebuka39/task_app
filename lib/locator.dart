import 'package:get_it/get_it.dart';

import 'data/repo/tasks_api.dart';
import 'data/repo/tasks_api.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton<AbstractTaskApi>(() => TaskApi());

}