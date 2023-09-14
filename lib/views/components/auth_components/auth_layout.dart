import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';

import '../../../core/route/route.dart';

class AuthLayout extends StatefulWidget {
  final String imageUrl;
  final Widget child;
  final double bottomSpace;
  final bool showBackButton;
  final double imageHeight;
  final double imageWidth;

  const AuthLayout({
    Key? key,
    required this.imageUrl,
    required this.child,
    this.bottomSpace = -Dimensions.space20,
    this.showBackButton = false,
    this.imageHeight = Dimensions.imageHeight,
    this.imageWidth = Dimensions.imageWidth
  }) : super(key: key);

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(height: MediaQuery.of(context).size.height),
          Positioned(
            top: -160, right: -80,
            child: Container(
              height: 420, width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: MyColor.circleContainerColor2,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: -170, left: -10, right: -10,
            child: Container(
              height: 420, width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: MyColor.circleContainerColor1,
                  shape: BoxShape.circle
              ),
            ),
          ),
          widget.showBackButton ? Positioned(
            top: Dimensions.space20, left: Dimensions.space15,
            child: InkWell(
             onTap: () {
                Get.offAllNamed(RouteHelper.loginScreen);
              },
              child: Container(
                height: 32, width: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back, color: MyColor.colorBlack, size: 16),
              ),
            ),
          ) : const SizedBox(),
          Positioned(
            top: 60, left: Dimensions.space50, right: Dimensions.space50,
            child: Image.asset(widget.imageUrl, height: widget.imageHeight, width: widget.imageWidth),
          ),
          Positioned(
            top: 270, right: -25,
            child: Container(
              height: 80, width: 80,
              decoration: const BoxDecoration(
                  color: MyColor.smallCircleColor,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            bottom: widget.bottomSpace, left: -25,
            child: Container(
              height: 80, width: 80,
              decoration: const BoxDecoration(
                  color: MyColor.smallCircleColor,
                  shape: BoxShape.circle
              ),
            ),
          ),

          Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 300),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
                  ),
                  child: widget.child,
                ),
              ),
              const SizedBox(height: Dimensions.space20),
            ],
          )
        ],
      ),
    );
  }
}
