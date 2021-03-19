import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_description.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_step_description.dart';
import 'package:image_picker/image_picker.dart';

class ServiceDetailScreen2 extends StatefulWidget {
  final ServiceItem service;

  const ServiceDetailScreen2({Key key, this.service}) : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen2> {
  File _file;
  void pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    color: Colors.black12,
                    child: Hero(
                      tag: _file == null ? widget.service.image : _file,
                      child: ClipRRect(
                        child: _file == null
                            ? Image(
                                image: NetworkImage(widget.service.image),
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _file,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 25.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                    child: Container(
                      height: 170.0,
                      alignment: Alignment.bottomRight,
                      child: Card(
                        color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          iconSize: 25.0,
                          color: Colors.black,
                          //onPressed: getImage,
                          onPressed: pickImage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ServiceDetailDescription(
                name: widget.service.titleService,
                note: widget.service.note,
                price: widget.service.price,
              ),
              ServiceDetailStepDescription(
                description: widget.service.description,
              ),
              SizedBox(height: 35),
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
                    backgroundColor: Colors.blue[400],
                    label: Text(
                      'Lưu thay đổi',
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
