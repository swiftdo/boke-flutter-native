import 'package:oldbirds/services/services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => NativeRepository());
}
