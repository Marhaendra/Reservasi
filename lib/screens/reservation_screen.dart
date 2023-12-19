import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/models/date_list_model.dart';
import 'package:reservasi/screens/home_screen.dart';
import 'package:reservasi/screens/order_screen.dart';
import 'package:reservasi/theme.dart';

class ReservationScreen extends StatefulWidget {
  ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late PageController pageController;
  late int current;
  late List<DateListModel> dateList;

  @override
  void initState() {
    super.initState();
    DateTime selectedDate = DateTime.now();
    dateList = DateListModel.getDateList(selectedDate);
    current = 0; // Set initial position to the middle
    pageController = PageController(initialPage: current);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Column(children: [
        _header(context),
        tabBarReservation(),

        /// MAIN BODY
        contentReservation(),
      ]),
    ));
  }

  Container contentReservation() {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      width: double.infinity,
      height: 550,
      child: PageView.builder(
        itemCount: dateList.length,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                "Tab Content",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: MyTheme.primary),
              ),
            ],
          );
        },
      ),
    );
  }

  SizedBox tabBarReservation() {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: dateList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    current = index;
                    DateTime selectedDate =
                        DateTime.now().add(Duration(days: index - current));
                    dateList = DateListModel.getDateList(selectedDate);
                  });
                  pageController.animateToPage(
                    current,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(0),
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: current == index ? MyTheme.white : MyTheme.white1,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dateList[index].date,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: current == index
                                ? MyTheme.primary
                                : MyTheme.grey1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: current == index,
                child: Container(
                  width: 52,
                  height: 1,
                  decoration: const BoxDecoration(
                    color: MyTheme.primary,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Padding _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero, // Adjust the top padding
      child: Container(
        width: double.maxFinite,
        height: 160,
        color: MyTheme.primary, // Set the background color
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                children: [
                  // Padding for the Ticket icon
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                      left: 16,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const PhosphorIcon(
                        PhosphorIconsRegular.caretLeft,
                        color: MyTheme.white,
                        size: 24,
                      ),
                    ),
                  ),
                  // Padding for the User icon
                  Text(
                    'Lab. Techno',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: MyTheme.white,
                      fontWeight: FontWeight.w700,
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
