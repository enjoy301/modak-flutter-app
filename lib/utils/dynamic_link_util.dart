import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String> getLink(String purpose, String id) async {
  String dynamicLinkPrefix = 'https://modakflutterapp.page.link/invitation';
  final dynamicLinkParams = DynamicLinkParameters(
    uriPrefix: dynamicLinkPrefix,
    link: Uri.parse('$dynamicLinkPrefix/$purpose?id=$id'),
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
  print(dynamicLink.toString());
  return dynamicLink.toString();
}