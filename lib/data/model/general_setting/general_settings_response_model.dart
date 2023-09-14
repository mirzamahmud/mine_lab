import '../auth/registration_response_model.dart';

class GeneralSettingsResponseModel {
  GeneralSettingsResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  GeneralSettingsResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      GeneralSetting? generalSetting,}){
    _generalSetting = generalSetting;
}

  Data.fromJson(dynamic json) {
    _generalSetting = json['general_setting'] != null ? GeneralSetting.fromJson(json['general_setting']) : null;
  }
  GeneralSetting? _generalSetting;

  GeneralSetting? get generalSetting => _generalSetting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalSetting != null) {
      map['general_setting'] = _generalSetting?.toJson();
    }
    return map;
  }

}

class GeneralSetting {
  GeneralSetting({
      int? id, 
      String? siteName, 
      String? preLoaderTitle,
      String? curText, 
      String? curSym, 
      String? emailFrom, 
      String? emailTemplate, 
      String? smsBody, 
      String? smsFrom, 
      String? baseColor, 

      String? kv,
      String? ev,
      String? en,
      String? sv,
      String? sn,
      String? forceSsl,
      String? maintenanceMode,
      String? securePassword,
      String? agree,
      String? registration,
      String? activeTemplate, 
      String? systemInfo, 
      String? referralSystem,
      String? lastCron, 
      dynamic createdAt, 
      String? updatedAt,}){
    _id = id;
    _siteName = siteName;
    _preLoaderTitle = preLoaderTitle;
    _curText = curText;
    _curSym = curSym;
    _emailFrom = emailFrom;
    _emailTemplate = emailTemplate;
    _smsBody = smsBody;
    _smsFrom = smsFrom;
    _baseColor = baseColor;
    _kv = kv;
    _ev = ev;
    _en = en;
    _sv = sv;
    _sn = sn;
    _forceSsl = forceSsl;
    _maintenanceMode = maintenanceMode;
    _securePassword = securePassword;
    _agree = agree;
    _registration = registration;
    _activeTemplate = activeTemplate;
    _systemInfo = systemInfo;
    _referralSystem = referralSystem;
    _lastCron = lastCron;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  GeneralSetting.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'].toString();
    _preLoaderTitle = json['preloader_title'].toString();
    _curText = json['cur_text'].toString();
    _curSym = json['cur_sym'].toString();
    _emailFrom = json['email_from'].toString();
    _emailTemplate = json['email_template'].toString();
    _smsBody = json['sms_body'].toString();
    _smsFrom = json['sms_from'].toString();
    _baseColor = json['base_color'].toString();
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _en = json['en'].toString();
    _sv = json['sv'].toString();
    _sn = json['sn'].toString();
    _forceSsl = json['force_ssl'].toString();
    _maintenanceMode = json['maintenance_mode'].toString();
    _securePassword = json['secure_password'].toString();
    _agree = json['agree'].toString();
    _registration = json['registration'].toString();
    _activeTemplate = json['active_template'].toString();
    _systemInfo = json['system_info'].toString();
    _referralSystem = json['referral_system'].toString();
    _lastCron = json['last_cron'].toString();
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
  }
  int? _id;
  String? _siteName;
  String? _preLoaderTitle;
  String? _curText;
  String? _curSym;
  String? _emailFrom;
  String? _emailTemplate;
  String? _smsBody;
  String? _smsFrom;
  String? _baseColor;
  String? _kv;
  String? _ev;
  String? _en;
  String? _sv;
  String? _sn;
  String? _forceSsl;
  String? _maintenanceMode;
  String? _securePassword;
  String? _agree;
  String? _registration;
  String? _activeTemplate;
  String? _systemInfo;
  String? _referralSystem;
  String? _lastCron;
  dynamic _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get siteName => _siteName;
  String? get preLoaderTitle => _preLoaderTitle;
  String? get curText => _curText;
  String? get curSym => _curSym;
  String? get emailFrom => _emailFrom;
  String? get emailTemplate => _emailTemplate;
  String? get smsBody => _smsBody;
  String? get smsFrom => _smsFrom;
  String? get baseColor => _baseColor;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get en => _en;
  String? get sv => _sv;
  String? get sn => _sn;
  String? get forceSsl => _forceSsl;
  String? get maintenanceMode => _maintenanceMode;
  String? get securePassword => _securePassword;
  String? get agree => _agree;
  String? get registration => _registration;
  String? get activeTemplate => _activeTemplate;
  String? get systemInfo => _systemInfo;
  String? get referralSystem => _referralSystem;
  String? get lastCron => _lastCron;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_name'] = _siteName;
    map['preloader_title'] = _preLoaderTitle;
    map['cur_text'] = _curText;
    map['cur_sym'] = _curSym;
    map['email_from'] = _emailFrom;
    map['email_template'] = _emailTemplate;
    map['sms_body'] = _smsBody;
    map['sms_from'] = _smsFrom;
    map['base_color'] = _baseColor;
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['en'] = _en;
    map['sv'] = _sv;
    map['sn'] = _sn;
    map['force_ssl'] = _forceSsl;
    map['maintenance_mode'] = _maintenanceMode;
    map['secure_password'] = _securePassword;
    map['agree'] = _agree;
    map['registration'] = _registration;
    map['active_template'] = _activeTemplate;
    map['system_info'] = _systemInfo;
    map['referral_system'] = _referralSystem;
    map['last_cron'] = _lastCron;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

