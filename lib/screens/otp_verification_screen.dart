import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class OTPVerificationScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Obx(() => ElevatedButton(
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                  authController.verifyOTP(otpController.text);
                },
                child: authController.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('Verify'),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
