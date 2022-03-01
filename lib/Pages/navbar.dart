import 'package:e_com/Model/cart_model.dart';
import 'package:e_com/Pages/cart_page.dart';
import 'package:e_com/Pages/showcategories.dart';
import 'package:e_com/core/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:e_com/widget/color.dart';

import 'Homepage.dart';
import 'deals.dart';
import 'more_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key key, String type}) : super(key: key);

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;
  int currentTab = 0;
  final List<Widget> _children = [
    Carousel_Page(),
    // Categoriesscreen(),
    // PromotionScreen(),
    // AccountScreen()
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
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
            padding: EdgeInsets.only(top: 6),
            color: Colors.white,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = Carousel_Page();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            color: currentTab == 0
                                ? scaffoldcolor
                                : Colors.black87,
                            size: 30,
                          ),
                          Container(
                            child: Text(
                              'Home',
                              style: TextStyle(
                                  color: currentTab == 0
                                      ? scaffoldcolor
                                      : Colors.black87,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = CategoryScreen();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: 30,
                          ),
                          Text(
                            'Categories',
                            style: TextStyle(
                                color: currentTab == 1
                                    ? Colors.black87
                                    : Colors.black87,
                                fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = DealsScreen();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        children: [
                          Image(
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/tag.png')),
                          // Icon(
                          //   Icons.details,
                          //   color: currentTab == 2
                          //       ? scaffoldcolor
                          //       : Colors.black87,
                          //   size: 30,
                          // ),
                          Container(
                            child: Text(
                              'Deals',
                              style: TextStyle(
                                  color: currentTab == 2
                                      ? scaffoldcolor
                                      : Colors.black87,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                VxBuilder(
                  mutations: {AddMutation, RemoveMutation},
                  builder: (ctx, _) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //      VxBuilder(builder: (ctx,_), mutations: AddMutation,RemoveMutation){}
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width / 10,
                        onPressed: () {
                          setState(() {
                            currentScreen = CartPage(location: '1');
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.cart,
                              color: currentTab == 3
                                  ? scaffoldcolor
                                  : Colors.black87,
                              size: 30,
                            ),
                            Container(
                              child: Text(
                                'Cart',
                                style: TextStyle(
                                    color: currentTab == 3
                                        ? scaffoldcolor
                                        : Colors.black87,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ).badge(
                      color: Vx.gray500,
                      size: 22,
                      count: _cart.items.length,
                      textStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                // //      VxBuilder(builder: (ctx,_), mutations: AddMutation,RemoveMutation){}
                //       MaterialButton(
                //         minWidth: MediaQuery.of(context).size.width / 10,
                //         onPressed: () {
                //           setState(() {
                //             currentScreen = CartPage(location: '1');
                //             currentTab = 3;
                //           });
                //         },
                //         child: Column(
                //           children: [
                //             Icon(
                //               CupertinoIcons.cart,
                //               color: currentTab == 3
                //                   ? scaffoldcolor
                //                   : Colors.black87,
                //               size: 30,
                //             ),
                //             Container(
                //               child: Text(
                //                 'Cart',
                //                 style: TextStyle(
                //                     color: currentTab == 3
                //                         ? scaffoldcolor
                //                         : Colors.black87,
                //                     fontSize: 12),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = MoreScreen();
                          currentTab = 4;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.menu,
                            color: currentTab == 4
                                ? scaffoldcolor
                                : Colors.black87,
                            size: 30,
                          ),
                          Container(
                            child: Text(
                              'More',
                              style: TextStyle(
                                  color: currentTab == 4
                                      ? scaffoldcolor
                                      : Colors.black87,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
