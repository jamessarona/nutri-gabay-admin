import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutri_gabay_admin/views/shared/app_style.dart';
import 'package:nutri_gabay_admin/views/shared/dashboard_container.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int patientCount = 0;
  int nutritionistCount = 0;

  void getPatientCount() async {
    final collection = FirebaseFirestore.instance.collection('patient');

    await collection.get().then((querySnapshot) async {
      patientCount = querySnapshot.size;
    });
    setState(() {});
  }

  void getNutritionistCount() async {
    final collection = FirebaseFirestore.instance
        .collection('doctor')
        .where("status", isNotEqualTo: "Pending");

    await collection.get().then((querySnapshot) async {
      nutritionistCount = querySnapshot.size;
    });
    setState(() {});
  }

  @override
  void initState() {
    getPatientCount();
    getNutritionistCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              'Dashboard',
              style: appstyle(
                25,
                Colors.black,
                FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
                child: MediaQuery.of(context).size.width > 950
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DashBoardContainer(
                            title:
                                '${nutritionistCount.toString()} Nutritionist${nutritionistCount != 1 ? 's' : ''}',
                            icon: FontAwesomeIcons.userDoctor,
                          ),
                          DashBoardContainer(
                            title:
                                '${patientCount.toString()} Patient${patientCount != 1 ? 's' : ''}',
                            icon: FontAwesomeIcons.userInjured,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DashBoardContainer(
                            title:
                                '${nutritionistCount.toString()} Nutritionist${nutritionistCount != 1 ? 's' : ''}',
                            icon: FontAwesomeIcons.userDoctor,
                          ),
                          DashBoardContainer(
                            title:
                                '${patientCount.toString()} Patient${patientCount != 1 ? 's' : ''}',
                            icon: FontAwesomeIcons.userInjured,
                          ),
                        ],
                      )),
          ),
        ],
      ),
    );
  }
}
