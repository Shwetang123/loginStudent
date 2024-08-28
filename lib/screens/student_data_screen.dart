import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:loginstudent/screens/MenuItem_Screen.dart';
import 'package:loginstudent/services/Api_service.dart';
import 'package:lottie/lottie.dart';
import 'package:text_scroll/text_scroll.dart';

import '../models/Student_Detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final advancedDrawerController = AdvancedDrawerController();

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Future<StudentDetails> futureStudentDetails;
  bool showLottie = false;
  bool _hasShownLottie = false;
  int selectedStudentIndex = 0;
  DateTime?
      lastPressed; // Variable to track the time of the last back button press

  @override
  void initState() {
    super.initState();
    futureStudentDetails = ApiService().fetchStudentDetails();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final width = size.width;

    return WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();
          final isSecondPress = lastPressed != null &&
              now.difference(lastPressed!) < Duration(seconds: 2);

          if (isSecondPress) {
            // Show the pop-up dialog
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/animation/Alert.json', height: 100),
                      const Text(
                        'Do you want to stay?',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: "MainFont"),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "MainFont"),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () => Navigator.of(context).pop(true),
                            child:const  Text('No',style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: "MainFont"),),
                               ),
                            ],
                         ),
                     ],
                   ),
                );
              },
            );
          } else {
            lastPressed = DateTime.now();
            return false; // Prevent the default back action
          }
        },
        child: AdvancedDrawer(
            openRatio: 0.75,
            openScale: .9,
            animationCurve: Curves.easeInOut,
            controller: advancedDrawerController,
            backdropColor: Colors.white,
            childDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(25)),
            drawer: const SafeArea(
              child: MenuItemScreen(),
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    drawerControl();
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showStudentInfoPopup(context);
                    },
                    icon: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
                title: const Text(
                  "HOME",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MainFont"),
                ),
              ),
              body: Container(
                color: showLottie ? Colors.white10 : Colors.white,
                child: FutureBuilder<StudentDetails>(
                  future: futureStudentDetails,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('No data available'));
                    }

                    final studentDetails = snapshot.data!;
                    final student =
                        studentDetails.students[selectedStudentIndex];
                    // Check for birthday
                    final now = DateTime.now();
                    final dob = DateFormat('dd-MM-yyyy')
                        .parse(student.dob ?? '01-01-1970');
                    if (dob.day == now.day && dob.month == now.month) {
                      if (!_hasShownLottie) {
                        _hasShownLottie = true;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            showLottie = true;
                          });
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          if (mounted) {
                            setState(() {
                              showLottie = false;
                            });
                          }
                        });
                      }
                    }
                    return Stack(
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.center,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 15),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 48,
                                      child: Image.asset("assets/logo1.png"),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          student.sName ?? '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "MainFont"),
                                        ),
                                        Text(
                                          student.batchName ?? '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "MainFont"),
                                        ),
                                        Text(
                                          "RollNo. ${student.rollNo ?? 'N/A'}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "MainFont"),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "PARENT DASHBOARD",
                                style: TextStyle(
                                    color: showLottie
                                        ? Colors.white10
                                        : Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "MainFont"),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width / 4,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        color: showLottie
                                            ? Colors.white10
                                            : Colors.red,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Reg. No.',
                                              style: TextStyle(
                                                  color: showLottie
                                                      ? Colors.white10
                                                      : Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: "MainFont"),
                                            ),
                                            Text(
                                              student.regNo ?? '',
                                              style: TextStyle(
                                                  color: showLottie
                                                      ? Colors.white10
                                                      : Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "MainFont"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Card(
                                      elevation: 15,
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: showLottie
                                              ? Colors.white10
                                              : Colors.red,
                                          width: 1.0,
                                        ),
                                      ),
                                      color: showLottie
                                          ? Colors.white10
                                          : Colors.red[50],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.money,
                                              color: showLottie
                                                  ? Colors.white10
                                                  : Colors.green,
                                              size: 40,
                                            ),
                                            const SizedBox(width: 25),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Fees',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "MainFont",
                                                      color: showLottie
                                                          ? Colors.white10
                                                          : Colors.black),
                                                ),
                                                Text(
                                                  '₹ 19900',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: showLottie
                                                          ? Colors.white10
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "MainFont"),
                                                ),
                                                Text(
                                                  'Dues Remaining',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: showLottie
                                                          ? Colors.white10
                                                          : Colors.grey,
                                                      fontFamily: "MainFont"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Card(
                                      elevation: 10,
                                      color: showLottie
                                          ? Colors.white10
                                          : Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Date Of Birth',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                                Text(student.dob ?? '',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Mother\'s Name',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                                Text(student.mName ?? '',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Father\'s Name',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                                Text(student.fName ?? '',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Contact No.',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                                Text(
                                                    student.primaryContactNo ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        color: showLottie
                                                            ? Colors.white12
                                                            : Colors.black)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Address',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                                Text(
                                                    student.studentAddress ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "MainFont",
                                                        color: showLottie
                                                            ? Colors.white10
                                                            : Colors.black)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Container(
                                      //margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: showLottie
                                                  ? Colors.white10
                                                  : Colors.black26,
                                              blurRadius: 4.0,
                                              offset: const Offset(5, 5),
                                            )
                                          ]),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 99.1),
                                            decoration: BoxDecoration(
                                              color: showLottie
                                                  ? Colors.white10
                                                  : Colors.red,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                              ),
                                            ),
                                            child: Text(
                                              "IMPORTANT NOTICES",
                                              style: TextStyle(
                                                  color: showLottie
                                                      ? Colors.white10
                                                      : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: "MainFont"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: TextScroll(
                                              ' Spam refers to messages which are unsolicited and unwanted. Usually, spam texts are not coming from another phone. They mainly originate from a computer and are sent to your phone via an email address or instant messaging account. Because they are sent online, they are cheap and easy for scammers to send.',
                                              mode: TextScrollMode.endless,
                                              velocity: const Velocity(
                                                  pixelsPerSecond:
                                                      Offset(70, 0)),
                                              delayBefore: const Duration(
                                                  milliseconds: 500),
                                              numberOfReps: 50,
                                              pauseBetween: const Duration(
                                                  milliseconds: 50),
                                              style: TextStyle(
                                                  color: showLottie
                                                      ? Colors.white10
                                                      : Colors.black,
                                                  fontFamily: "MainFont",
                                                  fontSize: 15),
                                              textAlign: TextAlign.right,
                                              selectable: true,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (showLottie)
                          Positioned.fill(
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Lottie.asset('assets/animation/popup.json',
                                    // Path to your second Lottie animation file
                                    width: MediaQuery.sizeOf(context).height,
                                    height: MediaQuery.sizeOf(context).width,
                                    fit: BoxFit.cover),
                                Lottie.asset(
                                  'assets/animation/BirthdayAnimation.json',
                                  // Path to your first Lottie animation file
                                  width: MediaQuery.sizeOf(context).height,
                                  height: MediaQuery.sizeOf(context).width,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            )));
  }

  void drawerControl() {
    advancedDrawerController.showDrawer();
  }

  void showStudentInfoPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'My Ward',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "MainFont"),
          ),
          content: FutureBuilder<StudentDetails>(
            future: futureStudentDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No students available');
              }

              final students = snapshot.data!.students;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: students.map((student) {
                  return ListTile(
                    title: Text(
                      student.sName ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "MainFont"),
                    ),
                    subtitle: Text(
                      student.batchName ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      setState(() {
                        selectedStudentIndex = students.indexOf(student);
                      });
                      Navigator.of(context).pop();

                      // Date of birth check
                      final now = DateTime.now();
                      final dob = DateFormat('dd-MM-yyyy')
                          .parse(student.dob ?? '01-01-1970');
                      if (dob.day == now.day && dob.month == now.month) {
                        if (!_hasShownLottie) {
                          showLottie = true;
                          _hasShownLottie = true;
                          Future.delayed(const Duration(seconds: 20), () {
                            if (mounted) {
                              setState(() {
                                showLottie = false;
                              });
                            }
                          });
                        }
                      }
                    },
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
