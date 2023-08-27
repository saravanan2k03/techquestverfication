// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Detail.dart';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  List<dynamic> student = [];
  List<dynamic> Event = [];

  Future GetStudent() async {
    try {
      var result = await http.get(
        Uri.parse('https://mzcet.in/techquest23/returnjson.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (result.statusCode == 200) {
        student = jsonDecode(result.body);
        if (kDebugMode) {
          setState(() {
            if (kDebugMode) {
              print(student);
            }
            if (kDebugMode) {
              print(student[0]["TeamName"]);
            }
            if (kDebugMode) {
              print(student.length);
            }
          });
        }
      } else {
        if (kDebugMode) {
          print(result.body);
        }
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
    }
  }

  Future SendEvent(var KnowlegdeBowl, var Quizardry, var Techvein, var designUp,
      var CodeLog) async {
    Event = [];

    if (KnowlegdeBowl == "null" || KnowlegdeBowl == null) {
      if (kDebugMode) {
        print("KnowlegdeBowl object is null");
      }
    } else {
      Event.add(KnowlegdeBowl);
    }
    if (Quizardry == "null" || Quizardry == null) {
      if (kDebugMode) {
        print("Quizardry object is null");
      }
    } else {
      Event.add(Quizardry);
    }
    if (Techvein == "null" || Techvein == null) {
      if (kDebugMode) {
        print("Techvein object is null");
      }
    } else {
      Event.add(Techvein);
    }
    if (designUp == "null" || designUp == null) {
      if (kDebugMode) {
        print("designUp object is null");
      }
    } else {
      Event.add(designUp);
    }
    if (CodeLog == "null" || CodeLog == null) {
      if (kDebugMode) {
        print("CodeLog object is null");
      }
    } else {
      Event.add(CodeLog);
    }
    if (kDebugMode) {
      print("Event: $Event");
    }
  }

  @override
  void initState() {
    GetStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: Container(
                height: MediaQuery.of(context).size.height * .15,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: TextFormField(
                              // controller: searchtxt,
                              // initialValue: searchvalue,
                              onChanged: (value) {},
                              cursorColor:
                                  const Color.fromARGB(255, 19, 21, 21),

                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search_sharp),
                                  suffixIcon: Icon(Icons.more_vert_outlined),
                                  hoverColor: Color.fromARGB(255, 89, 90, 91),
                                  hintText: "search"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: MaterialButton(
                        color: const Color.fromARGB(255, 77, 45, 111),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            "SEARCH",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: MaterialButton(
                          color: const Color.fromARGB(255, 77, 45, 111),
                          onPressed: () {
                            setState(() {
                              GetStudent();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "REFRESH",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: Container(
                height: MediaQuery.of(context).size.height * .80,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: student.length,
                    itemBuilder: (context, index) {
                      var stu = student[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            width: MediaQuery.of(context).size.width * 0.70,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 254, 254, 254),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                                  61, 23, 24, 25)
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
                                          "https://mzcet.in/techquest23/${stu["ScreenShot"]}"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  "${stu["CollegeName"]}",
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Team Name:",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  "${stu["TeamName"]}",
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Team Leader:",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 05),
                                                child: Text(
                                                  "${stu["TeamLeader"]}",
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  child: MaterialButton(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    color:
                                        const Color.fromARGB(255, 77, 45, 111),
                                    onPressed: () {
                                      SendEvent(
                                        stu["Knowlegde_Bowl"],
                                        stu["Quizardry"],
                                        stu["Tech_vein"],
                                        stu["Design_up"],
                                        stu["CodeLog"],
                                      ).whenComplete(() {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Detail(
                                              EventList: Event,
                                              CollegeName:
                                                  stu["CollegeName"].toString(),
                                              Screenshot: stu["ScreenShot"],
                                              TeamId: stu["techquest_id"]
                                                  .toString(),
                                              TeamLeader:
                                                  stu["TeamLeader"].toString(),
                                              TeamMemberone:
                                                  stu["Memberone"].toString(),
                                              TeamMembertwo:
                                                  stu["MemberTwo"].toString(),
                                              TeamName:
                                                  stu["TeamName"].toString(),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Text(
                                        "VIEW",
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
                          )
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
