import 'package:buecherteam_2023_desktop/Models/settings/import_state.dart';
import 'package:buecherteam_2023_desktop/UI/settings_dialog/print_parent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Data/settings/student_excel_mapper_attributes.dart';
import '../../../Models/settings/settings_nav_state.dart';
import '../../../Resources/dimensions.dart';
import '../nav_bottom_bar.dart';
import '../warning_parent.dart';
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
                  nextWidget: MapEntry(SettingsNavButtons.MAHNUNG, WarningParent()),
                  previousWidget: MapEntry(SettingsNavButtons.DRUCKEN, PrintParent()),
                  error: state.currHeaderToAttributeError,
                           ),
             )
        )
      ],
    );
  }
}