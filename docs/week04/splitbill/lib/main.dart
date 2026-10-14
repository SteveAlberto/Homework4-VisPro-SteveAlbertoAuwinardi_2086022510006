import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'models.dart';
import 'harness.dart';

const Color kSeedColor = Color(0xFF00897B); 
const bool kLabHarness = true; 

void main() {
  runApp(kLabHarness ? const LabHarness() : const MyApp());
}

class MyApp extends StatelessWidget {
  final List<Langganan>? initialData; 
  final ThemeMode themeMode;

  const MyApp({
    super.key,
    this.initialData,
    this.themeMode = ThemeMode.system,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SplitBill App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kSeedColor),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: kSeedColor, brightness: Brightness.dark),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      themeMode: themeMode,
      home: LayarAwal(initialData: initialData),
      debugShowCheckedModeBanner: false,
    );
  }
}