import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:ecom_demo/feature/home/bloc/home_screen_bloc.dart';
import 'package:ecom_demo/feature/home/screen/home_screen.dart';
import 'package:ecom_demo/locator.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:ecom_demo/utils/common_widget/dismiss_widget.dart';
import 'package:ecom_demo/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await LocalStorage.initialiseLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarBrightness: Brightness.light,
      ),
    );
    return ConnectivityAppWrapper(
      app: ResponsiveSizer(
        builder: (_, orientation, screenType) {
          return DismissKeyboard(
            child: MaterialApp.router(
              routerConfig: _router,
            ),
          );
        },
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) =>
              HomeScreenBloc(homeRepository: locator<HomeRepository>()),
          child: const HomeScreen(),
        );
      },
      routes: <RouteBase>[
        // GoRoute(
        //   path: 'details',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const DetailsScreen();
        //   },
        // ),
      ],
    ),
  ],
);
