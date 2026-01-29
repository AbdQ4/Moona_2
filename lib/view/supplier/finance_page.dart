import 'package:flutter/material.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  static const String routeName = "/finance_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finance Page')),
      body: const Center(child: Text('Welcome to the Finance Page!')),
    );
  }
}
