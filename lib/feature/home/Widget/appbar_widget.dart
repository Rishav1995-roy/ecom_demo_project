import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/common_widget/imgae_display_widget.dart';
import 'package:ecom_demo/utils/images.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Strings.appName,
            style: CustomTextUtils.showPoppinsStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontColor: Colors.black,
            ),
          ),
          AssetImageWidget(
            imageData: Images.cart,
            imageWidth: 25,
            imageHeight: 25,
          ),
        ],
      ),
    );
  }
}
