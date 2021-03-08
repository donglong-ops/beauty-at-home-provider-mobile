import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/widgets_utils.dart';
import 'package:flutter_app/src/view/provider_detail_screen.dart';
import 'package:flutter_app/src/widgets/provider_detail_screen_widget.dart';

class ProviderManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
    );
  }
}

List<ServiceItem> lstServiceActive = List.from([
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Hani Nguyễn',
      titleService: 'Làm nail - Làm tóc',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_1.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_3.png',
      salonOwner: 'Marry Trần',
      titleService: 'Trang điểm - Làm tóc',
      area: 'Quận 10, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Aleck Marry',
      titleService: 'Combo làm tóc,trang điểm',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_1.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/mit_nails_spa.png',
      salonOwner: 'Mít Nail & Spa',
      titleService: 'Làm nail - Làm tóc',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/mit_nails_spa.png',
      salonOwner: 'Mít Nail & Spa',
      titleService: 'Làm nail - Làm tóc',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_3.png',
      salonOwner: 'Marry Trần',
      titleService: 'Trang điểm - Làm tóc',
      area: 'Quận 10, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_1.jpg',
      salonOwner: 'Aleck Marry',
      titleService: 'Combo làm tóc,trang điểm',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Hani Nguyễn',
      titleService: 'Làm nail - Làm tóc',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_1.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_3.png',
      salonOwner: 'Marry Trần',
      titleService: 'Trang điểm - Làm tóc',
      area: 'Quận 10, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Aleck Marry',
      titleService: 'Combo làm tóc,trang điểm',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_1.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
]);

List<ServiceItem> lstServiceDis = List.from([
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Aleck Marry',
      titleService: 'Combo làm tóc,trang điểm',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_1.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_2.jpg',
      salonOwner: 'Hani Nguyễn',
      titleService: 'Làm nail - Làm tóc',
      area: 'Quận 2, TP. Hồ Chí Minh',
      range: '2.3 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_1.jpg',
      salonOwner: 'Tony Đặng',
      titleService: 'Massage - Giác hơi',
      area: 'Quận 1, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
  ServiceItem(
      image: 'public/img/nail_3.png',
      salonOwner: 'Marry Trần',
      titleService: 'Trang điểm - Làm tóc',
      area: 'Quận 10, TP. Hồ Chí Minh',
      range: '5 km',
      rate: 4.8,
      timeLine: '9:00 AM - 8:30 PM',
      status: 'Đang hoặt động',
      price: '50.000 - 500.000'),
]);

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  bool status = true;
  Color bgColorActive =  Color(0x2d27beba);
  Color bgColorDis = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            ProviderImage(
              path: 'public/img/mit_nails_spa.png',
            ),
            Container(
                alignment: Alignment.center,
                child: Text('Mit Nail & Spa',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
            Container(
                alignment: Alignment.center,
                child: Text('Chăm sóc tóc và móng',style: TextStyle(fontSize: 20),)),
            SizedBox(height: 10),
            SizedBox(height: 5),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 5),
                height: 35,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          bgColorDis = Colors.white;
                          bgColorActive = Color(0x2d27beba);
                          status = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 6),
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 35,
                        child: Material(
                          color: bgColorActive,
                          // color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: Color(0xff28beba),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 6,top: 6,bottom: 5,),
                            child: Text(
                              "Tất cả dịch vụ (${lstServiceActive.length})",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff0db5b4),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          bgColorActive = Colors.white;
                          bgColorDis = Color(0x2d27beba);
                          status = false;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 3),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 35,
                        child: Material(
                          color: bgColorDis,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: Color(0x60000000),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17, right: 16, top: 6, bottom: 5,),
                            child: Text(
                              "Dịch vụ đã dừng (${lstServiceDis.length})",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0x7f000000),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
            status ? LoadServicesActive() : LoadServicesDisable()
          ],
        ),
      ]),
      bottomNavigationBar: WidgetUtils.appBottomNavigationBar(2),
    );
  }
}

class ServiceItem {
  final String image;
  final String salonOwner;
  final String titleService;
  final double rate;
  final String area;
  final String timeLine;
  final String price;
  String range;
  String status;

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
  });
}


class LoadServicesActive extends StatefulWidget {
  @override
  _LoadServicesActiveState createState() => _LoadServicesActiveState();
}
class _LoadServicesActiveState extends  State<LoadServicesActive> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: lstServiceActive.length,
        itemBuilder: (BuildContext buildContext, int index) {
          ServiceItem service = lstServiceActive[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProviderDetailScreen(),
              ));
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(service.image),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 160,
                              child: Text(
                                service.titleService,
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              width: 65,
                              height: 26,
                              child: CustomSwitch(
                                value: true,
                                activeColor: Colors.blue,
                                onChanged: (value){
                                  print('value is: $value' );
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${service.price} đ',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.lightBlueAccent.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class LoadServicesDisable extends StatefulWidget {
  @override
  _LoadServicesDisableState createState() => _LoadServicesDisableState();
}
class _LoadServicesDisableState extends State<LoadServicesDisable> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: lstServiceDis.length,
        itemBuilder: (BuildContext buildContext, int index) {
          ServiceItem service = lstServiceDis[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProviderDetailScreen(),
              ));
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(service.image),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 160,
                              child: Text(
                                service.titleService,
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              width: 65,
                              height: 26,
                              child: CustomSwitch(
                                value: false,
                                activeColor: Colors.blue,
                                onChanged: (value){
                                  print('value is: $value' );
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${service.price} đ',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.lightBlueAccent.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class AnimatedSearchBar extends StatefulWidget {
  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _folded ? 50 : 350,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: !_folded
                  ? TextField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.blue[300]),
                        border: InputBorder.none),
                    )
                  : null,
            ),
          ),
          Container(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 32 : 0),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_folded ? 32 : 0),
                  bottomRight: Radius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    size: 18,
                    color: Colors.blue[900],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
