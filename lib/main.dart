import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/route/route.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'core/di_service/di_services.dart' as di_service;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di_service.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: MyStrings.appName,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: RouteHelper.splashScreen,
      navigatorKey: Get.key,
      getPages: RouteHelper.routes,
    );
  }
}