// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/mail.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../widgets/drawer.dart';

class EmailDetailPage extends StatelessWidget {
  final Mail email;
  // Add a variable to track the expansion state
  bool isExpanded = false;

  EmailDetailPage({Key? key, required this.email}) : super(key: key);

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
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
            ),
            Text(
              email.subject,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            //an outline button to show inbox
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Back to Inbox',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            ExpansionTile(
              title: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      backgroundColor: _getAvatarColor(email.replyTo),
                      child: Text(
                        email.replyTo.isNotEmpty
                            ? email.replyTo[0].toUpperCase()
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
                      email.replyTo,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
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
                        Border.all(color: Colors.green), // Set the green border
                    borderRadius: BorderRadius.circular(
                        8.0), // Optional: Set border radius
                  ),
                  padding: const EdgeInsets.all(8.0), // Optional: Set padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'From: ${email.replyTo}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'To: ${email.receiver}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Reply-To: ${email.replyTo}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date: ${email.date}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                // Handle expansion state if needed
              },
            ),
            const SizedBox(height: 16),
            HtmlWidget(
              // the first parameter (`html`) is required
              email.message,

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
            if (email.attachments.isNotEmpty)
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
                  Text(email.attachments),
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
}
