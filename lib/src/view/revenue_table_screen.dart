
import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/widgets_utils.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryScreen> {
  CalendarController _controller;
  List holidays = null;
  bool changeDate = true;
  bool changeMonth = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Column(
            children: [
              Text(
                'Lịch sử làm của bạn',
                style: CustomTextStyle.headerText(Colors.black87),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Theo Ngày',
                      style: CustomTextStyle.titleText(Colors.black87),
                    )),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Theo Tháng',
                      style: CustomTextStyle.titleText(Colors.black87),
                    )),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        child: TableCalendar(
                          initialCalendarFormat: CalendarFormat.week,
                          calendarStyle: CalendarStyle(
                            // todayColor: Colors.orange,
                              selectedColor: Theme.of(context).primaryColor,
                              todayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white)),
                          headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonDecoration: BoxDecoration(
                              color: Colors.orange, // hiện cái week
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            formatButtonTextStyle: TextStyle(color: Colors.white),
                            formatButtonShowsNext: false,
                          ),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onDaySelected: (date, events, holidays) {
                            print(date.toIso8601String());
                            setState(() {
                              changeDate = !changeDate;
                            });
                          },
                          builders: CalendarBuilders(
                            selectedDayBuilder: (context, date, events) => Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                            todayDayBuilder: (context, date, events) => Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          calendarController: _controller,
                        ),
                      ),
                      changeDate ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text('Tổng doanh thu :',style: TextStyle(fontSize: 20),),
                                  Text(' 1860.000 đ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            color: Colors.black.withOpacity(0.3),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              // color: Colors.grey.withOpacity(0.3),
                              margin: EdgeInsets.only(top: 5),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('   Hoàn thành 5 dịch vụ',style: TextStyle(fontSize: 18)),
                              )
                          ),
                        ],
                        ),
                      ) : Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text('Tổng doanh thu :',style: TextStyle(fontSize: 20),),
                                  Text(' 1210.000 đ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            color: Colors.black.withOpacity(0.3),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              // color: Colors.grey.withOpacity(0.3),
                              margin: EdgeInsets.only(top: 5),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('   Hoàn thành 4 dịch vụ',style: TextStyle(fontSize: 18)),
                              )
                          ),
                        ],
                        ),
                      ),
                      changeDate ? LoadHistory() : LoadHistoryNextDate()
                    ],
                  ),
                  // LoadHistory(),
                ],
              ),
              Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        child: TableCalendar(
                          initialCalendarFormat: CalendarFormat.week,
                          calendarStyle: CalendarStyle(
                              todayColor: Colors.orange,
                              selectedColor: Theme.of(context).primaryColor,
                              todayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white)),
                          headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonDecoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            formatButtonTextStyle: TextStyle(color: Colors.white),
                            formatButtonShowsNext: false,
                          ),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onDaySelected: (date, events, holidays) {
                            print(date.toIso8601String());
                            changeMonth = !changeMonth;
                          },
                          builders: CalendarBuilders(
                            selectedDayBuilder: (context, date, events) => Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                            todayDayBuilder: (context, date, events) => Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          calendarController: _controller,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Jan'),
                                  Text('1'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Fed'),
                                  Text('2'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Mar',style: TextStyle(color: Colors.lightBlueAccent),),
                                  Text('3',style: TextStyle(color: Colors.lightBlueAccent)),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Apr'),
                                  Text('4'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('May'),
                                  Text('5'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Jun'),
                                  Text('6'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Jul'),
                                  Text('7'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Aug'),
                                  Text('8'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Sep '),
                                  Text('9'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Oct'),
                                  Text('10'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Nov'),
                                  Text('11'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              child: Column(
                                children: [
                                  Text('Dec'),
                                  Text('12'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      changeMonth ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text('Tổng doanh thu :',style: TextStyle(fontSize: 20),),
                                  Text(' 22.360.000 đ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            color: Colors.black.withOpacity(0.3),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              // color: Colors.grey.withOpacity(0.3),
                              margin: EdgeInsets.only(top: 5),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('   Hoàn thành 22 dịch vụ',style: TextStyle(fontSize: 18)),
                              )
                          )
                        ],
                        ),
                      ) : Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text('Tổng doanh thu :',style: TextStyle(fontSize: 20),),
                                  Text(' 19.860.000 đ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            color: Colors.black.withOpacity(0.3),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              // color: Colors.grey.withOpacity(0.3),
                              margin: EdgeInsets.only(top: 5),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('   Hoàn thành 27 dịch vụ',style: TextStyle(fontSize: 18)),
                              )
                          )
                        ],
                        ),
                      ),
                      changeMonth ? LoadHistory() : LoadHistoryNextDate()
                    ],
                  ),
                  // LoadHistory(),
                ],
              )
              // _dayActive(context),
              // _monthActive(context),
            ],
          ),
        ),
        bottomNavigationBar: WidgetUtils.appBottomNavigationBar(3),
      ),
    );
  }
}



