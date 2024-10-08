import 'package:buecherteam_2023_desktop/Models/settings/settings_nav_state.dart';
import 'package:buecherteam_2023_desktop/UI/settings_dialog/import/big_button.dart';
import 'package:buecherteam_2023_desktop/UI/settings_dialog/import/import_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/dimensions.dart';
import '../../Resources/text.dart';

class ImportParent extends StatelessWidget {
  const ImportParent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BigButton(onPressed: (){
          Provider.of<SettingsNavState>(context, listen: false)
              .setCurrWidget(const ImportPreferences(), SettingsNavButtons.IMPORT);
        }, text: TextRes.importNewSchoolYearTitle),
        const SizedBox(height: Dimensions.spaceLarge,),
        BigButton(onPressed: (){}, text: TextRes.importNewStudents),
        const SizedBox(height: Dimensions.spaceLarge,),
        BigButton(onPressed: (){}, text: TextRes.importNewAttributes)
      ],
    );
  }
}
