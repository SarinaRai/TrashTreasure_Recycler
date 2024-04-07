import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtreasure_recycler/pages/side_pages/profile.dart';
import 'package:trashtreasure_recycler/seller_authentication/login_page.dart';

import '../static/static_shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = "";
  @override
  void initState() {
    getToken();
    super.initState();
  }

  void getToken() async {
    final SharedPreferences prefs =
        await UserStoragePreferences.getPreferences();

    token = prefs.getString('token')!;
    setState(() {
      token = token;
    });
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 62, 33),
        actions: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60, 10, 0, 10),
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12.0)),
                  onTap: () {
                    controller.openView();
                  },
                  leading: const Row(children: [
                    Text('Search'),
                    Padding(
                      padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  return ListTile(
                    title: const Text(''),
                    onTap: () {},
                  );
                });
              }),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white70,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ]),
          ),
        ],
      ),
      drawer: Builder(builder: (context) {
        return Drawer(
          child: ListView(children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "TrashTreasure for User",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 2, 62, 33),
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.verified_user_sharp),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              title: Text(
                'setting',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.logout),
              onTap: () async {
                final SharedPreferences prefs =
                    await UserStoragePreferences.getPreferences();

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'TrashTreasure',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 2, 62, 33))),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 2, 62, 33))),
                        onPressed: () {
                          prefs.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            )
          ]),
        );
      }),
      body: SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}
