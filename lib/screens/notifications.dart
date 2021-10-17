import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:tutors/data/bloc/notificationBloc.dart';
import 'package:tutors/data/database.dart';
import 'package:tutors/data/utils/Utils.dart';

import '../constants.dart';

class NotificationScreen extends GetView<NotificationListController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.notifications.isEmpty
        ? Center(
            child: Text('Nothing here yet!'),
          )
        : ListView.builder(
            itemCount: controller.notifications.length + 1,
            itemBuilder: (_, index) {
              if (index == controller.notifications.length)
                return SizedBox(height: 16);
              return NotificationTile(
                notificationData: controller.notifications[index],
              );
            },
          );
  }
}

class NotificationTile extends StatefulWidget {
  final NotificationData notificationData;

  const NotificationTile({Key? key, required this.notificationData})
      : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: ListTile(
          contentPadding:
              EdgeInsets.only(left: 0, right: 16, top: 8, bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              width: 0.1,
              color: kBlueColor,
            ),
          ),
          leading: IconButton(
            onPressed: widget.notificationData.isRead
                ? null
                : () {
                    setState(() {
                      widget.notificationData.isRead = true;
                      widget.notificationData.markAsRead();
                    });
                  },
            icon: Icon(
              !widget.notificationData.isRead
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_outlined,
              color: !widget.notificationData.isRead ? kBlueColor : null,
            ),
            tooltip: !widget.notificationData.isRead ? 'Mark as read' : null,
          ),
          title: Text('${widget.notificationData.title}'),
          subtitle: Text('${widget.notificationData.body}'),
          trailing: Text(
            getFormattedTime(DateTime.now()),
            style: context.textTheme.caption,
          ),
          enabled: !widget.notificationData.isRead,
        ),
      ),
    );
  }
}
