import 'dart:convert';
import 'package:get/get.dart';
import 'package:mine_lab/data/model/about/privacy_response_model.dart';
import 'package:mine_lab/data/model/global/response_model/response_model.dart';
import 'package:mine_lab/data/repo/privacy_repo/privacy_repo.dart';
import 'package:mine_lab/views/components/snackbar/show_custom_snackbar.dart';


class PrivacyController extends GetxController{

  int selectedIndex=1;
  PrivacyRepo repo;
  bool isLoading=true;

  List<PolicyPages>list=[];

  late var selectedHtml='';

  PrivacyController({required this.repo});

  void loadData()async{
    ResponseModel model=await repo.loadAboutData();
    if(model.statusCode==200){
      PrivacyResponseModel responseModel=PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      if(responseModel.data?.policyPages !=null && responseModel.data!.policyPages!=null && responseModel.data!.policyPages!.isNotEmpty){
        list.clear();

        list.addAll(responseModel.data!.policyPages!);
        changeIndex(0);
        updateLoading(false);
      }
    }else{
       CustomSnackBar.showCustomSnackBar(errorList: [model.message], msg: [], isError: false);
       updateLoading(false);
    }
  }


  void changeIndex(int index){
    selectedIndex=index;
    selectedHtml = list[index].dataValues?.description??'';
    update();
  }

  updateLoading(bool status){
    isLoading=status;
    update();
  }
}