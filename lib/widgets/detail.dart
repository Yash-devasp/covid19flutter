import 'package:covid19/constant.dart';
import 'package:covid19/widgets/MyHeader.dart';
import 'package:flutter/material.dart';
import 'package:flat_segmented_control/flat_segmented_control.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Browser stats-rafiki.svg",
              textTop: "Research Done",
              textBottom: "About COVID19",
              pageNum: 3,
            ),
            FlatSegmentedControl(
              tabChildren: <Widget>[
                Container(
                  height: 50.0,
                  child: Center(child: Text("South Korea")),
                ),
                Container(
                  height: 50.0,
                  child: Center(child: Text("India")),
                ),
                Container(
                  height: 50.0,
                  child: Center(child: Text("United States")),
                ),
              ],
              childrenHeight: 680,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Text("Our Research",style: kTitleTextStyle,),
                    SizedBox(height: 20,),
                    Image.asset("assets/images/korea.jpeg",width: 350),
                    SizedBox(height: 10,),
                    Expanded(
                        child: countryInfo(
                        population: "51.7 million",
                        cases: "90.3 thousand",
                        outOf: "572",
                        per10000: "17",
                        actualAwareness: "70-73",
                        predictedAwareness: "74.70",
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Text("Our Research",style: kTitleTextStyle,),
                    SizedBox(height: 20,),
                    Image.asset("assets/images/india.jpeg",width: 350),
                    SizedBox(height: 10,),
                    Expanded(
                        child: countryInfo(
                        population: "1.38 billion",
                        cases: "11.11 million",
                        outOf: "124",
                        per10000: "80",
                        actualAwareness: "49-53",
                        predictedAwareness: "49.47",
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Text("Research Done",style: kTitleTextStyle,),
                    SizedBox(height: 20,),
                    Image.asset("assets/images/america.jpeg",width: 350,),
                    SizedBox(height: 10,),
                    Expanded(
                        child: countryInfo(
                        population: "320 million",
                        cases: "19.02 million",
                        outOf: "17",
                        per10000: "588",
                        actualAwareness: "40-44",
                        predictedAwareness: "44.52",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text("Awareness Report",style: kTitleTextStyle,),
            SizedBox(height: 10,),
            Image.asset("assets/images/bezier.png",width: 350,),
            SizedBox(height: 20,),
            Text("Awareness Report",style: kTitleTextStyle,),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.circle,size: 10,),
              title: Text("y = (8.06e-09 * x^4) + (-1.02e-05 * x^3) + (4.36e-03 * x^2) + (-7.21e-01 * x) + 8.75e+01"),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class countryInfo extends StatelessWidget {
  final String population;
  final String cases;
  final String outOf;
  final String per10000;
  final String actualAwareness;
  final String predictedAwareness;

  const countryInfo(
      {Key key,
      this.population,
      this.cases,
      this.outOf,
      this.per10000,
      this.actualAwareness,
      this.predictedAwareness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.circle,
            size: 10,
          ),
          title: Text("Population : ${population}"),
        ),
        ListTile(
          leading: Icon(
            Icons.circle,
            size: 10,
          ),
          title: Text("Total Cases : ${cases}"),
        ),
        ListTile(
          leading: Icon(
            Icons.circle,
            size: 10,
          ),
          title: Text("Every 1 out of ${outOf} was infercted"),
        ),
        ListTile(
          leading: Icon(
            Icons.circle,
            size: 10,
          ),
          title: Text("Affected per 10,000 : ${per10000}(approx.)"),
        ),
        ListTile(
          leading: Icon(
            Icons.circle,
            size: 10,
          ),
          title: Text("Actual Awareness : ${actualAwareness}"),
        ),
        ListTile(
          leading: Icon(
            Icons.circle,
            size: 10,
          ),
          title: Text("Predicted Awareness : ${predictedAwareness}"),
        ),
      ],
    );
  }
}
