import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../controllers/auth_controller.dart';

class PhoneInputScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    controller.phoneNumber.value = number.phoneNumber ?? '';
                  },
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                    showFlags: false,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  initialValue: PhoneNumber(isoCode: 'IN'),
                  formatInput: true,
                  inputDecoration: InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            )
                : ElevatedButton(
              onPressed: () {
                if (controller.phoneNumber.value.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please enter a phone number',
                    snackPosition: SnackPosition.TOP,
                  );
                } else {
                  controller.verifyPhoneNumber();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                side: BorderSide(color: Colors.blue, width: 2),
              ),
              child: Text(
                'Verify',
                style: TextStyle(color: Colors.white),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
