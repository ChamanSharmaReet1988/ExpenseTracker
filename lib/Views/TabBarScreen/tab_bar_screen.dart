import 'package:flutter/material.dart';
import 'package:expense_tracker/Views/HomeScreen/home_screen.dart';
import 'package:expense_tracker/Views/Profile/profile_screen.dart';
import 'package:expense_tracker/Views/BudgetScreens/budget_screen.dart';
import 'package:expense_tracker/Views/TransactionsScreens/transactions_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isExpanded = false;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    );
  }

  void toggleFAB() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeScreen(),
          TransactionsScreen(),
          BudgetScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-5, animation.value * 100),
                child: child,
              );
            },
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                // Handle button 1 press
              },
              mini: true,
              child: Image.asset(
                'assets/images/Expense.png',
                height: 39,
                width: 39,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-5, animation.value * 50),
                child: child,
              );
            },
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                // Handle button 2 press
              },
              mini: true,
              child: Image.asset(
                'assets/images/Income.png',
                height: 39,
                width: 39,
              ),
            ),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF7F3DFF),
            onPressed: toggleFAB,
            child:
                Icon(isExpanded ? Icons.add : Icons.close, color: Colors.white),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFCFCFC),
        shape: const CircularNotchedRectangle(),
        notchMargin: 9.0,
        elevation: 0, // Set elevation to 0
        child: TabBar(
          indicatorColor: Colors.white,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          dividerHeight: 0.0,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 0.1, color: Colors.transparent),
          ),
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              icon: Image.asset(
                _tabController.index == 0
                    ? 'assets/images/home_page_colored.jpg'
                    : 'assets/images/home_page.jpg',
                height: 24,
                width: 24,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 1
                    ? 'assets/images/Transaction.jpg'
                    : 'assets/images/Transaction_grey.jpg',
                height: 24,
                width: 24,
              ),
              child: const FittedBox(
                fit: BoxFit.none,
                child: Text('Transaction'),
              ),
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 2
                    ? 'assets/images/Piechart.jpg'
                    : 'assets/images/Piechart_greyt.jpg',
                height: 24,
                width: 24,
              ),
              text: 'Budget',
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 3
                    ? 'assets/images/user_colored.jpg'
                    : 'assets/images/user_grey.jpg',
                height: 24,
                width: 24,
              ),
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
