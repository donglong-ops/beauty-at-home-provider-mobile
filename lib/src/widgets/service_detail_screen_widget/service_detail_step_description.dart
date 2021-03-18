import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';
import 'package:flutter_map/flutter_map.dart';

class ServiceDetailStepDescription extends StatelessWidget {
  final List<String> description;

  String getFromList(List<String> list) {
    String list = "";
    for (int i = 0; i < description.length; i++) {
      list = list + description[i].toString() + '\n';
    }
    return list;
  }

  const ServiceDetailStepDescription({Key key, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10.0, bottom: 2),
            child: Text(
              'CÁC BƯỚC LÀM DỊCH VỤ',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    //initialValue: description[index],
                    initialValue: getFromList(description),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 11,
                  ),
                ),
              ),
            ),
          )
        ]);
  }
}
