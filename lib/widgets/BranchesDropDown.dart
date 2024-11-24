import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import '../util/LessonExtension.dart';

class BranchesDropdown extends StatelessWidget {
  final Function(Branch?) onBranchSelected;

  const BranchesDropdown({Key? key, required this.onBranchSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final branches = BranchesExtension.getAllBranches(); // Enum'dan gelen liste

    // Filter duplicates using the `id` property, assuming `id` is unique
    final uniqueBranches = branches.toSet().toList();

    return DropdownButtonFormField<Branch>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color1),
        ),
      ),
      items: uniqueBranches.map((branch) {
        return DropdownMenuItem<Branch>(
          value: branch,
          child: Text(
            branch.name,
            style: styleBlack14Bold,
          ),
        );
      }).toList(),
      onChanged: onBranchSelected,
      hint: const Text('Branş Seç'),
    );
  }
}
