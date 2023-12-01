import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/drawer.dart';

class ComposeEmail extends StatefulWidget {
  const ComposeEmail({super.key});

  @override
  State<ComposeEmail> createState() => _ComposeEmailState();
}

class _ComposeEmailState extends State<ComposeEmail> {
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
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter recipient email address',
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
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter subject',
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
                style: const TextStyle(fontSize: 16),
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter message',
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Change button color
                    ),
                    child: const Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
