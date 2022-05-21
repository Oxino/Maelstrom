import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/base_app_bar.dart';

// import 'package:maelstrom/widgets/home/home_app_bar.dart';
// import 'package:maelstrom/widgets/base_navigation_bar.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: BaseAppBar(user.email!),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BaseText(TextType.sectionTitle, "User Page"),
              ],
            ),
          )),
      // bottomNavigationBar: BaseNavigationBar(4),
    );
  }
}
