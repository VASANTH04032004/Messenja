import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class OTPVerificationScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
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
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: _authController.isLoading.value
                  ? null
                  : () {
                _authController.verifyOTP(otpController.text);
              },
              child: _authController.isLoading.value
                  ? CircularProgressIndicator()
                  : Text('Verify'),
            )),
          ],
        ),
      ),
    );
  }
}
