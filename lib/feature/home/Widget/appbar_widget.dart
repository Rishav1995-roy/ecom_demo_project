import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/common_widget/imgae_display_widget.dart';
import 'package:ecom_demo/utils/images.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';

class HomeAppBarWidget extends StatelessWidget {
  final int count;
  const HomeAppBarWidget({
    super.key,
    required this.count,
  });

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
          Stack(
            children: [
              AssetImageWidget(
                imageData: Images.cart,
                imageWidth: 25,
                imageHeight: 25,
              ),
              if (count > 0) ...[
                Positioned(
                  right: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        count > 9 ? '9+' : count.toString(),
                        style: CustomTextUtils.showPoppinsStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
