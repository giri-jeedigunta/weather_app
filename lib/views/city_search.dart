import 'package:flutter/material.dart';

class CitySearch extends StatefulWidget {
  static String routeName = 'CitySearchView';
  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment(
              0.5,
              0.5,
            ), // 10% of the width, so there are ten blinds.
            colors: [
              Color(0xff6ABDCB),
              Color(0xFFFFFFFF),
            ], // whitish to gray
          ),
        ),
        child: const Hero(
          child: Text('dsds'
          ),
          tag: 'city',
        ),
      );
}
