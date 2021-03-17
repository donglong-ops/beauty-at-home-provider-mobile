import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_description.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_image.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_step_description.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';

class AddNewServiceScreen extends StatefulWidget {
  final ServiceItem service;

  const AddNewServiceScreen({Key key, this.service}) : super(key: key);

  @override
  _AddNewServiceScreenState createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 1.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0
                        ),
                      ],
                    ),
                    child: Container(
                      child: ClipRRect(
                        child: Image(
                          image: AssetImage('ccc'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 25.0),
                    child: Row(
                      children: <Widget>[
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.white,),
                          iconSize: 30.0,
                          color: Colors.black,
                        ),
                      )
                    ],),
                  ),
                ],
              ),
              Container(
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: TextFormField(
                              initialValue: " ",
                              decoration: InputDecoration(
                                hintText: 'Tên Dịch vụ',
                                hintStyle: CustomTextStyle.subtitleText(Colors.black45),
                              ),
                            )
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                            child: TextFormField(
                              initialValue: " ",
                              decoration: InputDecoration(
                                hintText: 'Giá dịch vụ',
                                hintStyle: CustomTextStyle.subtitleText(Colors.black45),
                              ),
                            )
                        ),
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(right: 10.0),
                        child: TextFormField(
                          initialValue: " ",
                          decoration: InputDecoration(
                            hintText: 'Miêu tả dịch vụ',
                            hintStyle: CustomTextStyle.subtitleText(Colors.black45),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Text(
                      'CÁC BƯỚC LÀM DỊCH VỤ',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: " ",
                            decoration: InputDecoration(
                              hintText: 'Miêu tả các bước',
                              hintStyle: CustomTextStyle.subtitleText(Colors.black45),
                              prefix: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Bước  1 :',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: " ",
                            decoration: InputDecoration(
                              hintText: 'Miêu tả các bước',
                              hintStyle:
                                  CustomTextStyle.subtitleText(Colors.black45),
                              prefix: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Bước  2 :',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: " ",
                            decoration: InputDecoration(
                              hintText: 'Miêu tả các bước',
                              hintStyle:
                                  CustomTextStyle.subtitleText(Colors.black45),
                              prefix: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Bước  3 :',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: " ",
                            decoration: InputDecoration(
                              hintText: 'Miêu tả các bước',
                              hintStyle:
                                  CustomTextStyle.subtitleText(Colors.black45),
                              prefix: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Bước  4 :',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: " ",
                            decoration: InputDecoration(
                              hintText: 'Miêu tả các bước',
                              hintStyle:
                                  CustomTextStyle.subtitleText(Colors.black45),
                              prefix: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Bước  5 :',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: " ",
                            decoration: InputDecoration(
                              hintText: 'Miêu tả các bước',
                              hintStyle:
                                  CustomTextStyle.subtitleText(Colors.black45),
                              prefix: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Bước  6 :',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProviderManagerScreen(),
                  ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(1.0),
                      ),
                    ),
                    backgroundColor: Colors.grey,
                    label: Text(
                      'Lưu mới',
                      style: TextStyle(color: Colors.white, letterSpacing: 4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
