import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  late String selectedMonth;

  final List<Map<String, String>> transactions = [
    {
      "type": "Shopping",
      "description": "Buy some grocery",
      "amount": "-\$120",
      "time": "10:00 AM"
    },
    {
      "type": "Subscription",
      "description": "Disney+ Annual",
      "amount": "-\$80",
      "time": "03:30 PM"
    },
    {
      "type": "Food",
      "description": "Buy a ramen",
      "amount": "-\$32",
      "time": "07:30 PM"
    },
    {
      "type": "Bills",
      "description": "Electricity Bill Fill",
      "amount": "-\$1200",
      "time": "09:30 PM"
    }
  ];

  @override
  void initState() {
    super.initState();
    // Set the selectedMonth to the current month
    selectedMonth = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Replace with actual image URL
                  ),
                  Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedMonth,
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMonth = newValue!;
                            });
                          },
                          items: months
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                      const Text('Account Balance',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Icon(Icons.notifications, color: Colors.purple),
                ],
              ),
              const SizedBox(height: 16),
              const Text('\$9400',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIncomeExpenseCard('Budget', '\$5000', Colors.green),
                  _buildIncomeExpenseCard('Expenses', '\$1200', Colors.red),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 150,
                color: Colors.grey[200], // Placeholder for the graph
                child: const Center(child: Text('Graph Placeholder')),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recent Transactions',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.shopping_cart),
                            title: Text(transactions[index]['type']!),
                            subtitle: Text(transactions[index]['description']!),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(transactions[index]['amount']!,
                                    style: const TextStyle(color: Colors.red)),
                                Text(transactions[index]['time']!),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeExpenseCard(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(amount,
              style: TextStyle(
                  color: color, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
