import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_images.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/auth/registration/registration_controller.dart';
import 'package:mine_lab/data/repo/auth/registration/registration_repo.dart';
import 'package:mine_lab/data/services/api_service.dart';
import 'package:mine_lab/views/components/auth_components/auth_layout.dart';
import 'package:mine_lab/views/components/will_pop_widget.dart';
import 'package:mine_lab/views/screens/auth/registration/widget/registration_form.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.screenBgColor,
            body: GetBuilder<RegistrationController>(
              builder: (controller) => AuthLayout(
                showBackButton: true,
                imageUrl: MyImages.registrationImage,
                imageHeight: 230,
                imageWidth: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Text(MyStrings.signUpTitle, textAlign: TextAlign.center, style: interRegularExtraLarge.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: Dimensions.space20),
                      const RegistrationForm(),
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
