import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutri_gabay_admin/models/doctor.dart';
import 'package:nutri_gabay_admin/views/shared/app_style.dart';
import 'package:nutri_gabay_admin/views/shared/custom_table.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  late Size screenSize;
  late List<Doctor> a;
  final Stream<QuerySnapshot> _doctorStream =
      FirebaseFirestore.instance.collection('doctor').snapshots();
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 50,
            width: double.infinity,
            color: customColor[70],
            alignment: Alignment.centerLeft,
            child: Text(
              'List of Nutritionist - Added',
              style: appstyle(
                25,
                Colors.black,
                FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _doctorStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Text('data');
              }

              return Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.01,
                          vertical: screenSize.height * 0.05),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.01,
                          vertical: screenSize.height * 0.03),
                      constraints:
                          BoxConstraints(minHeight: screenSize.height * 0.8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Column(
                        children: [
                          Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.11),
                              1: FractionColumnWidth(0.17),
                              2: FractionColumnWidth(0.17),
                              3: FractionColumnWidth(0.1),
                              4: FractionColumnWidth(0.11),
                              5: FractionColumnWidth(0.24),
                              6: FractionColumnWidth(0.1),
                            },
                            children: const [
                              TableRow(
                                children: [
                                  TableCellHeaderLabel(
                                      title: 'Specification', isCenter: false),
                                  TableCellHeaderLabel(
                                      title: 'Name', isCenter: false),
                                  TableCellHeaderLabel(
                                      title: 'Email Address', isCenter: false),
                                  TableCellHeaderLabel(
                                      title: 'Date of Birth', isCenter: false),
                                  TableCellHeaderLabel(
                                      title: 'Phone', isCenter: false),
                                  TableCellHeaderLabel(
                                      title: 'City', isCenter: false),
                                  TableCellHeaderLabel(
                                      title: 'Document', isCenter: true),
                                ],
                              ),
                            ],
                          ),
                          Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.11),
                              1: FractionColumnWidth(0.17),
                              2: FractionColumnWidth(0.17),
                              3: FractionColumnWidth(0.1),
                              4: FractionColumnWidth(0.11),
                              5: FractionColumnWidth(0.24),
                              6: FractionColumnWidth(0.1),
                            },
                            border: const TableBorder(
                              top: BorderSide(width: 1),
                              horizontalInside: BorderSide(width: 1),
                              bottom: BorderSide(width: 1),
                            ),
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return TableRow(children: [
                                    TableDetailLabel(
                                        title: data['specialization'],
                                        isCenter: false),
                                    TableDetailLabel(
                                        title: data['name'], isCenter: false),
                                    TableDetailLabel(
                                        title: data['email'], isCenter: false),
                                    TableDetailLabel(
                                        title: data['birthdate'],
                                        isCenter: false),
                                    TableDetailLabel(
                                        title: data['phone'], isCenter: false),
                                    TableDetailLabel(
                                        title: data['address'],
                                        isCenter: false),
                                    TableCell(
                                      child: Container(
                                        height: 40,
                                        alignment: Alignment.center,
                                        child: data['file'] != ''
                                            ? IconButton(
                                                onPressed: () {
                                                  js.context.callMethod(
                                                      'open', [data['file']]);
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons.filePdf,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : const Text(''),
                                      ),
                                    ),
                                  ]);
                                })
                                .toList()
                                .cast(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
