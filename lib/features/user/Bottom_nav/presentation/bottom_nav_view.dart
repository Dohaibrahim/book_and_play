import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/features/settings/presentation/settings_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key, required this.home});
  final Widget home;
  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int selectedIndex = 0;
  late List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens = [widget.home, const SettingsView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: screens[selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: ColorManager.primaryColor),
          unselectedIconTheme: IconThemeData(color: Colors.grey[800]),
          selectedItemColor: ColorManager.primaryColor,
          unselectedItemColor: Colors.grey[800],
          backgroundColor: Colors.white,
          currentIndex: selectedIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'bottom_nav.home'.tr(),
              icon: ImageIcon(
                size: 29,
                AssetImage('assets/icons/home_icon.png'),
                //color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: 'bottom_nav.settings'.tr(),
              icon: ImageIcon(
                size: 29,
                AssetImage('assets/icons/settings_icon.png'),
                //color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
