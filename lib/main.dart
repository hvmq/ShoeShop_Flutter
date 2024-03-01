import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoeshop_flutter/models/shoe.dart';
import 'package:shoeshop_flutter/providers/cart_provider.dart';
import 'package:shoeshop_flutter/providers/shoe_provider.dart';
import 'package:shoeshop_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ShoeAdapter());
  await Hive.openBox<Shoe>('shoeBox');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: ShoeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
