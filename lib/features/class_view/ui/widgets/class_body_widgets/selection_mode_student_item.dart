import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/custom_student_item.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:flutter/material.dart';

class SelectionModeStudentItem extends StatelessWidget {
  const SelectionModeStudentItem({
    super.key,
    required this.student,
    required this.index,
    required this.classModel,
    required this.isSelected,
    required this.onTap,
  });

  final StudentModel student;
  final int index;
  final ClassModel classModel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              CustomStudentItem(
                student: student,
                index: index,
                classModel: classModel,
                isSelectionMode: true,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? ColorsTheme().primaryColor
                        : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? ColorsTheme().primaryColor
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
