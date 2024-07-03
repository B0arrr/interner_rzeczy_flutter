import 'package:flutter_thermometer/thermometer.dart';

class CustomScaleProvider implements ScaleProvider {

  @override
  List<ScaleTick> calcTicks(double minValue, double maxValue) {
    return [
      ScaleTick(minValue,
          label: '-50',
          length: 10,
          labelSpace: 5,
          thickness: 3),
      ScaleTick((maxValue-minValue)/2 + minValue,
          label: '0',
          length: 5,
          labelSpace: 10,
          thickness: 3),
      ScaleTick(maxValue,
          label: '50',
          length: 10,
          thickness: 3)
    ];
  }


}
