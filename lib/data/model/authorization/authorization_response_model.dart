import '../auth/registration_response_model.dart';

class AuthorizationResponseModel {
  AuthorizationResponseModel({
      String? remark, 
      String? status, 
      Message? message,}){
    _remark = remark;
    _status = status;
    _message = message;
}

  AuthorizationResponseModel.fromJson(dynamic json) {
    _remark = json['remark'].toString();
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    return map;
  }

}

