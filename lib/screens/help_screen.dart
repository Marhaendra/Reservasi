import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservasi/theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Bantuan',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: MyTheme.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                AccordionFAQ()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding faq(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 330,
        height: 606,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 18,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FAQ',
                    style: TextStyle(
                      color: Color(0xFF6497F5),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0.03,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 330,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 330,
                    height: 42,
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 328,
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF2F2F2),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 1,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Apa itu (...)?',
                                      style: TextStyle(
                                        color: Color(0xFF6497F5),
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0.09,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccordionFAQ extends StatefulWidget {
  @override
  _AccordionFAQState createState() => _AccordionFAQState();
}

class _AccordionFAQState extends State<AccordionFAQ> {
  int _expandedIndex = -1; // Initially, no item is expanded

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        width: 330,
        height: 606,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 18,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FAQ',
                    style: TextStyle(
                      color: Color(0xFF6497F5),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0.03,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 330,
              child: Column(
                children: [
                  for (int i = 0; i < faqItems.length; i++)
                    buildAccordionItem(faqItems[i]['question']!,
                        faqItems[i]['additionalText']!, i),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccordionItem(String question, String additionalText, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _expandedIndex = (_expandedIndex == index) ? -1 : index;
          });
        },
        child: Container(
          child: Column(
            children: [
              Container(
                height: 44,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: ShapeDecoration(
                  color: Color(0xFFF2F2F2),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFF2F2F2),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      question,
                      style: const TextStyle(
                        color: Color(0xFF6497F5),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                    ),
                  ],
                ),
              ),
              if (_expandedIndex == index)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    additionalText,
                    style: TextStyle(
                      color: MyTheme.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Replace these questions and additional texts with your actual FAQ items
  List<Map<String, String>> faqItems = [
    {
      'question': 'Apa itu (...)?',
      'additionalText':
          '() adalah aplikasi yang memungkinkan anda untuk melakukan pemesanan tempat duduk pada tempat yang anda pilih'
    },
    {
      'question': 'Bagaimana cara melakukan reservasi?',
      'additionalText':
          'Additional Text for Bagaimana cara melakukan reservasi?'
    },
    {
      'question': 'Apakah bisa membatalkan reservasi?',
      'additionalText': 'Additional Text for Apakah bisa membatalkan reservasi?'
    },
    {
      'question': 'Haruskah melakukan Check-In/Check-Out',
      'additionalText':
          'Additional Text for Haruskah melakukan Check-In/Check-Out'
    },
  ];
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: AccordionFAQ(),
        ),
      ),
    ),
  );
}
