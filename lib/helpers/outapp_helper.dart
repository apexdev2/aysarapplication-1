import 'package:aysar_app/utils/enms.dart';
import 'package:url_launcher/url_launcher.dart';

mixin OutAppHelper {
  Future<void> launchThisUrl(
    String link, {
    LauncherType type = LauncherType.link,
  }) async {
    String s = '';

    switch (type) {
      case LauncherType.link:
        s = link;
        break;
      case LauncherType.mobile:
        s = 'tel:$link';
        break;
      case LauncherType.sms:
        s = 'sms:$link';
        break;
      case LauncherType.email:
        s = 'mailto:$link';
        break;
      case LauncherType.whatsapp:
        s = 'https://wa.me/$link';
        break;
    }

    final Uri url = Uri.parse(s);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // Future<void> shareThisUrl(String link, {String? subject}) async {
  //   await Share.share(link, subject: subject);
  // }
}
