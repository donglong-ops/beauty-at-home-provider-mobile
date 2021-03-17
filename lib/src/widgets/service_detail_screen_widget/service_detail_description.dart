import 'package:flutter/material.dart';

class ServiceDetailDescription extends StatelessWidget {
  final String name;
  final String note;
  final String price;

  const ServiceDetailDescription({Key key, this.name, this.note, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey[200], offset: Offset(0.0, 8.0))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: TextFormField(
                     initialValue: name,
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    initialValue: price + " đ",
                  )),
            ],
          ),
          Container(
              padding: EdgeInsets.only(left: 10.0),
              child: TextFormField(
                initialValue: note,
              )
          ),
        ],
      ),
    );
  }
}
