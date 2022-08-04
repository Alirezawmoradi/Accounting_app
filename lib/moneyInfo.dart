import 'package:flutter/material.dart';

class moneyInfo extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String firstPrice;
  final String secondPrice;

  const moneyInfo(
      {Key? key,
      required this.firstText,
      required this.secondText,
      required this.firstPrice,
      required this.secondPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Text(firstPrice,style: const TextStyle(fontSize: 12),)),
          Text(secondText,
              textAlign: TextAlign.right, textDirection: TextDirection.rtl,style: const TextStyle(fontSize: 12)),
          Expanded(child: Text(secondPrice, textAlign: TextAlign.right,style: const TextStyle(fontSize: 12))),
          Text(firstText,textDirection: TextDirection.rtl,style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
