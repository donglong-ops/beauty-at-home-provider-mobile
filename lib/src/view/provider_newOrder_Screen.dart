import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/booking_model.dart';
import 'package:flutter_app/src/providers/booking_provider.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/utils/firebase_helper.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:flutter_app/src/utils/widgets_utils.dart';
import 'package:flutter_app/src/view/provider_confirm_screen.dart';
import 'package:flutter_app/src/widgets/google_map_service/google_service.dart';
import 'package:flutter_app/src/widgets/shared_widget.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProviderNewOderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProviderNewOderScreenState();
}

Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return ProviderNewOderScreenState()._showNotification(message);
}

class ProviderNewOderScreenState extends State<ProviderNewOderScreen> {
  FlutterLocalNotificationsPlugin notiPlugin =
      FirebaseHelper.flutterLocalNotiInstance();

  final FirebaseMessaging _firebaseMessaging = FirebaseHelper.fcmInstance();

  Future _showNotification(Map<String, dynamic> message) async {
    await notiPlugin.show(
      0,
      'new message arived',
      '${message['data']['title']} for ${message['data']['price']}',
      FirebaseHelper.platformSpecInstance(),
      payload: 'Default_Sound',
    );
  }

  getTokenz() async {
    String token = await _firebaseMessaging.getToken();
    print(token);
  }

  Future selectNotification(String payload) async {
    await notiPlugin.cancelAll();
  }

