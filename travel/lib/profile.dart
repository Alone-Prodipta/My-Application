import 'package:flutter/material.dart';
import 'profile_login.dart';
import 'profile_signin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sign in'),
              Tab(text: 'Log in'),
            ],
          ),
        ),
        body:const TabBarView(
          children: [
            SigninPage(),
            loginPage(),
          ],
        ),
      ),
    );
  }
}