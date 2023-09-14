import 'package:flutter/material.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/views/components/form_row.dart';

class LabelText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final bool required;
  final Color textColor;

  const LabelText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textColor = MyColor.labelTextColor,
    this.required = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return required?FormRow(label: text, isRequired: true):Text(
      text,
      textAlign: textAlign,
      style: interRegularDefault.copyWith(color: textColor),
    );
  }
}
