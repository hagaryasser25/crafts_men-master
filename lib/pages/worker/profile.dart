import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class profile extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      print(user.email);
      int retryCount = 0;
      int maxRetries = 5;
      Duration delay = Duration(milliseconds: 500);
      try {
        // print("UID" + user.email);
        await _firestore.collection('craftsMen').where(
            "email",
            isEqualTo: user.email.toString()
        ).get().then((event) {
          if (event.docs.isNotEmpty) {
            return event.docs.single.data; //if it is a single document
          }
        }).catchError((e) => print("error fetching data: $e"));
        return {};
      } catch (e) {
        if (e is FirebaseException && e.code == 'unavailable') {
          retryCount++;
          if (retryCount >= maxRetries) {
            throw Exception('Service unavailable after multiple retries.');
          }
          await Future.delayed(delay);
          delay *= 2; // Exponential backoff
        } else {
          throw e; // Re-throw other exceptions
        }
      }
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            var userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${userData['name'] ?? 'N/A'}'),
                  SizedBox(height: 8),
                  Text('Email: ${userData['email'] ?? 'N/A'}'),
                  SizedBox(height: 8),
                  Text('Phone: ${userData['phone'] ?? 'N/A'}'),
                  // Add more fields as necessary
                ],
              ),
            );
          }
        },
      ),
    );
  }
}