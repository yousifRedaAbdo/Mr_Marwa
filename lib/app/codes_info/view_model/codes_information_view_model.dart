import 'package:mrs_marwa/app/codes_info/model/codes_informaion_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/navigation_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

class CodesInformationViewModel extends BaseViewModel {
  var navigation = locator<NavigationService>();
  var pref = locator<SharedPrefServices>();
  var api = locator<ApiService>();
  List<Data> patches = [];
  bool isDataLoading = true;
  bool isError = false;

  String userRole = '';
  String token = '';

  getUserRole() async {
    userRole = await pref.getString(userType);
    setState(ViewState.Idle);
  }

  gatAllPatches({required String courseId}) async {
    token = await pref.getString(userToken);
    var data =
        await api.getCodesInformation(courseId: courseId, token: '$token');
    if (data != 'fail') {
      GetCodesInfoModel model = GetCodesInfoModel.fromJson(data);
      for (var i in model.data!) {
        patches.add(i);
      }
      isDataLoading = false;
      setState(ViewState.Idle);
    } else {
      isError = true;
      setState(ViewState.Idle);
    }
  }
}
