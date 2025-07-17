import 'package:url_launcher/url_launcher.dart';

class LinkHelper {
  static Future<void> openUrl(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch URI: $uri';
    }
  }
}
