import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/param_item_list.dart';

class ParamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BaseText(TextType.sectionTitle, 'Préférances'),
      SizedBox(height: 15),
      BaseText(TextType.bigText, 'Notifications'),
      SizedBox(height: 10),
      ParamItemList("Toutes les notifictions", null, false),
      ParamItemList(
          "Notifications essentielle",
          'Seulement les notifications concernant les établissements mis en favoris.',
          true),
      ParamItemList("Désactiver les notifications", null, false),
      SizedBox(height: 15),
      BaseText(TextType.bigText, 'Localisation'),
      SizedBox(height: 10),
      ParamItemList("Activez la localisation", null, true),
      ParamItemList("Désactiver la localisation", null, false),
      SizedBox(height: 20),
      BaseText(TextType.sectionTitle, 'Générale'),
      SizedBox(height: 15),
      ParamItemList("Condition générale d'utilisation", null, false),
      ParamItemList("Politique de confidentialité", null, false),
      SizedBox(height: 10),
      Align(
        alignment: Alignment.center,
        child: BaseButton(
            ButtonsType.big,
            () => FirebaseAuth.instance.signOut(),
            "Se déconnecter",
            [ThemeColors.grayColor, ThemeColors.grayColor]),
      ),
      SizedBox(height: 10),
    ]);
  }
}
