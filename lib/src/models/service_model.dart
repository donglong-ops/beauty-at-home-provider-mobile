class ServiceItem {
  final String image;
  final String salonOwner;
  final String titleService;
  final String descriptionService;
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
    this.descriptionService,
    this.rate,
    this.area,
    this.timeLine,
    this.price,
    this.description,
  });
}
