import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:ecom_demo/feature/category_details/screen/category_screen.dart';
import 'package:ecom_demo/feature/home/Widget/appbar_widget.dart';
import 'package:ecom_demo/feature/home/Widget/category_widget.dart';
import 'package:ecom_demo/feature/home/Widget/product_widget.dart';
import 'package:ecom_demo/feature/home/Widget/serach_widget.dart';
import 'package:ecom_demo/feature/home/bloc/home_screen_bloc.dart';
import 'package:ecom_demo/feature/product_details/screen/product_details_screen.dart';
import 'package:ecom_demo/models/category_list_model.dart';
import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  static GoRoute route({
    required HomeRepository homeRepository,
  }) {
    return GoRoute(
      name: 'splash',
      path: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => HomeScreenBloc(homeRepository: homeRepository),
          child: const HomeScreen(),
        );
      },
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<CategoryListModel> categoryList = [];
  List<ProductListModel> productList = [];
  List<ProductListModel> filterProductList = [];
  TextEditingController searchController = TextEditingController();
  ScrollController categoryListViewController = ScrollController();
  ScrollController productListViewController = ScrollController();
  int productLimit = 10;
  int categoryLimit = 10;
  int productOffset = 0;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterProductList = productList
          .where((element) => element.title
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
    context.afterWidgetBuilt(() {
      _fetchCategory(categoryLimit);
      _fetechProducts(productLimit, productOffset);
    });
    categoryListViewController.addListener(() {
      if (categoryListViewController.position.atEdge &&
          categoryListViewController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        _fetchCategory(categoryLimit);
      }
    });
    productListViewController.addListener(() {
      if (productListViewController.position.atEdge &&
          productListViewController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        _fetechProducts(productLimit, productOffset);
      }
    });
    // check api trigger is done or not
  }

  void _fetchCategory(int l) async {
    context.read<HomeScreenBloc>().add(FetchCategoryEvent(limit: l));
  }

  void _fetechProducts(int l, int o) async {
    context.read<HomeScreenBloc>().add(
          FetchProductsEvent(
            offset: o,
            limit: l,
          ),
        );
  }

  void _onSearchCahnged(String value) {
    filterProductList = productList
        .where((element) => element.title
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    if (mounted) {
      setState(() {});
    }
  }

  void _goToCatgeory(
    int id,
    String name,
  ) {
    context.push(
      CategoryScreen.routeName,
      extra: {
        'catgeoryName': name,
        'categoryId': id,
      },
    );
  }

  void _goToProductDetails(int id) {
    context.push(
      ProductDetailsScreen.routeName,
      extra: id,
    );
  }

  void _addToCart(ProductListModel data) {
    context.read<HomeScreenBloc>().add(
          AddToCart(
            productListModel: data,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<HomeScreenBloc>().cartCountStream,
      builder: (context, snapshot) {
        return BlocConsumer<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (state is CategoryListLoading) {
              if (categoryList.isEmpty) {
                isLoading = true;
              }
              isLoading = true;
            } else if (state is CategoryListLoaded) {
              categoryLimit += 10;
              categoryList.addAll(state.categoryList);
            } else if (state is CategoryListError ||
                state is ProductListError) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(Strings.somethingWentWrong),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is ProductListLoaded) {
              isLoading = false;
              productOffset += 10;
              productLimit += 10;
              productList.addAll(state.productList);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: ConnectivityWidgetWrapper(
                  message: Strings.noInternet,
                  child: SizedBox(
                    width: context.getWidth(),
                    height: context.getHeight(),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeAppBarWidget(
                                count: snapshot.data ?? 0,
                              ),
                              HomeSearchWidget(
                                searchController: searchController,
                                onSearchChanged: _onSearchCahnged,
                              ),
                              context.paddingVertical(10),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CategoryWidget(
                                        categoryList: categoryList,
                                        categoryListViewController:
                                            categoryListViewController,
                                        goToCatgeory: _goToCatgeory,
                                      ),
                                      ProductWidget(
                                        productList:
                                            searchController.text.isEmpty
                                                ? productList
                                                : filterProductList,
                                        productListViewController:
                                            productListViewController,
                                        onTap: _goToProductDetails,
                                        addToCart: _addToCart,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
