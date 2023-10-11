import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

var errorLoginSnackBar = SnackBar(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  content: Text(tr('wrong_login')),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

var failLoginSnackBar = SnackBar(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  content: Text(tr('unKnown_wrong')),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

var selectYearSnackBar = SnackBar(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  content: Text(tr('select_year')),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);
