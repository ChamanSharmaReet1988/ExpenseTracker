import 'package:flutter/material.dart';
import 'package:expense_tracker/HomeScreen/home_screen.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, 
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(          
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            Center(child: Text('Search Tab')),
            Center(child: Text('Transaction Tab')),
            Center(child: Text('Profile Tab')),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.search), text: 'Transaction'),
            Tab(icon: Icon(Icons.notifications), text: 'Budget'),
            Tab(icon: Icon(Icons.account_circle), text: 'Profile'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
