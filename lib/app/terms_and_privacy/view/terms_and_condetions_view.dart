import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../utils/colors.dart';
import '../../../utils/texts.dart';

class TermsAndPolicy extends StatelessWidget {
  TermsAndPolicy({
    Key? key,
    required this.mdFileName,
    required this.appBarTitleText,
  })  : assert(mdFileName.contains('.md'),
  'The file must contain the .md extension'),
        super(key: key);

  final String mdFileName;
  String appBarTitleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: SafeArea(
        top: true,
        bottom: false,
        right: false,
        left: false,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradColor1, gradColor2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              elevation: 0,
              centerTitle: true,
              title: appBarTitle(appBarTitleText),
            ),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: Future.delayed(const Duration(milliseconds: 150))
                        .then((value) {
                      return rootBundle.loadString('assets/$mdFileName');
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Markdown(
                          data: snapshot.data.toString(),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
