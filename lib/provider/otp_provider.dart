import 'dart:async';
import 'package:flutter/material.dart';

class OtpProvider with ChangeNotifier {
  bool isResendEnabled = false;
  int resendCountdown = 30;
  Timer? _timer;

  // Method to handle OTP verification
  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    // Replace with actual OTP validation logic; this example uses "123456" as the correct OTP
    return otp == "123456";
  }

  // Method to handle OTP resend
  void resendOtp() {
    isResendEnabled = false;
    resendCountdown = 30;
    _startResendCountdown();
    notifyListeners();
  }

  // Countdown timer for enabling the resend button
  void _startResendCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown > 0) {
        resendCountdown--;
      } else {
        isResendEnabled = true;
        _timer?.cancel();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
