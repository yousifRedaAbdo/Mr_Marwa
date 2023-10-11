import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:mrs_marwa/app/home_drawer/view_model/home_drawer_view_model.dart';

// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../../base_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/texts.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeDrawerViewModel>(
      onModelReady: (viewModel) {
        viewModel.getAboutUs();
      },
      builder: (context, viewModel, child) {
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
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
                centerTitle: true,
                title: appBarTitle(tr('about')),
              ),
              body: viewModel.aboutUs == ''
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      child: SingleChildScrollView(
                        child: HtmlWidget(
                          viewModel.aboutUs,
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
