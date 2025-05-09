import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_demo/feature/product_details/bloc/product_details_screen_bloc.dart';
import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/common_widget/imgae_display_widget.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
  int current = 0;

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

  void setIndicator(index) {
    if (mounted) {
      setState(() {
        current = index;
      });
    }
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
        return SafeArea(
          child: Scaffold(
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
                            horizontal: 10,
                            vertical: 10,
                          ),
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
                                  size: 15,
                                ),
                              ),
                              Text(
                                Strings.back,
                                style: CustomTextUtils.showPoppinsStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildCarsouelSlider(),
                        context.paddingVertical(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                productData!.category.name,
                                style: CustomTextUtils.showPoppinsStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontColor: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  context.read<ProductDetailsScreenBloc>().add(
                                        AddToCart(
                                          productListModel: productData!,
                                        ),
                                      );
                                },
                                child: Container(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        context.paddingVertical(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  productData!.title,
                                  style: CustomTextUtils.showPoppinsStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontColor: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                context.convertCurrencyInBottomSheet(
                                  double.parse(
                                    productData!.price.toString(),
                                  ),
                                ),
                                style: CustomTextUtils.showPoppinsStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        context.paddingVertical(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            productData!.description,
                            style: CustomTextUtils.showPoppinsStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: Colors.black,
                            ),
                          ),
                        ),
                        context.paddingVertical(40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            Strings.similarProducts,
                            style: CustomTextUtils.showPoppinsStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontColor: Colors.black,
                            ),
                          ),
                        ),
                        context.paddingVertical(20),
                        Container(
                          height: 200,
                          margin: EdgeInsets.only(left: 20),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: similarProductList
                                .length, // Replace with your category count
                            itemBuilder: (ctx, index) {
                              var prod = similarProductList[index];
                              return Container(
                                width: 170,
                                padding: EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    context.push(
                                      ProductDetailsScreen.routeName,
                                      extra: prod.id,
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CacheImageWidget(
                                        imageWidth: 150,
                                        imageHeight: 150,
                                        imageUrl: prod.images[0],
                                      ),
                                      ctx.paddingVertical(10),
                                      Expanded(
                                        child: Text(
                                          prod.title,
                                          style:
                                              CustomTextUtils.showPoppinsStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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

  Widget _buildCarsouelSlider() {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: productData!.images.length,
          options: CarouselOptions(
            height: 45.h,
            viewportFraction: 1.0,
            reverse: false,
            enableInfiniteScroll: false,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setIndicator(index);
            },
          ),
          itemBuilder: (
            BuildContext context,
            int itemIndex,
            int pageViewIndex,
          ) {
            return CacheImageWidget(
              imageWidth: context.getWidth(),
              imageHeight: 45.h,
              imageUrl: productData!.images[itemIndex],
            );
          },
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: productData!.images.map(
                (url) {
                  int index = productData!.images.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: current == index ? Colors.blue : Colors.white38,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
