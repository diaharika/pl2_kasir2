import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase
import 'login.dart';  // Import the LoginScreen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(
      url: 'https://mmvqwzcwxukkqalyuuds.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1tdnF3emN3eHVra3FhbHl1dWRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxMzI5OTgsImV4cCI6MjA1MTcwODk5OH0.nsxmWf0YQpwoBSh2UFffeTnVI2l7Yg_zHmli-7MbFEw',
    );
    runApp(const MyApp());
  } catch (e) {
    print('Supabase initialization failed: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Set LoginScreen as the home
    );
  }
}
