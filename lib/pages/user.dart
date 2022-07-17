import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/user_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';
import 'package:maelstrom/repositories/user/user_repo.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/business_item_list.dart';
import 'package:maelstrom/widgets/param_list.dart';

// import 'package:maelstrom/widgets/home/home_app_bar.dart';
// import 'package:maelstrom/widgets/base_navigation_bar.dart';

class UserPage extends StatelessWidget {
  final bool isBusiness;
  UserPage(this.isBusiness);

  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final UserRepo _userRepos = UserRepo();
  final BusinessRepo _businessRepos = BusinessRepo();

  @override
  Widget build(BuildContext context) {
    return isBusiness
        ? StreamBuilder<BusinessModel?>(
            stream: _businessRepos.getCurrentBusiness(userId),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  children: [
                    BaseAppBar(
                        leftIcon: 'assets/icons/arrow-back.svg',
                        leftIconFuction: PageType.home,
                        textBar: 'Erreur'),
                    SizedBox(height: 20),
                    BaseText(TextType.sectionTitle, "Pas d'utilisateur",
                        textMaxSize: 30)
                  ],
                );
              }
              return Column(
                children: [
                  BaseAppBar(
                      leftIcon: 'assets/icons/arrow-back.svg',
                      leftIconFuction: PageType.home,
                      textBar: snapshot.data!.institutionName),
                  SizedBox(height: 10),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ParamList(),
                    ],
                  )))
                ],
              );
            }))
        : StreamBuilder<UserModel?>(
            stream: _userRepos.getUserById(userId),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  children: [
                    BaseAppBar(
                        leftIcon: 'assets/icons/arrow-back.svg',
                        leftIconFuction: PageType.home,
                        textBar: 'Erreur'),
                    SizedBox(height: 20),
                    BaseText(TextType.sectionTitle, "Pas d'utilisateur",
                        textMaxSize: 30)
                  ],
                );
              }
              UserModel user = snapshot.data!;
              return Column(
                children: [
                  BaseAppBar(
                      leftIcon: 'assets/icons/arrow-back.svg',
                      leftIconFuction: PageType.home,
                      textBar: user.firstName),
                  SizedBox(height: 10),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(TextType.sectionTitle, 'Vos favoris'),
                      SizedBox(height: 10),
                      Column(
                          children: user.favorite.map<Widget>((businessId) {
                        return BusinessItemList(businessId);
                      }).toList()),
                      SizedBox(height: 20),
                      ParamList(),
                    ],
                  )))
                ],
              );
            }));
  }
}
