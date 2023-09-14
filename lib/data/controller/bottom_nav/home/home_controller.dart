import 'dart:convert';

import 'package:get/get.dart';
import 'package:mine_lab/core/helper/string_format_helper.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/data/model/global/response_model/response_model.dart';
import 'package:mine_lab/data/model/home/home_response_model.dart';
import 'package:mine_lab/data/repo/bottom_nav/home/home_repo.dart';
import 'package:mine_lab/views/components/snackbar/show_custom_snackbar.dart';

class HomeController extends GetxController{
  HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  bool isLoading = true;
  List<Miners> minersList = [];
  List<Transactions> transactionList = [];

  String balance = "";
  String referralBonus = "";

  String currencySymbol = '';
  String currency = '';
  String imagePath = "";
  String referralLink = "";

  String rejected = "";
  String pending = "";
  String approved = "";
  String unpaid = "";

  Future<void> loadDashboardData() async{
    currency = homeRepo.apiClient.getCurrencyOrUsername();
    ResponseModel responseModel = await homeRepo.getDashboardData();

    transactionList.clear();

    if(responseModel.statusCode == 200){
      HomeResponseModel model = HomeResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == "success"){
        List<Transactions>? tempTransactionList = model.data?.transactions;
        balance = "${MyConverter.twoDecimalPlaceFixedWithoutRounding(model.data?.widget?.balance ?? "")} $currency";
        referralLink = model.data?.referralLink ?? "";
        referralBonus = "${MyConverter.twoDecimalPlaceFixedWithoutRounding(model.data?.widget?.referralBonus ?? "")} $currency";
        imagePath = "${model.data?.coinImagePath ?? ""}/";

        rejected = model.data?.plan?.rejected ?? "0";
        approved = model.data?.plan?.approved ?? "0";
        pending = model.data?.plan?.pending ?? "0";
        unpaid = model.data?.plan?.unpaid ?? "0";

        if(tempTransactionList != null && tempTransactionList.isNotEmpty){
          transactionList.addAll(tempTransactionList);
        }

        List<Miners>? tempMinersList = model.data?.miners;
        if(tempMinersList != null && tempMinersList.isNotEmpty){
          minersList.addAll(tempMinersList);
        }

      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ??[ MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }

    isLoading = false;
    update();

  }

  changeStatusColor(String string, int index) {
      String trxType = transactionList[index].trxType ?? "";
      return trxType == "+" ? MyColor.primaryColor : MyColor.colorRed;
    }
}