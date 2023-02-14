import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/features/number_trivia/presentation/components/pop_up_scope.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/home_tab.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/schedule_tab.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/dummy.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/my_books.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.local_hospital, 'index': 0},
  {'icon': Icons.add, 'index': 1},
  {'icon': Icons.calendar_today, 'index': 2},
];

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => LeaveAppDialog(),
        )) ??
        false;
  }

  void sign_out() async {
    AlertDialog(
      content: Text("Sign out"),
    );
    await FirebaseAuth.instance.signOut();
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
      ScheduleTab(),
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
          selectedItemColor: Color(CustomColors.primary),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            for (var navigationBarItem in navigationBarItems)
              BottomNavigationBarItem(
                icon: Container(
                  height: 55,
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
                    size: 30,
                    color: _selectedIndex == 0
                        ? Color(CustomColors.bg01)
                        : Color(CustomColors.bg02),
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
