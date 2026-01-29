import 'package:flutter/material.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/contractor_finance_page.dart';
import 'package:moona/view/contractor/contractor_licence_page.dart';
import 'package:moona/view/contractor/contractor_profile_page.dart';
import 'package:moona/view/contractor/contructor_home_page.dart';
import 'package:moona/widgets/custom_navBar.dart';

class ContractorMainLayout extends StatefulWidget {
  const ContractorMainLayout({super.key});
  static const String routeName = "/contractor_main_layout";

  @override
  State<ContractorMainLayout> createState() => _ContractorMainLayoutState();
}

class _ContractorMainLayoutState extends State<ContractorMainLayout> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    ContructorHomePage(),
    ContractorFinancePage(),
    ContractorLicencePage(),
    ContractorProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.green,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomNavbar(
        currentIndex: _selectedIndex,
        onTab: _onItemTapped,
      ),
    );
  }
}
