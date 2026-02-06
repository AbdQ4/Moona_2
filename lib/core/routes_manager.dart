import 'package:flutter/material.dart';
import 'package:moona/view/auth/auth_redirect.dart';
import 'package:moona/view/auth/email_verification_screen.dart';
import 'package:moona/view/auth/forget_password_screen.dart';
import 'package:moona/view/auth/pending_screen.dart';
import 'package:moona/view/auth/renew_license_screen.dart';
import 'package:moona/view/auth/signup_screen.dart';
import 'package:moona/view/auth/login_screen.dart';
import 'package:moona/view/contractor/card_detailes_page.dart';
import 'package:moona/view/contractor/contractor_finance_page.dart';
import 'package:moona/view/contractor/contractor_main_layout.dart';
import 'package:moona/view/contractor/product_details.dart';
import 'package:moona/view/contractor/your_cart_page.dart';
import 'package:moona/view/supplier/finance_page.dart';
import 'package:moona/view/supplier/licence_page.dart';
import 'package:moona/view/supplier/products_details_supplier.dart';
import 'package:moona/view/supplier/supplier_main_layout.dart';

import '../view/auth/update_password.dart';

class RoutesManager {
  static Map<String, Widget Function(BuildContext)> appRoutes = {
    SignupScreen.routeName: (context) => SignupScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
    EmailVerificationScreen.routeName: (context) => EmailVerificationScreen(),
    ContractorMainLayout.routeName: (context) => ContractorMainLayout(),
    SupplierMainLayout.routeName: (context) => SupplierMainLayout(),
    UpdatePassword.routeName: (context) => UpdatePassword(),
    ProductsDetailsSupplier.routeName: (context) => ProductsDetailsSupplier(),
    PendingScreen.routeName: (context) => PendingScreen(),
    AuthRedirect.routeName: (context) => AuthRedirect(),
    RenewLicenseScreen.routeName: (context) => RenewLicenseScreen(),
    FinancePage.routeName: (context) => FinancePage(),
    LicencePage.routeName: (context) => LicencePage(),
    ContractorFinancePage.routeName: (context) => ContractorFinancePage(),
    ProductsDetailsContractor.routeName: (context) =>
        ProductsDetailsContractor(),
    YourCartPage.routeName: (context) => YourCartPage(),
  };
}
