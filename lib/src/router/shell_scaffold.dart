import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// https://medium.com/@antonio.tioypedro1234/flutter-go-router-the-essential-guide-349ef39ec5b3
class ShellScaffold extends StatelessWidget {
  const ShellScaffold({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _onTapItem(context, index),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 1 ? Icons.person : Icons.person_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 2 ? Icons.person : Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: navigationShell,
    );
  }

  void _onTapItem(BuildContext context, int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }
}
