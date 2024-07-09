import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expense_tracker/Views/LoginScreen/login_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  int carouselCurrentIndex = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'assets/images/Ilustration.png',
    'assets/images/Illustration2.png',
    'assets/images/Illustration3.png',
  ];

  final List<String> textList = [
    'Gain total control of your money',
    'Know where your money goes',
    'Planning ahead'
  ];

  final List<String> subTextList = [
    'Become your own money manager and make every cent count',
    'Track your transaction easily, with categories and financial report',
    'Setup your budget for each category so you in control'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        items: imgList
                            .map((item) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item,
                                  ),
                                ))
                            .toList(),
                        carouselController: _controller,
                        options: CarouselOptions(
                          initialPage: 0,
                          viewportFraction: 1.0,
                          disableCenter: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          scrollDirection: Axis.horizontal,
                          autoPlay: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              carouselCurrentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Space between box and text
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Text(
                  textList[carouselCurrentIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color(0xFF111111),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15), // Space between box and text
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  subTextList[carouselCurrentIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF91919F),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              const Spacer(),
              AnimatedSmoothIndicator(
                activeIndex: carouselCurrentIndex,
                count: imgList.length,
                effect: const ScrollingDotsEffect(
                  activeDotColor: Color(0xFF7F3DFF),
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
                onDotClicked: (index) {
                  _controller.animateToPage(index);
                },
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 56,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF7F3DFF),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFEEE5FF),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const LoginPage());
}
