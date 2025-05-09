import 'package:ecom_demo/models/category_list_model.dart';
import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/common_widget/imgae_display_widget.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final List<CategoryListModel> categoryList;
  final ScrollController categoryListViewController;
  final Function goToCatgeory;
  const CategoryWidget({
    super.key,
    required this.categoryList,
    required this.categoryListViewController,
    required this.goToCatgeory,
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
            Strings.category,
            style: CustomTextUtils.showPoppinsStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontColor: Colors.black,
            ),
          ),
        ),
        context.paddingVertical(10),
        Container(
          height: 200,
          margin: EdgeInsets.only(left: 20),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            controller: categoryListViewController,
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length, // Replace with your category count
            itemBuilder: (ctx, index) {
              var cat = categoryList[index];
              return Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    goToCatgeory(cat.id, cat.name);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CacheImageWidget(
                        imageWidth: 150,
                        imageHeight: 150,
                        imageUrl: cat.image,
                      ),
                      ctx.paddingVertical(10),
                      Text(
                        cat.name,
                        style: CustomTextUtils.showPoppinsStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontColor: Colors.black,
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
    );
  }
}
