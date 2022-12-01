import 'package:flutter/material.dart';

import '../strings.dart';
import '../styles.dart';
import '../themes.dart';

PreferredSizeWidget appBar({required String name, required IconData icon}) =>
    AppBar(
      elevation: 0.0,
      backgroundColor: AppTheme.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppTheme.white,
            radius: Corners.xl + 8,
            child: CircleAvatar(
              radius: Corners.xl + 6,
              backgroundImage: NetworkImage(
                  "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg"),
            ),
          ),
          SizedBox(
            width: Insets.sm, // your of space
          ),
          RichText(
            text: TextSpan(
                style: TextStyles.primary
                    .copyWith(color: AppTheme.darkYellow, fontSize: 10),
                children: [
                  TextSpan(
                      text: Strings.hello,
                      style: TextStyles.primary.copyWith(
                          color: AppTheme.darkYellow,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  WidgetSpan(
                      child: SizedBox(
                    width: Insets.xs, // your of space
                  )),
                  TextSpan(
                    text: name,
                    style: TextStyles.primary.copyWith(
                        color: AppTheme.darkYellow,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ]),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: Icon(icon, color: AppTheme.darkYellow))
        ],
      ),
    );
