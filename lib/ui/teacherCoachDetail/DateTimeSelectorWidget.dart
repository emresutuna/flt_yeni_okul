import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

class DateTimeSelectorWidget extends StatelessWidget {
  final List<String> dates;
  final String selectedDate;
  final ValueChanged<String> onDateSelected;
  final List<String> times;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const DateTimeSelectorWidget({
    super.key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
    required this.times,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tarih Seçin:", style: styleBlack14Bold),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final isSelected = selectedDate == dates[index];
              return GestureDetector(
                onTap: () => onDateSelected(dates[index]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: isSelected ? color5 : Colors.white,
                    border: Border.all(
                      color: color5,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      dates[index],
                      style: styleBlack12Bold.copyWith(
                        color: isSelected ? Colors.white : color5,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text("Saat Seçin:", style: styleBlack14Bold),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: times.map((time) {
            final isSelected = selectedTime == time;
            return ChoiceChip(
              label: Text(
                time,
                style: styleBlack12Bold.copyWith(
                  color: isSelected ? Colors.white : color5,
                ),
              ),
              showCheckmark: false,
              selected: isSelected,
              selectedColor: color5,
              backgroundColor: Colors.white,
              side: BorderSide(
                color:color5,
                width: 1.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              labelStyle: styleBlack12Bold.copyWith(
                color: isSelected ? Colors.white : color5,
              ),
              onSelected: (selected) {
                onTimeSelected(time);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
