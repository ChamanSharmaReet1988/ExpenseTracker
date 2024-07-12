import 'package:expense_tracker/Views/BudgetScreens/budget_screen.dart';
import 'package:expense_tracker/Views/HomeScreen/home_screen.dart';
import 'package:expense_tracker/Views/Profile/profile_screen.dart';
import 'package:expense_tracker/Views/TransactionsScreens/transactions_screen.dart';
import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF7F3DFF),
        onPressed: () {
          // Action for the floating button
        },
        child: const Icon(Icons.add, color: Colors.white), // Replace with your desired icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFCFCFC),
        shape: const CircularNotchedRectangle(),
        notchMargin: 9.0,
        elevation: 0, // Set elevation to 0
        child: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(), // Hides the indicator line
          labelColor: const Color(0xFF7F3DFF),
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              icon: Image.asset(
                _tabController.index == 0 ? 'assets/images/home_page_colored.jpg' : 'assets/images/home_page.jpg',
                height: 24,
                width: 24,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 1 ? 'assets/images/Transaction.jpg' : 'assets/images/Transaction_grey.jpg',
                height: 24,
                width: 24,
              ),
              text: 'Transaction',
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 2 ? 'assets/images/Piechart.jpg' : 'assets/images/Piechart_greyt.jpg',
                height: 24,
                width: 24,
              ),
              text: 'Budget',
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 3 ? 'assets/images/user_colored.jpg' : 'assets/images/user_grey.jpg',
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













// import 'package:expense_tracker/Views/Profile/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:expense_tracker/Views/HomeScreen/home_screen.dart';

// class TabBarScreen extends StatefulWidget {
//   const TabBarScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _TabBarScreenState createState() => _TabBarScreenState();
// }

// class _TabBarScreenState extends State<TabBarScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       initialIndex: 0,
//       child: Scaffold(
//         body: const TabBarView(
//           children: [
//             HomeScreen(),
//             Center(child: Text('Search Tab')),
//             Center(child: Text('Transaction Tab')),
//             ProfileScreen()
//           ],
//         ),
//         bottomNavigationBar: const TabBar(
//           tabs: [
//             TabWithImage(imagePath: 'assets/images/home.jpg', text: 'Home'),
//             TabWithImage(imagePath: 'assets/images/Transaction.jpg', text: 'Transaction'),
//             TabWithImage(imagePath: 'assets/images/piechart.jpg', text: 'Budget'),
//             TabWithImage(imagePath: 'assets/images/profile.jpg', text: 'Profile'),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           backgroundColor: const Color(0xFF7F3DFF), // Change the background color to purple
//           foregroundColor: Colors.white, // Change the icon color to white
//           elevation: 0, // Optionally remove the button's elevation
//           shape: const CircleBorder(),
//           child: const Icon(Icons.add),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }
// }



// class TabWithImage extends StatelessWidget {
//   final String imagePath;
//   final String text;

//   const TabWithImage({
//     required this.imagePath,
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Tab(
//       icon: Image.asset(
//         imagePath,
//         width: 24,
//         height: 24,
//       ),
//       text: text,
//     );
//   }
// }











