import 'package:accounting/EmptyWidget.dart';
import 'package:accounting/const.dart';
import 'package:accounting/main.dart';
import 'package:accounting/money.dart';
import 'package:accounting/new_transations_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static List<Money> moneys = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        floatingActionButton: fabWidget(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              headerWidget(),
              Expanded(
                child: HomeScreen.moneys.isEmpty
                    ? const EmptyWidget()
                    : ListView.builder(
                        itemCount: HomeScreen.moneys.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(

                              ///!Edit
                              onTap: () {
                                NewTransactionScreen.date=HomeScreen.moneys[index].date;
                                NewTransactionScreen.desciprionController.text =
                                    HomeScreen.moneys[index].title;
                                NewTransactionScreen.priceController.text =
                                    HomeScreen.moneys[index].price;
                                NewTransactionScreen.groupId =
                                    HomeScreen.moneys[index].isReceived ? 1 : 2;
                                NewTransactionScreen.isEditing = true;
                                NewTransactionScreen.index = HomeScreen.moneys[index].id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NewTransactionScreen(),
                                  ),
                                ).then((value) {
                                  MyApp.getData();
                                  setState(() {});
                                });
                              },

                              ///! Delete
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'آیا از حذف این آیتم مطمئن هستید؟',
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('خیر',
                                              style: TextStyle(
                                                  color: Colors.black87))),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              hiveBox.deleteAt(index);
                                              MyApp.getData();
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'بله',
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ))
                                    ],
                                  ),
                                );
                              },
                              child: MyListTileWidget(index: index));
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }


   ///! Fab Widget
  Widget fabWidget() {
    return FloatingActionButton(
        backgroundColor: kPurpleColor,
        child: const Icon(Icons.add),
        onPressed: () {
          NewTransactionScreen.date='تاریخ';
          NewTransactionScreen.desciprionController.text = '';
          NewTransactionScreen.priceController.text = '';
          NewTransactionScreen.groupId = 0;
          NewTransactionScreen.isEditing = false;
          Navigator.of(context)
              .push(
            MaterialPageRoute(
                builder: (BuildContext contex) => const NewTransactionScreen()),
          )
              .then((value) {
            MyApp.getData();
            setState(() {});
          });
        });
  }


  ///! Header Widget
  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 5, top: 25),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              textEditingController: TextEditingController(),
              isOriginalAnimation: false,
              hintText: '...جستجو کنید',
              buttonBorderColour: Colors.black26,
              buttonIcon: Icons.search,
              onCollapseComplete: () {
                MyApp.getData();
                searchController.text = '';
                setState(() {});
              },
              onFieldSubmitted: (String text) {
                List<Money> result = hiveBox.values
                    .where((value) =>
                        value.title.contains(text) ||
                        value.date.contains(text) ||
                        value.price.contains(text))
                    .toList();
                HomeScreen.moneys.clear();
                setState(() {
                  for (var value in result) {
                    HomeScreen.moneys.add(value);
                  }
                });
              },
              buttonShadowColour: Colors.black26,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            ' تراکنش ها',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

/// MyListTileWidget
class MyListTileWidget extends StatelessWidget {
  final int index;

  const MyListTileWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HomeScreen.moneys[index].isReceived
                    ? kGreenColor
                    : kRedColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(
                  HomeScreen.moneys[index].isReceived
                      ? Icons.add
                      : Icons.remove,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(HomeScreen.moneys[index].title.toString()),
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  const Text(
                    'تومان',
                    style: TextStyle(
                        fontSize: 14,
                        color: kRedColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    HomeScreen.moneys[index].price,
                    style: const TextStyle(
                        fontSize: 14,
                        color: kRedColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(HomeScreen.moneys[index].date,
                  textDirection: TextDirection.rtl),
            ],
          ),
        ],
      ),
    );
  }
}
