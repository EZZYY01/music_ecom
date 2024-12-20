import 'package:flutter/material.dart';
import 'package:music_ecom/view/Profile_view.dart';
import 'package:music_ecom/view/home_view.dart';
import 'package:music_ecom/view/rent_view.dart';
import 'package:music_ecom/view/wishlist_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(), // Create a HomeView widget for your main dashboard
    const RentView(),
    const WishlistView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/images/logo.png', height: 40, width: 40),
        ),
        title: const Text("Welcome User,"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Rent",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Liked",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
