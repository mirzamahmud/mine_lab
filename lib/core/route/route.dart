import 'package:get/get.dart';
import 'package:mine_lab/views/screens/account/change_password/change_password_screen.dart';
import 'package:mine_lab/views/screens/auth/email_verification/email_verify_screen.dart';
import 'package:mine_lab/views/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:mine_lab/views/screens/auth/kyc/kyc.dart';
import 'package:mine_lab/views/screens/auth/login/login_screen.dart';
import 'package:mine_lab/views/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:mine_lab/views/screens/auth/registration/registration_screen.dart';
import 'package:mine_lab/views/screens/auth/reset_password/reset_password_screen.dart';
import 'package:mine_lab/views/screens/auth/sms_verification/sms_verify_screen.dart';
import 'package:mine_lab/views/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:mine_lab/views/screens/auth/verify_forget_password/password_verify_screen.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/home/home_screen.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/menu/menu_screen.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/mine/mining_history/mining_history_screen.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/mine/mining_track/mining_tracks_screen.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/mine/plan_payment_method/plan_payment_method_screen.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/mine/start_mining_screen/mining_plan_screen.dart';
import 'package:mine_lab/views/screens/bottom_nav_screens/wallet/wallet_screen.dart';
import 'package:mine_lab/views/screens/withdraw/withdraw_webview/withdraw_webview_screen.dart';
import 'package:mine_lab/views/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:mine_lab/views/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:mine_lab/views/screens/profile/user_profile/profile_screen.dart';
import 'package:mine_lab/views/screens/referral/my_referral/my_referral_screen.dart';
import 'package:mine_lab/views/screens/referral/referral_bonus_log/referral_bonus_logs_screen.dart';
import 'package:mine_lab/views/screens/splash/splash_screen.dart';
import 'package:mine_lab/views/screens/transaction/transaction_screen.dart';
import 'package:mine_lab/views/screens/withdraw/withdraw_money/withdraw_money_screen.dart';
import 'package:mine_lab/views/screens/withdraw/withdraw_log/withdraw_log_screen.dart';

class RouteHelper{

  static const String splashScreen              = "/splash_screen";
  static const String loginScreen               = "/login_screen";
  static const String registrationScreen        = "/registration_screen";
  static const String forgotPasswordScreen      = "/forgot_password_screen";
  static const String resetPasswordScreen       = "/reset_password_screen";
  static const String passVerifyScreen          = "/verify_password_screen";
  static const String changePasswordScreen      = "/change_password_screen";
  static const String bottomNav                 = "/bottom_nav";
  static const String homeScreen                = "/Home_screen";
  static const String walletScreen              = "/Wallet_screen";
  static const String profileScreen             = "/profile_screen";
  static const String depositLogScreen          = "/deposit_log_screen";
  static const String depositMoneyScreen        = "/deposit_money_screen";
  static const String withdrawLogScreen         = "/withdraw_log_screen";
  static const String withdrawMoneyScreen       = "/withdraw_money_screen";
  static const String miningHistoryScreen       = "/mining_history_screen";
  static const String miningTrackScreen         = "/mining_tracks_screen";
  static const String miningPlanScreen          = "/buy_plan_screen";
  static const String referralBonusLogScreen    = "/referral_bonus_log_screen";
  static const String privacyPolicyScreen       = "/privacy_policy_screen";
  static const String editProfileScreen         = "/edit_profile_screen";
  static const String profileCompleteScreen     = "/profile_complete_screen";
  static const String emailVerifyScreen         = "/email_verify_screen";
  static const String smsVerifyScreen           = "/sms_verify_screen";
  static const String transactionScreen         = "/transaction_screen";
  static const String myReferralScreen          = "/my_referral_screen";
  static const String menuScreen                = "/menu_screen";
  static const String depositWebScreen          = "/deposit_web_screen";
  static const String planPaymentMethodScreen   = "/plan_payment_method_screen";

  static const String twoFactorScreen           = "/two-factor-screen";
  static const String kycScreen                 = "/kyc_screen";

  static List<GetPage> routes = [

    GetPage(name: splashScreen,                 page: () => const SplashScreen()),
    GetPage(name: loginScreen,                  page: () => const LoginScreen()),
    GetPage(name: registrationScreen,           page: () => const RegistrationScreen()),
    GetPage(name: forgotPasswordScreen,         page: () => const ForgotPasswordScreen()),
    GetPage(name: resetPasswordScreen,          page: () => const ResetPasswordScreen()),
    GetPage(name: passVerifyScreen,             page: () => const VerifyForgetPassScreen()),
    GetPage(name: changePasswordScreen,         page: () => const ChangePasswordScreen()),
    GetPage(name: homeScreen,                   page: () => const HomeScreen()),
    GetPage(name: walletScreen,                 page: () => const WalletScreen()),
    GetPage(name: profileScreen,                page: () => const ProfileScreen()),
    GetPage(name: withdrawLogScreen,            page: () => const WithdrawLogScreen()),
    GetPage(name: withdrawMoneyScreen,          page: () => const WithdrawMoneyScreen()),
    GetPage(name: miningHistoryScreen,          page: () => const MiningHistoryScreen()),
    GetPage(name: miningTrackScreen,            page: () => const MiningTracksScreen()),
    GetPage(name: miningPlanScreen,             page: () => const MiningPlanScreen()),
    GetPage(name: referralBonusLogScreen,       page: () => const ReferralBonusLogsScreen()),
    GetPage(name: privacyPolicyScreen,          page: () => const PrivacyPolicyScreen()),
    GetPage(name: editProfileScreen,            page: () => const EditProfileScreen()),
    GetPage(name: profileCompleteScreen,        page: () => const ProfileCompleteScreen()),
    GetPage(name: emailVerifyScreen,            page: () => EmailVerifyScreen(needSmsVerification: Get.arguments[0], isProfileCompleteEnabled: Get.arguments[1], needTwoFactor: Get.arguments[2])),
    GetPage(name: smsVerifyScreen,              page: () => const SmsVerifyScreen()),
    GetPage(name: transactionScreen,            page: () => const TransactionScreen()),
    GetPage(name: myReferralScreen,             page: () => const MyReferralScreen()),
    GetPage(name: menuScreen,                   page: () => const MenuScreen()),
    GetPage(name: depositWebScreen,             page: () => WithdrawWebviewScreen(redirectUrl: Get.arguments)),
    GetPage(name: planPaymentMethodScreen,      page: () => PlanPaymentMethodScreen(title: Get.arguments[0],amount:Get.arguments[1],orderId: Get.arguments[2],)),
    GetPage(name: twoFactorScreen,              page: () => TwoFactorVerificationScreen(isProfileCompleteEnable: Get.arguments)),
    GetPage(name: kycScreen,                    page: () => const KycScreen()),

  ];
}