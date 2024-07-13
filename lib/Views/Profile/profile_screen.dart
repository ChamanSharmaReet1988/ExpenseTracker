import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  final List<Map<String, dynamic>> options = [
    {
      'title': 'Account',
      'icons': 'assets/images/account.jpg',
      'onTap': () {},
    },
    {
      'title': 'Settings',
      'icons': 'assets/images/settings.jpg',
      'onTap': () {},
    },
    {
      'title': 'Export Data',
      'icons': 'assets/images/exportData.jpg',
      'onTap': () {},
    },
    {
      'title': 'Logout',
      'icons': 'assets/images/logout.jpg',
      'onTap': () {},
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with your image URL
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Sakshi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.black)
                  ],
                ),

                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 20.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Prevent the ListView from scrolling independently
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        return SizedBox(
                          height: 85,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                            leading: SizedBox(
                              width: 40, // Specify the desired width for the image
                              child: Image.asset(option['icons']),
                            ),
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(option['title']),
                            ),
                            onTap: option['onTap'],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 1, color:  Color(0xFFF5F5F5));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfileScreen(),
  ));
}