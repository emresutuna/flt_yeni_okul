import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

class ExpandableCourseDetail extends StatefulWidget {
  final String title;
  final String description;
  final String teacher;
  final String date;
  final String time;
  final String location;
  final String price;

  const ExpandableCourseDetail({
    Key? key,
    required this.title,
    required this.description,
    required this.teacher,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
  }) : super(key: key);

  @override
  State<ExpandableCourseDetail> createState() => _ExpandableCourseDetailState();
}

class _ExpandableCourseDetailState extends State<ExpandableCourseDetail> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0,left: 8,right: 8,bottom: 16),
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
                  Text(
                    widget.title,
                    style: styleBlack14Bold
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
                          Text("Öğretmen: ", style: styleBlack12Bold),
                          Text(widget.teacher, style:styleBlack12Regular),
                        ],
                      ),
                    if (widget.teacher.isNotEmpty) const SizedBox(height: 4),

                    if (widget.date.isNotEmpty)
                      Row(
                        children: [
                          Text("Tarih: ", style: styleBlack12Bold),
                          Text(widget.date, style: styleBlack12Regular),
                        ],
                      ),
                    if (widget.date.isNotEmpty) const SizedBox(height: 4),

                    if (widget.time.isNotEmpty)
                      Row(
                        children: [
                          Text("Konu: ", style: styleBlack12Bold),
                          Text(widget.time, style: styleBlack12Regular),
                        ],
                      ),
                    if (widget.time.isNotEmpty) const SizedBox(height: 4),

                    if (widget.location.isNotEmpty)
                      Row(
                        children: [
                          Text("Sınıf: ", style:styleBlack12Bold),
                          Text(widget.location, style:styleBlack12Regular,)
                        ],
                      ),
                    if (widget.location.isNotEmpty) const SizedBox(height: 4),

                    if (widget.price.isNotEmpty)
                      Row(
                        children: [
                          Text("Fiyat: ", style:styleBlack12Bold),
                          Text("${widget.price} ₺", style: styleBlack12Regular),
                        ],
                      ),
                    if (widget.price.isNotEmpty) const SizedBox(height: 8),

                    if (widget.description.isNotEmpty)
                      Row(
                        children: [
                          Text("Açıklama: ", style:styleBlack12Bold),
                          Text("${widget.description} ₺", style: styleBlack12Regular),
                        ],
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
