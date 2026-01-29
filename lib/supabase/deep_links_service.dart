import 'package:app_links/app_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();

  Future<void> initAppLinks() async {
    // Handle app opened via link (cold start)
    final Uri? initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      await _handleLink(initialUri);
    }

    // Listen for incoming links while app is running
    _appLinks.uriLinkStream.listen((Uri uri) {
      _handleLink(uri);
    });
  }

  Future<void> _handleLink(Uri uri) async {
    try {
      await Supabase.instance.client.auth.exchangeCodeForSession(uri.toString());
      print("✅ Session established from deep link: $uri");
    } catch (e) {
      print("❌ Error handling deep link: $e");
    }
  }
}
