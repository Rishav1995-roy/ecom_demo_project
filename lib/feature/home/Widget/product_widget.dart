import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/common_widget/imgae_display_widget.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final List<ProductListModel> productList;
  final ScrollController productListViewController;
  final Function onTap;
  final Function addToCart;
  const ProductWidget({
    super.key,
    required this.productList,
    required this.productListViewController,
    required this.onTap,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.paddingVertical(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            Strings.products,
            style: CustomTextUtils.showPoppinsStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontColor: Colors.black,
            ),
          ),
        ),
        context.paddingVertical(10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            cacheExtent: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.6,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var prod = productList[index];
              return LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onTap(prod.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 170,
                          child: Stack(
                            children: [
                              CacheImageWidget(
                                imageWidth: 170,
                                imageHeight: 170,
                                imageUrl: prod.images[0],
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      addToCart(prod);
                                    },
                                    child: Container(
                                      color:
                                          Colors.white.withValues(alpha: 0.6),
                                      padding: const EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        context.paddingVertical(10),
                        Text(
                          prod.title,
                          style: CustomTextUtils.showPoppinsStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontColor: Colors.black,
                          ),
                        ),
                        context.paddingVertical(10),
                        Text(
                          context.convertCurrencyInBottomSheet(
                              double.parse(prod.price.toString())),
                          style: CustomTextUtils.showPoppinsStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