  void initPushNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    notiPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    super.initState();
    _firebaseMessaging.configure(
      onBackgroundMessage: myBackgroundHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        String notiType = message['data']['notiType'];
        int index = -1;
        if (notiType == "booking_created") {
          String bookingId = message['data']['bookingId'];
          context.read<BookingProvider>().getAndAddNewBooking(bookingId);
        }
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // title: Column(
                //   children: [
                //     ClipRRect(
                //       child: Text(message['notification']['title']),
                //       borderRadius: BorderRadius.all(Radius.circular(4)),
                //     ),
                //   ],
                // ),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    message['notification']['title'] + '\n',
                    style: CustomTextStyle.statusText(Colors.black),
                  ),
                  Text(
                    '${message['notification']['body']}',
                    style: CustomTextStyle.subtitleText(Colors.black54),
                  ),
                ]),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
    var userId = context.read<UserProfile>().profile.uid;
    String topic = "booking_created_id_" + userId.toString();
    log(topic);
    getTokenz();
    _firebaseMessaging.subscribeToTopic(topic);
  }

  final CountdownController controller = CountdownController();
  double minute = 20;
  String currentAddress = "";
  UserProfile userFo;
  @override
  void initState() {
    initPushNotification();
    getUserLocation();
    userFo = context.read<UserProfile>();
    context.read<BookingProvider>().initAllNewBooking(
        "https://beauty-at-home.azurewebsites.net/api/v1.0/bookings?status=M???i&BeautyArtistAccountId=" +
            userFo.profile.uid.toString());
  }

  getUserLocation() async {
    LocationData myLocation;
    Location location = new Location();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 0,
        backgroundColor: Colors.white,
        title: Text(
          '????n m???i c?? th??? nh???n',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<BookingProvider>(
        builder: (context, value, child) => value.bookings == null ||
                value.bookings.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                  " B???n kh??ng c?? ????n m???i n??o ",
                  style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                )))
            : Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: value.bookings.length,
                            itemBuilder:
                                (BuildContext buildContext, int index) {
                              BookingModel booking = value.bookings[index];
                              return (value.bookings[index].status
                                      .contains("M???i"))
                                  ? OutlinedCard(
                                      margin: EdgeInsets.only(top: 4),
                                      padding:
                                          EdgeInsets.only(left: 4, right: 4),
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
                                                        Text('SHA-' +
                                                            booking.id),
                                                        Card(
                                                          color:
                                                              Color(0xff707DB9),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child: Text(
                                                              booking.status,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 100,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      width: 120,
                                                      child: value
                                                                  .bookings[
                                                                      index]
                                                                  .createDate !=
                                                              null
                                                          ? Text(
                                                              DateFormat(
                                                                      'hh:mm dd-MM-yyyy')
                                                                  .format(DateTime.parse(value
                                                                      .bookings[
                                                                          index]
                                                                      .createDate)),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text('9AM - 8PM'))
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
                                                          ' Kh??ch ?????t: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                        Text(
                                                            '${booking.customerAccount.name}'),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 10,
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_sharp,
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
                                                      margin: EdgeInsets.only(
                                                          left: 15, right: 5),
                                                      child: Icon(Icons
                                                          .local_library_rounded)),
                                                  Container(
                                                    width: 270,
                                                    child: Text(
                                                      booking.endAddress,
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ]),
                                                GestureDetector(
                                                  onTap: () {
                                                    MapUtils4.openMap(
                                                        currentAddress,
                                                        booking.endAddress);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 44,
                                                      ),
                                                      Text(
                                                        'Xem b???n ?????',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff0DB5B4),
                                                            fontSize: 11),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color:
                                                            Color(0xff0DB5B4),
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
                                                    margin: EdgeInsets.only(
                                                        left: 15, right: 5),
                                                    child: Icon(Icons
                                                        .description_outlined)),
                                                Container(
                                                    width: 270,
                                                    child: Text(
                                                      'Ghi ch??: ${booking.note}',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            itemCount:
                                                booking.bookingDetails.length,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              height: 6,
                                            ),
                                            itemBuilder: (context, index) =>
                                                Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${booking.bookingDetails[index].quantity}  x',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 14),
                                                      child: Text(
                                                        booking
                                                            .bookingDetails[
                                                                index]
                                                            .serviceName,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(Utils.formatPrice(booking
                                                    .bookingDetails[index]
                                                    .servicePrice))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      '?????t th???i gian chu???n b???')),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 315,
                                                height: 31,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: Color(0x42000000),
                                                    width: 1,
                                                  ),
                                                ),
                                                padding: const EdgeInsets.only(
                                                  left: 22,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            minute =
                                                                minute - 10;
                                                          });
                                                        },
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            width: 90,
                                                            child: Icon(Icons
                                                                .maximize_sharp))),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 105,
                                                      height: 17,
                                                      child: Text(
                                                        "${this.minute} mins",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            minute =
                                                                minute + 10;
                                                          });
                                                        },
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 90,
                                                            child: Icon(
                                                                Icons.add))),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                width: 316,
                                                height: 30,
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        SimpleAPI.put(
                                                          'bookings',
                                                          booking.id,
                                                          headers: {
                                                            "Accept":
                                                                "application/json",
                                                            "content-type":
                                                                "application/json"
                                                          },
                                                          body: jsonEncode(<
                                                              String, String>{
                                                            'id': booking.id,
                                                            'status': '???? h???y',
                                                          }),
                                                        );
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ProviderNewOderScreen()));
                                                      },
                                                      child: Container(
                                                        width: 95,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xffcf8b93),
                                                            width: 1.50,
                                                          ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 17,
                                                                right: 18,
                                                                top: 5),
                                                        child: Text(
                                                          "B??? QUA",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffcf8b93),
                                                            fontSize: 13,
                                                            fontFamily:
                                                                "Roboto",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 19),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              // title: Text("B???n c?? ch???c mu???n h???y ????n?"),
                                                              content: Text(
                                                                "B???n c?? mu???n nh???n ????n kh??ng?",
                                                              ),
                                                              actions: [
                                                                FlatButton(
                                                                  textColor: Color(
                                                                      0xFF6200EE),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Kh??ng'),
                                                                ),
                                                                FlatButton(
                                                                  textColor: Color(
                                                                      0xFF6200EE),
                                                                  onPressed:
                                                                      () {
                                                                    SimpleAPI
                                                                        .put(
                                                                      'bookings',
                                                                      booking
                                                                          .id,
                                                                      headers: {
                                                                        "Accept":
                                                                            "application/json",
                                                                        "content-type":
                                                                            "application/json"
                                                                      },
                                                                      body: jsonEncode(<
                                                                          String,
                                                                          String>{
                                                                        'id': booking
                                                                            .id,
                                                                        'status':
                                                                            'X??c nh???n',
                                                                      }),
                                                                    );
                                                                    SimpleAPI
                                                                        .putAccountModel(
                                                                      'accounts',
                                                                      id: userFo
                                                                          .profile
                                                                          .uid
                                                                          .toString(),
                                                                      displayName: userFo
                                                                          .profile
                                                                          .displayName,
                                                                      phone: userFo
                                                                          .profile
                                                                          .phone,
                                                                      status:
                                                                          "INACTIVE",
                                                                      path:
                                                                          null,
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushReplacement(MaterialPageRoute(
                                                                            builder: (context) => ProviderScreen(
                                                                                  isSwiched: false,
                                                                                )));
                                                                  },
                                                                  child: Text(
                                                                      '?????ng ??'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        width: 200,
                                                        height: 30,
                                                        child: Material(
                                                          color:
                                                              Color(0xff50B644),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0x23000000),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 10,
                                                              top: 8,
                                                              bottom: 7,
                                                            ),
                                                            child: Center(
                                                              child: Container(
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                      "CH???P NH???N  ",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                    Countdown(
                                                                      controller:
                                                                          controller
                                                                              .restart(),
                                                                      seconds:
                                                                          50,
                                                                      build: (_,
                                                                              double time) =>
                                                                          Text(
                                                                        ' (${time.toInt().toString()}) ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      interval: Duration(
                                                                          seconds:
                                                                              1),
                                                                      onFinished:
                                                                          () {
                                                                        //
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      height: 1,
                                    );
                            }),
                      ),
                    ],
                  ),
                ),
              ]),
      ),
      bottomNavigationBar: WidgetUtils.appBottomNavigationBar(0),
    );
  }
}
