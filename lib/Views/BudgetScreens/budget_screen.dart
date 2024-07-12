

import 'package:flutter/material.dart';

void main() {
  runApp(const BudgetScreen());
}

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  int currentMonthIndex = 4; // May

  List<Map<String, dynamic>> budgets = [
    {
      'category': 'Shopping',
      'remaining': 0,
      'spent': 1200,
      'total': 1000,
      'color': Colors.orange,
      'warning': true
    },
    {
      'category': 'Transportation',
      'remaining': 350,
      'spent': 350,
      'total': 700,
      'color': Colors.blue,
      'warning': false
    },
    {
      'category': 'Shopping',
      'remaining': 0,
      'spent': 1200,
      'total': 1000,
      'color': Colors.orange,
      'warning': true
    },
    {
      'category': 'Transportation',
      'remaining': 350,
      'spent': 350,
      'total': 700,
      'color': Colors.blue,
      'warning': false
    },
    {
      'category': 'Shopping',
      'remaining': 0,
      'spent': 1200,
      'total': 1000,
      'color': Colors.orange,
      'warning': true
    },
    {
      'category': 'Transportation',
      'remaining': 350,
      'spent': 350,
      'total': 700,
      'color': Colors.blue,
      'warning': false
    }
  ];

  void _goToNextMonth() {
    setState(() {
      currentMonthIndex = (currentMonthIndex + 1) % 12;
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      currentMonthIndex = (currentMonthIndex - 1 + 12) % 12;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xFF7F3DFF),
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(vertical: 16.0),
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                  onPressed: _goToPreviousMonth,
                ),
                Text(
                  months[currentMonthIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                  onPressed: _goToNextMonth,
                ),
              ],
            ),
          ),
          Expanded(
            child: budgets.isEmpty
                ? const Center(
                    child: Text(
                      "You don't have a budget.\nLet's make one so you in control.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: budgets.length,
                    itemBuilder: (context, index) {
                      final budget = budgets[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: budget['color'],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    budget['category'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  if (budget['warning'])
                                    const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Remaining \$${budget['remaining']}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: budget['spent'] / budget['total'],
                                color: budget['color'],
                                backgroundColor: budget['color'].withOpacity(0.2),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$${budget['spent']} of \$${budget['total']}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              if (budget['warning'])
                                const Text(
                                  'You\'ve exceed the limit!',
                                  style: TextStyle(color: Colors.red),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                // Add button action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7F3DFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50), // Full width button
              ),
              child: const Text(
                'Create a budget',
                style: TextStyle(fontSize: 16, color: Colors.white ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


