import 'package:ecom_demo/feature/category_details/bloc/category_screen_bloc.dart';
import 'package:ecom_demo/feature/home/Widget/serach_widget.dart';
import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/common_widget/imgae_display_widget.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  static const String routeName = '/category-screen';

  static GoRoute route({
    required HomeRepository homeRepository,
  }) {
    return GoRoute(
      name: 'category',
      path: CategoryScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        final data = state.extra as Map<String, dynamic>;
        final int categoryId = data['categoryId'];
        final String categoryName = data['catgeoryName'];
        return BlocProvider(
          create: (context) => CategoryScreenBloc(
            homeRepository: homeRepository,
          ),
          child: CategoryScreen(
            categoryId: categoryId,
            categoryName: categoryName,
          ),
        );
      },
    );
  }

  const CategoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ScrollController productListViewController = ScrollController();
  bool isLoading = false;
  List<ProductListModel> productList = [];
  List<ProductListModel> filterProductList = [];
  TextEditingController searchController = TextEditingController();
  int productLimit = 10;
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
      _fetechProducts(productLimit, productOffset);
    });
    productListViewController.addListener(() {
      if (productListViewController.position.atEdge &&
          productListViewController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        _fetechProducts(productLimit, productOffset);
      }
    });
  }

  void _onSearchCahnged(String value) {
    filterProductList = productList
        .where((element) => element.title
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  void _fetechProducts(int l, int o) async {
    context.read<CategoryScreenBloc>().add(
          FetchCategoryProductsEvent(
            offset: o,
            limit: l,
            categoryId: widget.categoryId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryScreenBloc, CategoryScreenState>(
      listener: (context, state) {
        if (state is ProductListLoading) {
          isLoading = true;
        } else if (state is ProductListError) {
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
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : productList.isEmpty
                    ? const Center(
                        child: Text('No Products Found'),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  context.paddingHorizontal(5),
                                  Text(
                                    widget.categoryName,
                                    style: CustomTextUtils.showPoppinsStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            HomeSearchWidget(
                              searchController: searchController,
                              onSearchChanged: _onSearchCahnged,
                            ),
                            context.paddingVertical(10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                controller: productListViewController,
                                shrinkWrap: true,
                                itemCount: searchController.text.isEmpty ? productList.length : filterProductList.length,
                                itemBuilder: (context, index) {
                                  var prod = searchController.text.isEmpty
                                      ? productList[index]
                                      : filterProductList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CacheImageWidget(
                                          imageWidth: 100,
                                          imageHeight: 150,
                                          imageUrl:
                                              prod.images[0],
                                        ),
                                        context.paddingHorizontal(10),
                                        Expanded(
                                          child: Text(
                                            prod.title,
                                            style: CustomTextUtils
                                                .showPoppinsStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }
}
