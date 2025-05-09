import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:ecom_demo/feature/home/bloc/home_screen_bloc.dart';
import 'package:ecom_demo/feature/home/screen/home_screen.dart';
import 'package:ecom_demo/locator.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp.router(
        routerConfig: _router,
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
