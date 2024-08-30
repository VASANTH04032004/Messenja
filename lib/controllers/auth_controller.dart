import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/home_screen.dart';
import '../screens/otp_verification_screen.dart';

class AuthController extends GetxController {
  RxString phoneNumber = ''.obs;
  RxString verificationId = ''.obs;
  RxBool isLoading = false.obs;
  RxString otp = ''.obs;
  int? resendToken;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyPhoneNumber() async {
    isLoading(true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.value,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            Get.offAll(() => HomeScreen()); 
          } catch (e) {
            Get.snackbar('Error', 'Failed to sign in: ${e.toString()}');
            isLoading(false);
          }
        },
        verificationFailed: (FirebaseAuthException e) {

          Get.snackbar('Error', 'Verification failed: ${e.message ?? 'Unknown error'}');
          isLoading(false);
        },
        codeSent: (String verId, int? token) {
          verificationId.value = verId;
          resendToken = token;
          isLoading(false);
          Get.to(() => OTPVerificationScreen());
        },
        codeAutoRetrievalTimeout: (String verId) {

          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to send verification code: ${e.toString()}');
      isLoading(false);
    }
  }


  void verifyOTP(String smsCode) async {
    isLoading(true);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId.value,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      Get.snackbar('Success', 'Congratulations! Successfully logged in');
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in: ${e.toString()}');
      isLoading(false);
    }
  }


  void resendOTP() async {
    isLoading(true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.value,
        forceResendingToken: resendToken,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            Get.offAll(() => HomeScreen());
          } catch (e) {
            Get.snackbar('Error', 'Failed to sign in: ${e.toString()}');
            isLoading(false);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message ?? 'Unknown error'}');
          isLoading(false);
        },
        codeSent: (String verId, int? token) {
          verificationId.value = verId;
          resendToken = token;
          isLoading(false);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend verification code: ${e.toString()}');
      isLoading(false);
    }
  }
}
