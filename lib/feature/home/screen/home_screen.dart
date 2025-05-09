import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:ecom_demo/feature/home/bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    // check api trigger is done or not
    _fetechProducts();
  }

  void _fetechProducts() async {
    context.read<HomeScreenBloc>().add(FetchProductsEvent(offset: 0, limit: 10));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: ConnectivityWidgetWrapper(
        message: 'No Internet Connection detected',
        child: Text(
          'Welcome to the Home Screen!',
        ),
      ),
    );
  }
}
//