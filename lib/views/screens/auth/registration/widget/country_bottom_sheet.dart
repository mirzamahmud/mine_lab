import 'package:flutter/material.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/styles.dart';
import 'package:mine_lab/data/controller/auth/registration/registration_controller.dart';

class CountryBottomSheet{

  static void bottomSheet(BuildContext context, RegistrationController controller){
    showModalBottomSheet(
        isScrollControlled:true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height*.8,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
            ),
            child: Column(
              children: [
                const SizedBox(height: 8,),
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColor.colorGrey.withOpacity(0.4),
                    ),

                  ),
                ),
                const SizedBox(height: 15,),
                Flexible(
                  child: ListView.builder(itemCount:controller.countryList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: MyColor.transparentColor,
                            onTap: (){
                              controller.countryController.text = controller.countryList[index].country??'';
                              controller.setCountryNameAndCode(controller.countryList[index].country??'',
                                  controller.countryList[index].countryCode??'', controller.countryList[index].dialCode??'');

                              Navigator.pop(context);

                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: MyColor.screenBgColor.withOpacity(.5)
                              ),
                              child: Text(
                                  '+${controller.countryList[index].dialCode}  ${controller.countryList[index].country}',
                                  style: interRegularDefault.copyWith(color: MyColor.colorBlack)
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        }
    );
  }
}