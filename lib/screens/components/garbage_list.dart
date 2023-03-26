import 'package:flutter/material.dart';
import 'package:garbage_manager/constants/size_config.dart';
import 'package:garbage_manager/database_manager.dart';
import 'package:garbage_manager/models/Item.dart';

import 'garbage_item_widget.dart';

class GarbageItemList extends StatefulWidget {
  final String predictedItem;

  const GarbageItemList({Key key, this.predictedItem}) : super(key: key);

  @override
  _GarbageItemListState createState() => _GarbageItemListState();
}

class _GarbageItemListState extends State<GarbageItemList> {
  @override
  Widget build(BuildContext context) {
    print("Predicted item is: ${widget.predictedItem}");
    return Container(
        padding: EdgeInsets.only(top: getProportionateScreenWidth(10)),
        child: FutureBuilder<List<Item>>(
            future: DatabaseManager.instance.getItems(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Loading"));
              }
              return snapshot.data?.isEmpty == true
                  ? Center(child: Text('No items found'))
                  : Column(
                      children: snapshot.data?.map((item) {
                        return Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          3, 3), // changes position of shadow
                                    ),
                                    widget.predictedItem.toLowerCase() == item.name.toLowerCase() ?
                                    BoxShadow(
                                      color: Colors.yellow.shade50,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          3, 3), // changes position of shadow
                                    ):BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ], //add it here
                                ),
                                child: GarbageItem(item: item)));
                      })?.toList(),
                    );
            }));
  }
}
