import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';
import 'locator.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final Function(T, Function(int), List<AnimationController>)? initController;
  final Function(T)? onModelReady;
  final Function(T)? onFinish;

  BaseView(
      {this.builder, this.onModelReady, this.onFinish, this.initController});

  @override
  _BaseScreenState<T> createState() => _BaseScreenState<T>();
}

class _BaseScreenState<T extends BaseViewModel> extends State<BaseView<T>>
    with TickerProviderStateMixin {
  T model = locator<T>();
  final List<AnimationController> _controllers = [];

  @override
  void initState() {
    super.initState();
    // secureScreen();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onModelReady?.call(model);
    });
    widget.initController?.call(model, newController, _controllers);
  }

  @override
  void dispose() {
    widget.onFinish?.call(model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (!connected) {
            return Scaffold(
              backgroundColor: whiteColor,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: mainColorTitle(tr('no_internet')),
                        ),
                        heightSpace(20),
                        Image.asset('assets/images/no_connection.png'),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return ChangeNotifierProvider<T>.value(
            value: model,
            child: Consumer<T>(builder: widget.builder!),
          );
        },
        child: const Text(''),
      );
    });
  }

  AnimationController newController(int duration) {
    var cont = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration), // <-- Set your duration here.
    );
    _controllers.add(cont);
    return cont;
  }
}

// Future<void> secureScreen() async {
//   if (Platform.isAndroid) {
//     await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
//   }
// }

Future<void> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
  } else if (connectivityResult == ConnectivityResult.none) {}
}
