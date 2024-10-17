import 'package:firstpro/TaxiApp/view/auth/login.dart';
import 'package:firstpro/auth/signin.dart';
import 'package:flutter/material.dart';

class AuthSeclection extends StatefulWidget {
  const AuthSeclection({super.key});

  @override
  State<AuthSeclection> createState() => _AuthSeclectionState();
}

class _AuthSeclectionState extends State<AuthSeclection> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    // Start the animation after a short delay
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F8),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 260,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(150),
              ),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  top: !_isAnimated
                      ? -800
                      : -80, // Adjust the end position as needed
                  left: 40,
                  child: Transform.scale(
                    scale: 1.1,
                    child: Image.asset(
                      'assets/images/car_top.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Welcome to ",
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              SizedBox(
                width: 6,
              ),
              Hero(
                tag: 'log',
                child: Image.asset(
                  'assets/images/secondlog.png',
                  width: 110,
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, FadePageRoute(page: LoginScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: 'number',
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.black),
                    ),
                    Icon(Icons.arrow_drop_down,
                        size: 29, color: Colors.black45),
                    Text(
                      '   +1         123456789',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black45.withOpacity(0.1),
          ),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Or connect using social media accounts',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
