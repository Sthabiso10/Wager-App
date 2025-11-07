import 'package:get_it/get_it.dart';
import 'package:wager_app/services/authentication_service.dart';
import 'package:wager_app/services/dialog_service.dart';
import 'package:wager_app/services/navigation.dart';
import 'package:wager_app/services/route_service.dart';
import 'package:wager_app/services/toast_service.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerLazySingleton(() => AuthenticationService());
  getIt.registerLazySingleton(() => DialogService());
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerLazySingleton(() => RouteService());
  getIt.registerLazySingleton(() => ToastService());
}
