import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final List<Widget> pages;
  final int initialPage;

  const BottomNavBar({required this.pages, this.initialPage = 0, Key? key})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 40,
            color: Colors.white,
          ),
          Icon(Icons.search, size: 35, color: Colors.white),
          Icon(
            Icons.event_available,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            Icons.bookmark,
            size: 35,
            color: Colors.white,
          ),
          Icon(Icons.person, size: 35, color: Colors.white),
        ],
        color: const Color.fromARGB(255, 222, 220, 220),
        backgroundColor: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        height: 56.0,
        index: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        letIndexChange: (index) => true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
          // Change the selected icon in the CurvedNavigationBar
          _bottomNavigationKey.currentState?.setPage(index);
        },
        children: widget.pages,
      ),
    );
  }
}
