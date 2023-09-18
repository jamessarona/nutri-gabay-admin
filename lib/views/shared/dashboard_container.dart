import 'package:flutter/material.dart';
import 'package:nutri_gabay_admin/views/shared/app_style.dart';

class DashBoardContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  const DashBoardContainer(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 130,
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: customColor[60],
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: appstyle(
                23,
                Colors.black,
                FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
