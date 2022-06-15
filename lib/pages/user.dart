import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/bloc/bloc_provider.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/base_button.dart';

// import 'package:maelstrom/widgets/home/home_app_bar.dart';
// import 'package:maelstrom/widgets/base_navigation_bar.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BaseAppBar(
              leftIcon: 'assets/icons/arrow-back.svg',
              leftIconFuction: PageType.home,
              textBar: 'UserName'),
          SizedBox(height: 20),
          BaseButton(ButtonsType.big, () => FirebaseAuth.instance.signOut(),
              "Se déconnecter", [ThemeColors.grayColor, ThemeColors.grayColor]),
        ],
      ),
    );
  }
}
