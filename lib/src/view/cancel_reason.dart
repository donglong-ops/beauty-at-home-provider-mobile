import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/routes_name.dart';
import 'package:flutter_app/src/view/provider_confirm_screen.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:flutter_app/src/view/provider_newOrder_Screen.dart';
import 'package:flutter_app/src/widgets/shared_widget/outlined_card.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';

final List<String> listReasons = List.from([
  "Khách hàng không trả lời điện thoại (nhiều lần)",
  "Khách hàng không có nhà",
  "Khách hàng nhờ hủy đơn",
  "Khác (thợ bận việc đột xuất)",
]);

class CancelReason extends StatefulWidget {
  const CancelReason({Key key}) : super(key: key);

  @override
  _CancelReasonState createState() => _CancelReasonState();
}

class _CancelReasonState extends State<CancelReason> {
  String _selected;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: screenSize.width * 0.9,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProviderScreen(noContent: true),
            ));

          },
          child: Text('XÁC NHẬN HỦY ĐƠN'),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Column(
          children: [
            Text(
              'Chọn lí do hủy đơn',
              style: CustomTextStyle.headerText(Colors.black87),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: OutlinedCard(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: screenSize.width * 0.95,
              sections: listReasons
                  .map<Widget>(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Align(
                            child: Text(
                              e,
                              style: CustomTextStyle.subtitleText(Colors.black),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            setState(() {
                              _selected = e;
                            });
                          },
                        ),
                        if (_selected != null && _selected == e)
                          Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
