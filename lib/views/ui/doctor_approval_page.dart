import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutri_gabay_admin/services/baseauth.dart';
import 'package:nutri_gabay_admin/views/shared/app_style.dart';
import 'package:nutri_gabay_admin/views/shared/custom_table.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DoctorApprovalPage extends StatefulWidget {
  const DoctorApprovalPage({super.key});

  @override
  State<DoctorApprovalPage> createState() => _DoctorApprovalPageState();
}

class _DoctorApprovalPageState extends State<DoctorApprovalPage> {
  late Size screenSize;
  final Stream<QuerySnapshot> _doctorStream = FirebaseFirestore.instance
      .collection('doctor')
      .where("status", isEqualTo: "Pending")
      .snapshots();

  showAlertDialog(BuildContext context, String nutritionistId, int method,
      String email, String password) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: appstyle(14, Colors.black, FontWeight.normal),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        method == 0 ? "Decline" : "Approve",
        style: appstyle(
            14, method == 0 ? Colors.red : Colors.green, FontWeight.bold),
      ),
      onPressed: () async {
        if (method == 0) {
          await deleteNutritionist(nutritionistId).whenComplete(() {
            Navigator.of(context).pop();
            setState(() {});
          });
        } else {
          await approveNutritionist(nutritionistId, email, password)
              .whenComplete(() {
            Navigator.of(context).pop();
            setState(() {});
          });
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirmation",
        style: appstyle(15, Colors.black, FontWeight.bold),
      ),
      content: Text(
        "Are you sure you want to ${method == 0 ? "decline" : "approve"} this registration?",
        style: appstyle(13, Colors.black, FontWeight.normal),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> deleteNutritionist(String nutritionistId) async {
    final docUser =
        FirebaseFirestore.instance.collection('doctor').doc(nutritionistId);
    await docUser.delete();
  }

  Future<void> approveNutritionist(
      String nutritionistId, String email, String password) async {
    final docUser =
        FirebaseFirestore.instance.collection('doctor').doc(nutritionistId);
    await docUser.update({"status": "Approve"});

    await FireBaseAuth().signUpWithEmailAndPassword(email, password);
  }

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
              'Nutritionist Approval',
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
                return const Text('No Records');
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
                              1: FractionColumnWidth(0.15),
                              2: FractionColumnWidth(0.15),
                              3: FractionColumnWidth(0.1),
                              4: FractionColumnWidth(0.11),
                              5: FractionColumnWidth(0.2),
                              6: FractionColumnWidth(0.1),
                              7: FractionColumnWidth(0.08),
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
                                  TableCellHeaderLabel(
                                      title: 'Delete', isCenter: true),
                                ],
                              ),
                            ],
                          ),
                          Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.11),
                              1: FractionColumnWidth(0.15),
                              2: FractionColumnWidth(0.15),
                              3: FractionColumnWidth(0.1),
                              4: FractionColumnWidth(0.11),
                              5: FractionColumnWidth(0.2),
                              7: FractionColumnWidth(0.08),
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
                                                  launchUrlString(data['file']);
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons.filePdf,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : const Text(''),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        height: 40,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showAlertDialog(
                                                    context,
                                                    data['uid'],
                                                    0,
                                                    data['email'],
                                                    data['password']);
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.xmark,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            IconButton(
                                              onPressed: () {
                                                showAlertDialog(
                                                    context,
                                                    data['uid'],
                                                    1,
                                                    data['email'],
                                                    data['password']);
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.check,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
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
