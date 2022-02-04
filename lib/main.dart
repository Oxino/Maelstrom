import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'testGrid.dart';

const fondColor = Color(0xFF181929);
const whiteColor = Color(0xFFf1f1f1);
const grayColor = Color(0xFF272b3e);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF236BFE),
        backgroundColor: Color(0xFF181929),

        fontFamily: GoogleFonts.poppins(
          color: whiteColor,
          fontSize: 14,
        ).fontFamily,

        // textTheme: const TextTheme(
        //    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   subtitle1: TextStyle(fontSize: 24),
        // )
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mealstrom',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: MyAppBar(),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchSection(),
                  PromoteSection(),
                  RecoSection(),
                  TestGrid(),
                ],
              ),
            )));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: Row(
        children: [
          SizedBox(
            height: 40, // Your Height
            width: 40,
            child: SvgPicture.asset(
              'assets/icons/maelstrom.svg',
              // color: Colors.red,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
            color: whiteColor,
            size: 30,
          ),
          onPressed: null,
        ),
      ],
      backgroundColor: fondColor,
    );
  }
}

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 15, bottom: 20),
      child: Expanded(
          child: Container(
        decoration: BoxDecoration(
            color: grayColor, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          style: TextStyle(color: whiteColor),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            hintText: 'Rechercher',
            hintStyle: TextStyle(
              color: whiteColor,
            ),
            border: InputBorder.none,
          ),
        ),
      )),
    );
  }
}

class PromoteSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 206,
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
                height: 30,
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(children: [
                  Text(
                    'Evènement de la soirée',
                    style: TextStyle(
                        fontFamily: 'Dosis', color: whiteColor, fontSize: 24),
                  ),
                ])),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: grayColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      height: 77,
                      width: 125,
                      margin: EdgeInsets.only(right: 12, bottom: 19),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/image3.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                      child: null,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          'Soirée célib! Faites des rencontres!',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'La casa',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 12,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 23,
                        width: 61,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomRight: Radius.circular(7)),
                            color: Theme.of(context).colorScheme.primary),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'Y aller !',
                            style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

class RecoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
              height: 30,
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(children: [
                Text(
                  'Recomandations',
                  style: TextStyle(
                      fontFamily: 'Dosis', color: whiteColor, fontSize: 24),
                ),
              ])),
        ],
      ),
    );
  }
}
