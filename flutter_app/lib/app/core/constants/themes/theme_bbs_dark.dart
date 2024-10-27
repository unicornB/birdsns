part of 'index_theme.dart';

final ThemeData themeBbsDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: const Color(0xffE5E5E5),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // 状态栏图标为暗色调
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.white, // 状态栏背景为白色
      systemNavigationBarColor: Colors.black,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Colors.black,
    labelColor: AppColor.primaryColor,
    indicatorColor: Color(0xffFF2E4D),
    labelStyle: TextStyle(
      fontSize: 16,
    ),
    unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 16),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColor.primaryColor,
    unselectedItemColor: Colors.black,
    elevation: 0,
    backgroundColor: Colors.white,
  ),
);
