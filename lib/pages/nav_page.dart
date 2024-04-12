import 'package:flutter/material.dart';

import 'package:trashtreasure_recycler/pages/add_product.dart';
import 'package:trashtreasure_recycler/pages/chat.dart';
import 'package:trashtreasure_recycler/pages/home_page.dart';
import 'package:trashtreasure_recycler/pages/product_page.dart';

import 'package:trashtreasure_recycler/pages/trash_page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    ProductPage(),
    ChatPage(),
    TrashSellPage(),
    AddProduct(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 2, 62, 33),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProduct(),
                ));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 2, 62, 33),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Colors.black : Colors.white70,
                        ),
                        Text('Home',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.black
                                  : Colors.white70,
                              fontSize: 15,
                            ))
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = TrashSellPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color:
                              currentTab == 1 ? Colors.black : Colors.white70,
                        ),
                        Text('Trash',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.black
                                  : Colors.white70,
                              fontSize: 15,
                            ))
                      ],
                    ),
                  )
                ],
              ),
              //right bottomnavbar
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProductPage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color:
                              currentTab == 2 ? Colors.black : Colors.white70,
                        ),
                        Text('Product',
                            style: TextStyle(
                              color: currentTab == 2
                                  ? Colors.black
                                  : Colors.white70,
                              fontSize: 15,
                            ))
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ChatPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color:
                              currentTab == 3 ? Colors.black : Colors.white70,
                        ),
                        Text('chat',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.black
                                  : Colors.white70,
                              fontSize: 15,
                            ))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
