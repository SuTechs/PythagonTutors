import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutors/constants.dart';
import 'package:tutors/screens/transcation.dart';

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
                backgroundImage: AssetImage('assets/images/name.png'),
                // child: Image.asset('assets/images/name.png'),
              ),

              SizedBox(width: 16),

              /// name and phone
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// name
                  Text(
                    'Uchit Chakma',
                    style: TextStyle(
                      fontSize: 18,
                      color: kBlueColor,
                    ),
                  ),

                  SizedBox(height: 4),

                  /// phone
                  Text(
                    '+91 7667323338',
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
                      '₹ 500',
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 32,
                  child: ProfileListContainerTile(
                    icon: Icons.computer_sharp,
                    title: 'Computer Science',
                  ),
                ),
                SizedBox(
                  height: 32,
                  child: ProfileListContainerTile(
                    icon: Icons.science,
                    title: 'Chemistry',
                  ),
                ),
                SizedBox(
                  height: 32,
                  child: ProfileListContainerTile(
                    icon: Icons.attach_money,
                    title: 'Economics',
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: ProfileListContainerTile(
                    icon: Icons.poll,
                    title: 'Writing',
                  ),
                ),
              ],
            ),
          ),

          /// course
          ProfileListContainer(
            title: 'Course',
            child: ProfileListContainerTile(
              icon: Icons.school,
              title: 'B.Tech CSE',
            ),
          ),

          /// college
          ProfileListContainer(
            title: 'College',
            child: ProfileListContainerTile(
              icon: Icons.account_balance,
              title: 'HKBK College Of Eng',
            ),
          ),

          /// dob
          ProfileListContainer(
            title: 'DOB',
            child: ProfileListContainerTile(
              icon: Icons.calendar_today,
              title: '23/07/2001',
            ),
          ),

          /// gender
          ProfileListContainer(
            title: 'Gender',
            child: ProfileListContainerTile(
              icon: Icons.person,
              title: 'Male',
            ),
          ),

          /// email
          ProfileListContainer(
            title: 'Email',
            child: ProfileListContainerTile(
              icon: Icons.email,
              title: 'sumit123210@gmail.com',
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
  final String title;
  final IconData icon;

  const ProfileListContainerTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
