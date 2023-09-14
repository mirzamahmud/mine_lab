import 'package:flutter/material.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/styles.dart';

class MenuItems extends StatelessWidget {
  final String imageSrc;
  final String label;
  final VoidCallback onPressed;
  const MenuItems({
    Key? key,
    required this.imageSrc,
    required this.label,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
        color: MyColor.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35, width: 35,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: MyColor.screenBgColor, shape: BoxShape.circle),
                  child: Image.asset(imageSrc, color: MyColor.colorBlack, height: 17.5, width: 17.5),
                ),
                const SizedBox(width: Dimensions.space15),
                Text(label, style: interRegularDefault.copyWith(color: MyColor.colorBlack))
              ],
            ),
            Container(
              height: 30, width: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: MyColor.transparentColor, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_forward_ios_rounded, color: MyColor.colorBlack, size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
