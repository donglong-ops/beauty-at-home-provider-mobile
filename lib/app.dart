import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/login_screen.dart';
import 'package:flutter_app/src/view/provider_confirm_screen.dart';
import 'package:flutter_app/src/view/provider_newOrder_Screen.dart';

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter app",
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => LoginScreen(),
        //'/': (context) => CheckoutScreen(),
        //'/': (context) => PaymentScreen(),
        // '/': (context) => NotificationScreen(),
        //'/': (context) => LocationChangeDescriptionScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }
}
