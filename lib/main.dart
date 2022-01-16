// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_location/feature/_feature_exports.dart';
import 'package:provider/provider.dart';
import 'core/init/injection_container.dart' as dependencyInjection;

void main() async {
  await dependencyInjection.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserLocationProvider>(
          create: (_) => dependencyInjection.serviceLocator(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MapPage(),
    );
  }
}
