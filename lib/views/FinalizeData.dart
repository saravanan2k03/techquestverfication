// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:techquest/api/PdfApi.dart';
import 'package:techquest/models/arrival.dart';
import '../widgets/utils.dart';

class FinalizeData extends StatefulWidget {
  const FinalizeData({super.key});

  @override
  State<FinalizeData> createState() => _FinalizeDataState();
}

class _FinalizeDataState extends State<FinalizeData> {
  late Future<List<arrival>> studentsFuture;

  List<arrival> students = [];
  List<dynamic> searchstudent = [];

  String url = "https://mzcet.in/techquest23/api/Allow.php";
  String searchvalue = "";
  String dropdownvalue = 'Choose Event';
  var items = [
    'Choose Event',
    'KnowlegdeBowl',
    'Quizardry',
    'Techvein',
    'Designup',
    'CodeLog',
  ];
  Future<List<arrival>> GetStudent() async {
    try {
      var result = await http.get(
        Uri.parse('https://mzcet.in/techquest23/api/arrivaljson.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (result.statusCode == 200) {
        List<dynamic> student = groupByTeam(jsonDecode(result.body));
        List<arrival> students =
            student.map((stu) => arrival.fromJson(stu)).toList();
        searchstudent = groupByTeam(jsonDecode(result.body));
        if (kDebugMode) {
          print(searchstudent);
        }
        return students;
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

  Future<List<arrival>> SubmitEvent() async {
    final response = await http.post(
      Uri.parse('https://mzcet.in/techquest23/api/arrivalreturnwhere.php'),
      body: {
        'Event': dropdownvalue.toString(),
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> student = groupByTeam(jsonDecode(response.body));
      //searchstudent = jsonDecode(response.body);
      searchstudent = groupByTeam(jsonDecode(response.body));
      //sens
      students = student.map((stu) => arrival.fromJson(stu)).toList();
      return students;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      throw Exception('Failed to load data');
    }
  }

  List groupByTeam(List<dynamic> jsonList) {
    final groupedData = <String, Map<String, dynamic>>{};

    for (final item in jsonList) {
      final teamId = int.tryParse(item['techquest_id'] ?? '0');
      final uniqueEvent = item['Events'];

      if (teamId == 0 || teamId == null) {
        continue;
      }

      if (groupedData.containsKey('${teamId.toString()}:$uniqueEvent') &&
          item["Participate"] == "Yes") {
        List mems = groupedData['${teamId.toString()}:$uniqueEvent']!['Member'];
        mems.add(item['Member']);
        groupedData['${teamId.toString()}:$uniqueEvent'] = {
          'id': item['id'],
          'techquest_id': teamId.toString(),
          'TeamName': item['TeamName'],
          'Events': item['Events'],
          'Mark': item['Mark'],
          'Participate': 'Yes',
          'Member': mems
        };
      } else if (item["Participate"] == "Yes") {
        groupedData['${teamId.toString()}:$uniqueEvent'] = {
          'id': item['id'],
          'techquest_id': teamId.toString(),
          'TeamName': item['TeamName'],
          'Events': item['Events'],
          'Mark': item['Mark'],
          'Participate': 'Yes',
          'Member': [item['Member']]
        };
      }
    }
    List result = [];

    for (var element in groupedData.values) {
      element['Member'] =
          element['Member'].toString().replaceAll('[', '').replaceAll(']', '');

      result.add(element);
    }
    result.sort((a, b) => int.parse(b['Mark']).compareTo(int.parse(a['Mark'])));
    if (kDebugMode) {
      print('sens $result');
    }
    return result;
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

  Future<void> cutomdia(String tittle, String content, String id) async {
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
                // sendPostRequest(id).whenComplete(() {
                //   Navigator.of(context).pop();
                //   setState(() {
                //     Apicall();
                //     GetStudent();
                //   });
                // });
              },
            ),
            TextButton(
              child: Text(
                'CANCEL',
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

  @override
  void initState() {
    super.initState();
    Apicall();
  }

  Apicall() {
    if (dropdownvalue == 'Choose Event') {
      setState(() {
        studentsFuture = initializeData();
      });
    } else {
      setState(() {
        studentsFuture = SubmitEvent();
      });
    }
  }

  Future<List<arrival>> initializeData() async {
    try {
      List<arrival> students = await GetStudent();
      // if (kDebugMode) {
      //   for (var student in students) {
      //     print("Team Name: ${student.teamName}, Member: ${student.member}");
      //   }
      // }
      return students;
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      rethrow; // Rethrow the exception to propagate it
    }
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
                height: MediaQuery.of(context).size.height * .17,
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                      suffixIcon:
                                          Icon(Icons.more_vert_outlined),
                                      hoverColor:
                                          Color.fromARGB(255, 89, 90, 91),
                                      hintText: "search"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          // margin: const EdgeInsets.symmetric(vertical: 15),
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
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8.0, bottom: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownvalue,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.map((String items) {
                                      return DropdownMenuItem<String>(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                        Apicall();
                                      });
                                    },
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: MaterialButton(
                            color: const Color.fromARGB(255, 77, 45, 111),
                            onPressed: () async {
                              DateTime currentDate = DateTime.now();
                              var todaydate = currentDate.toUtc().toString();
                              final utcTimestamp = DateTime.parse(todaydate);
                              final formattedDate =
                                  DateFormat.yMMMd().format(utcTimestamp);
                              List<List<dynamic>> data = [];
                              final header = [
                                'TEAM ID',
                                'TEAM NAME',
                                'STUDENT NAME',
                                'EVENT',
                                'MARK'
                              ];
                              for (var element in searchstudent) {
                                List temp = [
                                  element['techquest_id'],
                                  element['TeamName'],
                                  element['Member'],
                                  element['Events'],
                                  element['Mark']
                                ];
                                data.add(temp);
                              }
                              final pdfFile = await PdfApi.generateTable(
                                  data, header, formattedDate);

                              // Open the saved PDF file
                              await PdfApi.openFile(pdfFile);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                "EXPORT PDF",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                  Apicall();
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
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                          // color: Colors.red,
                          height: MediaQuery.of(context).size.height * .70,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child:
                              SingleChildScrollView(child: buildDataTable())),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDataTable() {
    final columns = [
      // 'ID',
      'TEAM ID',
      'TEAM NAME',
      'STUDENT',
      'EVENT',
      'MARK'
    ];

    return FutureBuilder<List<arrival>>(
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
          return DataTable(
            // dataRowColor:
            //     MaterialStateColor.resolveWith((states) => Colors.lightGreen),
            columns: getColumns(columns),
            rows: getRows(snapshot.data!
                .where((element) => element.teamName
                    .toString()
                    .toLowerCase()
                    .contains(searchvalue.toLowerCase()))
                .toList()), // Pass the fetched data to getRows
          );
        }
      },
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows(List<arrival> users) => users.map(
        (arrival user) {
          final cells = [
            // user.id,
            user.techquestId,
            user.teamName,
            user.member,
            user.events,
            user.mark
          ];
          Color cellColor = user.participate!.toLowerCase() == 'no'
              ? Colors.red // Change this to the desired color
              : const Color.fromARGB(255, 10, 40, 141);
          return DataRow(
            cells: Utils.modelBuilder(cells, (index, cell) {
              final showEditIcon = index == 6;
              return DataCell(
                Text(
                  '$cell',
                  style: TextStyle(
                    color: cellColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                showEditIcon: showEditIcon,
                onTap: () async {
                  switch (index) {
                    case 4:
                      await editParticipate(user);
                      break;
                  }
                },
              );
            }),
          );
        },
      ).toList();

  editParticipate(arrival editUser) async {}
}
