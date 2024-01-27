import 'package:calculator/controlls/notifier_provider.dart';
import 'package:calculator/core/sizes/dynamic_sizes.dart';
import 'package:calculator/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


const List keyContent = [
  'AC',
  'C',
  '+/-',
  '÷',
  '7',
  '8',
  '9',
  '×',
  '4',
  '5',
  '6',
  '−',
  '1',
  '2',
  '3',
  '+',
  '0',
  '.',
  '00',
  '='
];

// ignore: must_be_immutable
class MyCalculator extends ConsumerWidget {
  Color? keyColor;

  Color? textColor;

  MyCalculator({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: LightMode.bgColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                right: context.screenWidth(.02), top: context.screenWidth(.1)),
            color: LightMode.bgColor,
            width: double.infinity,
            height: context.screenHeight(.3),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  ref.watch(notifyProvider),
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: LightMode.textColor,
                      fontSize: context.screenHeight(.08),
                      fontWeight: FontWeight.w600),
                )),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: context.screenWidth(.015),
                  crossAxisSpacing: context.screenWidth(.015)),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                // specify the color upto its index
                if (index < 3) {
                  keyColor = const Color(0xff0dcafc);
                  textColor = Colors.white;
                } else if (index == 7 ||
                    index == 11 ||
                    index == 15 ||
                    index == 19 ||
                    index == 3) {
                  keyColor = LightMode.subKeyColor;
                  textColor = Colors.white;
                } else {
                  keyColor = LightMode.mainKeyColor;
                  textColor = Colors.black;
                }
                return InkWell(
                  onTap: () {
                    ref
                        .read(notifyProvider.notifier)
                        .buttonEvent(str: keyContent[index]);
                  },
                  child: buttonBox(context, index),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container buttonBox(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          color: keyColor, borderRadius: BorderRadius.circular(100)),
      width: context.screenWidth(.1),
      height: context.screenWidth(.1),
      child: Center(
        child: Text(
          keyContent[index],
          style: TextStyle(
            color: textColor,
            fontSize: context.screenWidth(.045),
          ),
        ),
      ),
    );
  }
}
