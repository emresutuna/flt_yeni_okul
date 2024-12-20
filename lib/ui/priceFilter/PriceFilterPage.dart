import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

class PriceFilter extends StatefulWidget {
  final double minLimit;
  final double maxLimit;
  final Function(double minValue, double maxValue) onApply;

  const PriceFilter({
    Key? key,
    this.minLimit = 0,
    this.maxLimit = 50000,
    required this.onApply,
  }) : super(key: key);

  @override
  _PriceFilterState createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  double _minPrice = 70;
  double _maxPrice = 20083;
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(_minPrice, _maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildPriceBox('En Az', _minPrice)),
            16.toWidth,
            Expanded(child: _buildPriceBox('En Çok', _maxPrice)),
          ],
        ),
        16.toHeight,
        RangeSlider(
          values: _currentRangeValues,
          min: widget.minLimit,
          max: widget.maxLimit,
          divisions: 500,
          labels: RangeLabels(
            '${_currentRangeValues.start.round()} TL',
            '${_currentRangeValues.end.round()} TL',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              _minPrice = values.start;
              _maxPrice = values.end;
            });
            // Fiyat aralığı değiştiğinde onApply fonksiyonu çağrılıyor
            widget.onApply(_minPrice, _maxPrice);
          },
          activeColor: color5,
          inactiveColor: color5.withAlpha(50),
        ),
      ],
    );
  }

  Widget _buildPriceBox(String label, double value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: styleBlack14Regular,),
         4.toHeight,
          Text(
            '${value.round()} TL',
            style:styleBlack16Bold
          ),
        ],
      ),
    );
  }
}
