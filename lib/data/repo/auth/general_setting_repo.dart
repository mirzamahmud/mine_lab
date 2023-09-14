import 'dart:convert';

import 'package:mine_lab/core/helper/share_preference_helper.dart';
import 'package:mine_lab/core/utils/method.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/url_container.dart';
import 'package:mine_lab/data/model/general_setting/general_setting_main_model.dart';
import 'package:mine_lab/data/model/global/response_model/response_model.dart';
import 'package:mine_lab/data/services/api_service.dart';


class GeneralSettingRepo {

  ApiClient apiClient;

  GeneralSettingRepo({required this.apiClient});


  Future<dynamic> getGeneralSetting() async {
      String url='${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
      ResponseModel response= await apiClient.request(url, Method.getMethod, null,passHeader: false);
      return response;
  }

  GeneralSettingMainModel getGeneralSettingFromSharedPreferences(){
    GeneralSettingMainModel model;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.generalSettingKey)) {
      String? obj =
      apiClient.sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey);
      if(obj!=null){
        model=GeneralSettingMainModel.fromJson(jsonDecode(obj));
      }
      model=GeneralSettingMainModel();
      return model;
    } else {
      model=GeneralSettingMainModel();
      return model;
    }
  }

  storeGeneralSetting(GeneralSettingMainModel model){
    String json=jsonEncode(model.toJson());
    apiClient.sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingMainModel getGSData(){
    String pre= apiClient.sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingMainModel model=GeneralSettingMainModel.fromJson(jsonDecode(pre));
    return model;
  }


}
