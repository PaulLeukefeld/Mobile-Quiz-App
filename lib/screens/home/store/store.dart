import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/models/store_item.dart';
import 'package:mobile_quiz_app/screens/home/store/store_item_list.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/loading.dart';
import 'package:flutter/services.dart';

///Store page, which allows the user to buy in app products
class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    ///Setting the device orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Variable thats used to determin the screen dimensionss
    Size size = MediaQuery.of(context).size;

    ///User provider variable to read and update user data
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user.uid).userMetaData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: HexColor("#F3F4F5"),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: size.width * 0.1),
                    Text("Shop",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold))
                  ]),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          child: StreamProvider<List<StoreItem>>.value(
                              initialData: [null],
                              value: DatabaseService().storeItemsData,
                              child: StoreItemList()),
                          color: HexColor("#F3F4F5"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
