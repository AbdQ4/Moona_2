// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `No items yet in`
  String get noItems {
    return Intl.message('No items yet in', name: 'noItems', desc: '', args: []);
  }

  /// `No Items Added`
  String get noItemsAdded {
    return Intl.message(
      'No Items Added',
      name: 'noItemsAdded',
      desc: '',
      args: [],
    );
  }

  /// `Tap the button below to add an item`
  String get addItems {
    return Intl.message(
      'Tap the button below to add an item',
      name: 'addItems',
      desc: '',
      args: [],
    );
  }

  /// `Building Materials`
  String get buildingMaterials {
    return Intl.message(
      'Building Materials',
      name: 'buildingMaterials',
      desc: '',
      args: [],
    );
  }

  /// `Bricks`
  String get bricks {
    return Intl.message('Bricks', name: 'bricks', desc: '', args: []);
  }

  /// `Cement`
  String get cement {
    return Intl.message('Cement', name: 'cement', desc: '', args: []);
  }

  /// `Sand`
  String get sand {
    return Intl.message('Sand', name: 'sand', desc: '', args: []);
  }

  /// `Steel`
  String get steel {
    return Intl.message('Steel', name: 'steel', desc: '', args: []);
  }

  /// `Electrical & Lightning`
  String get electricalAndLightning {
    return Intl.message(
      'Electrical & Lightning',
      name: 'electricalAndLightning',
      desc: '',
      args: [],
    );
  }

  /// `Wires`
  String get wires {
    return Intl.message('Wires', name: 'wires', desc: '', args: []);
  }

  /// `Switches`
  String get switches {
    return Intl.message('Switches', name: 'switches', desc: '', args: []);
  }

  /// `Bulbs`
  String get bulbs {
    return Intl.message('Bulbs', name: 'bulbs', desc: '', args: []);
  }

  /// `Panles`
  String get panels {
    return Intl.message('Panles', name: 'panels', desc: '', args: []);
  }

  /// `Finishing Materilas`
  String get finishingMaterilas {
    return Intl.message(
      'Finishing Materilas',
      name: 'finishingMaterilas',
      desc: '',
      args: [],
    );
  }

  /// `Paints`
  String get paints {
    return Intl.message('Paints', name: 'paints', desc: '', args: []);
  }

  /// `Tiles`
  String get tiles {
    return Intl.message('Tiles', name: 'tiles', desc: '', args: []);
  }

  /// `Wallpaper`
  String get wallpaper {
    return Intl.message('Wallpaper', name: 'wallpaper', desc: '', args: []);
  }

  /// `Plumbing`
  String get plumbing {
    return Intl.message('Plumbing', name: 'plumbing', desc: '', args: []);
  }

  /// `Pipes`
  String get pipes {
    return Intl.message('Pipes', name: 'pipes', desc: '', args: []);
  }

  /// `Taps`
  String get taps {
    return Intl.message('Taps', name: 'taps', desc: '', args: []);
  }

  /// `Valves`
  String get valves {
    return Intl.message('Valves', name: 'valves', desc: '', args: []);
  }

  /// `Construction Tools`
  String get constructionTools {
    return Intl.message(
      'Construction Tools',
      name: 'constructionTools',
      desc: '',
      args: [],
    );
  }

  /// `Hummer`
  String get hummer {
    return Intl.message('Hummer', name: 'hummer', desc: '', args: []);
  }

  /// `Drill`
  String get drill {
    return Intl.message('Drill', name: 'drill', desc: '', args: []);
  }

  /// `Saw`
  String get saw {
    return Intl.message('Saw', name: 'saw', desc: '', args: []);
  }

  /// `Product Type ?`
  String get productType {
    return Intl.message(
      'Product Type ?',
      name: 'productType',
      desc: '',
      args: [],
    );
  }

  /// `Select Type`
  String get selectType {
    return Intl.message('Select Type', name: 'selectType', desc: '', args: []);
  }

  /// `Select Item`
  String get selectItem {
    return Intl.message('Select Item', name: 'selectItem', desc: '', args: []);
  }

  /// `Stock`
  String get stock {
    return Intl.message('Stock', name: 'stock', desc: '', args: []);
  }

  /// `Price \ Ton`
  String get pricePerTon {
    return Intl.message(
      'Price \\ Ton',
      name: 'pricePerTon',
      desc: '',
      args: [],
    );
  }

  /// `Company of the Product`
  String get companyOfProduct {
    return Intl.message(
      'Company of the Product',
      name: 'companyOfProduct',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Delivery ?`
  String get delivery {
    return Intl.message('Delivery ?', name: 'delivery', desc: '', args: []);
  }

  /// `Sell on Credit ?`
  String get sellOnCredit {
    return Intl.message(
      'Sell on Credit ?',
      name: 'sellOnCredit',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get fillAllFields {
    return Intl.message(
      'Please fill all fields',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Your License`
  String get yourLicense {
    return Intl.message(
      'Your License',
      name: 'yourLicense',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Load Data`
  String get faildLoadData {
    return Intl.message(
      'Failed To Load Data',
      name: 'faildLoadData',
      desc: '',
      args: [],
    );
  }

  /// `Your Renewal Date Is`
  String get renewalDate {
    return Intl.message(
      'Your Renewal Date Is',
      name: 'renewalDate',
      desc: '',
      args: [],
    );
  }

  /// `Your Lisense Is : Active`
  String get licenseStatus {
    return Intl.message(
      'Your Lisense Is : Active',
      name: 'licenseStatus',
      desc: '',
      args: [],
    );
  }

  /// `It seems there is a problem in viewing your license, contact us to review the problem`
  String get noLicenseMessage {
    return Intl.message(
      'It seems there is a problem in viewing your license, contact us to review the problem',
      name: 'noLicenseMessage',
      desc: '',
      args: [],
    );
  }

  /// `More Details`
  String get moreDetails {
    return Intl.message(
      'More Details',
      name: 'moreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get deleteProduct {
    return Intl.message(
      'Delete Product',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Update this product with the new details?`
  String get updateConfirmation {
    return Intl.message(
      'Update this product with the new details?',
      name: 'updateConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `Product Updated Successfully`
  String get productUpdated {
    return Intl.message(
      'Product Updated Successfully',
      name: 'productUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Product Deleted Successfully`
  String get productDeleted {
    return Intl.message(
      'Product Deleted Successfully',
      name: 'productDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Update Product`
  String get updateProduct {
    return Intl.message(
      'Update Product',
      name: 'updateProduct',
      desc: '',
      args: [],
    );
  }

  /// `Delete this product? This action cannot be undone.`
  String get deleteProductConfirmation {
    return Intl.message(
      'Delete this product? This action cannot be undone.',
      name: 'deleteProductConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Delete Product`
  String get deleteFailed {
    return Intl.message(
      'Failed To Delete Product',
      name: 'deleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Update Product`
  String get updateFailed {
    return Intl.message(
      'Failed To Update Product',
      name: 'updateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Change Name`
  String get changeName {
    return Intl.message('Change Name', name: 'changeName', desc: '', args: []);
  }

  /// `Enter New Name`
  String get enterNewName {
    return Intl.message(
      'Enter New Name',
      name: 'enterNewName',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Change Phone Number`
  String get changePhoneNo {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Phone Number`
  String get enterNewPhoneNo {
    return Intl.message(
      'Enter New Phone Number',
      name: 'enterNewPhoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Sales History`
  String get salesHistory {
    return Intl.message(
      'Sales History',
      name: 'salesHistory',
      desc: '',
      args: [],
    );
  }

  /// `Review License`
  String get reviewLisense {
    return Intl.message(
      'Review License',
      name: 'reviewLisense',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpAndSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpAndSupport',
      desc: '',
      args: [],
    );
  }

  /// `Account Details`
  String get accountDetails {
    return Intl.message(
      'Account Details',
      name: 'accountDetails',
      desc: '',
      args: [],
    );
  }

  /// `Select Theme`
  String get selectTheme {
    return Intl.message(
      'Select Theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message('Light Theme', name: 'lightTheme', desc: '', args: []);
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message('Dark Theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Invalid Email or Password`
  String get invalidEmailOrPassword {
    return Intl.message(
      'Invalid Email or Password',
      name: 'invalidEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Don't have an account? `
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification`
  String get emailVerification {
    return Intl.message(
      'Email Verification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `A verification email has been sent to your email address. Please check your inbox and click the verification link to verify your email.`
  String get verificationEmailSent {
    return Intl.message(
      'A verification email has been sent to your email address. Please check your inbox and click the verification link to verify your email.',
      name: 'verificationEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Resend Verification Email`
  String get resendVerificationEmail {
    return Intl.message(
      'Resend Verification Email',
      name: 'resendVerificationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Verification email resent. Please check your inbox.`
  String get verificationEmailResent {
    return Intl.message(
      'Verification email resent. Please check your inbox.',
      name: 'verificationEmailResent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send verification email. Please try again later.`
  String get verificationFailed {
    return Intl.message(
      'Failed to send verification email. Please try again later.',
      name: 'verificationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message('Continue', name: 'continueText', desc: '', args: []);
  }

  /// `Session Expired`
  String get sessionExpired {
    return Intl.message(
      'Session Expired',
      name: 'sessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please log in again to continue.`
  String get sessionExpiredMessage {
    return Intl.message(
      'Your session has expired. Please log in again to continue.',
      name: 'sessionExpiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Email Verified`
  String get emailVerified {
    return Intl.message(
      'Email Verified',
      name: 'emailVerified',
      desc: '',
      args: [],
    );
  }

  /// `Email Not Verified`
  String get emailNotVerified {
    return Intl.message(
      'Email Not Verified',
      name: 'emailNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `Your email has been successfully verified. You can now access all features of the app.`
  String get verificationSuccess {
    return Intl.message(
      'Your email has been successfully verified. You can now access all features of the app.',
      name: 'verificationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Email verification failed. Please try again later or contact support if the issue persists.`
  String get verificationFailedMessage {
    return Intl.message(
      'Email verification failed. Please try again later or contact support if the issue persists.',
      name: 'verificationFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your account is being reviewed. Please wait for approval.`
  String get accountBeingReviewed {
    return Intl.message(
      'Your account is being reviewed. Please wait for approval.',
      name: 'accountBeingReviewed',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Company Name`
  String get companyName {
    return Intl.message(
      'Company Name',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNo {
    return Intl.message('Phone Number', name: 'phoneNo', desc: '', args: []);
  }

  /// `Tax ID`
  String get tax {
    return Intl.message('Tax ID', name: 'tax', desc: '', args: []);
  }

  /// `Upload PDF License`
  String get uploadPDFLicense {
    return Intl.message(
      'Upload PDF License',
      name: 'uploadPDFLicense',
      desc: '',
      args: [],
    );
  }

  /// `Re-Password`
  String get rePassword {
    return Intl.message('Re-Password', name: 'rePassword', desc: '', args: []);
  }

  /// `Contractor`
  String get contractor {
    return Intl.message('Contractor', name: 'contractor', desc: '', args: []);
  }

  /// `Supplier`
  String get supplier {
    return Intl.message('Supplier', name: 'supplier', desc: '', args: []);
  }

  /// `I accept the `
  String get accept {
    return Intl.message('I accept the ', name: 'accept', desc: '', args: []);
  }

  /// `Terms `
  String get terms {
    return Intl.message('Terms ', name: 'terms', desc: '', args: []);
  }

  /// `and `
  String get and {
    return Intl.message('and ', name: 'and', desc: '', args: []);
  }

  /// `Conditions`
  String get conditions {
    return Intl.message('Conditions', name: 'conditions', desc: '', args: []);
  }

  /// `You need to accept our terms and conditions`
  String get needToAcceptTerms {
    return Intl.message(
      'You need to accept our terms and conditions',
      name: 'needToAcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `Choose product's image`
  String get chooseImage {
    return Intl.message(
      'Choose product\'s image',
      name: 'chooseImage',
      desc: '',
      args: [],
    );
  }

  /// `Press here to clear the image`
  String get clearImage {
    return Intl.message(
      'Press here to clear the image',
      name: 'clearImage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
