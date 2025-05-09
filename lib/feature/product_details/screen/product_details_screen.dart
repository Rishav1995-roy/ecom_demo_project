import 'package:ecom_demo/feature/product_details/bloc/product_details_screen_bloc.dart';
import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  static const String routeName = '/product-details-screen';

  static GoRoute route({
    required HomeRepository homeRepository,
  }) {
    return GoRoute(
      name: 'product-details',
      path: ProductDetailsScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        final productID = state.extra as int;
        return BlocProvider(
          create: (context) => ProductDetailsScreenBloc(
            homeRepository: homeRepository,
          ),
          child: ProductDetailsScreen(
            productId: productID,
          ),
        );
      },
    );
  }

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<ProductListModel> similarProductList = [];
  ProductListModel? productData;

  @override
  void initState() {
    super.initState();
    context.afterWidgetBuilt(() {
      context.read<ProductDetailsScreenBloc>().add(
            FetchProductsDetailsEvent(
              productID: widget.productId,
            ),
          );
      context.read<ProductDetailsScreenBloc>().add(
            FetchSimilarProductEvent(
              productID: widget.productId,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsScreenBloc, ProductDetailsScreenState>(
      listener: (context, state) {
        if (state is ProductDetailsLoaded) {
          productData = state.productData;
        } else if (state is SimilarProductListLoaded) {
          similarProductList.addAll(state.productList);
        } else if (state is ProductDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Strings.somethingWentWrong),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: productData == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.paddingVertical(10),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                Strings.back,
                                style: CustomTextUtils.showPoppinsStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontColor: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
