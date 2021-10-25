import 'package:country_picker/country_picker.dart';
import 'package:covid19/constant.dart';
import 'package:covid19/widgets/detail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/MyHeader.dart';
import 'widgets/counter.dart';
import 'widgets/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: TextTheme(
          body1: TextStyle(color: kBodyTextColor),
        ),
      ),
      supportedLocales: [
        const Locale('en'),
        const Locale('el'),
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _country = "WorldWide";
  String infected = "0";
  String deaths = "0";
  String recovered = "0";

  String changeNumber(int number) {
    String newNumber;
    if (number >= 1000000) {
      int rest = (number / 1000000).round();
      newNumber = "${rest}M";
    } else if (number >= 1000) {
      int rest = (number / 1000).round();
      newNumber = "${rest}K";
    }
    return newNumber;
  }

  void getGlobalData() async {
    var url = 'https://api.covid19api.com/summary';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var global = jsonResponse["Global"];
      setState(() {
        infected = changeNumber(global["TotalConfirmed"]);
        deaths = changeNumber(global["TotalDeaths"]);
        recovered = changeNumber(global["TotalRecovered"]);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGlobalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              pageNum: 1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (Country country) async {
                            var url =
                                'https://disease.sh/v3/covid-19/countries/${country.countryCode}';
                            var response = await http.get(url);
                            if (response.statusCode == 200) {
                              var jsonResponse =
                                  convert.jsonDecode(response.body);
                              setState(() {
                                infected = changeNumber(jsonResponse["cases"]);
                                deaths = changeNumber(jsonResponse["deaths"]);
                                recovered =
                                    changeNumber(jsonResponse["recovered"]);
                              });
                            } else {
                              print(response.statusCode);
                            }
                            setState(() {
                              _country = country.displayNameNoCountryCode;
                            });
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_country),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextStyle,
                            ),
                            TextSpan(
                                text: "Newest Update Today",
                                style: TextStyle(
                                  color: kTextLightColor,
                                )),
                          ],
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        child: Text(
                          "See Research",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Detail();
                          }));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfextedColor,
                          number: infected,
                          title: "Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: deaths,
                          title: "Death",
                        ),
                        Counter(
                          color: kRecoveryColor,
                          number: recovered,
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextStyle,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Visit Website",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch('https://rishabh-goel.netlify.app');
                            },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: false,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 6.0,
                      dotIncreasedColor: Color(0xFFFF335C),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.topRight,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      images: [
                        ExactAssetImage("assets/images/coronavirus-cases.png"),
                        ExactAssetImage("assets/images/coronavirus-death.png")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
