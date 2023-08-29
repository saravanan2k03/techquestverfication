// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techquest/views/HomeScreen.dart';
import '../widgets/drawer.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  final TeamId;
  final CollegeName;
  final TeamName;
  final TeamLeader;
  final TeamMemberone;
  final TeamMembertwo;
  final Screenshot;
  final verification;
  final List<dynamic> EventList;
  const Detail({
    super.key,
    this.TeamId,
    required this.EventList,
    this.CollegeName,
    this.TeamName,
    this.TeamLeader,
    this.TeamMemberone,
    this.TeamMembertwo,
    this.Screenshot,
    this.verification,
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool verification = false;
  String url = "https://mzcet.in/techquest23/api/verify.php";
  String arrival = "https://mzcet.in/techquest23/api/arrival.php";
  List<String> student = [];
  List<String> EventList = [];

  Future<void> sendPostRequest() async {
    // Replace with your actual URL
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': widget.TeamId.toString(),
      }, // Replace '1' with the actual techquest_id you want to update
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (kDebugMode) {
        print('Success: ${data['success']}');
      }
    } else {
      customshowAlertDialog(
          'Error', 'Request failed with status:${response.statusCode}');
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }

  Future<void> SubmitRequest() async {
    // Convert the EventList into a comma-separated string
    String eventsString = EventList.join(',');
    final response = await http.post(
      Uri.parse(arrival),
      body: {
        'student': student.join(','),
        'events': eventsString,
        'TeamName': widget.TeamName,
        'id': widget.TeamId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (kDebugMode) {
        print('Success: ${data['success']}');
      }
      if (data['success'] == false) {
        customshowAlertDialog('Error', 'Student Has Been Already Added ');
      } else {
        customshowAlertDialog('success', 'Student Has Been Added Successfully');
      }
    } else {
      customshowAlertDialog(
          'Error', 'Request failed with status:${response.statusCode}');
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }

  AddStudentList() {
    student = [];
    EventList = [];
    for (var element in widget.EventList) {
      EventList.add(element);
    }
    if (widget.TeamLeader != "") {
      student.add(widget.TeamLeader);
      if (kDebugMode) {
        print("TeamLeader Not Empty");
      }
    } else {
      if (kDebugMode) {
        print("TeamLeader empty");
      }
    }
    if (widget.TeamMemberone != "") {
      student.add(widget.TeamMemberone);

      if (kDebugMode) {
        print("TeamMemberone Not Empty");
      }
    } else {
      if (kDebugMode) {
        print("TeamMemberone empty");
      }
    }
    if (widget.TeamMembertwo != "") {
      student.add(widget.TeamMembertwo);
      if (kDebugMode) {
        print("Not Empty");
      }
    } else {
      if (kDebugMode) {
        print("TeamMembertwo empty");
      }
    }
    if (kDebugMode) {
      print("student:$student");
      print("Event:${widget.EventList}");
    }
  }

  Future<void> customshowAlertDialog(String tittle, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: Text(
            tittle,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: const Color.fromARGB(255, 77, 45, 111),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  content,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future Profile() async {
    if (kDebugMode) {
      print(widget.verification);
    }
    if (widget.verification == null || widget.verification == "null") {
      verification = true;
      if (kDebugMode) {
        print("null verification");
      }
    } else {
      verification = false;
      if (kDebugMode) {
        print("not null verification");
      }
    }
  }

  @override
  void initState() {
    Profile();
    AddStudentList();
    super.initState();
  }

  bool profile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const DrawerPage(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * .80,
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(61, 23, 24, 25)
                            .withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .70,
                          width: MediaQuery.of(context).size.width * 0.20,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(61, 23, 24, 25)
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                fit: BoxFit.cover,
                                "https://mzcet.in/techquest23/${widget.Screenshot}"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "PROFILE:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: verification
                                          ? const Icon(
                                              Icons.not_interested_sharp,
                                              color: Colors.red,
                                              size: 30.0,
                                            )
                                          : const Icon(
                                              Icons.verified_sharp,
                                              color: Colors.green,
                                              size: 30.0,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "TEAM ID:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        widget.TeamId,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "COLLEGE NAME:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          widget.CollegeName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "TEAM NAME:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          widget.TeamName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              // // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "TEAM LEADER:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    // Note: Same code is applied for the TextFormField as well

                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          widget.TeamLeader,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.10,
                                            child: const TextField(
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color.fromARGB(
                                                          255,
                                                          11,
                                                          8,
                                                          16)), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "TEAM MEMBER ONE:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          widget.TeamMemberone,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.10,
                                            child: const TextField(
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.black,
                                                  ), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "TEAM MEMBER TWO:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          widget.TeamMembertwo,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.10,
                                            child: const TextField(
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors
                                                          .black), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: Text(
                                        "EVENTS:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.blue,
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: widget.EventList.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    widget.EventList[index]
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: MaterialButton(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        color: const Color.fromARGB(
                                            255, 77, 45, 111),
                                        onPressed: () {
                                          sendPostRequest().whenComplete(
                                            () => Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Text(
                                            "VERIFY",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      child: MaterialButton(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        color: const Color.fromARGB(
                                            255, 77, 45, 111),
                                        onPressed: () {
                                          if (widget.verification == null ||
                                              widget.verification == "null") {
                                            customshowAlertDialog('VERIFY',
                                                'Please Make sure that profile Can Be Verified');
                                          } else {
                                            SubmitRequest();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Text(
                                            "SUBMIT",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
