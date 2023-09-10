// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../models/studentdetails.dart';
import 'Detail.dart';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  List<dynamic> student = [];
  late Future<List<StudentDetails>> studentsFuture;
  List<StudentDetails> studentdetails = [];
  List<dynamic> Event = [];
  String searchvalue = "";
  bool verification = false;
  var stuurl = "https://mzcet.in/techquest23/returnjson.php";
  Future<List<StudentDetails>> GetStudent() async {
    try {
      var result = await http.get(
        Uri.parse(stuurl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (result.statusCode == 200) {
        List<dynamic> student = jsonDecode(result.body);
        List<StudentDetails> studentdetails =
            student.map((stu) => StudentDetails.fromJson(stu)).toList();
        return studentdetails;
      } else {
        if (kDebugMode) {
          print("Error");
        }
        throw Exception('Failed to load data');
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      throw Exception('Failed to load data');
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

  imgefunc(String image) {
    if (image == "null" || image == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/no-image-icon-23500.jpg',
          fit: BoxFit.cover,
        ),
      );
    } else {
      final imageUrl = "https://mzcet.in/techquest23/$image";
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Future<List<StudentDetails>> initializeData() async {
    try {
      List<StudentDetails> studentdetails = await GetStudent();
      return studentdetails;
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      rethrow; // Rethrow the exception to propagate it
    }
  }

  Future<void> sendPostcheck() async {
    // Replace with your actual URL
    final response = await http.post(
      Uri.parse("https://mzcet.in/techquest23/QuizApi/user/login.php"),
      body: {
        'teamname': "Herosaravanan",
      }, // Replace '1' with the actual techquest_id you want to update
    );

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      if (kDebugMode) {
        print('Success: ${response.body}');
      }
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }

  ApiCall() {
    setState(() {
      studentsFuture = initializeData();
    });
  }

  @override
  void initState() {
    ApiCall();
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
                              initialValue: searchvalue,
                              onChanged: (value) {
                                setState(() {
                                  searchvalue = value;
                                });

                                if (kDebugMode) {
                                  print("search:$value");
                                }
                                if (kDebugMode) {
                                  print(searchvalue);
                                }
                              },
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
                        onPressed: () {
                          setState(() {
                            // sendPostcheck();
                          });
                        },
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
                              ApiCall();
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
                child: FutureBuilder<List<StudentDetails>>(
                  future: studentsFuture, // Use the future containing your data
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ); // Show a loading indicator while data is loading
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No data available.'),
                            ],
                          ));
                    } else {
                      // teamcheck();
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!
                            .where((element) => element.teamName
                                .toString()
                                .toLowerCase()
                                .contains(searchvalue.toLowerCase()))
                            .length,
                        itemBuilder: (context, index) {
                          var stu = snapshot.data!
                              .where((element) => element.teamName
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchvalue.toLowerCase()))
                              .toList()[index];
                          if (kDebugMode) {
                            print("enter");
                          }
                          if (kDebugMode) {
                            print(stu.screenShot.toString());
                          }

                          if (kDebugMode) {
                            print(stu.verification);
                          }
                          if (stu.verification == null ||
                              stu.verification == "null") {
                            verification = true;
                          } else {
                            verification = false;
                          }

                          return Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.70,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 254, 254, 254),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(61, 23, 24, 25)
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: imgefunc(
                                              stu.screenShot.toString()),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      "${stu.collegeName}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      "${stu.teamName}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 05),
                                                    child: Text(
                                                      "${stu.teamLeader}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      child: MaterialButton(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        color: verification
                                            ? const Color.fromARGB(
                                                255, 77, 45, 111)
                                            : Colors.green,
                                        onPressed: () {
                                          SendEvent(
                                            stu.knowlegdeBowl,
                                            stu.quizardry,
                                            stu.techVein,
                                            stu.designUp,
                                            stu.codeLog,
                                          ).whenComplete(() {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => Detail(
                                                  Email: stu.email,
                                                  EventList: Event,
                                                  CollegeName: stu.collegeName
                                                      .toString(),
                                                  Screenshot: stu.screenShot,
                                                  TeamId: stu.techquestId
                                                      .toString(),
                                                  TeamLeader:
                                                      stu.teamLeader.toString(),
                                                  TeamMemberone:
                                                      stu.memberone.toString(),
                                                  TeamMembertwo:
                                                      stu.memberTwo.toString(),
                                                  TeamName:
                                                      stu.teamName.toString(),
                                                  verification: stu.verification
                                                      .toString(),
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
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
