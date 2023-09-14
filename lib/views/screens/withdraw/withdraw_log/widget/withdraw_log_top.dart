import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/withdraw/withdraw_controller.dart';

class WithdrawLogTop extends StatelessWidget {
  const WithdrawLogTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(MyStrings.transactionNo, style: interRegularSmall.copyWith(color: MyColor.colorGrey, fontWeight: FontWeight.w500)),
                const SizedBox(height: Dimensions.space5),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    cursorColor: MyColor.primaryColor,
                    style: interRegularSmall.copyWith(color: MyColor.colorBlack),
                    keyboardType: TextInputType.text,
                    controller: controller.searchController,
                    decoration: InputDecoration(
                        hintText: MyStrings.searchByTransactions,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        hintStyle: interRegularSmall.copyWith(color: MyColor.hintTextColor),
                        filled: true,
                        fillColor: MyColor.transparentColor,
                        border: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey, width: 0.5)),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey, width: 0.5)),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor, width: 0.5))
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: Dimensions.space10),

          InkWell(
            onTap: () {
              controller.filterData();
            },
            child: Container(
              height: 45,
              width: 45,
              padding:
              const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColor.primaryColor,),
              child: const Icon(
                  Icons.search_outlined,
                  color: MyColor.colorWhite,
                  size: 18),
            ),
          )
        ],
      ),
    );
  }
}
