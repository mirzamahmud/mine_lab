import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_lab/core/utils/dimensions.dart';
import 'package:mine_lab/core/utils/my_color.dart';
import 'package:mine_lab/core/utils/my_strings.dart';
import 'package:mine_lab/data/controller/auth/profile_complete/profile_complete_controller.dart';
import 'package:mine_lab/views/components/buttons/rounded_button.dart';
import 'package:mine_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:mine_lab/views/components/text-field/custom_text_field.dart';

class ProfileCompleteForm extends StatefulWidget {
  const ProfileCompleteForm({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteForm> createState() => _ProfileCompleteFormState();
}

class _ProfileCompleteFormState extends State<ProfileCompleteForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ProfileCompleteController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              focusNode: controller.firstNameFocusNode,
              controller: controller.firstNameController,
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.firstName,
              hintText: MyStrings.enterFirstName,
              onChanged: (value){},
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.lastName,
              hintText: MyStrings.enterLastName,
              onChanged: (value){},
              focusNode: controller.lastNameFocusNode,
              controller: controller.lastNameController,
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.address,
              hintText: MyStrings.enterYourAddress,
              onChanged: (value){},
              focusNode: controller.addressFocusNode,
              controller: controller.addressController,
            ),
            const SizedBox(height: Dimensions.space20),

            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.state,
              hintText: MyStrings.enterYourState,
              onChanged: (value){},
              focusNode: controller.stateFocusNode,
              controller: controller.stateController,
            ),
            const SizedBox(height: Dimensions.space20),

            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.zipCode,
              hintText: MyStrings.enterYourZipcode,
              onChanged: (value){},
              focusNode: controller.zipCodeFocusNode,
              controller: controller.zipCodeController,
            ),
            const SizedBox(height: Dimensions.space20),

            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.city,
              hintText: MyStrings.enterYourCity,
              onChanged: (value){},
              focusNode: controller.cityFocusNode,
              controller: controller.cityController,
            ),
            const SizedBox(height: Dimensions.space25),

            controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
              press: (){
                controller.updateProfile();
              },
              width: MediaQuery.of(context).size.width,
              color: MyColor.primaryColor,
              text: MyStrings.updateProfile,
              textColor: MyColor.colorWhite,
            )
          ],
        ),
      ),
    );
  }
}
