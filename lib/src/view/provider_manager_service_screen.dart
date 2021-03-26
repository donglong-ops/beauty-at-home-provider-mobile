import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/service_model_new.dart';
import 'package:flutter_app/src/models-new/service_type_model.dart';
import 'package:flutter_app/src/providers/service_provider.dart';
import 'package:flutter_app/src/providers/service_type_provider.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:flutter_app/src/utils/widgets_utils.dart';
import 'package:flutter_app/src/view/add_new_service_screen.dart';
import 'package:flutter_app/src/view/service_detail_screen2.dart';
import 'package:provider/provider.dart';

class ProviderManagerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProviderManagerScreenStage();
}

class _ProviderManagerScreenStage extends State<ProviderManagerScreen> {
  bool status = true;
  bool state = true;
  int count;
  Color bgColorActive = Color(0x2d27beba);
  Color bgColorDis = Colors.white;
  String accountId;

  @override
  void initState() {
    accountId = context.read<UserProfile>().profile.uid.toString();
    context.read<ServiceTypeProvider>().initAllServiceType("https://beauty-at-home-4a5ss6e6yq-as.a.run.app/api/v1.0/service-types");
    context.read<ServiceProvider>().initAllService(
        "https://beauty-at-home-4a5ss6e6yq-as.a.run.app/api/v1.0/services?AccountId=" +
            accountId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ServiceProvider>(
        builder: (context, value, child) => value.services == null
            ? Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Text(" Bạn không có dịch vụ cup cấp nào ")),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.7),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddNewServiceScreen(),
                        ));
                      },
                      backgroundColor: Colors.lightBlueAccent,
                      label: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Thêm mới dịch vụ',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 4),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Stack(children: <Widget>[
                Column(
                  children: <Widget>[
                    ProviderImage(
                      path:
                          'https://2.bp.blogspot.com/-9ruLiOtWFX8/WsIGOAa0gPI/AAAAAAAAARs/IZUvPw4h5aEmFMqgfGy3Arr8cv6L3gy2wCLcBGAs/s1600/huong-dan-cach-trang-diem-mat-dep.jpg',
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: screenSize.width * 0.95,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.services[0].account.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Trang điểm và làm móng",
                            //value.services[0].account.,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: value.services.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          ServiceModelNew service = value.services[index];
                          return GestureDetector(
                            onTap: () {
                              _navigateAndDisplaySelection(context, service);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, bottom: 10),
                                  width: 80,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: (service.gallery.images.length > 0)
                                          ? NetworkImage(service
                                              .gallery.images[0].imageUrl)
                                          : NetworkImage(
                                              'https://images.unsplash.com/photo-1579159279743-4c5fefb3ba11?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80'),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 195,
                                  margin: EdgeInsets.only(top: 13),
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 13),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              service.serviceName,
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 13),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              Utils.formatPrice(service.price),
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.lightBlueAccent
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 65,
                                    height: 26,
                                    child: Switch(
                                      value: service.status == 'Active'
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        String status = "";
                                        print(service.serviceType.name);
                                        if (value) {
                                          status = "Active";
                                        } else
                                          status = "Inactive";
                                        // SimpleAPI.put(
                                        //   'services',
                                        //   service.serviceID,
                                        //   headers: {
                                        //     "Accept": "application/json",
                                        //     "content-type": "application/json",
                                        //   },
                                        //   body: jsonEncode(<String, String>{
                                        //     'id': service.serviceID,
                                        //     'description': service.description,
                                        //     'summary': service.summary,
                                        //     'price': service.price,
                                        //     'serviceName': service.serviceName,
                                        //     'estimateTime': service.estimateTime,
                                        //     'accountId': service.account.id,
                                        //     'serviceTypeId': service.serviceType.id.toString(),
                                        //     'status': status,
                                        //     'galleryId': service.gallery.id.toString(),
                                        //     'file': null,
                                        //   }),
                                        // );

                                        SimpleAPI.putServiceModel('services',id:
                                            service.serviceID,
                                            serviceName: service.serviceName,
                                            summary: service.summary ,
                                            price: service.price,
                                            estimateTime: '30',
                                            status: status,
                                            description: service.description,
                                            galleryId: service.gallery.id.toString(),
                                            accountId: service.account.id,
                                            serviceTypeId: service.serviceType.id,
                                        );
                                        setState(() {
                                          if (value) {
                                            service.status = 'Active';
                                          } else
                                            service.status = 'Inactive';
                                        });
                                      },
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(
                        left: 4,
                        right: 4,
                        bottom: 5,
                      ),
                      child: FloatingActionButton.extended(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddNewServiceScreen(),
                          ));
                        },
                        backgroundColor: Colors.lightBlueAccent,
                        label: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Thêm mới dịch vụ',
                              style: TextStyle(
                                  color: Colors.white, letterSpacing: 4),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
      ),
      bottomNavigationBar: WidgetUtils.appBottomNavigationBar(2),
    );
  }
}

class ServiceItem {
  final String image;
  final String salonOwner;
  final String titleService;
  final String note;
  final double rate;
  final String area;
  final String timeLine;
  final String price;
  String range;
  String status;
  List<String> description;

  ServiceItem({
    this.image,
    this.salonOwner,
    this.titleService,
    this.rate,
    this.area,
    this.timeLine,
    this.status,
    this.range,
    this.price,
    this.description,
    this.note,
  });
}

_navigateAndDisplaySelection(BuildContext context, ServiceModelNew service) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ServiceDetailScreen2(
              service: service,
            )),
  );
}

class ProviderImage extends StatelessWidget {
  final String path;
  const ProviderImage({
    Key key,
    this.path,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 1.0),
          child: Hero(
            tag: this.path,
            child: ClipRRect(
              child: Image(
                image: NetworkImage(this.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
        //   child: Row(
        //     children: <Widget>[
        //       IconButton(
        //         icon: Icon(Icons.arrow_back_ios_outlined),
        //         iconSize: 30.0,
        //         color: Colors.black,
        //         onPressed: () => Navigator.pop(context),
        //       ),
        //       // Container(
        //       //     width: 300,
        //       //     alignment: Alignment.topRight,
        //       //     child: AnimatedSearchBar()),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
