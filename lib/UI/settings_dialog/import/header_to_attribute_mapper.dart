import 'package:buecherteam_2023_desktop/Models/settings/import_state.dart';
import 'package:buecherteam_2023_desktop/Resources/text.dart';
import 'package:buecherteam_2023_desktop/UI/settings_dialog/import/download_excel_format_error.dart';
import 'package:buecherteam_2023_desktop/UI/settings_dialog/import/loading.dart';
import 'package:buecherteam_2023_desktop/UI/settings_dialog/import/select_excel.dart';
import 'package:buecherteam_2023_desktop/UI/settings_dialog/import/training_direction_mapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Data/settings/student_excel_mapper_attributes.dart';
import '../../../Models/settings/settings_nav_state.dart';
import '../../../Resources/dimensions.dart';
import '../nav_bottom_bar.dart';
import 'attribute_mapper_list.dart';

class HeaderToAttributeMapper extends StatelessWidget {
  const HeaderToAttributeMapper({super.key});

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.paddingSmall,
                  left: Dimensions.paddingVeryBig,
                  right: Dimensions.paddingVeryBig
              ),
              child: Consumer<ImportState>(
                builder: (context, state, _) => AttributeMapperList<StudentAttributes>(
                    availableDropdownItems: state.availableStudentAttributes,
                    initialMap: state.currHeaderToAttributeMap,
                    onUpdatedMap: (updatedMap) {
                      state.setCurrHeaderToAttributeMap(updatedMap);
                    },
                    width: availableWidth * 0.4),
              )),
        ),
        Consumer<ImportState>(
          builder: (context, state, _) =>
             Padding(
               padding: const EdgeInsets.all(Dimensions.paddingSmall),
               child: NavBottomBar(
                  nextWidget: MapEntry(SettingsNavButtons.IMPORT,
                      Loading(
                          functionToBeExecuted: state.preProcessExcel,
                          nextWidget: const MapEntry(SettingsNavButtons.IMPORT, TrainingDirectionMapper()),
                          fallbackWidget: const MapEntry(SettingsNavButtons.IMPORT, DownloadExcelFormatError()),
                          goToFallbackText: TextRes.goToDownload,
                      )
                  ),
                  previousWidget: const MapEntry(SettingsNavButtons.IMPORT, SelectExcel()),
                  error: state.currHeaderToAttributeError,
                           ),
             )
        )
      ],
    );
  }
}
