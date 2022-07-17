import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/event/event_repo.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/dashboard/bar_chart.dart';
import 'package:maelstrom/widgets/dashboard/data_box.dart';
import 'package:maelstrom/widgets/dashboard/line_chart.dart';
import 'package:maelstrom/widgets/dashboard/pie_chart.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';
import 'package:maelstrom/widgets/home/promote_widget.dart';

// class HomePage extends BasePage {
class Dashboard extends StatelessWidget {
  final EventRepos _eventRepos = EventRepos();
  String idBusiness = FirebaseAuth.instance.currentUser!.uid;
  int year = DateTime.now().year;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        HomeAppBar(isBusiness: true),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(TextType.sectionTitle, "Evènement du mois"),
            SizedBox(height: 15),
            StreamBuilder<EventModel?>(
                stream: _eventRepos.geEventById('KVg40ZOhfU8FjbsPAH5N'),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return BaseText(
                        TextType.bodyBoldText, "Something went wrong");
                  }
                  return PromoteWidget(snapshot.data!, isBusiness: true);
                })),
            SizedBox(height: 30),
            BaseText(TextType.sectionTitle, "Vos statistiques globales"),
            SizedBox(height: 15),
            BarChartBlock(),
            SizedBox(height: 15),
            PieChartBlock(),
            SizedBox(height: 15),
            BaseText(TextType.bigText, "Totals"),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child:
                      DataBox('Evénement', 78, 'assets/icons/data_event.svg'),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: DataBox('Vue', 8224, 'assets/icons/data_see.svg'),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: DataBox('Prévu', 852, 'assets/icons/data_provide.svg'),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: DataBox('Venu', 1644, 'assets/icons/data_go.svg'),
                )
              ],
            ),
            SizedBox(height: 30),
            BaseText(TextType.sectionTitle, "Statistiques de l'application"),
            SizedBox(height: 15),
            LineChartBlock(),
          ],
        )))
      ],
    );
  }
}
