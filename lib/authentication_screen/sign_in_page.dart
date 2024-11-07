// sign_in_page.dart
import 'package:flutter/material.dart';
import '../colors.dart';
import 'otp_verification_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignInPageState();
  }
}

class SignInPageState extends State<SignInPage> {
  String mobileNumber = "";
  String countryCode = "+91"; // Default country code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/images/urban_logo.png'),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                        letterSpacing: 3,
                        color: primary,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sf Ui Display SemiBold",
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Please enter your mobile number",
                      style: TextStyle(
                        fontFamily: "gill sans",
                        fontSize: 16,
                        color: Color(0xFF7D848D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IntlPhoneField(
                    initialCountryCode: 'IN',
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      fillColor: Colors.blueGrey.shade50,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (phone) {
                      setState(() {
                        mobileNumber = phone.number.toString();
                        countryCode = phone.countryCode;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 335,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (mobileNumber.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OtpVerificationPage(
                                mobileNumber: '$countryCode$mobileNumber',
                              );
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your mobile number'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Send OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Sf Ui Display medium",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
