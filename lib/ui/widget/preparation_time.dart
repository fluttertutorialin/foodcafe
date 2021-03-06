import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'animation/bounce_animation.dart';
import '../../model/order/order.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';

class PreparationTime extends StatelessWidget {
  final List<PreparationTimeList> preparationTimeList;
  final PreparationTimeDefault preparationTimeDefault;
  final ValueChanged<int> preparationTimeSelect,
      preparationTimeMinus,
      preparationTimePlus;

  PreparationTime(
      {this.preparationTimeList,
      this.preparationTimeDefault,
      this.preparationTimeSelect,
      this.preparationTimeMinus,
      this.preparationTimePlus});

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 1),
        Text(labelPreparationTime, style: preparationTimeStyle),
        Row(children: [
          Expanded(
              flex: 2500,
              child: Row(
                  children: preparationTimeList
                      .map((item) => Container(
                          padding: EdgeInsets.all(10),
                          child: Obx(() => BouncingAnimation(
                              scaleFactor: 1.5,
                              child: Text('${item.time}',
                                  style: item.isSelect.value
                                      ? preparationTimeSelectStyle
                                      : preparationTimeUnSelectStyle),
                              onPressed: () =>
                                  preparationTimeSelect(item.time.value)))))
                      .toList())),
          Expanded(
              flex: 1200,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                    onTap: () => preparationTimeMinus(
                        preparationTimeDefault.selectTime.value),
                    child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: preparationTimeDecoration,
                        child: Icon(minusIcon,
                            color: preparationTimeIconColor, size: 12))),
                SizedBox(width: 10),
                Obx(() => Text(
                    '${preparationTimeDefault.selectTime.value == null ? preparationTimeDefault.defaultTime.value : preparationTimeDefault.selectTime.value}'
                        .padLeft(2, '0'),
                    style: preparationTimeUnSelectStyle)),
                SizedBox(width: 2),
                Text(labelMin, style: preparationTimeMinHourStyle),
                SizedBox(width: 10),
                GestureDetector(
                    child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: preparationTimeDecoration,
                        child: Icon(plusIcon,
                            color: preparationTimeIconColor, size: 12)),
                    onTap: () => preparationTimePlus(
                        preparationTimeDefault.selectTime.value))
              ]))
        ])
      ]);
}
