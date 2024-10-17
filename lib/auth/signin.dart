import 'package:firstpro/auth/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background pattern
          // Container(
          //   decoration: BoxDecoration(
          //     color: Color(0xFFF5F7FA),
          //     image: DecorationImage(
          //       image: AssetImage(
          //           'assets/pattern.png'), // Add a subtle pattern image
          //       repeat: ImageRepeat.repeat,
          //       opacity: 0.05,
          //     ),
          //   ),
          // ),
          Positioned(
            top: -200,
            left: -200,
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(190),
                color: Colors.red.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            top: -120,
            left: -120,
            child: Container(
              height: 300,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(170),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.4),
                  )),
            ),
          ),
          Positioned(
            bottom: -200,
            right: -200,
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(190),
                color: Colors.red.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -120,
            child: Container(
              height: 300,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(170),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.4),
                  )),
            ),
          ),
          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 38),
                    _buildTextField(
                      icon: Icons.email_outlined,
                      hintText: 'Email',
                    ),
                    SizedBox(height: 24),
                    _buildTextField(
                      icon: Icons.lock_outline,
                      hintText: 'Password',
                      isPassword: true,
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.9,
                          child: Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                              activeColor: Colors.red),
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(color: Color(0xFF7F8C8D)),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password functionality
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement sign in functionality
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                    ),
                    SizedBox(height: 36),
                    _buildDivider(),
                    SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: FontAwesomeIcons.google,
                          color: Colors.green,
                        ),
                        SizedBox(width: 24),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.facebook,
                          color: Color(0xFF3b5998),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RichText(
                text: TextSpan(
                  text: 'Do not have an account? ',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign Up here!',
                      style: TextStyle(color: Colors.red),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the tap event, for example, navigate to the sign-up page
                          Navigator.push(
                            context,
                            FadePageRoute(page: SignUpScreen()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hintText,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword ? _obscureText : false,
        obscuringCharacter: "*",
        style: TextStyle(color: Color(0xFF2C3E50)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFBDC3C7)),
          prefixIcon: Icon(icon, color: Colors.red),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFBDC3C7),
            thickness: 0.5,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or Sign In With',
            style: TextStyle(
              color: Color(0xFF7F8C8D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFBDC3C7),
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement social sign in
      },
      child: Icon(icon, color: Colors.white, size: 24),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        elevation: 3,
      ),
    );
  }
}

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
