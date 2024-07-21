import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:expense_tracker/Utility/common.dart';
import 'package:expense_tracker/Utility/preferences_helper.dart';
import 'package:expense_tracker/Views/LoginScreen/login_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  PreferencesHelper prefs = PreferencesHelper();

  final List<Map<String, dynamic>> options = [
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
    loadImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    // Save the image to the directory
    await saveImageToDirectory(_image!);
  }

  Future<void> saveImageToDirectory(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String path = directory.path;
      const String fileName = 'profileImage.png';
      final File newImage = await image.copy('$path/$fileName');

      setState(() {
        _image = newImage;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error saving image: $e');
      }
    }
  }

  Future<void> loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    const String fileName = 'profileImage.png';
    var imagePath = '$path/$fileName';

    if (await File(imagePath).exists()) {
      setState(() {
        _image = File(imagePath);
      });
    } else {
      print("No image found at the path: $imagePath");
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditUsernameDialog() {
    TextEditingController newUsernameController = TextEditingController();
    newUsernameController.text = prefs.username ?? "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(
            controller: newUsernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  prefs.username = newUsernameController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Common.logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Common.deleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => showPicker(context),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.grey[800],
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          prefs.username ?? "No Name",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                        _showEditUsernameDialog();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                      color: Colors.white,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 0.0),
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // Prevent the ListView from scrolling independently
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options[index];
                          return SizedBox(
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                if (index == 2) {
                                  showLogoutDialog();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors
                                      .white, // Make sure the background is white
                                  borderRadius: BorderRadius.circular(
                                      0), // Set borderRadius to 0 to remove rounded corners
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 16.0),
                                  leading: SizedBox(
                                    width:
                                        40, // Specify the desired width for the image
                                    child: Image.asset(option['icons']),
                                  ),
                                  title: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(option['title']),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                              height: 1, color: Color(0xFFF5F5F5));
                        },
                      )),
                ),
                const Spacer(), // Add a Spacer widget to push the Delete Account button to the bottom
                // Delete Account button
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFF5F5F5)),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red
                              .withOpacity(0.1), // Light red background color
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: const Icon(
                          Icons.delete_outline, // Delete icon
                          color: Colors.red, // Red color for the icon
                        ),
                      ),
                      title: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Delete Account',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      onTap: () => showDeleteAccountDialog(),
                    ),
                  ),
                ), // Set the background color to red
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
