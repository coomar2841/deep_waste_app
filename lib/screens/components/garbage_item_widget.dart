import 'package:flutter/material.dart';
import 'package:garbage_manager/constants/app_properties.dart';
import 'package:garbage_manager/constants/size_config.dart';
import 'package:garbage_manager/models/Item.dart';

class GarbageItem extends StatelessWidget {
  const GarbageItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(90),
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(item.imageURL)),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenWidth(14)),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "${item.count} items",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenWidth(12)),
                  ),
                )
              ],
            )
          ],
        );
  }
}
