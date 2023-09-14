class UrlContainer{

  /// base url
  static const String baseUrl= "https://script.viserlab.com/minelab/demo/";

  static const String loginEndPoint ='api/login';
  static const String registrationEndPoint='api/register';
  static const String userDashboardEndPoint='api/dashboard';
  static const String forgetPasswordEndPoint='api/password/email';
  static const String passwordVerifyEndPoint='api/password/verify-code';
  static const String resetPasswordEndPoint='api/password/reset';
  static const String countryEndPoint='api/get-countries';
  static const String verify2FAUrl = 'api/verify-g2fa';

  /// plan
  static const String planEndPoint = "api/plans";
  static const String planPurchaseEndPoint = "api/plan/purchase";
  static const String purchasedPlanEndPoint = "api/purchased-plan";
  static const String planPaymentMethodEndPoint = "api/deposit/methods";
  static const String planPaymentInsertEndPoint = "api/deposit/insert";
  static const String miningTrackEndPoint = "api/mining-track";

  /// wallet
  static const String walletEndPoint = "api/wallets";
  static const String walletUpdateEndPoint = "api/wallets/update";

  /// withdraw
  static const String withdrawLogEndPoint = "api/withdraw/history";
  static const String withdrawMethodEndPoint = "api/withdraw/method";
  static const String withdrawRequestEndPoint = "api/withdraw/request";

  /// verification
  static const String verifyEmailEndPoint='api/verify-email';
  static const String verifySmsEndPoint='api/verify-mobile';
  static const String resendVerifyCodeEndPoint='api/resend-verify/';

  /// deposit
  static const String depositHistoryEndPoint='api/deposit/history';
  static const String depositMethodEndPoint='api/deposit/methods';
  static const String depositInsertEndPoint='api/deposit/insert';

  static const String authorizationCodeEndPoint='api/authorization';
  static const String generalSettingEndPoint='api/general-setting';
  static const String privacyPolicyEndPoint='api/policy/pages';

  /// profile
  static const String getProfileEndPoint='api/user-info';
  static const String updateProfileEndPoint='api/profile-setting';
  static const String profileCompleteEndPoint='api/user-data-submit';
  static const String changePasswordEndPoint='api/change-password';

  /// transaction
  static const String transactionEndpoint = 'api/transactions';

  static const String deviceTokenEndPoint = 'api/get/device/token';
  static const String logout = 'api/logout';

  /// referral
  static const String myReferralEndPoint = 'api/referral';
  static const String referralLogEndPoint = 'api/referral/log';

  //kyc
  static const String kycFormUrl='api/kyc-form';
  static const String kycSubmitUrl='api/kyc-submit';
}