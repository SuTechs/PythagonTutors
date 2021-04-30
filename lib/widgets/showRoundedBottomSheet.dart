import 'package:flutter/material.dart';

Future<T?> showRoundedBottomSheet<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        // side: BorderSide(
        //   color: Provider.of<UserData>(context, listen: false).isDarkMode
        //       ? kDarkModeSecondaryColor
        //       : kLightModeSecondaryColor,
        // ),
      ),
      context: context,
      builder: (context) => child);
}
