import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutors/constants.dart';
import 'package:tutors/data/database.dart';
import 'package:tutors/data/utils/Utils.dart';
import 'package:tutors/data/utils/modal/user.dart';
import 'package:tutors/screens/transaction.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              /// profile pic
              CircleAvatar(
                radius: 32,
                // backgroundColor: const Color(0xffF1F1F1),
                backgroundColor: Color(0xffF4B532),
                backgroundImage: NetworkImage(UserData.teacher.profilePic),
                // child: Image.asset('assets/images/name.png'),
              ),

              SizedBox(width: 16),

              /// name and phone
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// name
                  Row(
                    children: [
                      Text(
                        UserData.teacher.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: kBlueColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      if (UserData.teacher.isVerified)
                        Icon(
                          Icons.verified,
                          size: 15,
                          color: kLogoRedColor,
                        ),
                    ],
                  ),

                  SizedBox(height: 4),

                  /// phone
                  Text(
                    UserData.teacher.phone,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),

              Spacer(),

              /// balance
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: kBlueColor),
                  padding: EdgeInsets.only(right: 0, left: 8),
                ),
                onPressed: () {
                  Get.to(() => Transaction(),
                      transition: Transition.cupertino, curve: Curves.bounceIn);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹ ${UserData.teacher.balance}',
                      style: TextStyle(
                        fontSize: 16,
                        color: kBlueColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: kBlueColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32),

          /// subjects
          ProfileListContainer(
            title: 'Subjects',
            child: FutureBuilder<List<Subject>>(
                future: Subject.getSubjects(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error = ${snapshot.error}'));
                  }

                  if (snapshot.hasData)
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 6),
                        for (String s in UserData.teacher.subjectsIds)
                          SizedBox(
                            height: 32,
                            child: ListTile(
                              dense: true,
                              leading: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                backgroundImage: NetworkImage(
                                  snapshot.data!
                                      .firstWhere((element) => element.id == s)
                                      .image,
                                ),
                              ),
                              title: Text(
                                snapshot.data!
                                    .firstWhere((element) => element.id == s)
                                    .name,
                                style: TextStyle(color: kBlueColor),
                              ),
                              horizontalTitleGap: 0,
                            ),
                          ),
                        SizedBox(height: 12),
                      ],
                    );

                  return Center(child: CircularProgressIndicator());
                }),
          ),

          /// course
          ProfileListContainer(
            title: 'Stream',
            child: ProfileListContainerTile(
              icon: Icons.school,
              title: UserData.teacher.course.courseName,
            ),
          ),

          /// college
          ProfileListContainer(
            title: 'College',
            child: ProfileListContainerTile(
              icon: Icons.account_balance,
              title: UserData.teacher.college.collegeName,
            ),
          ),

          /// dob
          ProfileListContainer(
            title: 'DOB',
            child: ProfileListContainerTile(
              icon: Icons.calendar_today,
              title: UserData.teacher.dateOfBirth,
            ),
          ),

          /// gender
          if (UserData.teacher.gender.isNotEmpty)
            ProfileListContainer(
              title: 'Gender',
              child: ProfileListContainerTile(
                icon: Icons.person,
                title: UserData.teacher.gender,
              ),
            ),

          /// email
          ProfileListContainer(
            title: 'Email',
            child: ProfileListContainerTile(
              icon: Icons.email,
              title: UserData.teacher.email,
            ),
          ),

          /// account info
          if (UserData.teacher.accountInfo.isNotEmpty)
            ProfileListContainer(
              title: 'Account Info',
              child: ProfileListContainerTile(
                icon: Icons.attach_money,
                title: UserData.teacher.accountInfo,
              ),
            ),

          /// Request Change / verification
          ProfileListContainer(
            title: UserData.teacher.isVerified ? 'Update' : 'Verify',
            child: ProfileListContainerTile(
              icon: UserData.teacher.isVerified ? Icons.edit : Icons.verified,
              title: UserData.teacher.isVerified
                  ? 'Request Change'
                  : 'Request Verification',
              onTap: () {
                launchWhatsapp(
                    message:
                        '${UserData.teacher.id}\nHi! there, I would like to ${UserData.teacher.isVerified ? 'request change in ' : 'verify my account.'}');
              },
            ),
          ),

          /// logout
          ProfileListContainer(
            title: 'Logout',
            child: ProfileListContainerTile(
              icon: Icons.logout,
              title: 'Sign Out',
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListContainer extends StatelessWidget {
  final Widget child;
  final String title;

  const ProfileListContainer(
      {Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Material(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.2,
                  color: kBlueColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: child,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 0, left: 0, right: 8, bottom: 6),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.caption!.copyWith(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileListContainerTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final IconData icon;

  const ProfileListContainerTile(
      {Key? key, required this.title, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: Icon(
        icon,
        color: kBlueColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: kBlueColor),
      ),
      horizontalTitleGap: 0,
    );
  }
}
