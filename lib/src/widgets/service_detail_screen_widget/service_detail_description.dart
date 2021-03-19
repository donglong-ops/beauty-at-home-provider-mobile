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
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      initialValue: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextFormField(
                      initialValue: price + " đ",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                initialValue: note,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      ),
    );
  }
}
