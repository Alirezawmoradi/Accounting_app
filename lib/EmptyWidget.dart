import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          'assets/images/investment-svgrepo-com.svg',
          height: 200,
          width: 200,
          color: Colors.black.withOpacity(0.5),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text('! تراکنشی موجود نیست',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const Spacer(),
      ],
    );
  }
}
