import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/withdraw/withdraw_money_controller.dart';
import 'package:mine_lab/views/components/buttons/rounded_button.dart';
import 'package:mine_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:mine_lab/views/components/divider/custom_divider.dart';
import 'package:mine_lab/views/components/text-field/custom_amount_text_field.dart';
import 'package:mine_lab/views/components/text/header_text.dart';

class WithdrawMoneyBottomSheet{

  static void bottomSheet(BuildContext context,WithdrawMoneyController withdrawMoneyController, int index){

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: MyColor.transparentColor,
      context: context,
      builder: (context) => GetBuilder<WithdrawMoneyController>(builder: (controller)=>SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
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
                HeaderText(
                    text: "${MyStrings.withdraw} ${controller.methodList[index].miner?.name ?? ""}",
                    textStyle: interSemiBoldLarge.copyWith(color: MyColor.colorBlack)
                ),
                const CustomDivider(space: Dimensions.space15),
                CustomAmountTextField(
                  currency: controller.currency,
                  labelText: MyStrings.amount,
                  hintText: MyStrings.enterAmount,
                  controller: controller.amountController,
                  onChanged: (value){
                    return ;
                  },
                ),
                const SizedBox(height: Dimensions.space20),

                controller.submitLoading? const RoundedLoadingBtn() : RoundedButton(
                  color: MyColor.primaryColor,
                  text: MyStrings.submit,
                  textColor: MyColor.colorWhite,
                  press: () {
                    int walletId =controller.methodList[index].id ?? -1;
                    if(walletId != -1){
                      controller.submitWithdraw(walletId,index);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ))
    ).then((value){
      withdrawMoneyController.amountController.text='';
      withdrawMoneyController.submitLoading = false;
    });
  }
}