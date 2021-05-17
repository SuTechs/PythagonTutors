import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutors/data/database.dart';
import 'package:tutors/data/utils/Utils.dart';
import 'package:tutors/widgets/fileIcons.dart';

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
                for (String url in assignment.assignmentData.referenceFiles)
                  AttachmentButton(url: url),

                /// test
                for (Map<String, String> s in _images)
                  AttachmentButton(
                    url: s['link']!,
                    key: UniqueKey(),
                  ),
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

/// attachments buttons

class AttachmentButton extends StatefulWidget {
  final String url;

  const AttachmentButton({Key? key, required this.url}) : super(key: key);

  @override
  _AttachmentButtonState createState() => _AttachmentButtonState();
}

class _AttachmentButtonState extends State<AttachmentButton> {
  bool isDownloading = false;
  late String _taskId = 'hello';
  // ReceivePort _port = ReceivePort();
  // double downloadProgress = 0;

  @override
  void initState() {
    super.initState();
    // _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  // @override
  // void dispose() {
  //   _unbindBackgroundIsolate();
  //   super.dispose();
  // }

  // void _bindBackgroundIsolate() {
  //   bool isSuccess = IsolateNameServer.registerPortWithName(
  //       _port.sendPort, 'downloader_send_port');
  //   if (!isSuccess) {
  //     _unbindBackgroundIsolate();
  //     _bindBackgroundIsolate();
  //     return;
  //   }
  //   _port.listen((dynamic data) {
  //     // print('UI Isolate Callback: $data');
  //
  //     String id = data[0];
  //     DownloadTaskStatus status = data[1];
  //     int progress = data[2];
  //
  //     print('Su taskId = $_taskId and id = $id');
  //
  //     if (_taskId != 'hello' && id == _taskId) {
  //       print('hello SuMit');
  //
  //       setState(() {
  //         if (status == DownloadTaskStatus.running)
  //           downloadProgress = progress / 100;
  //
  //         if (status == DownloadTaskStatus.complete ||
  //             status == DownloadTaskStatus.failed) isDownloading = false;
  //       });
  //
  //       if (status == DownloadTaskStatus.complete)
  //         FlutterDownloader.open(taskId: _taskId);
  //     }
  //
  //     // if (_tasks != null && _tasks!.isNotEmpty) {
  //     //   final task = _tasks!.firstWhere((task) => task.taskId == id);
  //     //   if (task != null) {
  //     //     setState(() {
  //     //       task.status = status;
  //     //       task.progress = progress;
  //     //     });
  //     //   }
  //     // }
  //   });
  // }

  // void _unbindBackgroundIsolate() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  // }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    // final SendPort send =
    //     IsolateNameServer.lookupPortByName('downloader_send_port')!;
    // send.send([id, status, progress]);

    // print('HEllO SuMIT');
    // if (status == DownloadTaskStatus.failed)
    //   showError('Failed!', 'The download could not be completed.');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      decoration: isDownloading
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: kBlueColor, width: 0.2),
            ),
      child: isDownloading
          ? Stack(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.transparent,
                  child: FileIcon(
                    widget.url.split('/').last,
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: 44,
                  width: 44,
                  child: CircularProgressIndicator(
                    // value: downloadProgress,
                    strokeWidth: 1,
                  ),
                ),
              ],
            )
          : GestureDetector(
              child: FileIcon(
                widget.url.split('/').last,
                size: 46,
              ),
              onTap: () async {
                if (_taskId != 'hello') {
                  final b = await FlutterDownloader.open(taskId: _taskId);
                  if (b) return;
                }

                Get.snackbar(
                    "Downloading!", 'Chek notification for more details.');

                setState(() {
                  isDownloading = true;
                });

                await onFileClick().catchError((e) {
                  printError(info: 'Error #2325 = $e');

                  showError("Error #2325",
                      'Something went wrong. We will try to fix it ASAP!');
                });

                await Future.delayed(Duration(milliseconds: 2000));

                setState(() {
                  isDownloading = false;
                });
              },
            ),
    );
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  Future<void> onFileClick() async {
    /// chek for permission
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result != PermissionStatus.granted) {
        showError(
          'Permission Denied!',
          'Storage permission is require to download files',
        );
        return;
      }
    }

    /// getting path
    final directory = await getExternalStorageDirectory();
    print('Directory = $directory');
    if (directory == null) {
      showError('Error!', 'No directory to download file.');
      return;
    }
    final localPath = directory.path + Platform.pathSeparator + 'Download';
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    /// downloading files

    final t = await FlutterDownloader.enqueue(
        url: widget.url,
        savedDir: localPath,
        showNotification: true,
        openFileFromNotification: true);

    if (t != null) _taskId = t;

    print('Task Id = $_taskId');
  }
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

const _images = [
  // {
  //   'name': 'Arches National Park',
  //   'link':
  //       'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
  // },
  // {
  //   'name': 'Canyonlands National Park',
  //   'link':
  //       'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg'
  // },
  // {
  //   'name': 'Death Valley National Park',
  //   'link':
  //       'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg'
  // },
  {
    'name': 'Gates of the Arctic National Park and Preserve',
    'link':
        'https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg'
  }
];
