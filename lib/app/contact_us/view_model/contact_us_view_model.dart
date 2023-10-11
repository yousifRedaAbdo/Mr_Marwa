import 'package:mrs_marwa/app/auth/view_model/auth_view_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

class ContactUsViewModel extends BaseViewModel {
  AuthenticationViewModel authenticationViewModel = AuthenticationViewModel();
  ApiService apiService = locator<ApiService>();
  var pref = locator<SharedPrefServices>();
  String token = '';

  getToken() async {
    token = await pref.getString(userToken);
    print('token : $token');
  }
}
