import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';
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
        SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
                itemCount: description.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      initialValue: description[index],
                      decoration: InputDecoration(
                        hintText: 'Miêu tả các bước',
                        hintStyle:
                        CustomTextStyle.subtitleText(Colors.black45),
                        prefix: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text('Bước  ${index + 1} :',style: TextStyle(fontSize: 15),),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
