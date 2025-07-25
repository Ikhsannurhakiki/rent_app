import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/screens/chat_list_screen.dart';

import '../provider/main_provider.dart';
import '../style/colors/app_colors.dart';
import 'activity_screen.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatListScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  final List<String> _screensName = [
    "Home",
    "Chat",
    "Activity",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<MainProvider>();
    return Scaffold(
      body: IndexedStack(index: provider.tabIndex, children: _screens),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
          color: Colors.black,
          height: 70,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  provider.tabIndex == 0
                      ? Icons.home_rounded
                      : Icons.home_outlined,
                  color: provider.tabIndex == 0
                      ? Colors.white
                      : Colors.grey,
                  size: provider.tabIndex == 0 ?  35 : 25,
                ),
                onPressed: () => provider.setTabIndex(0),
              ),
              const SizedBox(width: 3),
              IconButton(
                icon: Icon(
                  provider.tabIndex == 1
                      ? Icons.chat_rounded
                      : Icons.chat_bubble_outline_rounded,
                  color: provider.tabIndex == 1
                      ? Colors.white
                      : Colors.grey,
                  size: provider.tabIndex == 1 ?  35 : 25,

                ),
                onPressed: () => provider.setTabIndex(1),
              ),
              const SizedBox(width: 3),
              IconButton(
                icon: Icon(
                  provider.tabIndex == 2
                      ? Icons.history
                      : Icons.history_outlined,
                  color: provider.tabIndex == 2
                      ? Colors.white
                      : Colors.grey,
                  size: provider.tabIndex == 2 ?  35 : 25,
                ),
                onPressed: () => provider.setTabIndex(2),
              ),
              IconButton(
                icon: Icon(
                  provider.tabIndex == 3 ? Icons.person : Icons.person_outline,
                  color: provider.tabIndex == 3
                      ?Colors.white
                      : Colors.grey,
                  size: provider.tabIndex == 3 ? 35 : 25,
                ),
                onPressed: () => provider.setTabIndex(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
