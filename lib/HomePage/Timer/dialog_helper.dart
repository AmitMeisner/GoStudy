
import 'package:flutter/material.dart';
import 'enterTimeDialog.dart';
import 'exit_confirmation_dialog.dart';
import 'missingData_dialog.dart';

class DialogHelperExit {

  static exit(context) => showDialog(context: context, builder: (context) => ExitConfirmationDialog());
}


class DialogHelperTime {

  static enterTime(context) => showDialog(context: context, builder: (context) => TimeConfirmationDialog());
}

class DialogHelperMissingData {

  static showError(context) => showDialog(context: context, builder: (context) => MissingDataDialog());
}

