import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String patientToJson(Admin data) => json.encode(data.toJson());

class Admin {
  final String uid;
  final String email;
  final String username;
  final String name;

  Admin({
    required this.uid,
    required this.email,
    required this.username,
    required this.name,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        uid: json["uid"],
        email: json["email"],
        username: json["username"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "username": username, "name": name};

  factory Admin.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Admin(
      uid: data?["uid"],
      email: data?["email"],
      username: data?["username"],
      name: data?["name"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {"uid": uid, "email": email, "username": username, "name": name};
  }
}
