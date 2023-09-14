import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/helper/string_format_helper.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/core/utils/util.dart';
import 'package:mine_lab/data/controller/wallet/wallet_controller.dart';
import 'package:mine_lab/data/repo/wallet_repo/wallet_repo.dart';
import 'package:mine_lab/data/services/api_service.dart';
import 'package:mine_lab/views/components/bottom_Nav/bottom_nav.dart';
import 'package:mine_lab/views/components/card/custom_card.dart';
import 'package:mine_lab/views/components/custom_loader.dart';
import 'package:mine_lab/views/components/divider/custom_divider.dart';
import 'package:mine_lab/views/components/general_components/no_data_found.dart';
import 'package:mine_lab/views/components/text/small_text.dart';
import 'package:mine_lab/views/components/will_pop_widget.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/wallet/widget/wallet_update_bottom_sheet.dart';

class WalletScreen extends StatefulWidget {

  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WalletRepo(apiClient: Get.find()));
    final controller = Get.put(WalletController(walletRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadWalletData();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreenUtil();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColor.primaryColor,
          title: Text(MyStrings.wallets, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
          automaticallyImplyLeading: false,
        ),
        body: GetBuilder<WalletController>(
          builder: (controller) => controller.isLoading ? const CustomLoader() : controller.walletList.isEmpty ? const Center(
            child: NoDataFound(),
          ) : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: Dimensions.screenPaddingHV,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.walletList.length,
                separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                itemBuilder: (context, index) => CustomCard(
                  cardBgColor: MyColor.colorWhite,
                  verticalPadding: Dimensions.space15, horizontalPadding: Dimensions.space15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.walletList[index].miner?.coinCode ?? ""} ${MyStrings.wallet}",
                            style: interRegularDefault.copyWith(color: MyColor.colorBlack)
                          ),
                          InkWell(
                            onTap: (){
                              controller.setTextFieldData(index);
                              WalletUpdateBottomSheet.bottomSheet(context, index);
                            },
                            child: Container(
                              height: 25, width: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.1), shape: BoxShape.circle),
                              child: const Icon(Icons.edit, color: MyColor.primarySubTitleColor, size: 12.5)
                            ),
                          )
                        ],
                      ),
                      const CustomDivider(space: Dimensions.space12),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SmallText(text: MyStrings.balance, textColor: MyColor.labelTextColor),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                    "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.walletList[index].balance ?? "")} ${controller.walletList[index].miner?.coinCode ?? ""}",
                                    style: interRegularDefault.copyWith(fontWeight: FontWeight.w500,)
                                ),
                              ],
                            ),

                            const SizedBox(width: Dimensions.space15,),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SmallText(text: "${MyStrings.wallet} ${MyStrings.address}", textColor: MyColor.labelTextColor),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                      controller.walletList[index].wallet ?? "",
                                      style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      maxLines: 2,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      ),
    );
  }
}
