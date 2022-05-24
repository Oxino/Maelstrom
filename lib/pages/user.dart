import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/base_button.dart';

// import 'package:maelstrom/widgets/home/home_app_bar.dart';
// import 'package:maelstrom/widgets/base_navigation_bar.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BaseText(TextType.sectionTitle, "User Page"),
              BaseButton(ButtonsType.big, () => FirebaseAuth.instance.signOut(),
                  "Se déconnecter"),
            ],
          ),
        )
        // bottomNavigationBar: BaseNavigationBar(4),
        );
  }
}
