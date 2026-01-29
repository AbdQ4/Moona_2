import 'package:flutter/widgets.dart';

class SupplierController with ChangeNotifier {
  List<String> _suppliers = [];

  List<String> get suppliers => _suppliers;

  void addSupplier(String name) {
    _suppliers.add(name);
    notifyListeners();
  }
}
