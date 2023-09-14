import 'package:flutter/material.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/styles.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  const HeaderText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interSemiBoldHeader1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle.copyWith(color: MyColor.colorBlack),
    );
  }
}
