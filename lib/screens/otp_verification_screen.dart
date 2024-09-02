import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../controllers/auth_controller.dart';

class OTPVerificationScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Verification',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verification code has been sent\nto ${controller.phoneNumber.value}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PinInputTextField(
                pinLength: 6,
                decoration: BoxLooseDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.blue),
                  strokeColorBuilder: PinListenColorBuilder(
                    Colors.blue,
                    Colors.blue[200]!,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.otp.value = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: controller.isLoading.value
                    ? null
                    : () {
                  controller.resendOTP();
                },
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      controller.verifyOTP(controller.otp.value);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      'Verify',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
