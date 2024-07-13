import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Utility/constant.dart';
import 'package:expense_tracker/Models/expense_model.dart';
import 'package:expense_tracker/Database/expense_table.dart';
import 'package:expense_tracker/Utility/preferences_helper.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  AddExpenseScreenState createState() => AddExpenseScreenState();
}

class AddExpenseScreenState extends State<AddExpense> {
  String? selectedCategory;
  String? currency;
  String? selectedWallet;
  bool repeatTransaction = false;
  TextEditingController expenseTextFieldController = TextEditingController();
  final FocusNode textNode = FocusNode();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCurrency();
  }

  void loadCurrency() {
    setState(() {
      if (PreferencesHelper().currency == "INR") {
        currency = "₹";
      } else {
        currency = "\$";
      }
    });
  }

  Future<void> addExpesne(BuildContext context) async {
    final String expenseAmount = expenseTextFieldController.text;
    if (expenseAmount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Expense is mandatory to fill'),
            backgroundColor: Colors.red),
      );
      return;
    }

    final double? expenseValue = double.tryParse(expenseAmount);
    if (expenseValue == null || expenseValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Expense amount must be greater than 0.'),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (selectedCategory?.isEmpty ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Category must be selected'),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (selectedWallet?.isEmpty ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Wallet must be selected'),
            backgroundColor: Colors.red),
      );
      return;
    }

    DateTime now = DateTime.now();
    ExpenseTable expenseTable = ExpenseTable();
    Expense expesne = Expense(
        title: selectedWallet ?? "",
        year: "${now.year}",
        month: "${now.month}",
        day: "${now.day}",
        time: DateFormat('HH:mm:ss').format(now),
        amount: '$expenseValue',
        desc: descriptionController.text,
        category: selectedCategory ?? "");
    expenseTable.insertItemIntoExpenseTable(expesne);

    showAlertDialog(context);
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500)),
          content: const Text('Your expense added successfully!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
            TextButton(
              onPressed: () {
                selectedCategory = "";
                descriptionController.text = "";
                expenseTextFieldController.text = "";
                selectedWallet = "";
                Navigator.of(context).pop();
              },
              child: const Text('Add More'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(), // Prevent scroll bounce
              reverse: isKeyboardVisible,
              child: Column(
                children: [
                  Container(
                    color: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 250, // Increased height for the top area
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  'Add Expense',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        const Spacer(),
                        const SizedBox(height: 10),
                        const Text(
                          'How much?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Row(children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              currency ?? "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                                  height: 70,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0,
                                          top: 0.0,
                                          right: 15.0,
                                          bottom: 0.0),
                                      child: TextField(
                                        controller: expenseTextFieldController,
                                        cursorColor: Colors.white,
                                        cursorWidth: 2.0,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        textInputAction: TextInputAction
                                            .done, // Set the cursor width
                                        style: const TextStyle(
                                            fontSize: 34.0,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '0.0',
                                          hintStyle: TextStyle(
                                            color: Colors
                                                .white, // Set the hint text color
                                            fontSize:
                                                34.0, // You can also set the font size
                                            fontFamily:
                                                'Inter', // And the font family
                                          ), // Set the placeholder text
                                        ),
                                        onChanged: (text) {},
                                      )))),
                        ]),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.redAccent,
                        child: const SizedBox(),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              value: selectedCategory,
                              hint: const Text("Category"),
                              items:
                                  Constant.expenseCategory.map((String code) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCategory = newValue;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: descriptionController,
                              autocorrect: false,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              decoration: const InputDecoration(
                                labelText: 'Description (Optional)',
                              ),
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: selectedWallet,
                              hint: const Text("Wallet"),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              items: Constant.walletList.map((String code) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedWallet = newValue;
                                });
                              },
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 30,
                              height: 84,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: TextButton(
                                  onPressed: () {
                                    addExpesne(context);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF7F3DFF),
                                    elevation: 4,
                                  ),
                                  child: const Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
