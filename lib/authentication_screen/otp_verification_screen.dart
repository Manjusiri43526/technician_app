import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/home_page.dart';
import '../colors.dart';
import '../provider/otp_provider.dart';

class OtpVerificationPage extends StatefulWidget {
  final String mobileNumber;

  const OtpVerificationPage({
    Key? key,
    required this.mobileNumber,
  }) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  void verifyOtp() async {
    setState(() {
      isLoading = true;
    });

    // Replace this with actual OTP verification from OtpProvider
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);
    bool isOtpValid = await otpProvider.verifyOtp(otpController.text);

    if (isOtpValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: const Text(
            "OTP Verification",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Enter the OTP sent to ${widget.mobileNumber}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFF7D848D),
                      ),
                      hintText: "Enter OTP",
                      fillColor: Colors.blueGrey.shade50,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 335,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Verify OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Sf Ui Display medium",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<OtpProvider>(
                  builder: (context, otpProvider, child) {
                    return TextButton(
                      onPressed: otpProvider.isResendEnabled
                          ? otpProvider.resendOtp
                          : null,
                      child: Text(
                        otpProvider.isResendEnabled
                            ? "Resend OTP"
                            : "Resend in ${otpProvider.resendCountdown} seconds",
                        style: TextStyle(
                          color: otpProvider.isResendEnabled
                              ? primary
                              : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
