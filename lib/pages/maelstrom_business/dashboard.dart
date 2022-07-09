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
import 'package:maelstrom/widgets/dashboard/line_chart.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';
import 'package:maelstrom/widgets/home/promote_section.dart';

// class HomePage extends BasePage {
class Dashboard extends StatelessWidget {
  final EventRepos _eventRepos = EventRepos();
  @override
  Widget build(BuildContext context) {
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
        HomeAppBar(),
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
                    print(snapshot.error);
                    return BaseText(
                        TextType.bodyBoldText, "Something went wrong");
                  }
                  return PromoteSection(snapshot.data!);
                })),
            SizedBox(height: 30),
            BaseText(TextType.sectionTitle, "Vos statistiques globales"),
            SizedBox(height: 30),
            BaseText(TextType.sectionTitle, "Statistiques de l'application"),
            SizedBox(height: 15),
            Container(
              height: 500,
              width: 5000,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: BoxDecoration(
                  color: ThemeColors.grayColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: LineChartWidget(),
            ),
          ],
        )))
      ],
    );
  }
}
