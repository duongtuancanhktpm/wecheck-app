import 'package:flutter/material.dart';

import '../../theme/colors.dart';

Widget indicatorSignIn(Color color1, Color color2, Color color3, Color color4, Color color5, Color color6) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: color1),
                  height: 8,
                ))),
        Expanded(
            flex: 1,
            child: Padding(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: color2),
                height: 8,
              ),
              padding: const EdgeInsets.all(3),
            )),
        Expanded(
            flex: 1,
            child: Padding(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: color3),
                height: 8,
              ),
              padding: const EdgeInsets.all(3),
            )),
        Expanded(
            flex: 1,
            child: Padding(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: color4),
                height: 8,
              ),
              padding: const EdgeInsets.all(3),
            )),
        Expanded(
            flex: 1,
            child: Padding(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: color5),
                height: 8,
              ),
              padding: const EdgeInsets.all(3),
            )),
        Expanded(
            flex: 1,
            child: Padding(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: color6),
                height: 8,
              ),
              padding: const EdgeInsets.all(3),
            )),
      ],
    ),
  );
}
