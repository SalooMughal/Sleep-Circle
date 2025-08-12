///callback when scrolling changed, since you ask for int
/// i prefer double instead : 20.5 kg or 100.34 kg
///
import 'package:flutter/material.dart';
typedef OnScrollChanged = void Function(double scale);

///calback when selected
typedef OnSelected = void Function(double scale);

class ScaleIndicator extends StatefulWidget {
  /// default value show in widget when first open
  final double? initialValue;

  ///what the distance for performance, min max kg so the we can pass max length to listview builder
  final int? range;
  final Color? indicatorColor;

  ///callback when scrolling changed
  final OnScrollChanged? onScrollChanged;

  ///calback when selected return double
  final OnSelected onSelected;

  const ScaleIndicator(
      {Key? key,
        this.initialValue,
        this.range,
        this.indicatorColor,
        this.onScrollChanged,
        required this.onSelected})
      : super(key: key);

  @override
  State<ScaleIndicator> createState() => _ScaleIndicatorState();
}

class _ScaleIndicatorState extends State<ScaleIndicator> {
  // default value show in widget when first open
  late double _initialValue;

  // what the distance for performance, min max kg so the we can pass max length to listview builder
  late int _range;

  late Color _indicatorColor;

  late double _valueSelected;

  static const double _indicatorWidth = 10.0;

  @override
  void initState() {
    super.initState();
    // set your default value here
    _initialValue = 0;
    _range = 200;
    _indicatorColor = Colors.blue;
    _valueSelected = 0;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        double pixels = scroll.metrics.pixels;
        double result = pixels / (_indicatorWidth * 10.0);
        setState(() {
          _valueSelected = result;
          widget.onScrollChanged!(
              double.tryParse(_valueSelected.toStringAsFixed(2)) ?? 0.0);
        });
        return true;
      },
      child: SizedBox(
        width: 200,
        height: 120,
        child: Column(
          children: [
            Flexible(
                child: FractionalTranslation(
                    translation: const Offset(0.175, 0.0),
                    child: Text(
                      "${_valueSelected.toStringAsFixed(2)} kg",
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ))),
            Expanded(
              child: ListView.builder(
                itemCount: _range,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: _indicatorWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 3,
                          height: _heightFromIndex(index),
                          decoration: BoxDecoration(
                              color: _indicatorColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0))),
                        ),
                        const Expanded(child: SizedBox())
                      ],
                    ),
                  );
                },
              ),
            ),
            //Button for ex you wanna show it on ShowDialog or else
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    widget.onSelected(
                        double.tryParse(_valueSelected.toStringAsFixed(2)) ??
                            0.0);
                  },
                  child: const Text("Done")),
            )
          ],
        ),
      ),
    );
  }

  double _heightFromIndex(int index) {
    if (index % 10 == 0) {
      return 40.0;
    } else if (index % 5 == 0) {
      return 25.0;
    }
    return 10.0;
  }
}