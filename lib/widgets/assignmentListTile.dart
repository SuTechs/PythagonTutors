import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '/data/database.dart';
import '/data/utils/Utils.dart';
import '/data/utils/modal/user.dart';
import '/widgets/fileIcons.dart';
import '../constants.dart';

class AssignmentsListView extends StatelessWidget {
  final List<TeachersAssignments> assignments;

  const AssignmentsListView({Key? key, required this.assignments})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: assignments.isEmpty
          ? Center(
              child: Text('Nothing here yet!'),
            )
          : ListView.builder(
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

/// status buttons

class StatusButton extends StatelessWidget {
  final TeacherRating? rating;
  final VoidCallback onPressed;
  final AssignmentStatus assignmentStatus;
  const StatusButton(
      {Key? key,
      required this.assignmentStatus,
      required this.onPressed,
      this.rating})
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
                    onPressed: onPressed,
                    label: Text(assignmentStatus == AssignmentStatus.Rated
                        ? '${_kButtonStatusText[assignmentStatus]!} ${rating!.avgRating.toStringAsFixed(1)}/5'
                        : _kButtonStatusText[assignmentStatus]!),
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
                    onPressed: onPressed,
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
  Rated,
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
  AssignmentStatus.Rated: kBlueColor,
};
const _kButtonStatusText = {
  AssignmentStatus.Pending: 'Pending Confirmation',
  AssignmentStatus.NotAssigned: 'Not Assigned',
  AssignmentStatus.Rejected: 'Rejected',
  AssignmentStatus.Upload: 'Upload Attachments',
  AssignmentStatus.Uploaded: 'In Review',
  AssignmentStatus.Completed: 'Completed',
  AssignmentStatus.Rated: 'Rated',
};
const _kButtonStatusIcons = {
  AssignmentStatus.Pending: Icons.access_time_outlined,
  AssignmentStatus.NotAssigned: Icons.clear,
  AssignmentStatus.Rejected: Icons.error_outline,
  AssignmentStatus.Upload: Icons.add,
  AssignmentStatus.Uploaded: Icons.access_time_rounded,
  AssignmentStatus.Completed: Icons.done,
  AssignmentStatus.Rated: Icons.star_sharp,
};

/// attachments buttons
class AttachmentButton extends StatefulWidget {
  final String url;
  final bool isName;

  const AttachmentButton({Key? key, required this.url, this.isName = false})
      : super(key: key);

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

  String get getFileName {
    try {
      return FirebaseStorage.instance.refFromURL(widget.url).name;
    } catch (e) {
      print('Error #13121 =$e');
      return Uri.decodeFull(widget.url).toString().split('/').last;
    }
    // if (widget.url.contains('key')) {
    //   final f = widget.url.split('key');
    //
    //   if (f.length > 2) return Uri.decodeFull(f[1]).toString();
    // }
    // return Uri.decodeFull(widget.url).toString().split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    final f = Container(
      margin: widget.isName ? null : EdgeInsets.only(right: 12),
      decoration: isDownloading || widget.isName
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
                    getFileName,
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
                getFileName,
                size: 46,
              ),
              onTap: onDownload,
            ),
    );

    if (widget.isName)
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: f,
        title: Text(
          getFileName,
        ),
        onTap: onDownload,
      );

    return f;
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void onDownload() async {
    if (isDownloading) return;

    if (_taskId != 'hello') {
      final b = await FlutterDownloader.open(taskId: _taskId);
      if (b) return;
    }

    Get.snackbar("Downloading!", 'Chek notification for more details.');

    setState(() {
      isDownloading = true;
    });

    await onFileClick().catchError((e) {
      printError(info: 'Error #2325 = $e');

      showError(
          "Error #2325", 'Something went wrong. We will try to fix it ASAP!');
    });

    await Future.delayed(Duration(milliseconds: 2000));

    setState(() {
      isDownloading = false;
    });
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

/// upload files
class UploadAssignmentFiles extends StatefulWidget {
  final void Function(List<String>) onFilesUploaded;
  final String assignmentId;

  const UploadAssignmentFiles(
      {Key? key, required this.onFilesUploaded, required this.assignmentId})
      : super(key: key);

  @override
  _UploadAssignmentFilesState createState() => _UploadAssignmentFilesState();
}

class _UploadAssignmentFilesState extends State<UploadAssignmentFiles> {
  final List<PlatformFile> filesToUpload = [];
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Upload',
            style: context.textTheme.caption,
          ),
        ),

        /// add files

        Expanded(
          child: ListView(
            children: [
              for (int i = 0; i < filesToUpload.length; i++)
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: FileIcon(filesToUpload[i].name, size: 42),
                  title: Text(filesToUpload[i].name),
                  trailing: GestureDetector(
                    child: Icon(Icons.clear),
                    onTap: () {
                      setState(() {
                        filesToUpload.removeAt(i);
                      });
                    },
                  ),
                ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.add),
                title: Text('Add Files'),
                onTap: _pickFiles,
              ),
            ],
          ),
        ),

        SizedBox(
          height: 42,
          width: double.infinity,
          child: isUploading
              ? OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kBlueColor),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: kBlueColor,
                    ),
                  ),
                )
              : OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kBlueColor),
                  ),
                  onPressed: _uploadFiles,
                  label: Text(
                    'Upload & Submit',
                    style: TextStyle(color: kBlueColor),
                  ),
                  icon: Icon(
                    Icons.upload_outlined,
                    color: kBlueColor,
                  ),
                ),
        ),
      ],
    );
  }

  void _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      // final files = result.paths.map((path) => File(path!)).toList();

      setState(() {
        filesToUpload.addAll(result.files);
      });
    }
  }

  void _uploadFiles() async {
    if (filesToUpload.isEmpty) {
      Get.snackbar(
        'No Files!',
        'Please add files before uploading.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return;
    }

    if (isUploading) return;

    setState(() {
      isUploading = true;
    });

    /// uploading file

    final urls = <String>[];

    for (final f in filesToUpload) {
      final r = await FirebaseStorage.instance
          .ref('Assignments')
          .child(widget.assignmentId)
          .child(UserData.teacher.id)
          .child(f.name)
          .putFile(File(f.path!));

      final url = await r.ref.getDownloadURL();
      urls.add(url);
    }

    setState(() {
      isUploading = false;
    });

    widget.onFilesUploaded(urls);
  }
}

