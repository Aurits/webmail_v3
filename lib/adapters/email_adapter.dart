import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webmail/utils/database.dart';

import '../models/mail.dart';

class EmailAdapter {
  List? emails = <Mail>[];
  List itemsTile = <ItemTile>[];

  EmailAdapter(this.emails, onItemClick) {
    for (int i = 0; i < emails!.length; i++) {
      itemsTile
          .add(ItemTile(index: i, object: emails![i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return ListView.builder(
      itemCount: itemsTile.length,
      itemBuilder: (BuildContext context, int index) {
        return itemsTile[index];
      },
      padding: const EdgeInsets.symmetric(vertical: 1),
    );
  }
}

class ItemTile extends StatefulWidget {
  final int index;
  final Mail object;
  final Function(int, Mail) onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    Color avatarColor = _getAvatarColor(widget.object.replyTo);
    Color textColor = Colors.black; // Default text color

    if (widget.object.status == "seen") {
      // Reduce opacity for seen emails
      avatarColor = avatarColor.withOpacity(0.5);
      textColor = textColor.withOpacity(0.5);
    }

    return InkWell(
      onTap: () {
        // Update status to "seen" when clicked
        widget.object.status = "seen";
        // Update status in local database
        _updateStatusInDatabase(widget.object);
        // Call the onClick function to handle the click event
        widget.onClick(widget.index, widget.object);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 5,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                backgroundColor: avatarColor,
                child: Text(
                  widget.object.replyTo.isNotEmpty
                      ? widget.object.replyTo[0].toUpperCase()
                      : '?', // Display '?' if replyTo is empty
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      widget.object.replyTo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      widget.object.subject,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: textColor,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _getFormattedDate(widget.object.date),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          const Icon(
                            Icons.star_border,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                  ),
                  Divider(
                    height: 0,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to update status in local database
  Future<void> _updateStatusInDatabase(Mail mail) async {
    // Open the database
    Database db = await Utils.init();
    // Update the status in the database
    await db.update(
      'emailTable',
      {'status': 'seen'},
      where: 'id = ?',
      whereArgs: [mail.id],
    );
  }

  // Function to get formatted date
  String _getFormattedDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat.MMMd().format(date); // Format: Month Day
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
