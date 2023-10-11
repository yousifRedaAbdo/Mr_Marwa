import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../base_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/texts.dart';
import '../view_model/web_view_view_model.dart';

class AppWebView extends StatelessWidget {
  String? url;
  String? title;

  AppWebView(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return BaseView<AppWebViewViewModel>(
      onModelReady: (viewModel) async {},
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, true);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradColor1, gradColor2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: appBarTitle(title!),
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back),
              //   onPressed: () {
              //     // Navigator.of(context).pop();
              //   },
              // ),
            ),
            body: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(url!)),
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED,
                    );
                  },
                  onLoadStop: (controller, url) async {
                    await controller.evaluateJavascript(
                        source: viewModel.getJavaScriptInjection());
                    await controller.injectCSSFileFromUrl(
                        urlFile: Uri.parse(viewModel.cssInjectionUrl));
                  },
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      allowUniversalAccessFromFileURLs: true,
                      allowFileAccessFromFileURLs: true,
                      useOnDownloadStart: true,
                      clearCache: true,
                    ),
                    android: AndroidInAppWebViewOptions(
                      domStorageEnabled: true,
                      databaseEnabled: true,
                      clearSessionCache: true,
                      thirdPartyCookiesEnabled: true,
                      allowFileAccess: true,
                      allowContentAccess: true,
                    ),
                  ),
                  onProgressChanged: (controller, progress) {
                    viewModel.progress = progress / 100;
                    viewModel.updateState();
                  },
                  onWebViewCreated: (InAppWebViewController controller) {
                    viewModel.webViewController = controller;
                  },
                  onDownloadStartRequest: (controller, url) async {
                    var x = url.toMap();
                    var link = x['url'];
                    viewModel.showMyDialog(context, fileUrl: link);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DownloadScreen extends StatelessWidget {
  String fileUrl;

  DownloadScreen(this.fileUrl);

  @override
  Widget build(BuildContext context) {
    return BaseView<AppWebViewViewModel>(
      onModelReady: (viewModel) {
        viewModel.openFile(
          context,
          url: fileUrl,
        );
      },
      builder: (context, viewModel, child) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
          child: new LinearPercentIndicator(
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: (viewModel.progress / 100),
            center: Text(
              '${viewModel.progress.toInt()}',
              style: TextStyle(
                color: backgroundColor,
              ),
            ),
            linearStrokeCap: LinearStrokeCap.round,
            backgroundColor: Colors.blueGrey,
            progressColor: mainColor,
          ),
        );
      },
      onFinish: (viewModel) {},
    );
  }
}