/// assignment details
class AssignmentDetail extends StatefulWidget {
  final String heroTag;
  final TeachersAssignments assignment;

  const AssignmentDetail(
      {Key? key, required this.heroTag, required this.assignment})
      : super(key: key);

  @override
  _AssignmentDetailState createState() => _AssignmentDetailState();

  static AssignmentStatus getAssignmentStatus(TeacherAssignmentStatus ta) {
    switch (ta) {
      case TeacherAssignmentStatus.Interested:
        return AssignmentStatus.Pending;

      case TeacherAssignmentStatus.Assigned:
        return AssignmentStatus.Upload;

      case TeacherAssignmentStatus.NotAssigned:
        return AssignmentStatus.NotAssigned;

      case TeacherAssignmentStatus.Completed:
        return AssignmentStatus.Uploaded;

      case TeacherAssignmentStatus.Rejected:
        return AssignmentStatus.Rejected;

      case TeacherAssignmentStatus.Closed:
        return AssignmentStatus.Completed;

      case TeacherAssignmentStatus.Rated:
        return AssignmentStatus.Rated;

      default:
        return AssignmentStatus.NotAssigned;
    }
  }
}

class _AssignmentDetailState extends State<AssignmentDetail> {
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
              tag: widget.heroTag,
              child: AssignmentListTile(
                isDetailPage: true,
                assignment: widget.assignment,
              ),
            ),
            SizedBox(height: 32),

            /// desc

            getTitle('Description', context),
            Text(
              widget.assignment.assignmentData.description,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 32),

            /// attachments
            if (widget.assignment.assignmentData.referenceFiles.isNotEmpty)
              getTitle('Attachments', context),
            Row(
              children: [
                for (String url
                    in widget.assignment.assignmentData.referenceFiles)
                  AttachmentButton(url: url),
              ],
            ),
            SizedBox(height: 32),

            /// uploaded files
            if (widget.assignment.assignmentFiles.isNotEmpty &&
                widget.assignment.status != TeacherAssignmentStatus.Assigned)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTitle('Uploaded Files', context),
                    Expanded(
                      child: ListView(
                        children: [
                          for (String url in widget.assignment.assignmentFiles)
                            AttachmentButton(url: url, isName: true),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              )

            /// upload files
            else if (widget.assignment.status ==
                TeacherAssignmentStatus.Assigned)
              Expanded(
                child: UploadAssignmentFiles(
                  assignmentId: widget.assignment.assignmentData.id,
                  onFilesUploaded: (urls) {
                    /// updating ui
                    setState(() {
                      widget.assignment.status =
                          TeacherAssignmentStatus.Completed;
                      widget.assignment.assignmentFiles.addAll(urls);
                    });

                    /// changing status of assignment
                    TeachersAssignments.changeStatus(
                        TeacherAssignmentStatus.Completed,
                        widget.assignment.id);

                    /// changing status of assignment
                    TeachersAssignments.updateFiles(urls, widget.assignment.id);
                  },
                ),
              )
            else
              Spacer(),

            /// buttons

            if (widget.assignment.status == TeacherAssignmentStatus.Sent)
              Row(
                children: [
                  /// sorry
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: kBlueColor)),
                        onPressed: () {
                          TeachersAssignments.changeStatus(
                              TeacherAssignmentStatus.NotInterested,
                              widget.assignment.id);
                          Get.back();
                        },
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
                        onPressed: () {
                          TeachersAssignments.changeStatus(
                              TeacherAssignmentStatus.Interested,
                              widget.assignment.id);

                          setState(() {
                            widget.assignment.status =
                                TeacherAssignmentStatus.Interested;
                          });
                        },
                        child: Text('I\'m in'),
                      ),
                    ),
                  ),
                ],
              )
            else if (widget.assignment.status !=
                TeacherAssignmentStatus.Assigned)
              StatusButton(
                rating: widget.assignment.rating,
                assignmentStatus: AssignmentDetail.getAssignmentStatus(
                    widget.assignment.status),
                onPressed: () {
                  print('Status = ${widget.assignment.status}');
                  if (widget.assignment.status !=
                      TeacherAssignmentStatus.Assigned) return;
                },
              ),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
