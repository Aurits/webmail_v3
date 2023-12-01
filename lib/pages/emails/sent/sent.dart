import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../widgets/drawer.dart';

class Sent extends StatefulWidget {
  const Sent({super.key});

  @override
  State<Sent> createState() => _SentState();
}

class _SentState extends State<Sent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sent',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
        body: const Center(
          child: Text('Sent'),
        ));
  }
}
