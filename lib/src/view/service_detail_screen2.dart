import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/models-new/image_model.dart';
import 'package:flutter_app/src/models-new/service_model_new.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_description.dart';
import 'package:flutter_app/src/widgets/service_detail_screen_widget/service_detail_step_description.dart';
import 'package:image_picker/image_picker.dart';

class ServiceDetailScreen2 extends StatefulWidget {
  final ServiceModelNew service;

  const ServiceDetailScreen2({Key key, this.service}) : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen2> {
  List serviceType =['Gội đầu','Chăm sóc tóc','Massage','Makeup - Trang điểm','Chăm sóc da','Cắt tóc','Nails - Làm móng'];
  String serviceTypeId;
  File _file;
  void pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
      this.widget.service.gallery.images.add(new ImageModel(imageUrl: this._file.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    this.widget.service.gallery.images.add(new ImageModel(imageUrl: 'https://images.unsplash.com/photo-1487412912498-0447578fcca8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'));
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
                    height: 190.0,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 1.0),
                    color: Colors.black12,
                    child: Carousel(
                      showIndicator: false,
                      autoplay: false,
                      images: [
                        NetworkImage(widget.service.gallery.images[0].imageUrl),
                        (widget.service.gallery.images.length > 1) ?  NetworkImage(widget.service.gallery.images[1].imageUrl): NetworkImage('https://images.unsplash.com/photo-1487412912498-0447578fcca8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
                        (widget.service.gallery.images.length > 2) ?  NetworkImage(widget.service.gallery.images[2].imageUrl): NetworkImage('https://images.unsplash.com/photo-1487412912498-0447578fcca8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
                      ],
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
                      height: 150.0,
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
                name: widget.service.serviceName,
                note: widget.service.summary,
                price: widget.service.price,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 5,left: 7),
                      child: Text("Chọn loại dịch vụ* : ",
                        style: TextStyle(fontSize: 16,
                            color: Colors.black.withOpacity(0.6)),)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down,size: 25,),
                        //value: serviceTypeId,
                        value: widget.service.serviceType.name,
                        onChanged: (newValue){
                          setState(() {
                            serviceTypeId = newValue;
                          });
                        },
                        items: serviceType.map((valueType){
                          return DropdownMenuItem(
                            value: valueType,
                            child: Text(valueType),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              ServiceDetailStepDescription(
                description: widget.service.description,
              ),
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
