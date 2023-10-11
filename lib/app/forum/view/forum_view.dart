import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/texts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_model/forum_view_model.dart';

class ForumView extends StatelessWidget {
  String forumUrl;

  ForumView({Key? key, required this.forumUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$forumUrl&lang=ar');
    return BaseView<ForumViewModel>(
      onModelReady: (viewModel) async {
        viewModel.getToken();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
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
            title: appBarTitle(tr('forum')),
          ),
          body: viewModel.token == ''
              ? const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                )
              : Stack(
                  children: [
                    InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: Uri.parse(
                          '$forumUrl&lang=en',
                        ),
                      ),
                      onReceivedServerTrustAuthRequest:
                          (controller, challenge) async {
                        return ServerTrustAuthResponse(
                            action: ServerTrustAuthResponseAction.PROCEED);
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
                            useOnDownloadStart: true),
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
                        await launch(url.toString());
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }
}
