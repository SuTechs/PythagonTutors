import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '/constants.dart';

/// welcome login

class WelcomeLogin extends StatelessWidget {
  final VoidCallback onPressed;

  static const bodyPadding = EdgeInsets.symmetric(horizontal: 32);

  const WelcomeLogin({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: bodyPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// logo
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset('assets/icons/logo.png'),
                  Text(
                    'ythagon',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: 2,
                      color: const Color(0xff464646),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64),

              /// tag line

              Text(
                'Earn',
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 64,
                  letterSpacing: 3,
                  color: const Color(0xff454449),
                ),
              ),
              Text(
                'learn.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                  letterSpacing: 3,
                  color: const Color(0xff45485B),
                ),
              ),
              SizedBox(height: 32),

              AnimatedQuote(),
              SizedBox(height: 64),

              /// t&c
              Center(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text: 'By proceeding, I agree to',
                      ),
                      TextSpan(
                        text: ' T&C',
                        style: TextStyle(
                          color: kLogoRedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              /// get started
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kLogoRedColor),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset('assets/icons/google.png')),
                      SizedBox(width: 16),
                      Text(
                        'Continue with Google',
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedQuote extends StatefulWidget {
  @override
  _AnimatedQuoteState createState() => _AnimatedQuoteState();
}

class _AnimatedQuoteState extends State<AnimatedQuote> {
  static final quotes = [
    'Make it possible with Pythagon',
    'Earn while you learn',
    'Highest payout'
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// divider
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _currentIndex == 0
              ? 117
              : _currentIndex == 1
                  ? 90
                  : 70,
          height: 12.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: kLogoYellowColor,
          ),
        ),
        SizedBox(height: 24),

        /// quote
        SizedBox(
          height: 16,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 16,
              color: const Color(0xff221f1f),
              letterSpacing: 1,
              fontWeight: FontWeight.w300,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              onNext: (i, isLast) {
                setState(() {
                  _currentIndex = (i + 1) % 3;
                });
              },
              animatedTexts: [
                for (String s in quotes) FadeAnimatedText(s),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// input field screen

class LoginInputScreen extends StatelessWidget {
  final Color backgroundColor;
  final int currentStep;
  final String image;
  final String title;
  final VoidCallback onNext;

  const LoginInputScreen({
    Key? key,
    required this.backgroundColor,
    required this.image,
    required this.onNext,
    required this.currentStep,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      ///
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// title
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 1.8,
              ),
              textAlign: TextAlign.center,
            ),

            /// image
            Image.asset(image),

            /// input field
            Container(
              height: 49,
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                    isDense: true,
                    hintText: 'Name',
                  ),
                ),
              ),
            ),

            /// slider indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    margin: i != 4 ? EdgeInsets.only(right: 8) : null,
                    width: 24.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      color: const Color(0xffffffff)
                          .withOpacity(i == currentStep - 1 ? 1 : 0.5),
                    ),
                  ),
              ],
            ),

            /// back and next
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white),

                /// get started
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  ),
                  onPressed: onNext,
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16, color: backgroundColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
