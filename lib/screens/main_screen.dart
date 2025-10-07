import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
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

  final List<String> _titles = <String>["Popüler Şarkılar", "Ara", "Favoriler"];

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: Stack(
        children: <Widget>[
          _screens[_currentIndex],
          const Align(alignment: Alignment.bottomCenter, child: MiniPlayer()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (final int index) => setState(() => _currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ara"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoriler",
          ),
        ],
      ),
    );
  }
}
