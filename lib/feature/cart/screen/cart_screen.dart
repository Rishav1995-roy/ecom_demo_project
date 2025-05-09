import 'package:ecom_demo/feature/cart/bloc/cart_screen_bloc.dart';
import 'package:ecom_demo/models/cart_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/common_widget/imgae_display_widget.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/local_storage.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart-screen';

  static GoRoute route({
    required HomeRepository homeRepository,
  }) {
    return GoRoute(
      name: 'cart',
      path: CartScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => CartScreenBloc(homeRepository: homeRepository),
          child: const CartScreen(),
        );
      },
    );
  }

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartData> cartItems = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.afterWidgetBuilt(() {
      _fetchCartItems();
    });
  }

  void _fetchCartItems() {
    context.read<CartScreenBloc>().add(FetchCartData());
  }

  void _removeCartData(String productID) {
    context.read<CartScreenBloc>().add(RemoveCart(productID: productID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartScreenBloc, CartScreenState>(
      listener: (context, state) {
        if (state is CartListLoaded) {
          isLoading = false;
          cartItems.addAll(state.cartData);
        } else if (state is CartListLoading) {
          isLoading = true;
        } else if (state is CartListError) {
          isLoading = false;
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
            body: SizedBox(
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
                        context.paddingVertical(10),
                        Expanded(
                          child: cartItems.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 140,
                                    vertical: 300,
                                  ),
                                  child: Text('No cart items added'),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Text(
                                          'Cart items',
                                          style:
                                              CustomTextUtils.showPoppinsStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                      context.paddingVertical(10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: cartItems.length,
                                          itemBuilder: (context, index) {
                                            var prod = cartItems[index];
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
                                                    imageUrl: prod.imageUrl[0],
                                                  ),
                                                  context.paddingHorizontal(10),
                                                  Expanded(
                                                    child: Text(
                                                      prod.name,
                                                      style: CustomTextUtils
                                                          .showPoppinsStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontColor: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        _removeCartData(
                                                            prod.id);
                                                      },
                                                      icon: Icon(
                                                        Icons.close_rounded,
                                                      ))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      context.paddingVertical(10),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black
                                              .withValues(alpha: 0.4),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Bill details',
                                              style: CustomTextUtils
                                                  .showPoppinsStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontColor: Colors.black,
                                              ),
                                            ),
                                            context.paddingVertical(10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Item total',
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontColor: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  context
                                                      .convertCurrencyInBottomSheet(
                                                    LocalStorage.getCartTotal(),
                                                  ),
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontColor: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                            context.paddingVertical(5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Festive handling charges',
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontColor: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  context
                                                      .convertCurrencyInBottomSheet(
                                                    8,
                                                  ),
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontColor: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                            context.paddingVertical(5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Delivary partner fee',
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontColor: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  context
                                                      .convertCurrencyInBottomSheet(
                                                    30,
                                                  ),
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontColor: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                            context.paddingVertical(5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Gst & Charges',
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontColor: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  context
                                                      .convertCurrencyInBottomSheet(
                                                    6,
                                                  ),
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontColor: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                            context.paddingVertical(5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'To pay',
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    fontColor: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  context
                                                      .convertCurrencyInBottomSheet(
                                                    157,
                                                  ),
                                                  style: CustomTextUtils
                                                      .showPoppinsStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    fontColor: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Container(
                              width: context.getWidth(),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Pay',
                                  style: CustomTextUtils.showPoppinsStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontColor: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                        context.paddingVertical(20),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
