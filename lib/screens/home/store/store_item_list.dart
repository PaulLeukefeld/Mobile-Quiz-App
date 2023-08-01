import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/store_item.dart';
import 'package:mobile_quiz_app/screens/home/store/store_item_tile.dart';

class StoreItemList extends StatefulWidget {
  @override
  _StoreItemListState createState() => _StoreItemListState();
}

class _StoreItemListState extends State<StoreItemList> {
  @override
  Widget build(BuildContext context) {
    final storeItems = (Provider.of<List<StoreItem>>(context) == null)
        ? []
        : Provider.of<List<StoreItem>>(context);
    print(storeItems.length);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: storeItems.length,
        itemBuilder: (context, index) {
          return StoreItemTile(storeItemData: storeItems[index]);
        });
  }
}
