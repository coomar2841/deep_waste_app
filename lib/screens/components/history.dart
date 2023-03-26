import 'package:flutter/material.dart';
import 'package:deep_waste/constants/size_config.dart';

import 'items.dart';

class History extends StatelessWidget {
  const History({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20),
            child: Text(
              "Let's recycle",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )),
            Items()
          ],
        ));
  }
}
