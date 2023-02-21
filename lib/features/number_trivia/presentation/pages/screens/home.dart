import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/utils/colors.dart';
import 'package:test/features/number_trivia/presentation/components/pop_up_scope.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/home_tab.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/schedule_tab.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/chat_screen.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/my_details.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/user_screen.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/dummy.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/my_books.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.home, 'index': 0},
  {'icon': Icons.calendar_today, 'index': 1},
  {'icon': Icons.chat_bubble_rounded, 'index': 2},
  {'icon': Icons.person, 'index': 3}
];

class _HomeState extends State<Home> {
  var phone = 0;
  var name = "John Doe";
  var company = "MMUST";
  int _selectedIndex = 0;
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => LeaveAppDialog(),
        )) ??
        false;
  }

  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeTab(
        onPressedScheduleCard: goToSchedule,
      ),
      MyBooks(),
      InfoUser(),
      MyDetals(),
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(CustomColors.primary),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 30,
          selectedItemColor: iconColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            for (var navigationBarItem in navigationBarItems)
              BottomNavigationBarItem(
                icon: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border(
                      top: _selectedIndex == navigationBarItem['index']
                          ? BorderSide(
                              color: Color(CustomColors.bg01), width: 5)
                          : BorderSide.none,
                    ),
                  ),
                  child: Icon(
                    navigationBarItem['icon'],
                    // size: _selectedIndex == 0 ? 20 : 30,
                    color: _selectedIndex == 0
                        ? Color(CustomColors.bg01)
                        : iconColor,
                  ),
                ),
                label: '',
              ),
          ],
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
            _selectedIndex = value;
          }),
        ),
      ),
    );
  }
}
