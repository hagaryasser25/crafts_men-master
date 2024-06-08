import 'package:firebase_database/firebase_database.dart';

class Mens {
  String? email;
  String? uid;
  String? phoneNumber;
  String? fullName;
  String? password;
  String? governate;
  String? address;
  String? id;
  String? imageUrl;
  int? rating;

  Mens(
      {this.email,
      this.uid,
      this.phoneNumber,
      this.fullName,
      this.password,
      this.governate,
      this.address,
      this.id,
      this.imageUrl,
      this.rating});

  Mens.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot.child("uid").value.toString());
    email = (dataSnapshot.child("email").value.toString());
    fullName = (dataSnapshot.child("name").value.toString());
    phoneNumber = (dataSnapshot.child("phoneNumber").value.toString());
    password = (dataSnapshot.child("password").value.toString());
    governate = (dataSnapshot.child("governate").value.toString());
    address = (dataSnapshot.child("address").value.toString());
    id = (dataSnapshot.child("id").value.toString());
    imageUrl = (dataSnapshot.child("imageUrl").value.toString());
    rating = (dataSnapshot.child("rating").value) as int?;
  }
}
