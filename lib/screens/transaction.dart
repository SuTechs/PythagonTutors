import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutors/data/database.dart';
import 'package:tutors/data/utils/Utils.dart';
import 'package:tutors/data/utils/modal/user.dart';

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
            /// balance
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
                    '₹ ${UserData.teacher.balance}',
                    style: TextStyle(
                      fontSize: 18,
                      color: kBlueColor,
                    ),
                  ),
                ],
              ),
            ),

            /// transactions
            Expanded(
                child: FutureBuilder<List<TransactionData>>(
              future: TransactionData.getTransaction(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print('Error 52527 = ${snapshot.error}');
                  Get.snackbar(
                    'Something went wrong!',
                    'It looks like we got some error #2321',
                  );
                }

                if (snapshot.hasData)
                  return ListView.separated(
                      itemBuilder: (_, i) {
                        return TransactionListTile(
                          transaction: snapshot.data![i],
                        );
                      },
                      separatorBuilder: (_, i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          color: const Color(0xff707070),
                          height: 0.1,
                        );
                      },
                      itemCount: snapshot.data!.length);

                return Center(child: CircularProgressIndicator());
              },
            )),
          ],
        ),
      ),
    );
  }
}

class TransactionListTile extends StatelessWidget {
  final TransactionData transaction;

  const TransactionListTile({Key? key, required this.transaction})
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
          transaction.isWithdrawn ? Icons.north_east : Icons.south_west,
          color: kBlueColor,
        ),
      ),
      title: Text(
        'Money ${transaction.isWithdrawn ? 'Withdrawn' : 'Deposited'}',
        style: TextStyle(color: kBlueColor),
      ),
      subtitle: Text(getFormattedTime(transaction.createdAt)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${transaction.isWithdrawn ? '-' : '+'} ₹${transaction.amount}',
            style: TextStyle(fontSize: 16, color: kBlueColor),
          ),
          SizedBox(height: 2),
          Text(
            'CB: ₹${transaction.closingBalance}',
            style: context.textTheme.caption,
          ),
        ],
      ),
    );
  }
}
