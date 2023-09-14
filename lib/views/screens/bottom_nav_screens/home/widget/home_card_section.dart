import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/helper/string_format_helper.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_images.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/url_container.dart';
import 'package:mine_lab/data/controller/bottom_nav/home/home_controller.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/home/components/miner_item_card.dart';

class HomeCardSection extends StatefulWidget {

  const HomeCardSection({Key? key}) : super(key: key);

  @override
  State<HomeCardSection> createState() => _HomeCardSectionState();
}

class _HomeCardSectionState extends State<HomeCardSection> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      builder: (controller) => SizedBox(
        height: 75,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MinerCardItem(image: MyImages.balance, title: '${MyStrings.balance}              ', data: controller.balance),
              const SizedBox(width: Dimensions.space10),
              MinerCardItem(image: MyImages.reward, title: MyStrings.referralBonus, data: controller.referralBonus),
              const SizedBox(width: Dimensions.space10),
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                itemCount: controller.minersList.length,
                separatorBuilder: (context, index) => const SizedBox(width: Dimensions.space10),
                itemBuilder: (context, index) => MinerCardItem(
                  isNetWorkImage: true,
                  image: "${UrlContainer.baseUrl}${controller.imagePath}${controller.minersList[index].coinImage}",
                  title: "${controller.minersList[index].coinCode ?? " "} ${MyStrings.wallet}",
                  data: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.minersList[index].userCoinBalances?.balance ?? "0",precision: 8)} ${controller.minersList[index].coinCode ?? " "}"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
