import 'package:ecom_demo/network/http_client.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:ecom_demo/network/services/home_services.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register your services and repositories here
  // Example:
  locator.registerLazySingleton<HttpClient>(() => HttpClient());
  locator.registerLazySingleton<HomeServices>(() => HomeServices(locator<HttpClient>()));
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository(locator<HomeServices>()));
  // locator.registerFactory<YourRepository>(() => YourRepository());

}