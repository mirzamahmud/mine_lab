import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_images.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/auth/two_factor_controller.dart';
import 'package:mine_lab/data/repo/auth/two_factor_repo.dart';
import 'package:mine_lab/data/services/api_service.dart';
import 'package:mine_lab/views/components/appbar/custom_appbar.dart';
import 'package:mine_lab/views/components/auth_components/auth_layout.dart';
import 'package:mine_lab/views/components/buttons/rounded_button.dart';
import 'package:mine_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class TwoFactorVerificationScreen extends StatefulWidget {

  final bool isProfileCompleteEnable;
  const TwoFactorVerificationScreen({
    Key? key,
    required this.isProfileCompleteEnable
  }) : super(key: key);

  @override
  State<TwoFactorVerificationScreen> createState() => _TwoFactorVerificationScreenState();
}

class _TwoFactorVerificationScreenState extends State<TwoFactorVerificationScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    final controller = Get.put(TwoFactorController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable=widget.isProfileCompleteEnable;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: CustomAppBar(title:MyStrings.twoFactorAuth.tr,fromAuth: true,bgColor: MyColor.primaryColor),
          body: SingleChildScrollView(
            child: GetBuilder<TwoFactorController>(
                builder: (controller) =>  AuthLayout(
                  bottomSpace: Dimensions.space50 * 2.2,
                  imageUrl: MyImages.resetPassImage,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(MyStrings.twoFactorMsg, style: interRegularDefault.copyWith(color: MyColor.colorBlack), textAlign: TextAlign.center),
                      const SizedBox(height: Dimensions.space30),
                      PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: interRegularDefault.copyWith(color: MyColor.colorBlack),
                        length: 6,
                        textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack),
                        obscureText: false,
                        obscuringCharacter: '*',
                        blinkWhenObscuring: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 40,
                            fieldWidth: 40,
                            inactiveColor:  MyColor.colorGrey,
                            inactiveFillColor: MyColor.transparentColor,
                            activeFillColor: MyColor.transparentColor,
                            activeColor: MyColor.primaryColor,
                            selectedFillColor: MyColor.transparentColor,
                            selectedColor: MyColor.primaryColor
                        ),
                        cursorColor: MyColor.colorBlack,
                        animationDuration:
                        const Duration(milliseconds: 100),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        beforeTextPaste: (text) {
                          return true;
                        },
                        onChanged: (value) {
                          setState(() {
                            controller.currentText = value;
                          });
                        },
                      ),
                      const SizedBox(height: Dimensions.space25),
                      controller.submitLoading?const RoundedLoadingBtn() : RoundedButton(
                        press: (){
                          controller.verifyYourSms(controller.currentText);
                        },
                        text: MyStrings.verify,
                      ),
                    ],
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}
