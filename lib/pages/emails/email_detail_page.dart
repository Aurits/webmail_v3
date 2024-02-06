// ignore_for_file: avoid_print, must_be_immutable

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webmail/utils/database.dart';

import '../../models/mail.dart';
import '../../widgets/drawer.dart';

class EmailDetailPage extends StatefulWidget {
  final Mail email;
  const EmailDetailPage({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailDetailPage> createState() => _EmailDetailPageState();
}

class _EmailDetailPageState extends State<EmailDetailPage> {
  // Add a variable to track the expansion state
  bool isExpanded = false;

  late String username = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    Database db = await Utils.init();
    List<Map<String, dynamic>> user = await db.query('usersTable');

    if (user.isNotEmpty) {
      setState(() {
        username = user[0]['username'];
      });
    } else {
      setState(() {
        username = 'No user found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Email',
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
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.archive),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mail_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              iconColor: Colors.green,
              shape: Border.all(color: Colors.white), // Set the green border
              collapsedIconColor: Colors.red,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              title: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      backgroundColor: _getAvatarColor(widget.email.replyTo),
                      child: Text(
                        widget.email.replyTo.isNotEmpty
                            ? widget.email.replyTo[0].toUpperCase()
                            : '?', // Display '?' if replyTo is empty
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    child: Text(
                      extractNameFromEmail(widget.email.replyTo),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black), // Set the green border
                    borderRadius: BorderRadius.circular(
                        16.0), // Optional: Set border radius
                  ),
                  padding: const EdgeInsets.all(12.0), // Optional: Set padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'From: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: extractEmail(widget.email.replyTo),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'To: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: username,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Date: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.email.date},',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                // Handle expansion state if needed
              },
            ),
            const SizedBox(height: 26),
            Center(
              child: Text(
                widget.email.subject,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14),
            HtmlWidget(
                // the first parameter (`html`) is required

                // widget.email.message,

                'dshfgd'

                // all other parameters are optional, a few notable params:

                // specify custom styling for an element
                // see supported inline styling below
                // customStylesBuilder: (element) {
                //   if (element.classes.contains('foo')) {
                //     return {'color': 'red'};
                //   }

                //   return null;
                // },

                // customWidgetBuilder: (element) {
                //   if (element.attributes['foo'] == 'bar') {
                //     // render a custom block widget that takes the full width
                //     return Container();
                //   }

                //   if (element.attributes['fizz'] == 'buzz') {
                //     // render a custom widget inline with surrounding text
                //     return InlineCustomWidget(
                //       child: Container(),
                //     );
                //   }

                //   return null;
                // },

                // // this callback will be triggered when user taps a link
                // onTapUrl: (url) {
                //   print('tapped url');
                //   return true;
                // },

                // // select the render mode for HTML body
                // // by default, a simple `Column` is rendered
                // // consider using `ListView` or `SliverList` for better performance
                // renderMode: RenderMode.column,

                // set the default styling for text
                //   textStyle: const TextStyle(fontSize: 14),
                ),
            const SizedBox(height: 16),
            if (widget.email.attachments.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attachments:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.email.attachments),
                ],
              ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.grey[200],
              child: Text(
                'This email is brought to you by Makerere Webmail',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(String text) {
    // A simple function to generate a color based on the text
    // You can replace this logic with your own color generation algorithm
    int hash = 0;
    for (int i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final int finalHash = hash & 0xFFFFFF;
    return Color(finalHash).withOpacity(1.0);
  }

  String extractEmail(String content) {
    RegExp emailRegex = RegExp(r'<([^>]+)>');
    Match? match = emailRegex.firstMatch(content);
    if (match != null) {
      return match.group(1) ??
          ''; // Provide a default value if match.group(1) is null
    } else {
      return '';
    }
  }

  String extractNameFromEmail(String email) {
    int index = email.indexOf('<');
    if (index != -1) {
      return email.substring(0, index).trim();
    } else {
      return email;
    }
  }
}
