import 'package:buecherteam_2023_desktop/Data/class_data.dart';

import 'package:buecherteam_2023_desktop/Data/student.dart';
import 'package:buecherteam_2023_desktop/Data/training_directions_data.dart';
import 'package:buecherteam_2023_desktop/Resources/dimensions.dart';
import 'package:buecherteam_2023_desktop/Resources/text.dart';
import 'package:buecherteam_2023_desktop/UI/tag_dropdown/dropdown.dart';
import 'package:flutter/material.dart';


/*
  StudentDialogContent holds all of the content for a dialog to
  create or update a student
 */

class StudentDialogContent extends StatefulWidget {
  const StudentDialogContent({super.key, this.student,
    required this.classes, required this.onStudentClassUpdated,
    required this.trainingDirections,
    required this.onStudentTrainingDirectionsUpdated,
    this.firstNameError, this.lastNameError, this.classError,
    required this.onFirstNameChanged, required this.onLastNameChanged});

  final Student? student; //update => existing student passed

  final Function(String firstName) onFirstNameChanged;
  final Function(String lastName) onLastNameChanged;

  final List<ClassData> classes;
  final Function(ClassData? classData) onStudentClassUpdated;

  final Function(List<TrainingDirectionsData> trainingDirections) onStudentTrainingDirectionsUpdated;
  final List<TrainingDirectionsData> trainingDirections;


  final String? firstNameError;
  final String? lastNameError;
  final String? classError;

  @override
  State<StudentDialogContent> createState() => _StudentDialogContentState();
}

class _StudentDialogContentState extends State<StudentDialogContent> {

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    insertTextController(widget.student); //initialData for firstName and lastName if available

  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth =
    MediaQuery.of(context).size.width*0.5>500?MediaQuery.of(context).size.width*0.5:500;
    return SizedBox(
            width: dialogWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /*
                first segment are the two textfields for first name and last name
                 */
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: TextField(
                            controller: firstNameController,
                            onChanged: widget.onFirstNameChanged,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: TextRes.firstNameHint,
                                labelStyle: Theme.of(context).textTheme.labelMedium,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium)
                              ),
                              errorText: widget.firstNameError
                            ),
                        )
                      ),
                      const SizedBox(width: Dimensions.spaceLarge,),
                      Expanded(child: TextField(
                          controller: lastNameController,
                          onChanged: widget.onLastNameChanged,
                          decoration: InputDecoration(
                              labelText: TextRes.lastNameHint,
                              labelStyle: Theme.of(context).textTheme.labelMedium,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
                              ),
                              errorText: widget.lastNameError
                          ),
                        )
                      )
                    ],
                  ),
                ),

                const SizedBox(height: Dimensions.spaceMedium,),
              /*
              Second segment to select the class
               */
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSmall, top: Dimensions.paddingSmall),
                  child: Text(TextRes.classDataDropdownDescription,
                  style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                if(widget.classError!=null) ...[ //show an error message on demand
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSmall),
                    child: Text(widget.classError!,
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: Theme.of(context).colorScheme.error, height: Dimensions.tightTextHeight)
                    ),
                  )
                ],
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingBetweenVerySmallAndSmall),
                  child: Dropdown<ClassData>(availableChips: widget.classes,
                      selectedChips: widget.student!=null
                          ?[ClassData(widget.student!.classLevel, widget.student!.classChar)]
                          :List<ClassData>.empty(),
                      onAddChip: (classChip){widget.onStudentClassUpdated(classChip as ClassData);},
                      onDeleteChip: (_){},
                      multiSelect: false, width: dialogWidth*0.8,
                      onCloseOverlay: (classes) {
                        widget.onStudentClassUpdated(classes.isNotEmpty
                            ?classes[0] as ClassData
                            :null);
                              }
                          ),
                ),
                const SizedBox(height: Dimensions.spaceMedium,),

                /*
                Third segment to select training directions
                 */

                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSmall, top: Dimensions.paddingSmall),
                  child: Text(TextRes.trainingDirectionsDataDropdownDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingBetweenVerySmallAndSmall),
                  child: Dropdown(availableChips: widget.trainingDirections,
                      selectedChips: widget.student!=null
                          ?widget.student!.trainingDirections.map((e) => TrainingDirectionsData(e)).toList()
                          :List<TrainingDirectionsData>.empty(),
                        onAddChip: (_){}, onDeleteChip: (_){},
                      multiSelect: true, width: dialogWidth*0.8,
                      onCloseOverlay: (trainingDirections) =>
                          widget.onStudentTrainingDirectionsUpdated(trainingDirections as List<TrainingDirectionsData>)
                  ),
                ),


              ],
            ),
        );

  }

  void insertTextController(Student? student) {
    if(student != null) {
      firstNameController.text = student.firstName;
      lastNameController.text = student.lastName;
    }
  }

}