import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/src/providers/booking_provider.dart';
import 'package:flutter_app/src/providers/service_provider.dart';
import 'package:flutter_app/src/providers/service_type_provider.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => UserProfile()),
        ChangeNotifierProvider(create: (context) => ServiceTypeProvider()),
      ],
      child: App(),
    ),
  );
}
