import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget{
  final List<Widget> children;
  const AppNavBar({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntrinsicHeight(
        child: Container(
          // height: kBottomNavigationBarHeight,
          margin: const EdgeInsets.symmetric(horizontal: 25).copyWith(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(38, 43, 58, 0.9),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children
          ),
        ),
      ),
    );
  }

}