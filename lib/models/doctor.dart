import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Doctor dotorFromJson(String str) => Doctor.fromJson(json.decode(str));

String dotorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String birthdate;
  final String address;
  final String image;

  Doctor({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.address,
    required this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        birthdate: json["birthdate"],
        address: json["address"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "birthdate": birthdate,
        "address": address,
        "image": image
      };

  factory Doctor.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Doctor(
      uid: data?["uid"],
      name: data?["name"],
      email: data?["email"],
      phone: data?["phone"],
      birthdate: data?["birthdate"],
      address: data?["address"],
      image: data?["image"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
      "birthdate": birthdate,
      "address": address,
      "image": image
    };
  }
}
