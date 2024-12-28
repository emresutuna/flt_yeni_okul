import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import '../util/LessonExtension.dart';

class BranchesDropdown extends StatelessWidget {
  final Function(Branches?) onBranchSelected;

  const BranchesDropdown({Key? key, required this.onBranchSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final branches = BranchesExtension.allBranches;

    final uniqueBranches = branches.toSet().toList();

    return DropdownButtonFormField<Branches>(
      isExpanded: true,
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
        return DropdownMenuItem<Branches>(
          value: branch,
          child: Text(
            branch.value,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: styleBlack14Bold,
          ),
        );
      }).toList(),
      onChanged: onBranchSelected,
      hint: Text('Branş Seç',
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          maxLines: 1,
          style: styleBlack14W600.copyWith(color: Colors.grey)),
    );
  }
}
