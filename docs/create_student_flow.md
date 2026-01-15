# Create Student Flow Documentation

## 📋 نظرة عامة على الـ Flow

هناك 3 طرق لإضافة طالب جديد:
1. **Single QR Scan**: مسح QR code للطالب الواحد من صفحة الـ scanner
2. **Batch QR Scan**: مسح عدة طلاب دفعة واحدة (Batch Mode)
3. **Manual Input**: إضافة يدوي من خلال AddStudentBottomSheet

---

## 🔄 Single QR Scan Flow

### الخطوات:
```
Scanner Page
    ↓
scanQRCode() [في ScannerCubit]
    ↓
checkStudentAttendance() أو addStudentByQRCode()
    ↓
StudentRepo.addStudentByQRCode()
    ↓
1. Get existing students من الـ Class
2. Check إذا الطالب موجود:
   - لو موجود → سجل attendance له (recordAttendance)
   - لو مش موجود → اتبع الخطوات تحت
3. Create StudentModel جديد بـ:
   - firstName, lastName (من اسم المسح)
   - studentId (UUID جديد)
   - attendanceCount: 0
   - التفاصيل الإضافية (اختيارية)
4. Save في Firestore باستخدام addStudentToClass()
5. Record attendance تلقائياً للطالب الجديد
```

### الكود الأساسي:
```dart
// في StudentRepo
Future<Either<String, String>> addStudentByQRCode({
  required ClassModel classModel,
  required String studentName,
  // ... other fields
}) async {
  // 1. Get existing students
  final existingStudents = await getStudentsByClassId(classModel);
  
  // 2. Check if student exists
  for (var element in existingStudents) {
    String name = '${element.firstName} ${element.lastName}'.toLowerCase();
    if (name == studentName.toLowerCase()) {
      // Student found → Record attendance
      return await studentAttendance(studentModel: element);
    }
  }
  
  // 3. Create new student
  StudentModel studentModel = StudentModel(
    firstName: studentName.split(' ').first,
    lastName: studentName.split(' ').sublist(1).join(' '),
    studentId: Uuid().v4(),
    attendanceCount: 0,
    createdAt: DateTime.now(),
    levelId: classModel.levelId,
    classId: classModel.id,
    // ... other fields
  );
  
  // 4. Save to Firestore
  await studentFirebaseServices.addStudentToClass(
    studentModel: studentModel,
    classModel: classModel,
  );
  
  // 5. Record attendance for new student
  return await studentAttendance(studentModel: studentModel);
}
```

---

## 📦 Batch QR Scan Flow

### الخطوات:
```
Scanner Page → enableBatchMode()
    ↓
User scans multiple students
    ↓
addStudentToBatchFromName() [لكل طالب]
    ↓
For each student:
  1. Get existing students
  2. Search for student by full name
  3. If found:
     - Add to scannedStudents list
     - Emit ScannerBatchMode with updated list
  4. If not found:
     - Call addStudentByQRCode() to create new student
     - Mark في studentsWithAttendance Set
     - Add to scannedStudents list
    ↓
User clicks Submit
    ↓
submitBatchAttendance() [في ScannerCubit]
    ↓
StudentRepo.batchStudentAttendance(students: scannedStudents)
    ↓
For existing students (مش في studentsWithAttendance):
  - Check إذا عندهم attendance ليوم
  - لو عندهم → Skip
  - لو مش عندهم → Record attendance
For new students (في studentsWithAttendance):
  - بالفعل عملنا record attendance عند الإضافة
```

