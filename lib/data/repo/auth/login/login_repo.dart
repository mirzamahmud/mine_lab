import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mine_lab/core/helper/share_preference_helper.dart';
import 'package:mine_lab/core/utils/method.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/core/utils/url_container.dart';
import 'package:mine_lab/data/model/auth/verification/email_verification_model.dart';
import 'package:mine_lab/data/model/global/response_model/response_model.dart';
import 'package:mine_lab/data/services/api_service.dart';
import 'package:mine_lab/views/components/snackbar/show_custom_snackbar.dart';

class LoginRepo{
  ApiClient apiClient;
  LoginRepo({required this.apiClient});

  Future<ResponseModel> loginUser({required String username, required String password}) async{

    Map<String, String> map = {"username" : username, "password" : password};
    String url = "${UrlContainer.baseUrl}${UrlContainer.loginEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: false);

    return responseModel;
  }

  Future<String> forgetPassword(String type, String value) async {

    final map = modelToMap(value, type);
    String url = '${UrlContainer.baseUrl}${UrlContainer.forgetPasswordEndPoint}';
    final response = await apiClient.request(url, Method.postMethod, map, isOnlyAcceptType: true, passHeader: true);

    EmailVerificationModel model  =   EmailVerificationModel.fromJson(jsonDecode(response.responseJson));

    if (model.message?.success != null) {
      apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, model.data?.email ?? '');
      CustomSnackBar.showCustomSnackBar(errorList: [], msg: ['${MyStrings.passwordResetEmailSentTo} ${model.data?.email ?? MyStrings.yourEmail}'], isError: false);
      return model.data?.email??'';
    }
    else {
      CustomSnackBar.error(errorList: model.message!.error ?? [MyStrings.somethingWentWrong]);
      return '';
    }
  }

  Map<String, String> modelToMap(String value, String type) {
    Map<String, String> map = {'type': type, 'value': value};
    return map;
  }

  Future<EmailVerificationModel> verifyForgetPassCode(String code) async {

    String? email = apiClient.sharedPreferences.getString(SharedPreferenceHelper.userEmailKey) ?? '';
    Map<String, String> map  = {'code': code, 'email': email};
    Uri url = Uri.parse('${UrlContainer.baseUrl}${UrlContainer.passwordVerifyEndPoint}');

    final response = await http.post(url, body: map, headers: {
      "Accept": "application/json",
    });

    EmailVerificationModel model = EmailVerificationModel.fromJson(jsonDecode(response.body));
    if (model.message?.success != null) {
      model.setCode(200);
      return model;
    } else {
      model.setCode(400);
      return model;
    }
  }

  Future<EmailVerificationModel> resetPassword(String email, String password,String token) async {
    Map<String, String> map = {
      'token': token,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };
    Uri url = Uri.parse('${UrlContainer.baseUrl}${UrlContainer.resetPasswordEndPoint}');
    final response = await http.post(url, body: map, headers: {
      "Accept": "application/json",
    });
    EmailVerificationModel model = EmailVerificationModel.fromJson(jsonDecode(response.body));
    if (model.status == 'success') {
      CustomSnackBar.showCustomSnackBar(errorList: [], msg: [model.message?.success.toString() ?? ''], isError: false);
      model.setCode(200);
      return model;
    } else {
      CustomSnackBar.showCustomSnackBar(errorList: model.message!.error ?? [], msg: [''], isError: true);
      model.setCode(400);
      return model;
    }
  }


 /* Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken = apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ?? '';
    } else {
      deviceToken = '';
    }
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;
    if (deviceToken.isEmpty) {
      firebaseMessaging.getToken().then((fcmDeviceToken) async {
        success = await sendUpdatedToken(fcmDeviceToken ?? '');
      });
    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        if (deviceToken == fcmDeviceToken) {
          success = true;
        } else {
          apiClient.sharedPreferences.setString(SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
          success = await sendUpdatedToken(fcmDeviceToken);
        }
      });
    }
    return success;
  }*/

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String,String> map = deviceTokenMap(deviceToken);
    await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return true;
  }

  Map<String,String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }
}