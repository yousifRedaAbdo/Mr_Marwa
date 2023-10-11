import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';

import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';

class ForumViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var token = '';

  getToken() async {
    token = await pref.getString(userToken);
    setState(ViewState.Idle);
  }

  double progress = 0;

  InAppWebViewController? webViewController;

  updateState() {
    setState(ViewState.Idle);
  }

  String cssInjectionUrl =
      'https://academy2022.nitg-eg.com//medhatnabil/academyApi/style/style.css';

  String getJavaScriptInjection() {
    return """ javascript:(function() { 
                var x = document.getElementsByClassName("inner_page_breadcrumb");
var y = document.getElementsByClassName("ccnHeader1");
var yMobile = document.getElementsByClassName("mobile-menu");
var z = document.getElementsByClassName("footer_one");
var a = document.getElementsByClassName("footer_middle_area");
var b = document.getElementsByClassName("footer_bottom_area");
var options = document.getElementById("ccnSettingsMenuContainer");

var dashboardTabs = document.getElementsByClassName("mobileNone");
var copyRightsBar = document.getElementsByClassName("copyright-widget");
var titleBar = document.getElementsByClassName("breadcrumb_widgets");
var learningPlansTitle = document.getElementsByClassName("ccnMdlHeading");

var options = document.getElementById("ccnSettingsMenuContainer");
if(options != null){options.style.display="none";}

var pageHeading = document.getElementById("page-heading-button");
if(pageHeading != null){pageHeading.style.display="none";}

var i;
var activityNav = document.getElementsByClassName("activity-navigation");
for (i = 0; i < activityNav .length; i++) {
    activityNav [i].style.display = "none";
}



for (i = 0; i < learningPlansTitle.length; i++) {
    learningPlansTitle[i].style.display = "none";
}
for (i = 0; i < titleBar.length; i++) {
    titleBar[i].style.display = "none";
}
for (i = 0; i < copyRightsBar.length; i++) {
    copyRightsBar[i].style.display = "none";
}
for (i = 0; i < dashboardTabs.length; i++) {
    dashboardTabs[i].style.display = "none";
}
for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
}
for (i = 0; i < y.length; i++) {
    y[i].style.display = "none";
}
for (i = 0; i < yMobile.length; i++) {
    yMobile[i].style.display = "none";
}
for (i = 0; i < z.length; i++) {
    z[i].style.display = "none";
}
for (i = 0; i < a.length; i++) {
    a[i].style.display = "none";
}
for (i = 0; i < b.length; i++) {
    b[i].style.display = "none";
}
                })()""";
  }
}
