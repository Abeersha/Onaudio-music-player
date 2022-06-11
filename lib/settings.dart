import 'package:animations/animations.dart';
import 'package:audio3/dialogs/privacy_dialoge.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(255, 131, 26, 18),
          Color.fromARGB(255, 49, 54, 58),
        ],
      )),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: const Color.fromARGB(255, 105, 43, 38),
            child: AppBar(
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: const Color.fromARGB(0, 168, 81, 81),
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () async {
              await Share.share('share this text');
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user_outlined),
            title: const Text('Terms & Conditions'),
            onTap: () {
              showModal(
                context: context,
                configuration: const FadeScaleTransitionConfiguration(),
                builder: (context) {
                  return PrivacyDialog(mdFileName: 'terms_and_conditions.md');
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {
              showModal(
                context: context,
                configuration: const FadeScaleTransitionConfiguration(),
                builder: (context) {
                  return PrivacyDialog(mdFileName: 'privacy_policy.md');
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationIcon:
                      Image.asset("assets/image.jpg", width: 30, height: 30),
                  applicationName: "AUDIO WAVE",
                  applicationVersion: "Version 1.0.0\n\nCopyright © 2022-2023",
                  applicationLegalese: "Developed by Abeersha Rahim ");
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    ));
  }
}
