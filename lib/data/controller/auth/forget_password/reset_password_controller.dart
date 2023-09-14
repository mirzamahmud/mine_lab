import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/helper/share_preference_helper.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/data/model/auth/error_model.dart';
import 'package:mine_lab/data/model/auth/verification/email_verification_model.dart';
import 'package:mine_lab/data/repo/auth/login/login_repo.dart';


class ResetPasswordController extends GetxController{
  LoginRepo loginRepo;


  String email = '';
  String token = '';
  bool submitLoading = false;

  ResetPasswordController({required this.loginRepo}){
    checkPasswordStrength = loginRepo.apiClient.getPasswordStrengthStatus();
  }

  bool checkPasswordStrength = false;

  final FocusNode passwordFocusNode         = FocusNode();
  final FocusNode confirmPasswordFocusNode  = FocusNode();

  TextEditingController passController        = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  void resetPassword() async {
    String password = passController.text;
    submitLoading = true;
    update();
    EmailVerificationModel model= await loginRepo.resetPassword(email,password,token);
    submitLoading = false;
    update();
    if(model.code==200){
     Get.offAndToNamed(RouteHelper.loginScreen);
    }
  }

  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{6,}$');

  String? validPassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword_.tr;
    } else {
      if(checkPasswordStrength){
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg.tr;
        } else {
          return null;
        }
      }else{
        return null;
      }
    }
  }


  List<ErrorModel> passwordValidationRules = [
    ErrorModel(text: MyStrings.hasUpperLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasDigit.tr, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar.tr, hasError: true),
    ErrorModel(text: MyStrings.minSixChar.tr, hasError: true),
  ];

  void updateValidationList(String value){
    passwordValidationRules[0].hasError = value.contains(RegExp(r'[A-Z]'))?false:true;
    passwordValidationRules[1].hasError = value.contains(RegExp(r'[a-z]'))?false:true;
    passwordValidationRules[2].hasError = value.contains(RegExp(r'[0-9]'))?false:true;
    passwordValidationRules[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))?false:true;
    passwordValidationRules[4].hasError = value.length>=6?false:true;

    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }



}


