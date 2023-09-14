import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/data/model/auth/verification/email_verification_model.dart';
import 'package:mine_lab/data/repo/auth/login/login_repo.dart';
import 'package:mine_lab/views/components/snackbar/show_custom_snackbar.dart';


class VerifyPasswordController extends GetxController{
  LoginRepo loginRepo;


  List<String> errors = [];
  String email='';
  String password='';
  String confirmPassword='';
  bool isLoading = false;
  bool remember = false;
  bool hasError = false;
  String currentText = "";

  VerifyPasswordController({required this.loginRepo});


  bool isResendLoading=false;
  void resendForgetPassCode() async {
    isResendLoading=true;
    update();
    String value = email;
    String type = 'email';
    await loginRepo.forgetPassword(type, value);
    isResendLoading=false;
    update();
  }

  bool verifyLoading=false;

  void verifyForgetPasswordCode(String value) async{
    if(value.isNotEmpty){
      verifyLoading=true;
      update();
      EmailVerificationModel model= await loginRepo.verifyForgetPassCode(value);

      if(model.status=='success'){
        verifyLoading=false;
        Get.offAndToNamed(RouteHelper.resetPasswordScreen,arguments: [email,value]);
      }else{
        verifyLoading=false;
        update();
        List<String>errorList=[MyStrings.verificationFailed];
        CustomSnackBar.error(errorList: model.message?.error??errorList);
      }
    }
  }

  clearAllData(){
    isLoading = false;
    currentText = '';
  }
}


