import 'package:flutter/material.dart';

import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/product_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/store_screen.dart';
import 'utils/app_routes.dart';

void main() => runApp(BuyItApp());

class BuyItApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuyIt',
      theme: ThemeData(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: const Color.fromARGB(255, 0, 95, 131), secondary: Colors.lightBlueAccent),
          fontFamily: 'Raleway',
          canvasColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ))),
      home: HomeScreen(),
      //initialRoute: '/',
      routes: {
        AppRoutes.LOGIN: (ctx) => LoginScreen(),
        AppRoutes.STORE: (ctx) => StoreScreen(),
        AppRoutes.PRODUCT: (ctx) => ProductScreen(),
        AppRoutes.HISTORY: (ctx) => HistoryScreen(), 
        AppRoutes.PROFILE: (ctx) => ProfileScreen(),
      },
    );
  }
}
