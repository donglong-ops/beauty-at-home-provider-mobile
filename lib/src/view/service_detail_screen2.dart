import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_description.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_image.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_step_description.dart';

class ServiceDetailScreen2 extends StatefulWidget {
  final ServiceItem service;

  const ServiceDetailScreen2({Key key, this.service})
      : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen2> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ServiceDetailImage(
                path: widget.service.image,
              ),
              ServiceDetailDescription(
                name: widget.service.titleService,
                note: widget.service.note,
                price: widget.service.price,
              ),
              ServiceDetailStepDescription(
                description: widget.service.description,
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProviderManagerScreen(),));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1.0),
                      ),
                    ),
                    backgroundColor: Colors.grey,
                    label: Text('Lưu Thay đổi', style: TextStyle(color: Colors.white, letterSpacing: 4),
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
