import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/booking_model.dart';
import 'package:flutter_app/src/providers/booking_provider.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:flutter_app/src/utils/widgets_utils.dart';
import 'package:flutter_app/src/view/cancel_reason.dart';
import 'package:flutter_app/src/view/provider_newOrder_Screen.dart';
import 'package:flutter_app/src/widgets/google_map_service/google_service.dart';
import 'package:flutter_app/src/widgets/shared_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProviderScreen extends StatefulWidget {
  final bool noContent;
  final bool isSwiched;

  const ProviderScreen({Key key, this.noContent = false, this.isSwiched})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProviderScreenState();
}

String currentAddress = "";

class _ProviderScreenState extends State<ProviderScreen> {
  int tab = 1;
  Color colorTap1 = Color(0x2d27beba);
  Color colorTap2 = Colors.white;
  Color colorTap3 = Colors.white;
  Color colorTap4 = Colors.white;
  int index = 0;
  bool isSwiched = true;

  @override
  void initState() {
    super.initState();
    getUserLocation();
    if (widget.isSwiched != null) {
      isSwiched = widget.isSwiched;
    }
    String accountId = context.read<UserProfile>().profile.uid.toString();
    context.read<BookingProvider>().initAllBooking(
        "https://beautyathome2.azurewebsites.net/api/v1.0/bookings?BeautyArtistAccountId=" +
            accountId);
  }

