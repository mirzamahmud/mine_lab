import 'package:flutter/material.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_images.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/views/components/text/default_text.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(MyImages.noData, height: 150, width: 150),
          const SizedBox(height: Dimensions.space15),
          DefaultText(text: MyStrings.noData, textAlign: TextAlign.center, textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack))
        ],
      ),
    );
  }
}
