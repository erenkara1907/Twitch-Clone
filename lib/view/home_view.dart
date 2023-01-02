import 'package:flutter/material.dart';
import 'package:twitch_app/utils/color.dart';
import 'package:twitch_app/view/feed_view.dart';
import 'package:twitch_app/view/go_live_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';
  const HomeView({Key? key}) : super(key: key);
  @override
// ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  List<Widget> pages = [
    const FeedView(),
    const GoLiveView(),
    const Center(child: Text('Browser')),
  ];

  onPageChange(int page) => setState(() {
        _page = page;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: primaryColor,
        backgroundColor: backgroundColor,
        onTap: onPageChange,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Following',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_rounded),
            label: 'Go Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.copy),
            label: 'Browser',
          ),
        ],
      ),
    );
  }
}
