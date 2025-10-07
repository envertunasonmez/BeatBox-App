import 'package:beatbox_app/screens/favorites_screen.dart';
import 'package:beatbox_app/screens/home_screen.dart';
import 'package:beatbox_app/screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/mini_player.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const <Widget>[
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _screens[_currentIndex],
          const Align(alignment: Alignment.bottomCenter, child: MiniPlayer()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1DB954),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (final int index) => setState(() => _currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "Your Library",
          ),
        ],
      ),
    );
  }
}
