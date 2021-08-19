import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String getFormattedTime(DateTime dateTime) {
  return DateFormat('d MMM h${dateTime.minute != 0 ? ':mm' : ''} a')
      .format(dateTime);
}

void launchWhatsapp({String message = ''}) async {
  // const url = "https://wa.me/917667323338?text=YourTextHere";
  final url = "whatsapp://send?phone=917779984115&text=$message";
  final encoded = Uri.encodeFull(url);

  if (await canLaunch(encoded)) {
    await launch(encoded);
  } else {
    Get.snackbar(
      'Error!',
      'Not able to launch whatsapp!',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
