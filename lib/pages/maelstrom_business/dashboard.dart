// import '';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/models/tag_model.dart';
import 'package:maelstrom/repositories/event/event_repo.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/dashboard/bar_chart.dart';
import 'package:maelstrom/widgets/dashboard/data_box.dart';
import 'package:maelstrom/widgets/dashboard/line_chart.dart';
import 'package:maelstrom/widgets/dashboard/pie_chart.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';
import 'package:maelstrom/widgets/home/promote_section.dart';

// class HomePage extends BasePage {
class Dashboard extends StatelessWidget {
  final EventRepos _eventRepos = EventRepos();
  String idBusiness = FirebaseAuth.instance.currentUser!.uid;
  int year = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
  List test = _eventRepos.getNumeberBusinnessEventsByMonth(idBusiness);
    EventModel event = new EventModel(
        idBusiness: 'PagMMWubUGUParLJbkRSmcWB1Dw1',
        name: "Soiréee beer bong",
        description:
            "Venez tente de gagner des récompenses en jouant au BeerPong c'est 10€ pour participer.",
        imageName: "13-p1-un-bar-l-endroit-ideal-pour-une-soiree-festive.jpg",
        tags: [
          {'colorValue': 4286178932, 'name': "Promo"},
          {'colorValue': 4294595885, 'name': "Jeux"}
        ],
        startDate: Timestamp.fromDate(DateTime.now()),
        endDate: Timestamp.fromDate(DateTime.now()),
        promote: true);

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
                stream: _eventRepos.geEventById('hDX1LPBqDJAEClTbfcOn'),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return BaseText(
                        TextType.bodyBoldText, "Something went wrong");
                  }
                  return PromoteSection(snapshot.data!);
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
                  child: DataBox('Evénement', 78, 'assets/icons/data_event.svg'),
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
