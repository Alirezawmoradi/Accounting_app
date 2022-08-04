import 'dart:math';
import 'package:accounting/MyTextField.dart';
import 'package:accounting/const.dart';
import 'package:accounting/home_screen.dart';
import 'package:accounting/main.dart';
import 'package:accounting/money.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewTransactionScreen extends StatefulWidget {
  static int groupId = 0;
  static TextEditingController desciprionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isEditing = false;
  static int index = 0;
  static String date = 'تاریخ';

  const NewTransactionScreen({Key? key}) : super(key: key);

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                  NewTransactionScreen.isEditing
                      ? 'ویرایش تراکنش'
                      : 'تراکنش جدید',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 25),
              MyTextField(
                Hint: 'توضیحات',
                isNumber: false,
                controller: NewTransactionScreen.desciprionController,
              ),
              const SizedBox(height: 30),
              MyTextField(
                Hint: 'مبلغ',
                isNumber: true,
                controller: NewTransactionScreen.priceController,
              ),
              const TypeAndDateWidget(),
              MyButton(
                text: NewTransactionScreen.isEditing
                    ? 'ویرایش کردن'
                    : 'اضافه کردن',
                onPressed: () {
                  Money item = Money(
                      id: Random().nextInt(99999999),
                      title: NewTransactionScreen.desciprionController.text,
                      price: NewTransactionScreen.priceController.text,
                      date: NewTransactionScreen.date,
                      isReceived:
                          NewTransactionScreen.groupId == 1 ? true : false);
                  if (NewTransactionScreen.isEditing) {
                    int index = 0;
                    MyApp.getData();
                    for (int i = 0; i < hiveBox.values.length; i++) {
                      if (hiveBox.values.elementAt(i).id ==
                          NewTransactionScreen.index) {
                        index = i;
                      }
                    }
                    hiveBox.putAt(index, item);
                  } else {
                    hiveBox.add(item);
                  }
                  if (NewTransactionScreen.date == 'تاریخ') {
                    return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text(
                                  'لطفا تاریخ را وارد کنید',
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                        onPressed: () {
                                          hiveBox.deleteAt(hiveBox.length-1);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('باشه',
                                            style: TextStyle(
                                                color: Colors.black87))),
                                  ),
                                ]));
                  }else{
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///! My Button
class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: kPurpleColor,
              ),
              onPressed: onPressed,
              child: Text(text))),
    );
  }
}

///! Type And Date Widget
class TypeAndDateWidget extends StatefulWidget {
  const TypeAndDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TypeAndDateWidget> createState() => _TypeAndDateWidgetState();
}

class _TypeAndDateWidgetState extends State<TypeAndDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyRadioButton(
            text: 'دریافتی',
            value: 1,
            groupValue: NewTransactionScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionScreen.groupId = value!;
              });
            }),
        MyRadioButton(
            text: 'پرداختی',
            value: 2,
            groupValue: NewTransactionScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionScreen.groupId = value!;
              });
            }),
        OutlinedButton(
          onPressed: () async {
            var pickedDate = await showPersianDatePicker(
              context: context,
              initialDate: Jalali.now(),
              firstDate: Jalali(1401),
              lastDate: Jalali(1499),
            );
            setState(() {
              String year = pickedDate!.year.toString();
              String month = pickedDate.month.toString().length == 1
                  ? '0${pickedDate.month.toString()}'
                  : pickedDate.month.toString();
              String day = pickedDate.day.toString().length == 1
                  ? '0${pickedDate.day.toString()}'
                  : pickedDate.day.toString();
              NewTransactionScreen.date = year + '/' + month + '/' + day;
            });
          },
          child: Text(NewTransactionScreen.date,
              style: const TextStyle(fontSize: 12, color: Colors.black)),
        ),
      ],
    );
  }
}

///! My Radio Button
class MyRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String text;

  const MyRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Radio(value: value, groupValue: groupValue, onChanged: onChanged),
            Text(text),
          ],
        ),
      ],
    );
  }
}