### الكود الأساسي:
```dart
// في ScannerCubit
Future<void> addStudentToBatchFromName({
  required String studentName,
  required ClassModel classModel,
}) async {
  // 1. Get existing students
  final existingStudents = await _studentRepo.getStudentsByClassId(classModel);
  
  // 2. Search for student
  StudentModel? foundStudent;
  for (var student in existingStudents) {
    String fullName = '${student.firstName} ${student.lastName}'.toLowerCase();
    if (fullName == studentName.toLowerCase()) {
      foundStudent = student;
      break;
    }
  }
  
  if (foundStudent != null) {
    // 3a. Add existing student to batch
    scannedStudents.add(foundStudent);
  } else {
    // 3b. Create new student
    final addResult = await _studentRepo.addStudentByQRCode(
      studentName: studentName,
      classModel: classModel,
    );
    
    // After successfully creating, fetch the new student and add
    final updatedStudents = await _studentRepo.getStudentsByClassId(classModel);
    
    // Find the newly created student
    for (var student in updatedStudents) {
      String fullName = '${student.firstName} ${student.lastName}'.toLowerCase();
      if (fullName == studentName.toLowerCase()) {
        scannedStudents.add(student);
        // Mark as already having attendance
        studentsWithAttendance.add(student.studentId!);
        break;
      }
    }
  }
}
```

---

## 👥 Manual Input Flow (AddStudentBottomSheet)

### الخطوات:
```
User clicks Add Button في ClassView
    ↓
AddStudentBottomSheet appears
    ↓
User fills form and clicks Submit
    ↓
_handleAddStudent() في AddStudentBottomSheet
    ↓
ScannerCubit.addStudentByQRCode() أو updateStudent()
    ↓
نفس flow السابقة
```

### من الـ AddStudentBottomSheet:
```dart
void _handleAddStudent() {
  if (_formKey.currentState!.validate()) {
    if (widget.studentModel != null) {
      // Update mode
      context.read<ScannerCubit>().updateStudent(
        studentModel: updatedStudent,
      );
    } else {
      // Add new student mode
      context.read<ScannerCubit>().addStudentByQRCode(
        classModel: widget.classModel,
        studentName: fullName,
        levelName: widget.levelName,
        sex: _selectedGender,
        phoneNumber: _phoneNumberController.text,
        // ... other fields
      );
    }
  }
}
```

---

## 🗄️ Firestore Structure

```
levels/{levelId}
  └── classes/{classId}
      └── students/{studentId}  ← StudentModel document
          ├── firstName: "محمد"
          ├── lastName: "الدين"
          ├── studentId: "uuid"
          ├── attendanceCount: 0
          ├── sex: "ذكر"
          ├── createdAt: timestamp
          └── attendance/{attendanceId}  ← Attendance records
              ├── date: timestamp
              └── status: "present"
```

---

## ⚠️ Important Notes

### 1. **Duplicate Prevention**
- عند الـ Single Scan: Check إذا الطالب موجود قبل الإضافة
- عند الـ Batch Scan: Track في `studentsWithAttendance` Set

### 2. **Attendance Automatic Recording**
- عند إضافة طالب جديد → يتم تسجيل attendance تلقائياً
- عند إضافة طالب موجود في الـ batch → يتم التحقق من attendance الحالي قبل التسجيل

### 3. **Student Data Validation**
```dart
// اسم الطالب يتم تقسيمه:
firstName: studentName.split(' ').first
lastName: studentName.split(' ').sublist(1).join(' ')

// إذا لم يكن عندك firstName و lastName منفصلة
```

### 4. **UUID Generation**
```dart
studentId: Uuid().v4()  // كل طالب جديد يأخذ ID فريد
```

### 5. **Batch Attendance Check**
```dart
// في batchStudentAttendance:
// 1. Filter students بدون attendance اليوم
// 2. Use Firestore Batch write للكفاءة
// 3. Commit كل شيء دفعة واحدة
```

---

## 📊 Comparison

| Feature | Single Scan | Batch Scan | Manual Input |
|---------|------------|-----------|--------------|
| الأداء | سريع (1 student) | أسرع (n students) | متوسط |
| الاستخدام | طالب واحد | عدة طلاب | إضافة مفصلة |
| Attendance Recording | تلقائي | تلقائي عند submit | تلقائي |
| Data Entry | من الـ QR code | من الـ QR code | يدوي كامل |

