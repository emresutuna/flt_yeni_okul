import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

class ExpandableCourseDetailItem extends StatefulWidget {
  final String teacher;
  final String title;
  final String date;
  final String time;
  final String location;
  final String price;
  final String description;

  const ExpandableCourseDetailItem({
    Key? key,
    this.teacher = '',
    this.title = '',
    this.date = '',
    this.time = '',
    this.location = '',
    this.price = '',
    this.description = '',
  }) : super(key: key);

  @override
  State<ExpandableCourseDetailItem> createState() =>
      _ExpandableCourseDetailItemState();
}

class _ExpandableCourseDetailItemState
    extends State<ExpandableCourseDetailItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.title,
                      style: styleBlack14Bold,
                    ),
                  ),
                  Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.teacher.isNotEmpty)
                      Row(
                        children: [
                          Text("Öğretmen: ", style: styleBlack14Bold),
                          Expanded(child: Text(widget.teacher, style: styleBlack14Regular,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    if (widget.teacher.isNotEmpty) const SizedBox(height: 4),
                    if (widget.date.isNotEmpty)
                      Row(
                        children: [
                          Text(
                            "Tarih: ",
                            style: styleBlack14Bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Flexible(
                            child: Text(
                              widget.date,
                              style: styleBlack14Regular,
                            ),
                          ),
                        ],
                      ),
                    if (widget.date.isNotEmpty) const SizedBox(height: 4),
                    if (widget.time.isNotEmpty)
                      Row(
                        children: [
                          Text("Konu: ", style: styleBlack14Bold),
                          Text(widget.time, style: styleBlack14Regular),
                        ],
                      ),
                    if (widget.time.isNotEmpty) const SizedBox(height: 4),
                    if (widget.location.isNotEmpty)
                      Row(
                        children: [
                          Text("Sınıf: ", style: styleBlack14Bold),
                          Text(widget.location, style: styleBlack14Regular),
                        ],
                      ),
                    if (widget.location.isNotEmpty) const SizedBox(height: 4),
                    if (widget.price.isNotEmpty) const SizedBox(height: 8),
                    if (widget.description.isNotEmpty)
                      Row(
                        children: [
                          Text("Açıklama: ", style: styleBlack14Bold),
                          Flexible(
                            child: Text(
                              widget.description,
                              style: styleBlack14Regular,
                            ),
                          ),
                        ],
                      ),
                    8.toHeight
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
