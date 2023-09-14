import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_images.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/menu_controller/menu_controller.dart';
import 'package:mine_lab/data/repo/menu_repo/menu_repo.dart';
import 'package:mine_lab/data/services/api_service.dart';
import 'package:mine_lab/views/components/bottom_Nav/bottom_nav.dart';
import 'package:mine_lab/views/components/divider/custom_divider.dart';
import 'package:mine_lab/views/components/will_pop_widget.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/menu/widget/menu_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    Get.put(MenuController(menuRepo: Get.find()));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: MyColor.primaryColor,
            title: Text(MyStrings.menu, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
            automaticallyImplyLeading: false,
          ),
          body: GetBuilder<MenuController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                    decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        MenuItems(
                            imageSrc: MyImages.person,
                            label: MyStrings.profile,
                            onPressed: () => Get.toNamed(RouteHelper.profileScreen)
                        ),
                        const CustomDivider(),
                        MenuItems(
                            imageSrc: MyImages.dChangePass,
                            label: MyStrings.changePassword,
                            onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen)
                        ),
                        const CustomDivider(),
                        MenuItems(
                            imageSrc: MyImages.newMine,
                            label: MyStrings.startMining,
                            onPressed: () => Get.toNamed(RouteHelper.miningPlanScreen)
                        ),
                        const CustomDivider(),
                        MenuItems(
                            imageSrc: MyImages.withdraw,
                            label: MyStrings.withdrawHistory,
                            onPressed: () => Get.toNamed(RouteHelper.withdrawLogScreen)
                        ),
                        const CustomDivider(),
                        MenuItems(
                            imageSrc: MyImages.miningTracks,
                            label: MyStrings.miningHistory,
                            onPressed: () => Get.toNamed(RouteHelper.miningHistoryScreen)
                        ),
                        const CustomDivider(),
                        MenuItems(
                            imageSrc: MyImages.dReferral,
                            label: MyStrings.referrals,
                            onPressed: () => Get.toNamed(RouteHelper.referralBonusLogScreen)
                        ),
                        const CustomDivider(),
                        MenuItems(
                            imageSrc: MyImages.transaction,
                            label: MyStrings.transaction,
                            onPressed: () => Get.toNamed(RouteHelper.transactionScreen)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                      decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          MenuItems(
                              imageSrc: MyImages.dPolicy,
                              label: MyStrings.privacyPolicy,
                              onPressed: () => Get.toNamed(RouteHelper.privacyPolicyScreen)
                          ),
                          const CustomDivider(),
                          controller.logoutLoading ? const Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 20, width: 20,
                              child: CircularProgressIndicator(color: MyColor.primaryColor, strokeWidth: 2.00),
                            ),
                          ) : MenuItems(
                              imageSrc: MyImages.dLogout,
                              label: MyStrings.dLogout,
                              onPressed: () => controller.logout()
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
        ),
      ),
    );
  }
}
