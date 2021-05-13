import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class Transaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(accentColor: kBlueColor),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBlueColor,
            ),
          ),
          title: Text(
            'Transactions',
            style: TextStyle(color: kBlueColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: kBlueColor.withOpacity(0.04),
              ),
              child: Row(
                children: [
                  Text(
                    'Balance Available',
                    style: TextStyle(
                      fontSize: 18,
                      color: kBlueColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '₹ 500',
                    style: TextStyle(
                      fontSize: 18,
                      color: kBlueColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (_, i) {
                    return TransactionListTile(isWithdrawn: i % 2 == 0);
                  },
                  separatorBuilder: (_, i) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      color: const Color(0xff707070),
                      height: 0.1,
                    );
                  },
                  itemCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionListTile extends StatelessWidget {
  final bool isWithdrawn;

  const TransactionListTile({Key? key, required this.isWithdrawn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 0.5, color: kBlueColor),
        ),
        child: Icon(
          isWithdrawn ? Icons.north_east : Icons.south_west,
          color: kBlueColor,
        ),
      ),
      title: Text(
        'Money ${isWithdrawn ? 'Withdrawn' : 'Deposited'}',
        style: TextStyle(color: kBlueColor),
      ),
      subtitle: Text('23 Apr 12:20 PM'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${isWithdrawn ? '-' : '+'} ₹500',
            style: TextStyle(fontSize: 16, color: kBlueColor),
          ),
          SizedBox(height: 2),
          Text(
            'CB: ₹200',
            style: context.textTheme.caption,
          ),
        ],
      ),
    );
  }
}
