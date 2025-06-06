import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omnia/Resources/Theme/theme.dart';
import 'package:omnia/Resources/elegantnotif.dart';

class ReportBug extends StatefulWidget {
  const ReportBug({super.key});

  @override
  State<ReportBug> createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  late TextEditingController _titleController;
  late TextEditingController _bugController;
  String? email;
  String? username;
  final User? user = FirebaseAuth.instance.currentUser;
  Elegantnotif notif = const Elegantnotif();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bugController = TextEditingController();
    _fetchUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bugController.dispose();
  }

  Future<void> _fetchUserData() async {
    if (user == null) {
      return;
    }

    email = user!.email;

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('UserModel').doc(email).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (mounted) {
          setState(() {
            username = userData['name'] ?? 'Name';
            email = userData['email'] ?? 'email unidentified';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        notif.myElegantError(context, "Failed to fetch user data: $e");
      }
    }
  }

  Future<void> _report() async {
    if (user == null) {
      if (mounted) {
        notif.myElegantError(context, "User not logged in");
      }
      return;
    }

    final email = user!.email;
    if (email == null) {
      if (mounted) {
        notif.myElegantError(context, "User email not found");
      }
      return;
    }

    try {
      final bugData = {
        'title': _titleController.text,
        'bug': _bugController.text,
        'reported_by': username,
        'email': email,
      };

      await FirebaseFirestore.instance.collection('BugReports').add(bugData);

      if (mounted) {
        notif.myElegantSuccess(context, "Bug reported Successfully. Thank You.");
        await Future.delayed(const Duration(seconds: 1));
        if(mounted){
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        notif.myElegantError(context, "Failed to Report Bug: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: const Text(
          "Report a Bug",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            const SizedBox(height: 16),
            _buildTextField(_titleController, 'Title'),
            const SizedBox(height: 16),
            _buildTextField(_bugController, 'Bug Description', maxLines: 4),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _report,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: itemColor,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Report'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: itemColor),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: navColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
