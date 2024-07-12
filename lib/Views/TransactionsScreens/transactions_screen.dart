import 'package:flutter/material.dart';

void main() {
  runApp(const TransactionsScreen());
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  double screenWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  final List<Map<String, dynamic>> transactions = [
    {
      'date': 'Today',
      'title': 'Shopping',
      'subtitle': 'Buy some grocery',
      'amount': '- \$120',
      'time': '10:00 AM',
      'icon': Icons.shopping_bag,
      'color': Colors.orange
    },
    {
      'date': 'Today',
      'title': 'Subscription',
      'subtitle': 'Disney+ Annual',
      'amount': '- \$80',
      'time': '03:30 PM',
      'icon': Icons.subscriptions,
      'color': Colors.purple
    },
    {
      'date': 'Today',
      'title': 'Food',
      'subtitle': 'Buy a ramen',
      'amount': '- \$32',
      'time': '07:30 PM',
      'icon': Icons.fastfood,
      'color': Colors.red
    },
    {
      'date': 'Yesterday',
      'title': 'Salary',
      'subtitle': 'Salary for July',
      'amount': '+ \$5000',
      'time': '04:30 PM',
      'icon': Icons.attach_money,
      'color': Colors.green
    },
    {
      'date': 'Yesterday',
      'title': 'Transportation',
      'subtitle': 'Charging Tesla',
      'amount': '- \$18',
      'time': '08:30 PM',
      'icon': Icons.directions_car,
      'color': Colors.blue
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: 'Month',
                    items: <String>['Month', 'Week', 'Day'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF7F3DFF),
                backgroundColor: const Color(0xFFEEE5FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Set the corner radius
                ),
              ),
              child: SizedBox(
                width: screenWidth - 80,
                height: 50.0, // Set the width to screen width minus padding
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Text('See your financial report'),
                    SizedBox(width: 8.0), // Adjust space between text and icon
                    Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF7F3DFF)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  buildTransactionSection('Today'),
                  const SizedBox(height: 20),
                  buildTransactionSection('Yesterday'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionSection(String date) {
    final filteredTransactions = transactions.where((tx) => tx['date'] == date).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(date, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...filteredTransactions.map((tx) => TransactionTile(tx)).toList(),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionTile(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction['color'].withOpacity(0.1),
          child: Icon(transaction['icon'], color: transaction['color']),
        ),
        title: Text(transaction['title']),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transaction['subtitle']),
            Text(transaction['time'], style: const TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: Text(
          transaction['amount'],
          style: TextStyle(
            color: transaction['amount'].startsWith('-') ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}