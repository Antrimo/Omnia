import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omnia/Admin/admnavbar.dart';
import 'package:omnia/Screens/Signup/auth.dart';
import 'package:omnia/Screens/Signup/login.dart';
import 'package:omnia/Screens/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:omnia/Resources/elegantnotif.dart';


class WidgetTREEE extends StatefulWidget {
  const WidgetTREEE({super.key});

  @override
  State<WidgetTREEE> createState() => _WidgetTREEEState();
}

class _WidgetTREEEState extends State<WidgetTREEE> {
  User? user = Auth().currentUser;
  Elegantnotif ele = const Elegantnotif();

  // Function to check if the current user is an admin
  Future<bool> checkIfAdmin(String email) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('UserModel')
          .doc(email)
          .get();

      if (userDoc.exists) {
        // Check if the admin field exists and return its value
        return userDoc['admin'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any errors here
      if(mounted)
      {  
        ele.myElegantError(context, 'Error checking admin status: $e');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for auth state changes
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is logged in, check if they are an admin
          return FutureBuilder<bool>(
            future: checkIfAdmin(snapshot.data!.email!),
            builder: (context, adminSnapshot) {
              if (adminSnapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while waiting for the admin check
                return const Center(child: CircularProgressIndicator());
              } else if (adminSnapshot.hasData && adminSnapshot.data == true) {
                // If the user is an admin, show the admin navigation page
                return const AdminNav();
              } else {
                // If the user is not an admin, show the basic navigation page
                return const Nav();
              }
            },
          );
        } else {
          // User is not logged in, show the login page
          return const Login();
        }
      },
    );
  }
}
