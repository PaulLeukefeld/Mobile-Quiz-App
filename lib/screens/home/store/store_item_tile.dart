import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/buttons/store_item_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/models/store_item.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/loading.dart';

class StoreItemTile extends StatelessWidget {
  final StoreItem storeItemData;
  StoreItemTile({this.storeItemData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user.uid).userMetaData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 0.1,
                        size.height * 0, size.width * 0, size.height * 0),
                    child: Text(storeItemData.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        size.height * 0.0475,
                        size.width * 0.05,
                        size.height * 0.0475,
                        size.height * 0.01),
                    width: size.width,
                    child: Text(storeItemData.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      size.width * 0.095,
                      size.height * 0.02,
                      size.width * 0.095,
                      size.height * 0.03),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: storeItemData.subName.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0,
                              size.height * 0,
                              size.width * 0,
                              size.height * 0.005),
                          child: StoreItemButton(
                            onPressed: () {},
                            name: storeItemData.subName[index],
                            value: storeItemData.subValue[index],
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(storeItemData.hint)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Kauf Wiederherstellen",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                )
              ],
            ));
          } else {
            return Loading();
          }
        });
  }
}
