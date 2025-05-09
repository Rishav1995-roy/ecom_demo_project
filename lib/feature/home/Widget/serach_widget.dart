import 'package:ecom_demo/utils/common_widget/custom_text_utils.dart';
import 'package:ecom_demo/utils/context_utils.dart';
import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';

class HomeSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function onSearchChanged;
  const HomeSearchWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.search, color: Colors.grey),
          context.paddingHorizontal(10),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                onSearchChanged(value);
              },
              decoration: InputDecoration(
                constraints: BoxConstraints(
                  maxHeight: 15, // For fixed height, set both min and max to the same value
                ),
                hintText: Strings.search,
                isDense: false,
                contentPadding: const EdgeInsets.only(
                  bottom: 13,
                ),
                border: InputBorder.none,
                hintStyle: CustomTextUtils.showPoppinsStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
