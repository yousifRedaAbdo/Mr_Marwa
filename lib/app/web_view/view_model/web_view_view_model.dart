import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../locator.dart';
import '../view/web_view.dart';

class AppWebViewViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  double progress = 0;

  InAppWebViewController? webViewController;

  updateState() {
    setState(ViewState.Idle);
  }

  Future<bool> onWillPop() async {
    if (await webViewController!.canGoBack()) {
      webViewController?.goBack();

      return false;
    } else {
      return true;
    }
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

  Future<File?> downloadFile(context, String url, String name) async {
    try {
      String dir = '';
      if (Platform.isAndroid) {
        dir = (await getExternalStorageDirectory())!.path;
        print('dir');
        print(dir);
      } else if (Platform.isIOS) {
        dir = (await getApplicationDocumentsDirectory()).path;
        print('dir');
        print(dir);
      }

      final appStorage = await getApplicationDocumentsDirectory();
      print(appStorage);
      final file = File('$dir/$name');
      final response = await Dio().get(
        url,
        onReceiveProgress: (x, y) {
          var result = (x / y) * 100;
          progress = result.toDouble();
          print(progress);
          setState(ViewState.Idle);
        },
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      final raf = await file.open(mode: FileMode.write);
      raf.writeFromSync(response.data);
      raf.close();
      return file;
    } catch (e) {
      print('error is $e');
    }
  }

  openFile(context, {required String url, String? fileName}) async {
    var name = fileName ?? url
        .split('/')
        .last;
    name = fileName ?? name
        .split('?')
        .first;
    print('name');
    print(name);
    final file = await downloadFile(context, url, name);

    if (file == null) {
      print('file == null');
    }

    Navigator.pop(context);
    OpenFile.open(file?.path);
  }

  showMyDialog(BuildContext context, {required String fileUrl}) async {
    await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.all(0),
            content: DownloadScreen(fileUrl),
          ),
    );
  }
}
