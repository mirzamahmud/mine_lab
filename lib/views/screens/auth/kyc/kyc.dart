import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/data/controller/kyc_controller/kyc_controller.dart';
import 'package:mine_lab/data/model/kyc/kyc_response_model.dart';
import 'package:mine_lab/data/repo/kyc/kyc_repo.dart';
import 'package:mine_lab/views/components/appbar/custom_appbar.dart';
import 'package:mine_lab/views/components/buttons/rounded_button.dart';
import 'package:mine_lab/views/components/checkbox/custom_check_box.dart';
import 'package:mine_lab/views/components/custom_drop_down_button_with_text_field.dart';
import 'package:mine_lab/views/components/custom_radio_button.dart';
import 'package:mine_lab/views/components/general_components/no_data_found.dart';
import 'package:mine_lab/views/components/text-field/custom_text_field.dart';
import 'package:mine_lab/views/screens/auth/kyc/widget/widget/file_item.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/custom_loader.dart';
import '../../../components/form_row.dart';
import 'widget/already_verifed.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({Key? key}) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(KycRepo(apiClient: Get.find()));
    Get.put(KycController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<KycController>().beforeInitLoadKycData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(
      builder: (controller) =>
          GestureDetector(
            onTap: (){
                FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: MyColor.screenBgColor,
              appBar: const CustomAppBar(title: MyStrings.kyc,bgColor:MyColor.primaryColor,),
              body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: controller.isLoading?const Padding(padding:EdgeInsets.all(Dimensions.space15),child:CustomLoader()):controller.isAlreadyVerified?const AlreadyVerifiedWidget():controller.isAlreadyPending?const AlreadyVerifiedWidget(isPending: true,):controller.isNoDataFound? const NoDataFound():Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding:  const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColor.colorWhite,
                            boxShadow: [
                              BoxShadow(
                                color: MyColor.otpTextFieldBorder.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1), // changes position of shadow
                              ),
                            ]
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 35,
                            ),

                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: controller.formList.length,
                                itemBuilder: (ctx,index){
                                  FormModel? model=controller.formList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        model.type=='text'?Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          CustomTextField(
                                                hintText: (model.name??'').toString().capitalizeFirst,
                                                needLabel: true,
                                                isRequired:model.isRequired=='optional'?false:true,
                                                needOutlineBorder: true,
                                                labelText: model.name??'',
                                                onChanged: (value){
                                                  controller.changeSelectedValue(value, index);
                                                }),
                                            const SizedBox(height: 10,),
                                          ],
                                        ):model.type=='textarea'?Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                                needLabel: true,
                                                isRequired:model.isRequired=='optional'?false:true,
                                                needOutlineBorder: true,
                                                labelText: model.name??'',
                                                hintText: (model.name??'').capitalizeFirst,
                                                onChanged: (value){
                                                  controller.changeSelectedValue(value, index);
                                                }),
                                            const SizedBox(height: 10,),
                                          ],
                                        ):model.type=='select'?Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                            const SizedBox(height: Dimensions.textToTextSpace,),
                                            CustomDropDownTextField(list: model.options??[],onChanged: (value){
                                              controller.changeSelectedValue(value,index);
                                            },selectedValue: model.selectedValue,),
                                          ],
                                        ):model.type=='radio'?Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                            CustomRadioButton(title:model.name,selectedIndex:controller.formList[index].options?.indexOf(model.selectedValue??'')??0,list: model.options??[],onChanged: (selectedIndex){
                                              controller.changeSelectedRadioBtnValue(index,selectedIndex);
                                            },),
                                          ],
                                        ):model.type=='checkbox'?Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                            CustomCheckBox(selectedValue:controller.formList[index].cbSelected,list: model.options??[],onChanged: (value){
                                              controller.changeSelectedCheckBoxValue(index,value);
                                            },),
                                          ],
                                        ):model.type=='file'?Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                child: ConfirmWithdrawFileItem(
                                                    index:index
                                                )
                                            )
                                          ],
                                        ):const SizedBox(),
                                        const SizedBox(height: 5,),
                                      ],
                                    ),
                                  );
                                }
                            ),
                            const SizedBox(height: 30,),
                            Center(
                                child: controller.submitLoading? const RoundedLoadingBtn(): RoundedButton(
                                press: () {
                                  controller.submitKycData();
                                },
                                text: MyStrings.submit,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ),
          ),
    );
  }
}
