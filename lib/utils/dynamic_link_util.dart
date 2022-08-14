import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';

class DynamicLinkUtil {
  static Future<Uri> getInvitationLink() async {
    String dynamicLinkPrefix = 'https://modakflutterapp.page.link/invitation';
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkPrefix,
      link: Uri.parse('https://modakflutterapp.page.link/invitation?link=https://app.mdak&d=${UserProvider.family_id}'),
      androidParameters: const AndroidParameters(
        packageName: "com.example.modakFlutterApp",
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.example.modakFlutterApp",
        minimumVersion: '0',
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    return Uri.parse(dynamicLink.toString());
  }
}