import 'dart:async';
import 'dart:developer';
import "package:intl/intl.dart";

class Utils {
  static Future sleep(int miliesSecond) {
    return Future.delayed(
      Duration(milliseconds: miliesSecond),
    );
  }

  static void redoTaskPerDuration(
      Function task, int miliesSecond, int count, Function afterTask) async {
    while (count-- > 0) {
      log('1st');
      await sleep(miliesSecond);
      task.call();
    }
    await sleep(miliesSecond);
    afterTask.call();
  }
  static String formatPrice(String review) {
    String result = review.toString();
    var formatter = NumberFormat('###,000');
    String formatString = formatter.format(double.parse(result));
    return formatString.replaceAll(new RegExp(r','), '.') + "đ";
  }
  static String calculatePrice(String unitPrice, String quantity) {
    double total = 0;
    total = double.parse(unitPrice) * double.parse(quantity);
    return formatPrice(total.toString());
  }
}
