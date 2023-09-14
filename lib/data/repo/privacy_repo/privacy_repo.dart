import 'package:mine_lab/core/utils/method.dart';
import 'package:mine_lab/core/utils/url_container.dart';
import 'package:mine_lab/data/services/api_service.dart';

class PrivacyRepo{

  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic>loadAboutData()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}';
    final response=await apiClient.request(url, Method.getMethod,null);
    return response;
  }

}