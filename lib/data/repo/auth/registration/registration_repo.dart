import 'package:mine_lab/core/helper/share_preference_helper.dart';
import 'package:mine_lab/core/utils/method.dart';
import 'package:mine_lab/core/utils/url_container.dart';
import 'package:mine_lab/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:mine_lab/data/model/global/response_model/response_model.dart';
import 'package:mine_lab/data/services/api_service.dart';


class RegistrationRepo {
  ApiClient apiClient;

  RegistrationRepo({required this.apiClient});

  Future<ResponseModel> registerUser(SignUpModel model) async {
    final map = modelToMap(model);
    String url ='${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';

    final responseModel = await apiClient.request(url, Method.postMethod, map,passHeader: true,isOnlyAcceptType: true);
    return responseModel;
  }

  Map<String, dynamic> modelToMap(SignUpModel model) {

    Map<String, dynamic> bodyFields = {
      'mobile':model.mobile,
      'email': model.email,
      'agree': model.agree.toString(),
      'username': model.username,
      'password': model.password,
      'password_confirmation':model.password,
      'country_code': model.countryCode,
      'country': model.country,
      "mobile_code": model.mobileCode,
    };

    return bodyFields;
  }

  Future<dynamic> getCountryData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}";
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }

  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken = apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ?? '';
    } else {
      deviceToken = '';
    }
    bool success = false;
    if (deviceToken.isEmpty) {
    } else {
    }
    return success;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url='${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String,String>map = deviceTokenMap(deviceToken);
    await apiClient.request(url,Method.postMethod,map,passHeader: true);
    return true;
  }

  Map<String,String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }

}