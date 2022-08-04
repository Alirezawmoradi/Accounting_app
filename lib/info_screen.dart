import 'package:accounting/Utils/calculate.dart';
import 'package:accounting/moneyInfo.dart';
import 'package:flutter/material.dart';

import 'Widgets/chartWidget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 15, top: 15, left: 5),
                child: Text('مدیریت تراکنش ها به تومان'),
              ),
              moneyInfo(
                  firstText: 'پرداختی امروز : ',
                  firstPrice:  Calculate.dToday().toString(),
                  secondPrice:Calculate.pToday().toString(),
                  secondText: 'دریافتی امروز :'),
              moneyInfo(
                  firstText: 'پرداختی این ماه : ',
                  firstPrice: Calculate.dMonth().toString(),
                  secondPrice: Calculate.pMonth().toString(),
                  secondText: 'دریافتی این ماه :'),
              moneyInfo(
                  firstText: 'پرداختی امسال : ',
                  firstPrice:  Calculate.dYear().toString(),
                  secondPrice:Calculate.pYear().toString(),
                  secondText: 'دریافتی امسال :'),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(20),
                  height:200,
                  child: const barChartWidget(),),
            ],
          ),
        ),
      ),
    );
  }
}
