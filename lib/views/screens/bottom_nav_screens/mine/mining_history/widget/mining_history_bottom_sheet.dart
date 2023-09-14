import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/helper/date_converter.dart';
import 'package:mine_lab/core/helper/string_format_helper.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/plan/purchased_plan/purchased_plan_controller.dart';
import 'package:mine_lab/views/components/buttons/rounded_button.dart';
import 'package:mine_lab/views/components/divider/custom_divider.dart';
import 'package:mine_lab/views/components/text/default_text.dart';
import 'package:mine_lab/views/components/text/header_text.dart';
import 'package:mine_lab/views/components/text/small_text.dart';

class MiningHistoryBottomSheet{

  static void bottomSheet(BuildContext context, int index){

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: MyColor.transparentColor,
      context: context,
      builder: (context) => GetBuilder<PurchasedPlanController>(
        builder: (controller) =>  SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
            decoration: const BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 5, width: 50,
                    decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: Dimensions.space15),
                HeaderText(text: MyStrings.miningDetails, textStyle: interSemiBoldLarge.copyWith(color: MyColor.colorBlack)),
                const CustomDivider(space: Dimensions.space15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.planTitle, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(text: controller.purchasedPlanList[index].planDetails?.title ?? "", textColor: MyColor.colorBlack)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.date, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(text: DateConverter.isoStringToLocalDateOnly(controller.purchasedPlanList[index].createdAt ?? ""), textColor: MyColor.colorBlack)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Dimensions.space15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.amount, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.purchasedPlanList[index].amount ?? "")} ${controller.currency}", textColor: MyColor.colorBlack)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.miner, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(text: controller.purchasedPlanList[index].planDetails?.miner ?? "", textColor: MyColor.colorBlack)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Dimensions.space15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.speed, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(text: controller.purchasedPlanList[index].planDetails?.speed ?? "", textColor: MyColor.colorBlack)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.returnDay, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(
                              text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.purchasedPlanList[index].minReturnPerDay ?? "")} ${controller.purchasedPlanList[index].miner?.coinCode ?? ""}",
                              textColor: MyColor.colorBlack
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Dimensions.space15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.totalDays, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(text: controller.purchasedPlanList[index].period.toString(), textColor: MyColor.colorBlack)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallText(text: MyStrings.remainingDays, textColor: MyColor.colorGrey),
                          const SizedBox(height: Dimensions.space5),
                          DefaultText(text: controller.purchasedPlanList[index].periodRemain.toString(), textColor: MyColor.colorBlack)
                        ],
                      ),
                    )
                  ],
                ),

                controller.purchasedPlanList[index].status == "0" ? Column(
                  children: [
                    const CustomDivider(space: Dimensions.space20),
                    RoundedButton(
                      press: (){
                        String orderId = controller.purchasedPlanList[index].id.toString();
                        String amount = controller.purchasedPlanList[index].amount??'';
                        String title = controller.purchasedPlanList[index].planDetails?.title??'';
                        Get.back();
                        Get.toNamed(RouteHelper.planPaymentMethodScreen, arguments: [title,amount,orderId]);
                      },
                      text: MyStrings.payNow,
                      textColor: MyColor.colorWhite,
                      color: MyColor.primaryColor,
                    ),
                    const SizedBox(height: Dimensions.space20)
                  ],
                ) : controller.purchasedPlanList[index].status == "1" ? const SizedBox(height: Dimensions.space20)
                    : controller.purchasedPlanList[index].status == "2" ? const SizedBox(height: Dimensions.space20)
                    : controller.purchasedPlanList[index].status == "3" ? const SizedBox(height: Dimensions.space20) : const SizedBox(height: Dimensions.space20)
              ],
            ),
          ),
        ),
      )
    );
  }
}