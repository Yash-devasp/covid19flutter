import 'package:covid19/widgets/infoscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';

class MyHeader extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final int pageNum;

  const MyHeader({
    Key key,
    this.image,
    this.textTop,
    this.textBottom,
    this.pageNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 40, top: 50, right: 20),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/virus.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: pageNum == 1 ? Alignment.topRight : Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  if (pageNum == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return InfoScreen();
                      }),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: pageNum == 1
                    ? SvgPicture.asset("assets/icons/menu.svg")
                    : Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  SvgPicture.asset(
                    image,
                    width: pageNum==3?200:250,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                    top: 20,
                    left: pageNum==3?180:150,
                    child: Text(
                      "$textTop \n$textBottom",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(), // the text is not appearing without it.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
