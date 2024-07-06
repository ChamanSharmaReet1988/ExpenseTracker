import 'package:flutter/material.dart';

class OtpModel {
  TextEditingController pinCodeController;
  FocusNode unfocusNode;

  OtpModel()
      : pinCodeController = TextEditingController(),
        unfocusNode = FocusNode();

  void dispose() {
    pinCodeController.dispose();
    unfocusNode.dispose();
  }

  String? Function(String?)? pinCodeControllerValidator;

  String? validatePinCode(String? value) {
    if (value == null || value.isEmpty || value.length != 6) {
      return 'Please enter a valid 6-digit pin code';
    }
    return null;
  }
}

OtpModel createModel(BuildContext context, Function() model) {
  return model();
}
