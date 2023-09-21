import 'package:flutter/material.dart';
import 'package:nutri_gabay_admin/views/shared/app_style.dart';

class TableCellHeaderLabel extends StatelessWidget {
  final String title;
  final bool isCenter;
  const TableCellHeaderLabel(
      {super.key, required this.title, required this.isCenter});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        title,
        style: appstyle(13, Colors.black, FontWeight.w500),
        textAlign: isCenter ? TextAlign.center : TextAlign.left,
      ),
    );
  }
}

class TableDetailLabel extends StatelessWidget {
  final String title;
  final bool isCenter;
  const TableDetailLabel(
      {super.key, required this.title, required this.isCenter});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        height: 40,
        alignment: isCenter ? Alignment.center : Alignment.centerLeft,
        child: Text(
          title,
          style: appstyle(13, Colors.black, FontWeight.w500),
        ),
      ),
    );
  }
}
