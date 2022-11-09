import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(children: const [
          Icon(FontAwesomeIcons.chevronLeft),
          Spacer(),
          Icon(FontAwesomeIcons.message),
          SizedBox(width: 20.0),
          Icon(FontAwesomeIcons.headphonesSimple),
          SizedBox(width: 20.0),
          Icon(FontAwesomeIcons.upRightFromSquare)
        ]),
      ),
    );
  }
}
