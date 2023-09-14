import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/data/controller/kyc_controller/kyc_controller.dart';



import '../../../../../../core/utils/my_strings.dart';
import '../../../../../../data/model/kyc/kyc_response_model.dart';
import 'choose_file_list_item.dart';

class ConfirmWithdrawFileItem extends StatefulWidget {

  final int index;

  const ConfirmWithdrawFileItem({Key? key,required this.index}) : super(key: key);

  @override
  State<ConfirmWithdrawFileItem> createState() => _ConfirmWithdrawFileItemState();
}

class _ConfirmWithdrawFileItemState extends State<ConfirmWithdrawFileItem> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<KycController>(builder: (controller){
      FormModel? model=controller.formList[widget.index];
      return SizedBox(
        child:InkWell(
          onTap: (){
            controller.pickFile(widget.index);
          }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile)),
      );
    });
  }
}
