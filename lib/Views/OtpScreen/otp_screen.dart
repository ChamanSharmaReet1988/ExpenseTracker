import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:expense_tracker/Views/OtpScreen/otp_model.dart';
import 'package:expense_tracker/Views/OtpScreen/welcome_screen.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String? verificationId;
  String? contactNumber;
  OtpScreen({
    super.key,
    required this.verificationId,
    required this.contactNumber,
  });

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() =>
      // ignore: no_logic_in_create_state
      _OtpScreenState(
          verificationId: verificationId, contactNumber: contactNumber);
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpLength = 6;
  final Color activeColor = Colors.blue; // Color for active OTP digit
  final Color inactiveColor = Colors.grey;
  String smsCodeString = ''; // Col // Number of OTP digits
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;
  String? contactNumber;
  _OtpScreenState({required this.verificationId, required this.contactNumber});
  bool isButtonEnabled = false;
  bool verifyButtonEnable = false;
  int timerCountdown = 120;
  late Timer timer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < otpLength; i++) {
      _focusNodes.add(FocusNode());
      _controllers.add(TextEditingController());
    }
    startTimer();
  }

  @override
  void dispose() {
    _focusNodes.forEach((node) => node.dispose());
    _controllers.forEach((controller) => controller.dispose());
    timer.cancel();
    super.dispose();
  }

  Future<void> _signInWithPhoneNumber() async {
    isLoading = true;
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCodeString,
    );

    try {
      await _auth.signInWithCredential(credential);
      isLoading = false;
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } catch (e) {
      print('Failed to sign in: $e');
    }
  }

  String getOtp() {
    return _controllers.map((controller) => controller.text).join();
  }

  void startTimer() {
    isButtonEnabled = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timerCountdown > 0) {
          timerCountdown--;
        } else {
          isButtonEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> resendCode() async {
    setState(() {
      timerCountdown = 60;
      isButtonEnabled = false;
      isLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: contactNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically signs the user in
        setState(() {
          isLoading = false;
        });
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (
        String verificationId,
        int? resendToken,
      ) {
        setState(() {
          isLoading = false;
          startTimer();
        });
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          setState(() {
            isLoading = false;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: const Text('Otp Screen'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Enter Your',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Verification Code',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111111),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Row(
                children: [
                  Expanded(
                    child: PinCodeTextField(
                      autoDisposeControllers: false,
                      appContext: context,
                      length: 6,
                      mainAxisAlignment: MainAxisAlignment.start,
                      enablePinAutofill: true,
                      errorTextSpace: 24,
                      showCursor: false,
                      cursorColor: Colors.blue,
                      obscureText: false,
                      hintCharacter: '●',
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                          fieldHeight: 34,
                          fieldWidth: 20,
                          borderWidth: 0,
                          borderRadius: BorderRadius.circular(0),
                          shape: PinCodeFieldShape.underline,
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent,
                          selectedColor: Colors.transparent,
                          activeFillColor: Colors.black,
                          inactiveFillColor: Colors.grey,
                          selectedFillColor: Colors.blue,
                          fieldOuterPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0)),
                      controller: OtpModel().pinCodeController,
                      onChanged: (value) {
                        setState(() {
                          smsCodeString = value;
                          verifyButtonEnable =
                              smsCodeString.length == 6 ? true : false;
                        });
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        // Add your validation logic here
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
                visible: !isButtonEnabled,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    formatTime(timerCountdown),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7F3DFF),
                    ),
                  ),
                )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Text(
                  'Verification code sent to your number: $contactNumber',
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
                visible: isButtonEnabled,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal),
                      ),
                      TextButton(
                        onPressed: isButtonEnabled ? resendCode : null,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: const Text(
                          "Send again",
                          style: TextStyle(
                              color: Color(0xFF7F3DFF),
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 84,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: TextButton(
                    onPressed:
                        verifyButtonEnable ? _signInWithPhoneNumber : null,
                    style: TextButton.styleFrom(
                      backgroundColor: verifyButtonEnable
                          ? const Color(0xFF7F3DFF)
                          : Color.fromARGB(255, 166, 166, 164),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEEE5FF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ),
        resizeToAvoidBottomInset: false,
      ),
      if (isLoading)
        Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
    ]);
  }
}
