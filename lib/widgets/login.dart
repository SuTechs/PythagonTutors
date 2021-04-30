import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/constants.dart';
import '/data/database.dart';

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
          height: 20,
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

  // input field
  final GestureTapCallback? onTap;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool isReadOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? prefixText;

  final _formKey = GlobalKey<FormState>();

  LoginInputScreen({
    Key? key,
    required this.backgroundColor,
    required this.image,
    required this.onNext,
    required this.currentStep,
    required this.title,

    // input
    this.onTap,
    required this.controller,
    this.validator,
    required this.label,
    this.isReadOnly = false,
    this.inputFormatters,
    this.keyboardType,
    this.prefixText,
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
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      isDense: true,
                      hintText: label,
                      prefixText: prefixText,
                    ),
                    textCapitalization: TextCapitalization.words,
                    onTap: onTap,
                    controller: controller,
                    validator: (v) {
                      if (v == null || v.isEmpty) return '$label is required';

                      if (validator != null) validator!(v);
                    },
                    inputFormatters: inputFormatters,
                    readOnly: isReadOnly,
                    keyboardType: keyboardType,
                  ),
                ),
              ),
            ),

            /// slider indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 6; i++)
                  Container(
                    margin: i != 5 ? EdgeInsets.only(right: 8) : null,
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
                  onPressed: () {
                    // ToDO : enable validation
                    //if (_formKey.currentState!.validate())
                    onNext();
                  },
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

/// select subjects
class SelectMultipleSubjects extends StatefulWidget {
  final List<Subject> subjects;
  final List<String> initiallySelectedSubjectsIds;

  final void Function(List<Subject> subjectsList) onSelect;

  const SelectMultipleSubjects(
      {Key? key,
      required this.subjects,
      required this.onSelect,
      required this.initiallySelectedSubjectsIds})
      : super(key: key);
  @override
  _SelectMultipleSubjectsState createState() => _SelectMultipleSubjectsState();
}

class _SelectMultipleSubjectsState extends State<SelectMultipleSubjects> {
  final List<Subject> subjectsList = [];
  final List<String> selectedSubjectsIds = [];
  String searchText = '';

  @override
  void initState() {
    subjectsList.addAll(widget.subjects);
    selectedSubjectsIds.addAll(widget.initiallySelectedSubjectsIds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 12),
              Expanded(
                child: Container(
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
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Search...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                          subjectsList.clear();
                          subjectsList.addAll(widget.subjects);
                          subjectsList.retainWhere((element) => element.name
                              .toLowerCase()
                              .contains(value.trim().toLowerCase()));
                        });
                      },
                    ),
                  ),
                ),
              ),
              if (selectedSubjectsIds.isNotEmpty) SizedBox(width: 12),
              if (selectedSubjectsIds.isNotEmpty)
                FloatingActionButton(
                  mini: true,
                  child: Icon(Icons.done),
                  onPressed: () {
                    widget.onSelect(widget.subjects
                        .where((element) =>
                            selectedSubjectsIds.contains(element.id))
                        .toList());
                    Navigator.pop(context);
                  },
                ),
              SizedBox(width: 12),
            ],
          ),
        ),

        /// items
        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  selected:
                      selectedSubjectsIds.contains(subjectsList[index].id),
                  onTap: () {
                    setState(() {
                      if (selectedSubjectsIds.contains(subjectsList[index].id))
                        selectedSubjectsIds.remove(subjectsList[index].id);
                      else
                        selectedSubjectsIds.add(subjectsList[index].id);
                    });
                  },
                  title: Text('${subjectsList[index].name}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(subjectsList[index].image),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Container(
                    height: 0.1,
                    color: const Color(0xffededed),
                  ),
                );
              },
              itemCount: subjectsList.length,
            ),
          ),
        ),
      ],
    );
  }
}
