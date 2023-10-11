

import 'package:mrs_marwa/base_view_model.dart';

import '../../../locator.dart';
import '../../../services/navigation_service.dart';
import '../../../services/shared_pref_services.dart';

class SelectAppLangViewModel extends BaseViewModel{
  var navigation = locator<NavigationService>();

  var pref = locator<SharedPrefServices>();

}