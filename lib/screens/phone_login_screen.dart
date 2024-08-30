import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../controllers/auth_controller.dart';

class PhoneInputScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number'),
        backgroundColor: Colors.blue, // Set AppBar color to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                _authController.phoneNumber.value = number.phoneNumber ?? '';
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              initialValue: PhoneNumber(isoCode: 'IN'),
              formatInput: true,
              inputDecoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authController.verifyPhoneNumber();
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
