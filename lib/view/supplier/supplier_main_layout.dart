import 'package:flutter/material.dart';
import 'package:moona/view/supplier/home_page.dart';
import 'package:moona/view/supplier/licence_page.dart';
import 'package:moona/view/supplier/finance_page.dart';
import 'package:moona/view/supplier/profile_page.dart';
import 'package:moona/widgets/custom_navBar.dart';

class SupplierMainLayout extends StatefulWidget {
  const SupplierMainLayout({super.key});

  static const String routeName = "/supplier_main_layout";

  @override
  State<SupplierMainLayout> createState() => _SupplierMainLayoutState();
}

class _SupplierMainLayoutState extends State<SupplierMainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    SupplierHomePage(),
    FinancePage(),
    SupplierLicencePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// This is the main layout of the main four screens
    /// (Home screen, Finance screen, License screen, Profile screen)

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomNavbar(
        currentIndex: _selectedIndex,
        onTab: _onItemTapped,
      ),
    );
  }
}
