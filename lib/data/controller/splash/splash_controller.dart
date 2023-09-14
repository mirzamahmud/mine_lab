import 'dart:convert';
import 'package:get/get.dart';
import 'package:mine_lab/core/helper/share_preference_helper.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/data/model/general_setting/general_setting_main_model.dart';
import 'package:mine_lab/data/model/global/response_model/response_model.dart';
import 'package:mine_lab/data/repo/auth/general_setting_repo.dart';
import 'package:mine_lab/views/components/snackbar/show_custom_snackbar.dart';

class SplashController extends GetxController{

  GeneralSettingRepo repo ;
  SplashController({required this.repo,}){
    gotoNext();
  }

  void gotoNext() async {
    bool isRemember = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    ResponseModel response = await repo.getGeneralSetting();

    if(response.statusCode == 200){
      GeneralSettingMainModel model = GeneralSettingMainModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase() == "success"){
        repo.storeGeneralSetting(model);
        checkAndGo(isRemember);
      }else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    }else{
      CustomSnackBar.showCustomSnackBar(errorList: [response.message], msg: [], isError: true);
    }
  }

  void checkAndGo(bool isRemember){
    if(isRemember){
      Get.offAndToNamed(RouteHelper.homeScreen);
    }else{
      Get.offAndToNamed(RouteHelper.loginScreen);
    }
  }
}