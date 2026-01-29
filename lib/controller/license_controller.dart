import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LicenseController extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool isUploading = false;
  String? licenseUrl;

  Future<void> uploadLicense(BuildContext context) async {
    try {
      // Pick PDF
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true, // REQUIRED for web
      );

      if (result == null) return;

      final file = result.files.single;
      final bytes = file.bytes;

      if (bytes == null) {
        throw Exception("File bytes are null");
      }

      isUploading = true;
      notifyListeners();

      final fileName =
          "licenses/${DateTime.now().millisecondsSinceEpoch}_${file.name}";

      // Upload to Supabase Storage
      await _supabase.storage.from('license').uploadBinary(fileName, bytes);

      // Get public URL
      final url = _supabase.storage.from('license').getPublicUrl(fileName);

      licenseUrl = url;

      isUploading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("License uploaded successfully ✅")),
      );
    } catch (e) {
      isUploading = false;
      notifyListeners();

      debugPrint("Upload error: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Upload failed ❌")));
    }
  }
}
