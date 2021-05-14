import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:tutors/data/database.dart';
import 'package:tutors/data/utils/Utils.dart';

import '../constants.dart';

class AssignmentsListView extends StatelessWidget {
  final List<TeachersAssignments> assignments;

  const AssignmentsListView({Key? key, required this.assignments})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: assignments.length + 1,
        itemBuilder: (_, index) {
          if (index == assignments.length) return SizedBox(height: 16);
          return Hero(
              tag: 'Hero Tag $index',
              child: AssignmentListTile(
                assignment: assignments[index],
                onTap: () {
                  Get.to(
                    () => AssignmentDetail(
                      heroTag: 'Hero Tag $index',
                      assignment: assignments[index],
                    ),
                    transition: Transition.cupertinoDialog,
                  );
                },
              ));
        },
      ),
    );
  }
}

class AssignmentListTile extends StatelessWidget {
  final TeachersAssignments assignment;
  final GestureTapCallback? onTap;
  final bool isDetailPage;

  const AssignmentListTile(
      {Key? key,
      this.onTap,
      this.isDetailPage = false,
      required this.assignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDetailPage ? 0 : 14, vertical: isDetailPage ? 0 : 8),
        child: ListTile(
          contentPadding: isDetailPage ? EdgeInsets.all(0) : null,
          onTap: onTap,
          shape: isDetailPage
              ? null
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(
                    width: 0.1,
                    color: kBlueColor,
                  ),
                ),
          leading: CircleAvatar(
            // child: Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Image.network(),
            // ),
            backgroundImage:
                NetworkImage(assignment.assignmentData.subject.image),
            backgroundColor: const Color(0xffF1F1F1),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                assignment.assignmentData.subject.name,
                style: context.textTheme.caption,
              ),
              SizedBox(height: 2),
              Text(assignment.assignmentData.name),
              SizedBox(height: 4),
            ],
          ),
          subtitle: Text(getFormattedTime(assignment.assignmentData.time)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('₹ ${assignment.amount}'),
              SizedBox(height: 2),
              Text(
                assignment.assignmentData.assignmentType ==
                        AssignmentType.Session
                    ? 'Sessn'
                    : 'Assgn',
                style: context.textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// assignment details

class AssignmentDetail extends StatelessWidget {
  final String heroTag;
  final TeachersAssignments assignment;

  const AssignmentDetail(
      {Key? key, required this.heroTag, required this.assignment})
      : super(key: key);

  Widget getTitle(String title, BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: context.textTheme.caption,
        ),
      );

  Widget getAttachment() => Container(
        margin: EdgeInsets.only(right: 12),
        width: 46.0,
        height: 46.0,
        decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(6.0),
          image: DecorationImage(
            image: const AssetImage('assets/icons/google.png'),
            fit: BoxFit.cover,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.clear,
            color: kBlueColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// assignment list tile
            Hero(
              tag: heroTag,
              child: AssignmentListTile(
                isDetailPage: true,
                assignment: assignment,
              ),
            ),
            SizedBox(height: 32),

            /// desc

            getTitle('Description', context),
            Text(
              assignment.assignmentData.description,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 32),

            /// attachments
            getTitle('Attachments', context),
            Row(
              children: [
                getAttachment(),
                getAttachment(),
                getAttachment(),
              ],
            ),

            Spacer(),

            /// buttons
            Row(
              children: [
                /// sorry
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: kBlueColor)),
                      onPressed: () {},
                      child: Text(
                        'Sorry',
                        style: TextStyle(color: kBlueColor),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 24),

                /// im in
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kBlueColor)),
                      onPressed: () {},
                      child: Text('I\'m in'),
                    ),
                  ),
                ),
              ],
            ),

            //StatusButton(assignmentStatus: AssignmentStatus.Completed),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final AssignmentStatus assignmentStatus;
  const StatusButton(
      {Key? key, this.assignmentStatus = AssignmentStatus.Pending})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// status
        Expanded(
          child: SizedBox(
            height: 42,
            child: assignmentStatus != AssignmentStatus.Upload
                ? ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                _kButtonStatusColors[assignmentStatus]!)),
                    onPressed: () {},
                    label: Text(_kButtonStatusText[assignmentStatus]!),
                    icon: Icon(
                      _kButtonStatusIcons[assignmentStatus]!,
                      color: Colors.white,
                    ),
                  )
                : OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: _kButtonStatusColors[assignmentStatus]!),
                    ),
                    onPressed: () {},
                    label: Text(
                      _kButtonStatusText[assignmentStatus]!,
                      style: TextStyle(
                          color: _kButtonStatusColors[assignmentStatus]!),
                    ),
                    icon: Icon(
                      _kButtonStatusIcons[assignmentStatus]!,
                      color: _kButtonStatusColors[assignmentStatus]!,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

enum AssignmentStatus {
  Pending,
  NotAssigned,
  Upload,
  Uploaded,
  Rejected,
  Completed,
}

// const _kButtonStatusColors = {
//   AssignmentStatus.Pending: kBlueColor,
//   AssignmentStatus.NotAssigned: Colors.red,
//   AssignmentStatus.Rejected: Colors.red,
//   AssignmentStatus.Upload: kBlueColor,
//   AssignmentStatus.Uploaded: kBlueColor,
//   AssignmentStatus.Completed: Colors.green,
// };
const _kButtonStatusColors = {
  AssignmentStatus.Pending: kBlueColor,
  AssignmentStatus.NotAssigned: kBlueColor,
  AssignmentStatus.Rejected: kBlueColor,
  AssignmentStatus.Upload: kBlueColor,
  AssignmentStatus.Uploaded: kBlueColor,
  AssignmentStatus.Completed: kBlueColor,
};
const _kButtonStatusText = {
  AssignmentStatus.Pending: 'Pending Confirmation',
  AssignmentStatus.NotAssigned: 'Not Assigned',
  AssignmentStatus.Rejected: 'Rejected',
  AssignmentStatus.Upload: 'Upload Attachments',
  AssignmentStatus.Uploaded: 'In Review',
  AssignmentStatus.Completed: 'Completed',
};
const _kButtonStatusIcons = {
  AssignmentStatus.Pending: Icons.access_time_outlined,
  AssignmentStatus.NotAssigned: Icons.clear,
  AssignmentStatus.Rejected: Icons.error_outline,
  AssignmentStatus.Upload: Icons.add,
  AssignmentStatus.Uploaded: Icons.access_time_rounded,
  AssignmentStatus.Completed: Icons.done,
};