class HistoryUsed {
  final String userName, payment ,price;
  final bool promo;

  HistoryUsed({
    this.userName,
    this.payment,
    this.price,
    this.promo,
  });
}

class LoadHistory extends StatelessWidget {
  List<HistoryUsed> lstHistory = List.from([
    HistoryUsed(
      userName: 'Cao Quỳnh Trang',
      payment: 'MOMOPAY',
      price: '250.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Huỳnh Thế Hiển',
      payment: 'AIRPAY',
      price: '150.000',
      promo: false,
    ),
    HistoryUsed(
      userName: 'Đồng Hữu Long',
      payment: 'MOMOPAY',
      price: '1050.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Trần Trịnh Đăng Huy',
      payment: 'AIRPAY',
      price: '550.000',
      promo: false,
    ),
    HistoryUsed(
      userName: 'Cao Quỳnh Trang',
      payment: 'MOMOPAY',
      price: '250.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Huỳnh Thế Hiển',
      payment: 'AIRPAY',
      price: '150.000',
      promo: false,
    ),
    HistoryUsed(
      userName: 'Đồng Hữu Long',
      payment: 'MOMOPAY',
      price: '1050.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Trần Trịnh Đăng Huy',
      payment: 'AIRPAY',
      price: '550.000',
      promo: false,
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: lstHistory.length,
          itemBuilder: (BuildContext buildContext, int index) {
            HistoryUsed history = lstHistory[index];
            return Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                margin: EdgeInsets.only(top: 5),
                                height: 50,
                                child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          history.userName.toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black.withOpacity(0.7)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Card(
                                              color: Color(0xff707DB9),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    history.payment,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            if(history.promo == true) Card(
                                              color: Colors.yellow,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                  'Promo',
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
                                    ],
                                  ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${history.price} đ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlue.withOpacity(0.8),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text('')
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class LoadHistoryNextDate extends StatelessWidget {
  List<HistoryUsed> lstHistory = List.from([
    HistoryUsed(
      userName: 'Đồng Hữu Long',
      payment: 'MOMOPAY',
      price: '1050.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Trần Trịnh Đăng Huy',
      payment: 'AIRPAY',
      price: '550.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Cao Quỳnh Trang',
      payment: 'MOMOPAY',
      price: '250.000',
      promo: false
    ),
    HistoryUsed(
      userName: 'Huỳnh Thế Hiển',
      payment: 'AIRPAY',
      price: '150.000',
      promo: false,
    ),
    HistoryUsed(
      userName: 'Cao Quỳnh Trang',
      payment: 'MOMOPAY',
      price: '250.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Huỳnh Thế Hiển',
      payment: 'AIRPAY',
      price: '150.000',
      promo: false,
    ),
    HistoryUsed(
      userName: 'Đồng Hữu Long',
      payment: 'MOMOPAY',
      price: '1050.000',
      promo: true,
    ),
    HistoryUsed(
      userName: 'Trần Trịnh Đăng Huy',
      payment: 'AIRPAY',
      price: '550.000',
      promo: false,
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: lstHistory.length,
          itemBuilder: (BuildContext buildContext, int index) {
            HistoryUsed history = lstHistory[index];
            return Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                margin: EdgeInsets.only(top: 5),
                                height: 50,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        history.userName.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black.withOpacity(0.7)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Card(
                                            color: Color(0xff707DB9),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                history.payment,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          if(history.promo == true) Card(
                                            color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                'Promo',
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
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.topRight,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${history.price} đ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlue.withOpacity(0.8),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text('')
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class Active {
  String saloners, imgUrls, status;
  int numServices;
  Function pres;

  Active({
    this.saloners,
    this.imgUrls,
    this.numServices,
    this.status,
    this.pres,
  });
}

class LoadActive extends StatelessWidget {
  List<Active> lstActive = List.from([]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: lstActive.length,
          itemBuilder: (BuildContext buildContext, int index) {
            Active active = lstActive[index];
            return Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: active.pres,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: 50,
                              margin: EdgeInsets.only(right: 13),
                              child: Image.asset(
                                active.imgUrls,
                                width: 50,
                                height: 50,
                              )),
                          Container(
                            width: 160,
                            margin: EdgeInsets.only(top: 5),
                            height: 50,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: active.saloners.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.7)),
                                  ),
                                  TextSpan(
                                    text: "\n${active.numServices} dịch vụ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              width: 100,
                              child: Text(
                                active.status,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                textAlign: TextAlign.left,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Container(color: Colors.white),
                  ),
                  Container(
                      width: 400,
                      height: 0.5,
                      color: Colors.black.withOpacity(0.5)),
                ],
              ),
            );
          }),
    );
  }
}
