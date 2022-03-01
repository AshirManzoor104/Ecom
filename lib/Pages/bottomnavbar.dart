import 'package:e_com/widget/color.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class BottpmBar extends StatefulWidget {
  const BottpmBar({Key key}) : super(key: key);

  @override
  _BottpmBarState createState() => _BottpmBarState();
}

class _BottpmBarState extends State<BottpmBar> {
  int _selectedIndex = 0;
  int currentTab = 0;
  final List<Widget> _children = [
    Carousel_Page(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget currentScreen = Carousel_Page();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          // S.of(context).Home,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      // drawer: DrawerScreen(),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 60),
        height: 100,
        width: 100,
        child: FloatingActionButton(
          backgroundColor: Colors.red[700],
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 8, left: 8),
            child: Column(
              children: [
                Image(
                  height: 26,
                  image: AssetImage("assets/icons/medical ui-19.png"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    '',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                Container(
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
            color: scaffoldcolor,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Image(
                            height: 50,
                            width: 100,
                            image: AssetImage("assets/icons/medical ui-20.png"),
                          ),
                          Container(
                            child: Text(
                              'Home',
                              style: TextStyle(
                                  color: currentTab == 0
                                      ? Colors.white
                                      : Colors.white,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Image(
                            height: 50,
                            width: 100,
                            image: AssetImage("assets/icons/logo.png"),
                            // color: Colors.white,
                            // color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Account',
                            //"My Ayaan",
                            style: TextStyle(
                                color: currentTab == 1
                                    ? Colors.white
                                    : Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
