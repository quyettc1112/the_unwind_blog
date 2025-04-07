import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavWithSlide extends StatefulWidget {
  @override
  _BottomNavWithSlideState createState() => _BottomNavWithSlideState();
}

class _BottomNavWithSlideState extends State<BottomNavWithSlide> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  // Danh sách các widget sẽ hiển thị khi người dùng chọn tab
  final List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Home Screen')),
    Center(child: Text('Favourite Screen')),
    Center(child: Text('Trip Screen')),
    Center(child: Text('Notification Screen')),
    Center(child: Text('Profile Screen')),
  ];

  // Hàm thay đổi mục và điều hướng page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Navigation with Slide')),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _widgetOptions,
        physics: NeverScrollableScrollPhysics(),  // Không cho phép vuốt trực tiếp
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,  // Mục hiện tại
        onTap: _onItemTapped,  // Khi bấm vào một mục, chuyển sang trang tương ứng
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}