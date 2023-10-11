import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/colors.dart';

var unKnownErrorSnackBar = SnackBar(
  content: Text(tr('unKnown_wrong')),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

var termsAndConditionsSnackBar = SnackBar(
  content: Text(tr('plz_accept_terms')),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

var wrongOldPasswordSnackBar = SnackBar(
  content: Text(tr('wrong_old_pass')),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);
var changePasswordSuccessfulSnackBar = SnackBar(
  content: Text(tr('password_changed_successful')),
  backgroundColor: successfulColor,
  behavior: SnackBarBehavior.floating,
);

var childAlreadyExist = SnackBar(
  content: Text(tr('child_already_exist')),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

var notYourChildSnackBar = SnackBar(
  content: Text(
    tr('sorry_not_child'),
  ),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

var failAddChildSnackBar = SnackBar(
  content: Text(
    tr('unKnown_wrong'),
  ),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

var childAddSuccess = SnackBar(
  content: Text(
    tr('child_add_success'),
  ),
  backgroundColor: successfulColor,
  behavior: SnackBarBehavior.floating,
);

var rateSnackBar = SnackBar(
  content: Text(
    tr('rate_add_success'),
  ),
  backgroundColor: successfulColor,
  behavior: SnackBarBehavior.floating,
);


var codeIsNotValid = SnackBar(
  content: Text(
    tr('not_valid_code'),
  ),
  backgroundColor: errorColor,
  behavior: SnackBarBehavior.floating,
);

