// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:techquest/models/arrival.dart';

import '../widgets/utils.dart';

class ArrivalData extends StatefulWidget {
  const ArrivalData({super.key});

  @override
  State<ArrivalData> createState() => _ArrivalDataState();
}

class _ArrivalDataState extends State<ArrivalData> {
  late Future<List<arrival>> studentsFuture;
  String searchvalue = "";
  Future<List<arrival>> GetStudent() async {
    try {
      var result = await http.get(
        Uri.parse('https://mzcet.in/techquest23/api/arrivaljson.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (result.statusCode == 200) {
        List<dynamic> student = jsonDecode(result.body);
        List<arrival> students =
            student.map((stu) => arrival.fromJson(stu)).toList();

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

  @override
  void initState() {
    super.initState();
    Apicall();
  }

  Apicall() {
    setState(() {
      studentsFuture = initializeData();
    });
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
    return Column(
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
                  color: const Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
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
                          cursorColor: const Color.fromARGB(255, 19, 21, 21),
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
                      setState(() {});
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
                        setState(() {});
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
                  color: const Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
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
                      child: SingleChildScrollView(child: buildDataTable())),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildDataTable() {
    final columns = ['ID', 'TEAM NAME', 'STUDENT', 'EVENT'];

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
          return DataTable(
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

  List<DataRow> getRows(List<arrival> users) => users.map((arrival user) {
        final cells = [
          user.techquestId,
          user.teamName,
          user.member,
          user.events
        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 3;

            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {},
            );
          }),
        );
      }).toList();
}
