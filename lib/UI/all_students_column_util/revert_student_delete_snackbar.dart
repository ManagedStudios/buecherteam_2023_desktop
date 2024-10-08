/*
  showSnackbar is used to undo a delete of a student
   */

import 'package:buecherteam_2023_desktop/Data/db.dart';
import 'package:buecherteam_2023_desktop/Models/student_detail_state.dart';
import 'package:buecherteam_2023_desktop/Util/database/update.dart';
import 'package:cbl/cbl.dart';
import 'package:flutter/material.dart';

import '../../Data/student.dart';
import '../../Models/studentListState.dart';
import '../../Resources/dimensions.dart';
import '../../Resources/text.dart';

void showRevertStudentDeleteSnackBar(
    Student student,
    StudentListState studentListState,
    StudentDetailState studentDetailState,
    BuildContext context,
    DB database) {

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content:
        Text("${student.firstName} ${student.lastName} ${TextRes.wasDeleted}"),
    action: SnackBarAction(
        label: TextRes.undo,
        onPressed: () {
          MutableDocument doc = MutableDocument();
          database.updateDocFromEntity(student, doc);
          database.saveDocument(doc);
          updateBookAmountOnBooksAddedUtil(student.books, database);
        } //save the student passed from the deletion process
            ),
    margin: const EdgeInsets.only(
        left: Dimensions.largeMargin,
        right: Dimensions.largeMargin,
        bottom: Dimensions.minMarginStudentView),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimensions.cornerRadiusSmall))),
    padding: const EdgeInsets.all(Dimensions.paddingMedium),
  ));
}
