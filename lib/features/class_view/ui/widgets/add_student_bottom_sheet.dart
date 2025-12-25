import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/class_view/manager/scanner_cubit/scanner_cubit.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_widgets/add_student_birthday_psalmist.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_widgets/add_student_contact_fields.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_widgets/add_student_gender_field.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_widgets/add_student_header.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_widgets/add_student_name_fields.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_widgets/add_student_submit_button.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStudentBottomSheet extends StatefulWidget {
  const AddStudentBottomSheet({
    super.key,
    required this.classModel,
    required this.levelName,
  });

  final ClassModel classModel;
  final String levelName;

  @override
  State<AddStudentBottomSheet> createState() => _AddStudentBottomSheetState();
}

class _AddStudentBottomSheetState extends State<AddStudentBottomSheet> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _parentNumberController;
  late TextEditingController _addressController;
  late TextEditingController _fatherNameController;

  late FocusNode _firstNameFocus;
  late FocusNode _lastNameFocus;
  late FocusNode _phoneNumberFocus;
  late FocusNode _parentNumberFocus;
  late FocusNode _addressFocus;
  late FocusNode _fatherNameFocus;

  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  DateTime? _selectedBirthday;
  bool _isPsalmist = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _parentNumberController = TextEditingController();
    _addressController = TextEditingController();
    _fatherNameController = TextEditingController();

    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _phoneNumberFocus = FocusNode();
    _parentNumberFocus = FocusNode();
    _addressFocus = FocusNode();
    _fatherNameFocus = FocusNode();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _parentNumberController.dispose();
    _addressController.dispose();
    _fatherNameController.dispose();

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _phoneNumberFocus.dispose();
    _parentNumberFocus.dispose();
    _addressFocus.dispose();
    _fatherNameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerCubit, ScannerState>(
      listener: (context, state) {
        if (state is ScannerSuccess) {
          setState(() => _isLoading = false);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Student added successfully'.tr()),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ScannerError) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: ColorsTheme().whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const AddStudentHeader(),

                // Name Fields
                AddStudentNameFields(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  firstNameFocus: _firstNameFocus,
                  lastNameFocus: _lastNameFocus,
                  onFirstNameSubmitted: () =>
                      FocusScope.of(context).requestFocus(_lastNameFocus),
                ),
                const SizedBox(height: 16),

                // Gender Field
                AddStudentGenderField(
                  selectedGender: _selectedGender,
                  onChanged: (value) => setState(() => _selectedGender = value),
                ),
                const SizedBox(height: 16),

                // Contact Fields
                AddStudentContactFields(
                  phoneNumberController: _phoneNumberController,
                  parentNumberController: _parentNumberController,
                  fatherNameController: _fatherNameController,
                  addressController: _addressController,
                  phoneNumberFocus: _phoneNumberFocus,
                  parentNumberFocus: _parentNumberFocus,
                  fatherNameFocus: _fatherNameFocus,
                  addressFocus: _addressFocus,
                ),
                const SizedBox(height: 16),

                // Birthday & Psalmist
                AddStudentBirthdayPsalmist(
                  selectedBirthday: _selectedBirthday,
                  isPsalmist: _isPsalmist,
                  onBirthdayTap: _selectBirthday,
                  onPsalmistChanged: (value) =>
                      setState(() => _isPsalmist = value),
                ),
                const SizedBox(height: 24),

                // Submit Button
                AddStudentSubmitButton(
                  isLoading: _isLoading,
                  onPressed: _handleAddStudent,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectBirthday() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: ColorsTheme().primaryDark),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedBirthday = picked);
    }
  }

  void _handleAddStudent() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Combine first and last name
      final fullName =
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';

      // Call the existing addStudentByQRCode method
      context.read<ScannerCubit>().addStudentByQRCode(
        classModel: widget.classModel,
        studentName: fullName,
        levelName: widget.levelName,
        // Additional fields (we'll need to modify the repo to accept these)
        sex: _selectedGender,
        phoneNumber: _phoneNumberController.text.trim(),
        parentNumber: _parentNumberController.text.trim(),
        address: _addressController.text.trim(),
        birthday: _selectedBirthday,
        fatherName: _fatherNameController.text.trim(),
        isPsalmist: _isPsalmist,
      );
    }
  }
}
