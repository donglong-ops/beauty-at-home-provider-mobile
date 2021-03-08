import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class ServiceDetailStepDescription extends StatelessWidget {
  final List<String> description;

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
          padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Text(
            'CÁC BƯỚC LÀM DỊCH VỤ',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: Colors.white,
          height: screenSize.height * 0.35,
          child: ListView.builder(
              itemCount: description.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                  width: screenSize.width * 0.8,
                  child: Text(description[index],
                  style: TextStyle(
                    fontSize: 15.0
                  ),),
                );
              }),
        ),
      ],
    );
  }
}