  getUserLocation() async {
    Location location = new Location();
    LocationData myLocation;
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      myLocation = null;
    }
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      currentAddress = first.addressLine;
    });
  }

  getDistance() async {
    Location location = new Location();
    LocationData myLocation;
    myLocation = await location.getLocation();
    // Geocoder geocoder = new Geocoder(this, addRess);
    //final double distance = Geolocator.distanceBetween(10.8418324, 106.8071312, myLocation.latitude, myLocation.longitude);
    final double distance = Geolocator.distanceBetween(
        10.8418324, 106.8071312, 10.8220246, 106.80624);
    print("nè nè : " + (distance / 1000).toString());
  }

  Widget title(BuildContext context) {
    if (this.isSwiched == true)
      return (Row(
        children: [
          Card(
            color: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                  width: 0.2,
                )),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.done_outlined,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
          Text(
            ' Hiện bạn có thể nhận đơn!',
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black),
          ),
        ],
      ));
    else
      return (Row(
        children: [
          Card(
            color: Colors.orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                  width: 0.2,
                )),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                FontAwesomeIcons.exclamation,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
          Text(
            'Hiện bạn không thể nhận đơn!',
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black),
          ),
        ],
      ));
  }

  @override
  Widget build(BuildContext context) {
    String status;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 0,
        backgroundColor: Colors.white,
        title: title(context),
        actions: [
          Switch(
              activeColor: Color(0xff256FEF),
              inactiveThumbColor: Color(0xff979797),
              activeTrackColor: Color(0xff256FEF),
              inactiveTrackColor: Color(0xff979797),
              value: isSwiched,
              onChanged: (value) {
                if (value) {
                  status = 'ACTIVE';
                } else {
                  status = "INACTIVE";
                }

                SimpleAPI.putAccountModel('accounts',
                    id: '21',
                    displayName: "Đồng Long",
                    phone: '0931180303',
                    status: status,
                    path: null);
                setState(() {
                  isSwiched = value;
                });
              }),
        ],
      ),
      body: Consumer<BookingProvider>(
        builder: (context, value, child) => value.bookings == null
            ? Text(" Bạn không có đơn nào ")
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(' Đơn của bạn',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 24,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tab = 1;
                                colorTap1 = Color(0x2d27beba);
                                colorTap2 = Colors.white;
                                colorTap3 = Colors.white;
                                colorTap4 = Colors.white;
                                index = 0;
                              });
                            },
                            child: SizedBox(
                              width: 80,
                              height: 24,
                              child: Material(
                                color: colorTap1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Chấp nhận (' +
                                        value.bookings
                                            .where((element) =>
                                                element.status == 'Xác nhận')
                                            .length
                                            .toString() +
                                        ')',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0x7f000000),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tab = 2;
                                colorTap2 = Color(0x2d27beba);
                                colorTap1 = Colors.white;
                                colorTap3 = Colors.white;
                                colorTap4 = Colors.white;
                                index = 1;
                              });
                            },
                            child: SizedBox(
                              width: 80,
                              height: 24,
                              child: Material(
                                color: colorTap2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Chuẩn bị (' +
                                        value.bookings
                                            .where((element) =>
                                                element.status ==
                                                'Đang trên đường')
                                            .length
                                            .toString() +
                                        ')',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0x7f000000),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tab = 3;
                                colorTap3 = Color(0x2d27beba);
                                colorTap1 = Colors.white;
                                colorTap2 = Colors.white;
                                colorTap4 = Colors.white;
                                index = 2;
                              });
                            },
                            child: SizedBox(
                              width: 84,
                              height: 24,
                              child: Material(
                                color: colorTap3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Đang làm (' +
                                        value.bookings
                                            .where((element) =>
                                                element.status == 'Đang làm')
                                            .length
                                            .toString() +
                                        ')',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0x7f000000),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tab = 4;
                                colorTap4 = Color(0x2d27beba);
                                colorTap2 = Colors.white;
                                colorTap3 = Colors.white;
                                colorTap1 = Colors.white;
                                index = 3;
                              });
                            },
                            child: SizedBox(
                              width: 88,
                              height: 24,
                              child: Material(
                                color: colorTap4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    'Hoàn thành (' +
                                        value.bookings
                                            .where((element) =>
                                                element.status == 'Hoàn thành')
                                            .length
                                            .toString() +
                                        ')',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0x7f000000),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildComponent(index, value),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: WidgetUtils.appBottomNavigationBar(1),
    );
  }

  Widget _buildComponent(int index, BookingProvider value) {
    switch (index) {
      case 0:
        return _buildAllBooking(value);
        break;
      case 1:
        return _buildPrepareBooking(value);
        break;
      case 2:
        return _buildDoingBooking(value);
        break;
      case 3:
        return _buildFinishBooking(value);
        break;
    }
  }

  Widget _buildAllBooking(BookingProvider value) {
    return Expanded(
      child: widget.noContent
          ? SizedBox()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: value.bookings.length,
              itemBuilder: (BuildContext buildContext, int index) {
                BookingModel booking = value.bookings[index];
                return (value.bookings[index].status.contains("Xác nhận"))
                    ? OutlinedCard(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(left: 4, right: 4),
                        width: 360,
                        sections: [
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: Row(
                                        children: [
                                          Text('SHA-' + booking.id),
                                          Card(
                                            color: Color(0xff707DB9),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                booking.status,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topRight,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          DateFormat('hh:mm dd-MM-yyyy').format(
                                              DateTime.parse(value
                                                  .bookings[index].createDate)),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 310,
                                      child: Row(
                                        children: [
                                          Icon(Icons.face),
                                          Text(
                                            ' Khách đặt: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                              '${booking.customerAccount.name}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Row(children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 15, right: 5),
                                        child:
                                            Icon(Icons.local_library_rounded)),
                                    Container(
                                      width: 270,
                                      child: Text(
                                        booking.endAddress,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ]),
                                  GestureDetector(
                                    onTap: () {
                                      MapUtils4.openMap(
                                          currentAddress, booking.endAddress);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 44,
                                        ),
                                        Text(
                                          'XEM BẢN ĐỒ',
                                          style: TextStyle(
                                              color: Color(0xff0DB5B4),
                                              fontSize: 11),
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Color(0xff0DB5B4),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 5),
                                      child: Icon(Icons.description_outlined)),
                                  Container(
                                      width: 270,
                                      child: Text(
                                        'Ghi chú: ${booking.note}',
                                        style: TextStyle(fontSize: 13),
                                      ))
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: booking.bookingDetails.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 6,
                              ),
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${booking.bookingDetails[index].quantity}  x',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text(
                                          booking.bookingDetails[index]
                                              .serviceName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(Utils.calculatePrice(
                                      booking
                                          .bookingDetails[index].servicePrice,
                                      booking.bookingDetails[index].quantity)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 315,
                                      child: Row(
                                        children: [
                                          Text('Tổng đơn: '),
                                          Text(Utils.formatPrice(
                                              booking.totalFee)),
                                          Card(
                                            color: Color(0xffC4C4C4),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Text(
                                                "CASH",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this.index = 1;
                                      colorTap2 = Color(0x2d27beba);
                                      colorTap1 = Colors.white;
                                      colorTap3 = Colors.white;
                                      colorTap4 = Colors.white;
                                    });
                                    SimpleAPI.put(
                                      'bookings',
                                      booking.id,
                                      headers: {
                                        "Accept": "application/json",
                                        "content-type": "application/json"
                                      },
                                      body: jsonEncode(<String, String>{
                                        'id': booking.id,
                                        'status': 'Đang trên đường',
                                      }),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 336,
                                    height: 40,
                                    child: Material(
                                      color: Color(0xff7899D4),
                                      borderRadius: BorderRadius.circular(5),
                                      clipBehavior: Clip.antiAlias,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 87,
                                          right: 88,
                                          top: 10,
                                          bottom: 9,
                                        ),
                                        child: Text(
                                          'CHUẨN BỊ XONG',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 1);
              }),
    );
  }

  Widget _buildPrepareBooking(BookingProvider value) {
    return Expanded(
      child: widget.noContent
          ? SizedBox()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: value.bookings.length,
              itemBuilder: (BuildContext buildContext, int index) {
                BookingModel booking = value.bookings[index];
                return (value.bookings[index].status
                        .contains("Đang trên đường"))
                    ? OutlinedCard(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(left: 4, right: 4),
                        width: 360,
                        sections: [
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: Row(
                                        children: [
                                          Text('SHA-' + booking.id),
                                          Card(
                                            color: Color(0xff707DB9),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                booking.status,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topRight,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          DateFormat('hh:mm dd-MM-yyyy').format(
                                              DateTime.parse(value
                                                  .bookings[index].createDate)),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 315,
                                      child: Row(
                                        children: [
                                          Icon(Icons.face),
                                          Text(
                                            ' Khách đặt: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                              '${booking.customerAccount.name} '),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      child: Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 35,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Row(children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 15, right: 5),
                                        child:
                                            Icon(Icons.local_library_rounded)),
                                    Container(
                                      width: 270,
                                      child: Text(
                                        booking.endAddress,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ]),
                                  GestureDetector(
                                    onTap: () {
                                      MapUtils4.openMap(
                                          currentAddress, booking.endAddress);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 44,
                                        ),
                                        Text(
                                          'XEM BẢN ĐỒ',
                                          style: TextStyle(
                                              color: Color(0xff0DB5B4),
                                              fontSize: 11),
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Color(0xff0DB5B4),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 5),
                                      child: Icon(Icons.description_outlined)),
                                  Container(
                                      width: 270,
                                      child: Text(
                                        'Ghi chú: ${booking.note}',
                                        style: TextStyle(fontSize: 13),
                                      ))
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: booking.bookingDetails.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 6,
                              ),
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${booking.bookingDetails[index].quantity}  x',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text(
                                          booking.bookingDetails[index]
                                              .serviceName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(Utils.formatPrice(booking
                                      .bookingDetails[index].servicePrice)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Text('Tổng đơn: '),
                                          Text(Utils.formatPrice(
                                              booking.totalFee)),
                                          Card(
                                            color: Color(0xffC4C4C4),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Text(
                                                "CASH",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  child: SizedBox(
                                      width: 336,
                                      height: 30,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                "Bạn có muốn hủy đơn không?",
                                              ),
                                              actions: [
                                                FlatButton(
                                                  textColor: Color(0xFF6200EE),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Không'),
                                                ),
                                                FlatButton(
                                                  textColor: Color(0xFF6200EE),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                      builder: (context) =>
                                                          CancelReason(),
                                                    ));
                                                    SimpleAPI.put(
                                                      'bookings',
                                                      booking.id,
                                                      headers: {
                                                        "Accept":
                                                            "application/json",
                                                        "content-type":
                                                            "application/json"
                                                      },
                                                      body: jsonEncode(<String,
                                                          String>{
                                                        'id': booking.id,
                                                        'status': 'Đã hủy',
                                                      }),
                                                    );
                                                  },
                                                  child: Text('Đồng ý'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Text("HỦY ĐƠN"),
                                      )),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this.index = 2;
                                      colorTap3 = Color(0x2d27beba);
                                      colorTap1 = Colors.white;
                                      colorTap2 = Colors.white;
                                      colorTap4 = Colors.white;
                                    });
                                    SimpleAPI.put(
                                      'bookings',
                                      booking.id,
                                      headers: {
                                        "Accept": "application/json",
                                        "content-type": "application/json"
                                      },
                                      body: jsonEncode(<String, String>{
                                        'id': booking.id,
                                        'status': 'Đang làm',
                                      }),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 336,
                                    height: 40,
                                    child: Material(
                                      color: Color(0xff7899D4),
                                      borderRadius: BorderRadius.circular(5),
                                      clipBehavior: Clip.antiAlias,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 87,
                                          right: 88,
                                          top: 10,
                                          bottom: 9,
                                        ),
                                        child: Text(
                                          'ĐÃ ĐẾN NƠI',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 1);
              }),
    );
  }

  Widget _buildDoingBooking(BookingProvider value) {
    return Expanded(
      child: widget.noContent
          ? SizedBox()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: value.bookings.length,
              itemBuilder: (BuildContext buildContext, int index) {
                BookingModel booking = value.bookings[index];
                return (value.bookings[index].status.contains("Đang làm"))
                    ? OutlinedCard(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(left: 4, right: 4),
                        width: 360,
                        sections: [
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 210,
                                      child: Row(
                                        children: [
                                          Text('SHA-' + booking.id),
                                          Card(
                                            color: Color(0xff707DB9),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                booking.status,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width: 120,
                                        child: value.bookings[index]
                                                    .createDate !=
                                                null
                                            ? Text(
                                                DateFormat('hh:mm dd-MM-yyyy')
                                                    .format(DateTime.parse(value
                                                        .bookings[index]
                                                        .createDate)),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text('9AM - 8PM'))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Icon(Icons.face),
                                          Text(
                                            ' Khách đặt: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                              '${booking.customerAccount.name} '),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Row(children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 15, right: 5),
                                        child:
                                            Icon(Icons.local_library_rounded)),
                                    Container(
                                      width: 270,
                                      child: Text(
                                        booking.endAddress,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ]),
                                  GestureDetector(
                                    onTap: () {
                                      MapUtils4.openMap(
                                          currentAddress, booking.endAddress);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 44,
                                        ),
                                        Text(
                                          'XEM BẢN ĐỒ',
                                          style: TextStyle(
                                              color: Color(0xff0DB5B4),
                                              fontSize: 11),
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Color(0xff0DB5B4),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 5),
                                      child: Icon(Icons.description_outlined)),
                                  Container(
                                      width: 270,
                                      child: Text(
                                        'Ghi chú: ${booking.note}',
                                        style: TextStyle(fontSize: 13),
                                      ))
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: booking.bookingDetails.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 6,
                              ),
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${booking.bookingDetails[index].quantity}  x',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text(
                                          booking.bookingDetails[index]
                                              .serviceName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(Utils.formatPrice(booking
                                      .bookingDetails[index].servicePrice)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Text('Tổng đơn: '),
                                          Text(Utils.formatPrice(
                                              booking.totalFee)),
                                          Card(
                                            color: Color(0xffC4C4C4),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Text(
                                                "CASH",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this.index = 3;
                                      this.isSwiched = true;
                                      colorTap4 = Color(0x2d27beba);
                                      colorTap2 = Colors.white;
                                      colorTap3 = Colors.white;
                                      colorTap1 = Colors.white;
                                    });
                                    SimpleAPI.put(
                                      'bookings',
                                      booking.id,
                                      headers: {
                                        "Accept": "application/json",
                                        "content-type": "application/json"
                                      },
                                      body: jsonEncode(<String, String>{
                                        'id': booking.id,
                                        'status': 'Hoàn thành',
                                      }),
                                    );
                                    SimpleAPI.putAccountModel(
                                      'accounts',
                                      id: '21',
                                      displayName: "Đồng Long",
                                      phone: '0931180303',
                                      status: "ACTIVE",
                                      path: null,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 336,
                                    height: 40,
                                    child: Material(
                                      color: Color(0xff7899D4),
                                      borderRadius: BorderRadius.circular(5),
                                      clipBehavior: Clip.antiAlias,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 87,
                                          right: 88,
                                          top: 10,
                                          bottom: 9,
                                        ),
                                        child: Text(
                                          "Đã Hoàn Thành",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 1);
              }),
    );
  }

  Widget _buildFinishBooking(BookingProvider value) {
    return Expanded(
      child: widget.noContent
          ? SizedBox()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: value.bookings.length,
              itemBuilder: (BuildContext buildContext, int index) {
                BookingModel booking = value.bookings[index];
                return (value.bookings[index].status.contains("Finish") ||
                        value.bookings[index].status.contains("Hoàn thành"))
                    ? OutlinedCard(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(left: 4, right: 4),
                        width: 360,
                        sections: [
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: Row(
                                        children: [
                                          Text('SHA-' + booking.id),
                                          Card(
                                            color: Color(0xff707DB9),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                booking.status,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          "Ngày hoàn thành: " +
                                              DateFormat('dd-MM-yyyy').format(
                                                  DateTime.parse(value
                                                      .bookings[index]
                                                      .updateDate)),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Icon(Icons.face),
                                          Text(
                                            ' Khách đặt: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                              '${booking.customerAccount.name}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Row(children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 15, right: 5),
                                        child:
                                            Icon(Icons.local_library_rounded)),
                                    Container(
                                      width: 270,
                                      child: Text(
                                        booking.endAddress,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ]),
                                  GestureDetector(
                                    onTap: () {
                                      MapUtils4.openMap(
                                          currentAddress, booking.endAddress);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 44,
                                        ),
                                        Text(
                                          'XEM BẢN ĐỒ',
                                          style: TextStyle(
                                              color: Color(0xff0DB5B4),
                                              fontSize: 11),
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Color(0xff0DB5B4),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 5),
                                      child: Icon(Icons.description_outlined)),
                                  Container(
                                      width: 270,
                                      child: Text(
                                        'Ghi chú: ${booking.note}',
                                        style: TextStyle(fontSize: 13),
                                      ))
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: booking.bookingDetails.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 6,
                              ),
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${booking.bookingDetails[index].quantity}  x',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text(
                                          booking.bookingDetails[index]
                                              .serviceName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(Utils.formatPrice(booking
                                      .bookingDetails[index].servicePrice)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Text('Tổng đơn: '),
                                          Text(Utils.formatPrice(
                                              booking.totalFee)),
                                          Card(
                                            color: Color(0xffC4C4C4),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Text(
                                                "CASH",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 1);
              }),
    );
  }
}
