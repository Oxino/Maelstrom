import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';


const fondColor = Color(0xFF181929);
const whiteColor = Color(0xFFf1f1f1);
const grayColor = Color(0xFF272b3e);


class TestGrid extends StatelessWidget {
  final List recoList = [
    {
      'title': 'Soirée célib : Faites des rencontres !',
      'place': 'La casa',
      'picture': 'assets/images/image1.jpg',
      'km': '1km',
      'tag': [],
    },
    {
      'title': 'Tournois Super Smash Bros Ulitimate',
      'place': 'Le R4dom',
      'picture': 'assets/images/image2.jpg',
      'km': '1.5km',
      'tag': [],
    },
    {
      'title': 'Soirée avec DJ Snake  1 conso offerte',
      'place': 'La plage',
      'picture': 'assets/images/image3.jpg',
      'km': '2km',
      'tag': [],
    },
    {
      'title': 'Soirée Beer Pong',
      'place': 'La Grange',
      'picture': 'assets/images/image2.jpg',
      'km': '2km',
      'tag': [],
    },
    {
      'title': 'Rencontre Geek',
      'place': 'Le Sherlock',
      'picture': 'assets/images/image1.jpg',
      'km': '2.5km',
      'tag': [],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: recoList.map((reco) {
          return RecoCard(reco);
        }).toList()
        // children: <Widget>[
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text("He'd have you all unravel at the"),
        //     color: Colors.teal[100],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Heed not the rabble'),
        //     color: Colors.teal[200],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Sound of screams but the'),
        //     color: Colors.teal[300],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Who scream'),
        //     color: Colors.teal[400],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Revolution is coming...'),
        //     color: Colors.teal[500],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Revolution, they...'),
        //     color: Colors.teal[600],
        //   ),
        // ],
    );
  }
}


class RecoCard extends StatelessWidget {
  final Map recoData;
  RecoCard(this.recoData);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 206,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: grayColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Container(
            height: 92,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                image: DecorationImage(
                  image: AssetImage(
                    recoData['picture'],
                  ),
                  fit: BoxFit.cover,
                )),
            child: Stack(
              children: [
                Positioned(
                  top: 75,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 3, 1),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(6)),
                      color: grayColor,
                    ),
                    child: Text(
                      recoData['km'],
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text(
                  recoData['title'],
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text(
                  recoData['place'],
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Container(
                  height: 23,
                  width: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(7)),
                      color: Theme.of(context).colorScheme.primary),
                  child: ElevatedButton(
                    onPressed: null,
                    child: null,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
