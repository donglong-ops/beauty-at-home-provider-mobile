import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/profile_screen.dart';
import 'package:flutter_app/src/view/provider_confirm_screen.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:flutter_app/src/view/provider_newOrder_Screen.dart';
import 'package:flutter_app/src/view/revenue_table_screen.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentActiveIndex;
  AppBottomNavigationBar({
    Key key,
    this.currentActiveIndex,
  }) : super(key: key);
  final dynamic currentScreenState = {
    0: ProviderScreen(),
    1: ProviderNewOderScreen(),
    2: ProviderManagerScreen(),
    3: HistoryScreen(),
    4: ProfileScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentActiveIndex,
      selectedItemColor: Color(0xff0DB5B4),
      unselectedItemColor: Color(0xffC4C4C4),
      onTap: (value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => currentScreenState[value],
        ));
      },
      items: [
        BottomNavigationBarItem(
          label: 'Booking',
          icon: Icon(
            Icons.book_outlined,
          ),
        ),
        BottomNavigationBarItem(
          label: 'New',
          icon: Icon(
            Icons.list,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Service',
          icon: Icon(
            Icons.settings,
          ),
        ),
        BottomNavigationBarItem(
          label: 'History',
          icon: Icon(
            Icons.history,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Account',
          icon: Icon(
            Icons.account_circle,
          ),
        ),
      ],
    );
  }
}
