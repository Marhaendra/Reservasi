import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/models/date_reservation_model.dart';
import 'package:reservasi/screens/home_screen.dart';
import 'package:reservasi/controllers/reservation_controller.dart';
import 'package:reservasi/theme.dart';
import 'package:get/get.dart';

class ReservationScreen extends StatefulWidget {
  ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late PageController pageController;
  late int current;
  late List<DateListModel> dateList;
  late ReservationController controller;

  @override
  void initState() {
    super.initState();
    controller = ReservationController();
    DateTime selectedDate = DateTime.now();
    dateList = DateListModel.getDateList(selectedDate);
    current = 0; // Set initial position to the middle
    pageController = PageController(initialPage: current);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ReservationController>(
        init: controller,
        builder: (_) {
          return SafeArea(
            child: Column(
              children: [
                _header(context),
                tabBarReservation(),
                contentReservation(),
              ],
            ),
          );
        },
      ),
    );
  }

  Container contentReservation() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      width: double.infinity,
      height: 610,
      child: PageView.builder(
        itemCount: dateList.length,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilih Kursi',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MyTheme.black,
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                          ItemStatus(
                            status: "Kosong",
                            color: MyTheme.white,
                            border: MyTheme.primary,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ItemStatus(
                            status: "Terisi",
                            color: MyTheme.grey,
                            border: MyTheme.grey,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ItemStatus(
                            status: "Dipilih",
                            color: MyTheme.primary,
                            border: MyTheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 24,
                alignment: Alignment.centerLeft, // Add this line
                child: Text(
                  dateList[current].longDateFormat,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              seat(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: On search tap
                      // Navigator.pop(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomeScreen()),
                      // );
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10.5),
                      decoration: BoxDecoration(
                        color: MyTheme.primary.withOpacity(.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          "Pesan",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: MyTheme.primary,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }

  Expanded seat() {
    return Expanded(
        child: Container(
      decoration: const BoxDecoration(
        color: MyTheme.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Row(
                        children: List.generate(
                          controller.session.length,
                          (index) => GestureDetector(
                            onTap: () => controller.changeSession(index),
                            child: Container(
                              margin: EdgeInsets.all(8),
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.indexSession.value == index
                                      ? MyTheme.primary
                                      : MyTheme.grey1,
                                ),
                                color: controller.indexSession.value == index
                                    ? MyTheme.primary.withOpacity(.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Sesi ${index + 1}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: controller.indexSession.value ==
                                                index
                                            ? MyTheme.primary
                                            : MyTheme.black,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "00.00 - 00.00",
                                      style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: controller.indexSession.value ==
                                                index
                                            ? MyTheme.primary
                                            : MyTheme.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    child: Obx(
                      () => GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 7,
                        ),
                        itemCount: controller
                            .session[controller.indexSession.value].length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => controller.selectSeat(index),
                          onDoubleTap: () => controller.selectSeat(index),
                          child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller.session[controller
                                                .indexSession
                                                .value][index]["status"] ==
                                            "available"
                                        ? MyTheme.primary
                                        : controller.session[controller
                                                    .indexSession
                                                    .value][index]["status"] ==
                                                "filled"
                                            ? MyTheme.grey
                                            : MyTheme.primary),
                                color: controller.session[controller
                                            .indexSession
                                            .value][index]["status"] ==
                                        "available"
                                    ? MyTheme.white
                                    : controller.session[controller.indexSession
                                                .value][index]["status"] ==
                                            "filled"
                                        ? MyTheme.grey
                                        : MyTheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: controller.session[controller
                                                .indexSession
                                                .value][index]["status"] ==
                                            "available"
                                        ? MyTheme.black
                                        : controller.session[controller
                                                    .indexSession
                                                    .value][index]["status"] ==
                                                "filled"
                                            ? MyTheme.black1
                                            : MyTheme.white,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }

  SizedBox tabBarReservation() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: dateList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  _updateDateList(index);
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
                    color: current == index ? MyTheme.white : MyTheme.white,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dateList[index].shortDateFormat,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
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

  void _updateDateList(int index) {
    setState(() {
      current = index;
      DateTime selectedDate =
          DateTime.now().add(Duration(days: index - current));
      dateList = DateListModel.getDateList(selectedDate);
    });
  }

  Padding _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero, // Adjust the top padding
      child: Container(
        width: double.maxFinite,
        height: 135,
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

class ItemStatus extends StatelessWidget {
  ItemStatus({
    Key? key,
    required this.status,
    required this.color,
    required this.border,
  }) : super(key: key);

  final String status;
  final Color color;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: border, // Set the color of the stroke
              width: 2.0, // Set the width of the stroke
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          status,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins()
                .fontFamily, // Use GoogleFonts.poppins() correctly
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
