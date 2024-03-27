
import 'dart:async';
import 'dart:convert';

import 'package:aws_flutter/artwork_sharing/add_new_artwork_screen.dart';
import 'package:aws_flutter/artwork_sharing/artwork_order_history_screen.dart';
import 'package:aws_flutter/artwork_sharing/my_artwork_screen.dart';
import 'package:aws_flutter/login_screen.dart';
import 'package:aws_flutter/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Accinfo?> accInfoFuture;
  late Future<String?> tokenFuture;
  late Accinfo accinfo = Accinfo.empty();
  late String token = '';

  final storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<Accinfo?> getAccInfo() async {
    String? accinfoJsonString = await storage.read(key: 'accinfo');
    if (accinfoJsonString != null) {
      Map<String, dynamic> accinfoJson = json.decode(accinfoJsonString);
      Accinfo accinfo = Accinfo.fromJson(accinfoJson);
      return accinfo;
    }
    return null;
  }

  void _handleLogout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    await storage.delete(key: 'accinfo');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logout success'),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  void initState() {
    getDataInitialized();
    super.initState();
  }

  void getDataInitialized() async {
    tokenFuture = getToken();
    tokenFuture.then((value) => {
      setState(() {
        token = value!;
      })
    });
    accInfoFuture = getAccInfo();
    accInfoFuture.then((value) => {
      setState(() {
        accinfo = value!;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            // CustomListTile
            CustomListTile(
              icon: Icons.person,
              title: 'User name',
              subtitle: accinfo.userName,
            ),

            // CustomListTile to display Email
            CustomListTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: accinfo.email,
            ),

            if(accinfo.isArtistAccount == true)
              CustomListTile(
                icon: Icons.add,
                title: 'Add Artwork',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewArtWorkScreen(),
                    ),
                  );
                },
              ),

            CustomListTile(
              icon: Icons.history,
              title: 'Order History',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtworkOrderHistoryScreen(),
                  ),
                );
              },
            ),

            CustomListTile(
              icon: FontAwesomeIcons.objectUngroup,
              title: 'My Artworks',
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      MyArtWorkScreen(),
                  ),
                );
              },
            ),
            // CustomListTile(
            //   icon: Icons.edit,
            //   title: 'Edit profile',
            //   onTap: () {
            //
            //   },
            // ),

            // CustomListTile to display Settings
            // CustomListTile(
            //   icon: Icons.settings,
            //   title: 'Settings',
            //   onTap: () {
            //
            //   },
            // ),

            // Log out
            CustomListTile(
              icon: Icons.logout,
              title: 'Log out',
              onTap: () {
                _handleLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
    );
  }
}