import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarkData extends StatefulWidget {
  const MarkData({super.key});

  @override
  State<MarkData> createState() => _MarkDataState();
}

class _MarkDataState extends State<MarkData> {
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
                                        // Apicall();
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
                            onPressed: () {
                              // setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                "DOWNLOAD",
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
                                  // Apicall();
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
                        child: SingleChildScrollView(child: Container()),
                      ),
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
}
