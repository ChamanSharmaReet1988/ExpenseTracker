import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/Utility/constant.dart';
import 'package:expense_tracker/OtpScreen/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  String globalTextFieldValue = '';
  String _selectedCountryCode = '+91'; // Default country code
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> signIn() async {
    isLoading = true;
    await _auth.verifyPhoneNumber(
      phoneNumber: _selectedCountryCode + _phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically signs the user in
        isLoading = false;
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        isLoading = false;
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print('Verification failed: ${e.message}');
      },
      codeSent: (
        String verificationId,
        int? resendToken,
      ) async {
        isLoading = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setBool('isLoggedInFirst', true);
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    verificationId: verificationId,
                    contactNumber:
                        "$_selectedCountryCode ${_phoneNumberController.text}")),
          );
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          isLoading = false;
          print('verificationId: ${verificationId}');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(children: [
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          value: _selectedCountryCode,
                          items: Constant.countryCodes.map((String code) {
                            return DropdownMenuItem<String>(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCountryCode = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Code',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )),
                  const SizedBox(width: 8),
                  Expanded(
                      flex: 7,
                      child: SizedBox(
                        height: 60,
                        child: TextField(
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: 84,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed: signIn,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF7F3DFF),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFEEE5FF),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
