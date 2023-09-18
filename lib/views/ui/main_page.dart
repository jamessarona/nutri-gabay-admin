import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:nutri_gabay_admin/services/baseauth.dart';
import 'package:nutri_gabay_admin/views/shared/app_style.dart';

class MainPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignOut;
  const MainPage({super.key, required this.auth, required this.onSignOut});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  bool isHideNavBar = false;

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            showToggle: false,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: customColor,
              selectedHoverColor: customColor,
              selectedColor: customColor,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            title: Column(
              children: [
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 150,
                  ),
                  child: Image.asset(
                    'assets/images/logo-name.png',
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            alwaysShowFooter: true,
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SideMenuItem(
                  title: 'Settings',
                  onTap: (index, _) {},
                  icon: const Icon(Icons.settings),
                ),
                SideMenuItem(
                  title: 'Exit',
                  icon: const Icon(Icons.exit_to_app),
                  onTap: (index, _) {},
                ),
              ],
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
              ),
              SideMenuItem(
                title: 'Add a Nutrisionist',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.person_add),
              ),
              SideMenuItem(
                title: 'List of Nutrisionists',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.people),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Add a Nutritionist',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'List of Nutrisionists',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
