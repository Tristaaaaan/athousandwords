import 'package:athousandwords/features/home/home.dart';
import 'package:athousandwords/features/story/presentation/screen/story_screen.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/navbar/custom_navbar.dart';
import '../../bookmarks/presentation/screen/bookmark_screen.dart';
import '../../profile/presentation/screen/profile_screen.dart';

class NavigationGate extends StatefulWidget {
  const NavigationGate({super.key});

  @override
  State<NavigationGate> createState() => _NavigationGateState();
}

class _NavigationGateState extends State<NavigationGate> {
  int _selectedIndex = 0;
  bool _isHolding = false;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleScrollDirection(bool isScrollingDown) {
    setState(() {
      _isHolding = isScrollingDown;
    });
  }

  List<Widget> get _screens => [
    const HomeScreen(),
    StoryScreen(onScrollDirectionChanged: _handleScrollDirection),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // main screen
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _screens[_selectedIndex],
          ),

          // bottom nav bar
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: _isHolding ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: _isHolding,
                child: CustomBottomNavBar(
                  currentIndex: _selectedIndex,
                  onTap: _onTabSelected,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
