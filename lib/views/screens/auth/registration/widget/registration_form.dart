import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/auth/registration/registration_controller.dart';
import 'package:mine_lab/views/components/buttons/rounded_button.dart';
import 'package:mine_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:mine_lab/views/components/text-field/custom_text_field.dart';
import 'package:mine_lab/views/components/validation_widget/validation_widget.dart';
import 'package:mine_lab/views/screens/auth/registration/widget/country_bottom_sheet.dart';

class RegistrationForm extends StatefulWidget {

  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool isChecked = false;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.username,
                hintText: MyStrings.usernameHint,
                controller: controller.usernameController,
                focusNode: controller.usernameFocusNode,
                onChanged: (value) {},
                validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.usernameHint;
                } else if(value.length<6){
                  return MyStrings.kShortUserNameError;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.emailAddress,
                hintText: MyStrings.emailAddressHint,
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                textInputType: TextInputType.emailAddress,
                onChanged: (value) {},
                validator: (value) {
                  if (value!=null && value.isEmpty) {
                    return MyStrings.emailAddressHint;
                  } else if(!MyStrings.emailValidatorRegExp.hasMatch(value??'')) {
                    return MyStrings.enterValidEmail;
                  }else{
                    return null;
                  }
                },
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              readOnly: true,
              needLabel: false,
              needOutlineBorder: true,
              hintText: MyStrings.selectCountry,
              controller: controller.countryController,
              isShowSuffixIcon: true,
              isIcon: true,
              isCountryPicker: true,
              onTap: (){
                CountryBottomSheet.bottomSheet(context, controller);
              },
              onSuffixTap: (){
                CountryBottomSheet.bottomSheet(context, controller);
              },
              onChanged: (value){
                return ;
              },
            ),
            const SizedBox(height: Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  height: 47,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColor.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
                  ),
                  child: Text(
                    controller.countryName == null ? "--" : "+${controller.mobileCode}",
                    style: interRegularSmall.copyWith(color: MyColor.colorWithe),
                  ),
                ),
                const SizedBox(width: Dimensions.space5 + 3),
                Expanded(
                  child: CustomTextField(
                    needOutlineBorder: true,
                    needLabel: false,
                    labelText: MyStrings.phoneNumber,
                    hintText:  MyStrings.enterPhoneNo,
                    controller: controller.mobileController,
                    focusNode: controller.mobileFocusNode,
                    textInputType: TextInputType.phone,
                    inputAction: TextInputAction.next,
                    onChanged: (value) {
                      return;
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space20),
            Visibility(
                visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                child: ValidationWidget(list: controller.passwordValidationRules,)),
            Focus(
              onFocusChange: (hasFocus){
                controller.changePasswordFocus(hasFocus);
              },
              child: CustomTextField(
                  needLabel: false,
                  needOutlineBorder: true,
                  labelText: MyStrings.password,
                  hintText: MyStrings.passwordHint,
                  isPassword: true,
                  isShowSuffixIcon: true,
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  validator: (value){
                    return controller.validatePassword(value ?? '');
                  },
                  onChanged: (value) {
                    if(controller.checkPasswordStrength){
                      controller.updateValidationList(value);
                    }
                  }
              ),
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.confirmPassword,
                hintText: MyStrings.confirmPasswordHint,
                isPassword: true,
                isShowSuffixIcon: true,
                controller: controller.confirmPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                validator: (value){
                  if (controller.passwordController.text.toLowerCase() != controller.confirmPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {}
            ),
            const SizedBox(height: Dimensions.space20),
            controller.needAgree ? Row(
              children: [
                SizedBox(
                  height: 20, width: 20,
                  child: Checkbox(
                      activeColor: MyColor.primaryColor,
                      value: controller.agreeTC,
                      side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                          width: 1.0,
                          color: controller.agreeTC ? MyColor.transparentColor : MyColor.colorGrey
                        ),
                      ),
                      onChanged: (value) {
                        controller.updateAgreeTC();
                      }
                  )
                ),
                const SizedBox(width: Dimensions.space10),
                Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          controller.updateAgreeTC();
                        },
                        child: Text(
                            "${MyStrings.iAgree} ", 
                            style: interRegularDefault.copyWith(color: MyColor.colorBlack)
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.privacyPolicyScreen),
                        child: Text(
                            "${MyStrings.privacyPolicy.toLowerCase()} ", 
                            style: interRegularDefault.copyWith(color: MyColor.primaryColor)
                        ),
                      ),
                    ]
                ),
              ],
            ) : const SizedBox(),
            const SizedBox(height: Dimensions.space20),
            controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
              press: (){
                if (formKey.currentState!.validate()) {
                  controller.registerUser();
                }
              },
              width: MediaQuery.of(context).size.width,
              color: MyColor.primaryColor,
              text: MyStrings.createAccount,
              textColor: MyColor.colorWithe,
            ),
            const SizedBox(height: Dimensions.space15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Expanded(child:  Text(MyStrings.haveAccount, style: interRegularDefault.copyWith(color: MyColor.accountEnsureTextColor)),),
                TextButton(
                  onPressed: (){
                    Get.toNamed(RouteHelper.loginScreen);
                  },
                  child: Text(MyStrings.loginNow, style: interRegularDefault.copyWith(color: MyColor.primaryColor)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
