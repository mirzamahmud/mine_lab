import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_images.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/auth/sms_verification_controler.dart';
import 'package:mine_lab/data/controller/profile/user_profile_controller.dart';
import 'package:mine_lab/data/repo/auth/sms_email_verification_repo.dart';
import 'package:mine_lab/data/repo/profile/user_profile_repo.dart';
import 'package:mine_lab/data/services/api_service.dart';
import 'package:mine_lab/views/components/appbar/custom_appbar.dart';
import 'package:mine_lab/views/components/auth_components/auth_layout.dart';
import 'package:mine_lab/views/components/buttons/rounded_button.dart';
import 'package:mine_lab/views/components/custom_loader.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SmsVerifyScreen extends StatefulWidget {

  const SmsVerifyScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerifyScreen> createState() => _SmsVerifyScreenState();
}

class _SmsVerifyScreenState extends State<SmsVerifyScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    Get.put(UserProfileRepo(apiClient: Get.find()));
    Get.put(UserProfileController(userProfileRepo: Get.find()));
    final controller = Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable = Get.arguments[0];
      controller.loadBefore();
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
          backgroundColor: MyColor.colorWhite,
          appBar: const CustomAppBar(
            fromAuth: true,
            isShowBackBtn: true,
            bgColor: MyColor.primaryColor,
            title: MyStrings.smsVerify,
          ),
          body: GetBuilder<SmsVerificationController>(
            builder: (controller) => AuthLayout(
              imageUrl: MyImages.emailVerifyImage,
              child: controller.isLoading ? const CustomLoader() : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(MyStrings.enterOtp, textAlign: TextAlign.center, style: interRegularExtraLarge.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: Dimensions.space10),
                  Text(
                      MyStrings.verifyPasswordSubText,
                      textAlign: TextAlign.center,
                      style: interRegularDefault.copyWith(color: MyColor.primarySubTitleColor)
                  ),
                  const SizedBox(height: Dimensions.space20),
                  PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: interRegularDefault.copyWith(color: MyColor.primaryColor),
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
                      controller.currentText = value;
                    },
                  ),
                  const SizedBox(height: Dimensions.space25),
                  RoundedButton(
                      text: MyStrings.submit,
                      textColor: MyColor.colorWhite,
                      color: MyColor.primaryColor,
                      press: (){
                        controller.verifyYourSms(controller.currentText);
                      }
                  )
                ],
              )
            ),
          ),
          ),
        ),
    );
  }
}
