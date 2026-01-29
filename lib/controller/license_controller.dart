import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LicenseController extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<File>? license;
  bool _isLoading = false;
  bool _isUploading = false;
  String? licenseUrl;

  Future<void> uploadLicense(BuildContext context) async {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (filePickerResult == null) return;
    final picked = filePickerResult.files.single;
    if (picked.path == null) return;
    File file = File(picked.path!);
    String name = picked.name;
    String fileName = "${DateTime.now().millisecondsSinceEpoch}_$name";
    _isUploading = true;
    notifyListeners();

    try {
      await _supabase.storage.from("license").upload(fileName, file);
      final publicUrl = _supabase.storage
          .from("license")
          .getPublicUrl(fileName);
      licenseUrl = publicUrl;
      _isUploading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.white,
          content: Text(
            "License uploaded successfully!",
            style: GoogleFonts.inter(
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.green,
            ),
          ),
        ),
      );
    } catch (e) {
      _isUploading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.white,
          content: Text(
            "Uploading failed, please try again",
            style: GoogleFonts.inter(
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.green,
            ),
          ),
        ),
      );
      debugPrint("Error uploading license: $e");
    }
  }
}
