import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:second_task/home_screen.dart';
import 'package:second_task/login_screen.dart';
import 'package:second_task/offer_model.dart';
import 'package:second_task/offers_cubit.dart';
import 'package:second_task/password_cubit.dart';
import 'package:second_task/screens/splash_screen.dart';
import 'package:second_task/signup_screen.dart';
import 'package:second_task/user_model.dart';
import 'firebase_options.dart';
import 'offers_screen.dart';
import 'order_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox('text box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: Colors.yellow,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/signup': (context) => BlocProvider(
          create: (context) => PassworedCubit(),
          child: const SignupScreen(),
        ),
        '/login': (context) => BlocProvider(
          create: (context) => PassworedCubit(),
          child: const PassworedScreen(),
        ),
        '/home': (context) => const FoodHomeScreen(),
        '/offers': (context) => const OffersScreen(),
        '/order': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final selectedOffer = (args is Offer)
              ? args
              : Offer(
                  title: 'Chicken BBQ',
                  description: 'Crispy chicken breasts with barbecue sauce',
                  newPrice: '155.00',
                  imagePath: 'assets/images/bbq.png',
                  category: 'chicken',
                );

          return OrderScreen(offer: selectedOffer);
        },
      },
    );
  }
}
