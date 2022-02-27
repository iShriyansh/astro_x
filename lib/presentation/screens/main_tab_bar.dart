import 'package:astro_tak/presentation/bloc/auth/auth_cubit.dart';
import 'package:astro_tak/presentation/screens/ask_question.dart';
import 'package:astro_tak/presentation/theme/theme.dart';
import 'package:astro_tak/presentation/widgets/comming_soon.dart';
import 'package:astro_tak/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({Key? key}) : super(key: key);

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const ComingSoon(),
    const ComingSoon(),
    AskQuestion(),
    const ComingSoon(),
    const ComingSoon(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final double _bottomNavigationItemImageWidth = 24;

  @override
  void initState() {
    //Authenticating user
    context.read<AuthCubit>().authenticate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
              width: _bottomNavigationItemImageWidth,
              color:
                  _selectedIndex == 0 ? AppTheme.secondaryColor : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/talk.png",
                width: _bottomNavigationItemImageWidth,
                color: _selectedIndex == 1 ? AppTheme.secondaryColor : null),
            label: 'Talk',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/ask.png",
                width: _bottomNavigationItemImageWidth,
                color: _selectedIndex == 2 ? AppTheme.secondaryColor : null),
            label: 'Ask Question',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/reports.png",
                width: _bottomNavigationItemImageWidth,
                color: _selectedIndex == 3 ? AppTheme.secondaryColor : null),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/chat.png",
                width: _bottomNavigationItemImageWidth,
                color: _selectedIndex == 4 ? AppTheme.secondaryColor : null),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
