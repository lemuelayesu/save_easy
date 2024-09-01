import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:save_easy/consts/theme.dart';
import 'package:save_easy/providers/savings_goal_provider.dart';
import 'package:save_easy/providers/transaction_provider.dart';
import 'package:save_easy/providers/user_provider.dart';
import 'package:save_easy/screens/home.dart';
import 'package:save_easy/screens/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:save_easy/services/news_service.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  tz.initializeTimeZones();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NewsService().fetchAndSaveNews();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavingsGoalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData(),
        home: FirebaseAuth.instance.currentUser == null
            ? const Onboarding()
            : const Homepage(),
      ),
    );
  }
}
