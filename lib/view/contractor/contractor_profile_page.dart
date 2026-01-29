import 'package:flutter/material.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:provider/provider.dart';

class ContractorProfilePage extends StatefulWidget {
  const ContractorProfilePage({super.key});

  @override
  State<ContractorProfilePage> createState() => _ContractorProfilePageState();
}

class _ContractorProfilePageState extends State<ContractorProfilePage> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            themeController.switchThemes();
          },
          child: Text('Change theme'),
        ),
      ),
    );
  }
}
