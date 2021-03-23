import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/image_model.dart';
import 'package:flutter_app/src/models-new/service_model_new.dart';
import 'package:flutter_app/src/utils/utils.dart';
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

  String serviceName ;
  String servicePrice;
  String serviceSumary;
  // String serviceTypeId;
  String serviceTypeName;
  String serviceDescription;

  File _file;
  void pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
      this.widget.service.gallery.images.add(new ImageModel(imageUrl: this._file.path));
    });
  }
  @override
  void initState() {
    serviceName = widget.service.serviceName;
    servicePrice= widget.service.price;
    serviceSumary= widget.service.summary;
    serviceTypeName= widget.service.serviceType.name; // lưu ý
    serviceDescription = widget.service.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextFormField(
                                initialValue: serviceName,
                                decoration: InputDecoration(
                                  labelText: "Tên dịch vụ",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value){
                                  setState(() {
                                    serviceName = value;
                                  });
                                },
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: TextFormField(
                                initialValue: Utils.formatPrice(servicePrice),
                                decoration: InputDecoration(
                                  labelText: "Giá (VND)",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value){
                                  setState(() {
                                    servicePrice = value;
                                  });
                                },
                              )),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          initialValue: serviceSumary,
                          decoration: InputDecoration(
                            labelText: "Miêu tả dịch vụ",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value){
                            setState(() {
                              serviceSumary = value;
                            });
                          },
                        )),
                  ],
                ),
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
                        value: serviceTypeName,
                        onChanged: (newValue){
                          setState(() {
                            serviceTypeName = newValue;
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
              // ServiceDetailStepDescription(
              //   description: widget.service.description,
              // ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 10.0, bottom: 2),
                      child: Text(
                        'CÁC BƯỚC LÀM DỊCH VỤ',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              initialValue: serviceDescription,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 8,
                              onChanged: (value){
                                setState(() {
                                  serviceDescription = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
              GestureDetector(
                onTap: () {
                  if(serviceName.isNotEmpty && servicePrice.isNotEmpty && serviceSumary.isNotEmpty
                      && serviceDescription.isNotEmpty){

                    SimpleAPI.putServiceModel('services',id: widget.service.serviceID,serviceName: serviceName,
                        summary: serviceSumary, price: servicePrice,estimateTime: '30', status: 'Active',
                        description: serviceDescription, accountId: '3',serviceTypeId: '3', path: _file.path);
                  }

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
