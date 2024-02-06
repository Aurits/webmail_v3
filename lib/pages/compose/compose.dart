// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/database.dart';
import '../../widgets/drawer.dart';

class ComposeEmail extends StatefulWidget {
  const ComposeEmail({super.key});

  @override
  State<ComposeEmail> createState() => _ComposeEmailState();
}

class _ComposeEmailState extends State<ComposeEmail> {
  // Define controllers for text fields
  final TextEditingController toController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    toController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  late String username = "";
  late String password = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    Database db = await Utils.init();
    List<Map<String, dynamic>> user = await db.query('usersTable');

    if (user.isNotEmpty) {
      setState(() {
        username = user[0]['username'];
        password = user[0]['password'];
      });
    } else {
      setState(() {
        username = 'No user found';
        password = 'No password found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Compose',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'To',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color as needed
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: toController, // Assign controller
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  label: Text('Enter email address'),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Subject',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color as needed
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: subjectController, // Assign controller
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  label: Text('Enter subject'),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Message',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color as needed
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: messageController, // Assign controller
                style: const TextStyle(fontSize: 16),
                maxLines: 7,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  label: Text('Enter message'),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Change button color
                    ),
                    child: const Text(
                      'Save draft',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Validate fields
                      if (_validateFields()) {
                        // Create a Dio instance
                        Dio dio = Dio();
                        try {
                          // Send the POST request
                          Response response = await dio.get(
                            'https://webmail-40d593e3-df80-433a-9a97.cranecloud.io/api/send-email', // Replace with your API endpoint
                            data: {
                              "to": toController.text,
                              "subject": subjectController.text,
                              "message": messageController.text,
                              "from_email": username,
                              "from_name": username,
                              "smtp_username": username,
                              "smtp_password": password,
                            },
                            options: Options(
                              headers: {
                                'Content-Type': 'application/json',
                                'Accept': '*/*',
                              },
                            ),
                          );

                          // Check if the request was successful
                          if (response.statusCode == 200) {
                            // Handle success
                            print('Email sent successfully');
                            // Clear text fields
                            toController.clear();
                            subjectController.clear();
                            messageController.clear();
                            // Display toast message

                            Fluttertoast.showToast(
                                msg: "This is Center Short Toast",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            // Handle other status codes
                            print('Failed to send email');
                          }
                        } catch (e) {
                          // Handle errors
                          print('Error: $e');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Change button color
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to validate fields
  bool _validateFields() {
    if (toController.text.isEmpty ||
        subjectController.text.isEmpty ||
        messageController.text.isEmpty) {
      // Display error message or toast indicating required fields
      return false;
    }
    return true;
  }
}
