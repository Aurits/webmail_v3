// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webmail/pages/emails/skelton.dart';

import '../../adapters/email_adapter.dart';
import '../../models/mail.dart';
import '../../models/user.dart';
import '../../widgets/drawer.dart';
import 'email_detail_page.dart';

class EmailsPage extends StatefulWidget {
  const EmailsPage({super.key});

  @override
  State<EmailsPage> createState() => _EmailsPageState();
}

class _EmailsPageState extends State<EmailsPage>
    with SingleTickerProviderStateMixin {
  List<Mail> emails = [];

  bool loading = true;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _loadEmails();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {});
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  // Function to load emails
  Future<void> _loadEmails() async {
    // Simulating an asynchronous call to fetch emails
    await Future.delayed(const Duration(seconds: 1));

    List<Mail> fetchedEmails = await Mail.getItems();
    setState(() {
      emails = fetchedEmails;
      //reverse the emails so that the latest email is at the top
      emails = emails.reversed.toList();
      if (emails.isNotEmpty) {
        loading = false;
      }
    });
  }

  // Function to handle pull-to-refresh
  Future<void> _handleRefresh() async {
    setState(() {
      loading = true;
    });

    await _loadEmails();
    setState(() {
      if (emails.isNotEmpty) {
        loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      //floating
      floatingActionButton: Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          heroTag: "fab1",
          backgroundColor: Colors.green[500],
          onPressed: () {
            print("Pressed");
          },
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/compose');
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            width: double.infinity,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  //display the number of emails
                  "All mails (${emails.length})",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: <Widget>[
                    //filter icon

                    IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        print("Pressed");
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        print("Pressed");
                        _handleRefresh();
                      },
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        print("Pressed");
                        Mail.deleteEmails();
                        //delete user
                        User.deleteUser();
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 10),
          loading
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  )),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(width: 260),
                                  SizedBox(height: 4),
                                  Skeleton(width: 190, height: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  )),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(width: 260),
                                  SizedBox(height: 4),
                                  Skeleton(width: 190, height: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  )),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(width: 260),
                                  SizedBox(height: 4),
                                  Skeleton(width: 190, height: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  )),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(width: 260),
                                  SizedBox(height: 4),
                                  Skeleton(width: 190, height: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  )),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(width: 260),
                                  SizedBox(height: 4),
                                  Skeleton(width: 190, height: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  )),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(width: 260),
                                  SizedBox(height: 4),
                                  Skeleton(width: 190, height: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  )),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(width: 260),
                                  SizedBox(height: 4),
                                  Skeleton(width: 190, height: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: EmailAdapter(emails, (index, mail) {
                      // Handle the click event, if needed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmailDetailPage(email: emails[index]),
                        ),
                      );
                    }).getView(),
                  ),
                ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(0),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: TabBar(
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 1,
                tabs: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Tab(
                      icon: InkWell(
                        onTap: () {
                          showBottonSheet();
                        },
                        child: Icon(
                          Icons.apps,
                          color: Colors.green[600],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Tab(
                      icon: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.green[600],
                        ),
                      ),
                    ),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottonSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.inbox,
                    color: Colors.green,
                  ),
                  title: const Text(
                    'Inbox',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/emails');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  title: const Text(
                    'Starred',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/starred');
                  },
                ),
                ListTile(
                    leading: const Icon(
                      Icons.send,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Sent',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/sent');
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.drafts,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Drafts',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/drafts');
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Trash',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/trash');
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.archive,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Archive',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/archive');
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    }),
              ],
            ),
          );
        });
  }
}
