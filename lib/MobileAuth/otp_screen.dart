import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:krishak_farma/MobileAuth/authprovider.dart';
import 'package:krishak_farma/MobileAuth/custom_button_in_mobile_auth.dart';
import 'package:krishak_farma/MobileAuth/snackbar.dart';
import 'package:krishak_farma/MobileAuth/userinformationscreen.dart';
import 'package:krishak_farma/screens/home/home_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String PhoneNumber;
  const OtpScreen({super.key, required this.verificationId, required this.PhoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  bool isResendingOtp = false; // Track whether resend OTP is in progress
  bool _showResendText = false; // Track the visibility of Resend OTP text

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    Timer(Duration(seconds: 30), () {
      setState(() {
        _showResendText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange[100],
                        ),
                        child: Image.asset(
                          "assets/AuthImages/text.png",
                          height: 150.0,
                          width: 150.0,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Otp Sent to ${widget.PhoneNumber}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: _showResendText
                            ? (isResendingOtp
                                ? null
                                : () {
                                    // Allow resend only if not already resending
                                    Provider.of<AuthProvider>(context, listen: false).resendOtp(
                                      phoneNumber: widget.PhoneNumber,
                                      context: context,
                                      onSuccess: () {
                                        // Handle success if needed
                                      },
                                      onFailed: (error) {
                                        // Handle failure if needed
                                      },
                                    );
                                  })
                            : null,
                        child: Text(
                          _showResendText ? "Resend OTP" : "Resend OTP in 30s",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _showResendText ? (isResendingOtp ? Colors.grey : Colors.deepOrangeAccent) : Colors.grey,
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

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              ap.getDataFromFirestore().then(
                (value) => ap.saveUserDataToSP().then(
                  (value) => ap.setSignIn().then(
                    (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false,
                    ),
                  ),
                ),
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfromationScreen(),
                ),
                (route) => false,
              );
            }
          },
        );
      },
    );
  }
}