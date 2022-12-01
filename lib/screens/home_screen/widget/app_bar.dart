import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: SvgPicture.asset(
          'assets/images/List.svg',
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            "assets/images/MagnifyingGlass.svg",
          ),
        ),
      ],
    );
  }
}
